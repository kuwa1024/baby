<?php
require_once dirname(__FILE__) . '/configs/config.php';

// バリデーション
$timing_id = intval($_GET['timing_id']);

// インスタンス
$db = new Mysql();

// タイプ一覧
$sql = 'SELECT * FROM timing_type ORDER BY sort';
$type_list = $db->query($sql);

// サブタイプ一覧
$sql = 'SELECT * FROM timing_subtype ORDER BY sort';
$subtype_list = $db->query($sql);

// タイミング
$sql = 'SELECT * FROM timing WHERE timing_id = ?';
list($timing) = $db->query($sql, array($timing_id));

// アサイン
$smarty->assign('type_list', $type_list);
$smarty->assign('subtype_list', $subtype_list);
$smarty->assign('timing', $timing);
$smarty->display('edit.tpl');
