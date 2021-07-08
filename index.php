<?php
require_once dirname(__FILE__) . '/configs/config.php';

// バリデーション
$type_id = intval($_GET['type_id']);
$page_valid = $_GET['page'] ? intval($_GET['page']) : 1;

// インスタンス
$db = new Mysql();

// タイプ一覧
$sql = 'SELECT * FROM timing_type ORDER BY sort';
$type_list = $db->query($sql);

// サブタイプ一覧
$sql = 'SELECT * FROM timing_subtype ORDER BY sort';
$subtype_list = $db->query($sql);

// タイミング件数
$sql = 'SELECT COUNT(*) FROM timing';
list(list($count)) = $db->query($sql);

// タイミング一覧
$where[] = 1;

if ($type_id) {
    if ($type_id == 999) {
        $where[] = 'T.type_id IN (1, 2, 5)';
    } else {
        $where[] = 'T.type_id = ?';
        $params[] = $type_id;
    }
}

$sql = '
SELECT T.timing_id,
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
LIMIT ?, ?
';
$page_size = 20;
$page = ($page_valid - 1) * $page_size;
$params[] = $page;
$params[] = $page_size;
$timing_list = $db->query($sql, $params);

// アサイン
$smarty->assign('type_id', $type_id);
$smarty->assign('type_list', $type_list);
$smarty->assign('subtype_list', $subtype_list);
$smarty->assign('page_now', $page_valid);
$smarty->assign('page_count', ceil($count / $page_size));
$smarty->assign('timing_list', $timing_list);
$smarty->display('index.tpl');
