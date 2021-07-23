<?php

namespace app\models;

class Timing
{
    public function get($params)
    {
        $where[] = 'timing_id = :timing_id';
        $sql = 'SELECT * FROM timing WHERE ' . implode(' AND ', $where);
        list($row) = DB::query($sql, $params);
        return $row;
    }

    public function getList($params)
    {
        $where[] = 1;
        $pa = [];

        if ($params['type_id']) {
            if ($params['type_id'] == 999) {
                $where[] = 'T.type_id IN (1, 2, 5)';
            } else {
                $where[] = 'T.type_id = :type_id';
                $pa['type_id'] = $params['type_id'];
            }
        }

        // 件数
        $sql = 'SELECT COUNT(*)
                FROM timing AS T
                WHERE ' . implode(' AND ', $where) . '
        ';
        list(list($count)) = Db::query($sql, $pa);

        // 一覧
        $sql = 'SELECT T.timing_id,
                    T.type_id,
                    T.subtype_id,
                    T.datetime,
                    TT.name AS type_name,
                    TS.name AS subtype_name
                FROM timing AS T
                LEFT OUTER JOIN timing_type AS TT ON T.type_id = TT.type_id
                LEFT OUTER JOIN timing_subtype AS TS ON T.subtype_id = TS.subtype_id
                WHERE ' . implode(' AND ', $where) . '
                ORDER BY T.datetime DESC
                LIMIT :page, :page_size
        ';
        $pa['page'] = ($params['page'] - 1) * $params['page_size'];
        $pa['page_size'] = $params['page_size'];
        $list = Db::query($sql, $pa);

        $query['type_id'] = $params['type_id'];
        $page = Page::create($params['page'], $params['page_size'], $count, $query);

        return [$list, $page];
    }

    public function add($params)
    {
        $sql = 'INSERT INTO timing (type_id, subtype_id, datetime, cdate, udate) VALUES (:type_id, :subtype_id, NOW(), NOW(), NOW())';
        Db::query($sql, $params);
    }

    public function edit($params)
    {
        $sql = 'UPDATE timing SET datetime = :datetime, type_id = :type_id, subtype_id = :subtype_id WHERE timing_id = :timing_id';
        Db::query($sql, $params);
    }

    public function delete($params)
    {
        $sql = 'DELETE FROM timing WHERE timing_id = :timing_id';
        Db::query($sql, $params);
    }
}
