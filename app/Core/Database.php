<?php

namespace App\Core;

use PDO;
use PDOException;

/**
 * Database — Singleton PDO wrapper with query builder helpers.
 * Prevents SQL injection via prepared statements exclusively.
 */
class Database
{
    private static ?self $instance = null;
    private PDO           $pdo;
    private array         $queryLog = [];

    // ── Constructor ──────────────────────────────────────────
    private function __construct()
    {
        $config = require CONFIG_PATH . '/database.php';

        $dsn = sprintf(
            'mysql:host=%s;port=%s;dbname=%s;charset=utf8mb4',
            $config['host'],
            $config['port'],
            $config['database']
        );

        $options = [
            PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES   => false,
            PDO::ATTR_PERSISTENT         => $config['persistent'] ?? false,
            PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci",
        ];

        try {
            $this->pdo = new PDO($dsn, $config['username'], $config['password'], $options);
        } catch (PDOException $e) {
            // Never expose DB credentials in messages
            throw new \RuntimeException('Database connection failed.', 500, $e);
        }
    }

    // ── Singleton ────────────────────────────────────────────
    public static function getInstance(): self
    {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    // ── Raw PDO access ───────────────────────────────────────
    public function getPdo(): PDO
    {
        return $this->pdo;
    }

    // ── Query helpers ────────────────────────────────────────

    /**
     * Execute a SELECT and return all rows.
     *
     * @param string $sql    Parameterised SQL
     * @param array  $params Positional or named bindings
     * @return array<int, array<string, mixed>>
     */
    public function fetchAll(string $sql, array $params = []): array
    {
        $stmt = $this->execute($sql, $params);
        return $stmt->fetchAll();
    }

    /**
     * Execute a SELECT and return the first row or null.
     */
    public function fetchOne(string $sql, array $params = []): ?array
    {
        $stmt = $this->execute($sql, $params);
        $row  = $stmt->fetch();
        return $row !== false ? $row : null;
    }

    /**
     * Execute a SELECT and return a single column value.
     */
    public function fetchColumn(string $sql, array $params = []): mixed
    {
        $stmt = $this->execute($sql, $params);
        $val  = $stmt->fetchColumn();
        return $val !== false ? $val : null;
    }

    /**
     * Execute an INSERT and return the last inserted ID.
     */
    public function insert(string $table, array $data): int|string
    {
        $columns  = array_keys($data);
        $placeholders = array_map(fn($c) => ':' . $c, $columns);

        $sql = sprintf(
            'INSERT INTO `%s` (%s) VALUES (%s)',
            $table,
            implode(', ', array_map(fn($c) => "`$c`", $columns)),
            implode(', ', $placeholders)
        );

        $this->execute($sql, $data);
        return $this->pdo->lastInsertId();
    }

    /**
     * Execute an UPDATE and return the number of affected rows.
     *
     * @param array $where  ['column' => value, ...]
     */
    public function update(string $table, array $data, array $where): int
    {
        $setClauses   = array_map(fn($c) => "`$c` = :set_$c", array_keys($data));
        $whereClauses = array_map(fn($c) => "`$c` = :whr_$c", array_keys($where));

        $sql = sprintf(
            'UPDATE `%s` SET %s WHERE %s',
            $table,
            implode(', ', $setClauses),
            implode(' AND ', $whereClauses)
        );

        $params = [];
        foreach ($data  as $k => $v) $params["set_$k"] = $v;
        foreach ($where as $k => $v) $params["whr_$k"] = $v;

        $stmt = $this->execute($sql, $params);
        return $stmt->rowCount();
    }

    /**
     * Execute a DELETE and return affected row count.
     */
    public function delete(string $table, array $where): int
    {
        $clauses = array_map(fn($c) => "`$c` = :$c", array_keys($where));
        $sql = sprintf('DELETE FROM `%s` WHERE %s', $table, implode(' AND ', $clauses));

        $stmt = $this->execute($sql, $where);
        return $stmt->rowCount();
    }

    /**
     * Generic execute — logs in debug mode, always uses prepared statements.
     */
    public function execute(string $sql, array $params = []): \PDOStatement
    {
        $start = microtime(true);
        $stmt  = $this->pdo->prepare($sql);
        $stmt->execute($params);

        if (defined('APP_DEBUG') && APP_DEBUG) {
            $this->queryLog[] = [
                'sql'    => $sql,
                'params' => $params,
                'time'   => round((microtime(true) - $start) * 1000, 2) . 'ms',
            ];
        }

        return $stmt;
    }

    // ── Transactions ─────────────────────────────────────────
    public function beginTransaction(): void   { $this->pdo->beginTransaction(); }
    public function commit(): void             { $this->pdo->commit(); }
    public function rollback(): void           { $this->pdo->rollBack(); }

    /**
     * Run a callable inside a transaction; rolls back automatically on exception.
     */
    public function transaction(callable $callback): mixed
    {
        $this->beginTransaction();
        try {
            $result = $callback($this);
            $this->commit();
            return $result;
        } catch (\Throwable $e) {
            $this->rollback();
            throw $e;
        }
    }

    // ── Utilities ────────────────────────────────────────────
    public function getQueryLog(): array { return $this->queryLog; }

    public function lastInsertId(): string { return $this->pdo->lastInsertId(); }
}
