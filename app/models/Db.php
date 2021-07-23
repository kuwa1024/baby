<?php

namespace app\models;

use PDO, PDOException;

class Db
{
    static private $pdo;

    private static function init()
    {
        $env = getenv('MYSQLCONNSTR_localdb');
        $hostname = preg_replace('/^.*Data Source=(.+?);.*$/', '\\1', $env);
        $database = preg_replace('/^.*Database=(.+?);.*$/', '\\1', $env);
        $username = preg_replace('/^.*User Id=(.+?);.*$/', '\\1', $env);
        $password = preg_replace('/^.*Password=(.+?)$/', '\\1', $env);
        $dsn = sprintf('mysql:dbname=%s;host=%s;charset=utf8', $database, $hostname);
        self::$pdo = new PDO($dsn, $username, $password, array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION));
    }

    public static function query($sql, $params = array())
    {
        try {
            if (!is_object(self::$pdo)) {
                self::init();
            }

            $sth = self::$pdo->prepare($sql);
            foreach ($params as $key => $val) {
                is_numeric($val) ? $type = PDO::PARAM_INT : $type = PDO::PARAM_STR;
                $sth->bindValue(':' . $key, $val, $type);
            }
            $status = $sth->execute();
        } catch (PDOException $e) {
            echo $e->getMessage();
            exit;
        }

        if (strpos($sql, 'SELECT') !== false) {
            return $sth->fetchAll();
        } else {
            return;
        }
    }
}
