<?php
#error_reporting(E_ALL & ~E_NOTICE);
#ini_set('display_errors', 1);
require_once dirname(dirname(__FILE__)) . '/vendor/autoload.php';
require_once dirname(dirname(__FILE__)) . '/models/Mysql.php';

$smarty = new Smarty();
$smarty->escape_html = true;
$smarty->template_dir = dirname(dirname(__FILE__)) . '/templates/';
$smarty->compile_dir = dirname(dirname(__FILE__)) . '/templates_c/';
