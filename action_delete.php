<?php
require_once dirname(__FILE__) . '/configs/config.php';

// バリデーション
$timing_id = intval($_GET['timing_id']);

// インスタンス
$db = new Mysql();

if (!$timing_id) {
    header('Location: ./');
}

// タイプ一覧
$sql = 'DELETE FROM  timing WHERE timing_id = ?';
$type_list = $db->query($sql, array($timing_id));

header('Location: ./');
