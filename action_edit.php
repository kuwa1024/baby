<?php
require_once dirname(__FILE__) . '/configs/config.php';

// バリデーション
$timing_id = intval($_POST['timing_id']);
$date = $_POST['date'];
$time = $_POST['time'];
$type_id = intval($_POST['type_id']);
$subtype_id = intval($_POST['subtype_id']);

// インスタンス
$db = new Mysql();

if (!$timing_id) {
    header('Location: ./');
}

// タイプ一覧
$sql = 'UPDATE timing SET datetime = ?, type_id = ?, subtype_id = ? WHERE timing_id = ?';
$params = array(
    $date . ' ' . $time,
    $type_id,
    $subtype_id,
    $timing_id,
);
$type_list = $db->query($sql, $params);

header('Location: ./');
