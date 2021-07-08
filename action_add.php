<?php
require_once dirname(__FILE__) . '/configs/config.php';

// バリデーション
$type_id = intval($_POST['type_id']);
$subtype_id = intval($_POST['subtype_id']);

// インスタンス
$db = new Mysql();

// タイプ一覧
$sql = 'INSERT INTO timing (type_id, subtype_id, datetime, cdate, udate) VALUES (?, ?, NOW(), NOW(), NOW())';
$db->query($sql, array($type_id, $subtype_id));

header('Location: ./');
