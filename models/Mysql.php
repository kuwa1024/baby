<?php
class Mysql
{
    private $pdo;

    public function __construct()
    {
        if (getenv('MYSQLCONNSTR_localdb')) {
            $env = getenv('MYSQLCONNSTR_localdb');
        } else {
            require_once dirname(dirname(__FILE__)) . '/env.php';
            $env = getenv('MYSQLCONNSTR_localdb');
        }
        $hostname = preg_replace('/^.*Data Source=(.+?);.*$/', '\\1', $env);
        $database = preg_replace('/^.*Database=(.+?);.*$/', '\\1', $env);
        $username = preg_replace('/^.*User Id=(.+?);.*$/', '\\1', $env);
        $password = preg_replace('/^.*Password=(.+?)$/', '\\1', $env);
        $dsn = sprintf('mysql:dbname=%s;host=%s;charset=utf8', $database, $hostname);
        $this->pdo = new PDO($dsn, $username, $password, array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION));
    }

    public function query($sql, $params = array())
    {
        try {
            $sth = $this->pdo->prepare($sql);
            $i = 1;
            foreach ($params as $val) {
                is_numeric($val) ? $type = PDO::PARAM_INT : $type = PDO::PARAM_STR;
                $sth->bindValue($i, $val, $type);
                $i++;
            }
            $sth->execute();
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
