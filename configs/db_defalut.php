<?php
if (getenv('MYSQLCONNSTR_localdb')) {
    $env = getenv('MYSQLCONNSTR_localdb');
} elseif (file_exists(__DIR__ . '/db.php')) {
    require_once __DIR__ . '/db.php';
} else {
    putenv('MYSQLCONNSTR_localdb=Database=localdb;Data Source=db;User Id=root;Password=root');
}
