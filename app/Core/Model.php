<?php

namespace App\Core;

/**
 * Base Model — ActiveRecord-style with query builder, translation support,
 * and optional automatic branch scoping.
 */
abstract class Model
{
    protected static string  $table       = '';
    protected static string  $primaryKey  = 'id';
    protected static bool    $timestamps  = true;

    /** If true, all queries are automatically scoped to the active branch. */
    protected static bool    $branchScoped = false;

    protected Database $db;

    public function __construct()
    {
        $this->db = Database::getInstance();
    }

    // ── CRUD ─────────────────────────────────────────────────

    public function find(int $id): ?array
    {
        $sql    = "SELECT * FROM `" . static::$table . "` WHERE `" . static::$primaryKey . "` = ?";
        $params = [$id];

        if (static::$branchScoped) {
            $sql    .= ' AND `branch_id` = ?';
            $params[] = $this->currentBranchId();
        }

        return $this->db->fetchOne($sql, $params);
    }

    public function findOrFail(int $id): array
    {
        $record = $this->find($id);
        if (!$record) {
            throw new \App\Exceptions\NotFoundException(static::$table . " #$id not found.");
        }
        return $record;
    }

    public function all(array $conditions = [], string $orderBy = '', int $limit = 0, int $offset = 0): array
    {
        [$sql, $params] = $this->buildSelectQuery('*', $conditions, $orderBy, $limit, $offset);
        return $this->db->fetchAll($sql, $params);
    }

    public function first(array $conditions = []): ?array
    {
        [$sql, $params] = $this->buildSelectQuery('*', $conditions, '', 1, 0);
        return $this->db->fetchOne($sql, $params);
    }

    public function count(array $conditions = []): int
    {
        [$sql, $params] = $this->buildSelectQuery('COUNT(*)', $conditions);
        return (int) $this->db->fetchColumn($sql, $params);
    }

    public function create(array $data): int|string
    {
        if (static::$timestamps) {
            $data['created_at'] = date('Y-m-d H:i:s');
        }
        return $this->db->insert(static::$table, $data);
    }

    public function update(int $id, array $data): int
    {
        if (static::$timestamps) {
            $data['updated_at'] = date('Y-m-d H:i:s');
        }
        $where = [static::$primaryKey => $id];
        if (static::$branchScoped) {
            $where['branch_id'] = $this->currentBranchId();
        }
        return $this->db->update(static::$table, $data, $where);
    }

    public function delete(int $id): int
    {
        $where = [static::$primaryKey => $id];
        if (static::$branchScoped) {
            $where['branch_id'] = $this->currentBranchId();
        }
        return $this->db->delete(static::$table, $where);
    }

    // ── Pagination ───────────────────────────────────────────

    public function paginate(int $page, int $perPage, array $conditions = [], string $orderBy = ''): array
    {
        $page    = max(1, $page);
        $offset  = ($page - 1) * $perPage;
        $total   = $this->count($conditions);
        $items   = $this->all($conditions, $orderBy, $perPage, $offset);

        return [
            'data'         => $items,
            'total'        => $total,
            'per_page'     => $perPage,
            'current_page' => $page,
            'last_page'    => (int) ceil($total / $perPage),
            'from'         => $total ? $offset + 1 : 0,
            'to'           => min($offset + $perPage, $total),
        ];
    }

    // ── Translation helpers ──────────────────────────────────

    /**
     * Fetch the translation row for a record + language.
     */
    public function getTranslation(int $id, string $langCode, string $fallbackLang = 'de'): ?array
    {
        $translationTable = static::$table . '_translations';
        $fkColumn         = rtrim(static::$table, 's') . '_id'; // products → product_id

        $row = $this->db->fetchOne(
            "SELECT * FROM `$translationTable` WHERE `$fkColumn` = ? AND `lang_code` = ? LIMIT 1",
            [$id, $langCode]
        );

        if (!$row && $langCode !== $fallbackLang) {
            $row = $this->db->fetchOne(
                "SELECT * FROM `$translationTable` WHERE `$fkColumn` = ? AND `lang_code` = ? LIMIT 1",
                [$id, $fallbackLang]
            );
        }

        return $row ?: null;
    }

    // ── Query builder helper ─────────────────────────────────

    private function buildSelectQuery(
        string $select,
        array  $conditions,
        string $orderBy = '',
        int    $limit   = 0,
        int    $offset  = 0
    ): array {
        $sql    = "SELECT $select FROM `" . static::$table . "`";
        $params = [];

        if (static::$branchScoped) {
            $conditions['branch_id'] = $this->currentBranchId();
        }

        if ($conditions) {
            $clauses = [];
            foreach ($conditions as $col => $val) {
                if (is_array($val)) {
                    $placeholders = implode(',', array_fill(0, count($val), '?'));
                    $clauses[]    = "`$col` IN ($placeholders)";
                    $params       = array_merge($params, $val);
                } else {
                    $clauses[] = "`$col` = ?";
                    $params[]  = $val;
                }
            }
            $sql .= ' WHERE ' . implode(' AND ', $clauses);
        }

        if ($orderBy) $sql .= " ORDER BY $orderBy";
        if ($limit)   $sql .= " LIMIT $limit";
        if ($offset)  $sql .= " OFFSET $offset";

        return [$sql, $params];
    }

    // ── Branch scope ─────────────────────────────────────────

    private function currentBranchId(): int
    {
        return (int) ($_SESSION['branch_id'] ?? 1);
    }
}
