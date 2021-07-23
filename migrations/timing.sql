-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- ホスト: db
-- 生成日時: 2021 年 7 月 08 日 16:16
-- サーバのバージョン： 10.5.11-MariaDB-1:10.5.11+maria~focal
-- PHP のバージョン: 7.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- データベース: `localdb`
--

-- --------------------------------------------------------

--
-- テーブルの構造 `timing`
--

CREATE TABLE `timing` (
  `timing_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL COMMENT 'タイプID',
  `subtype_id` int(11) NOT NULL,
  `datetime` datetime NOT NULL,
  `cdate` datetime NOT NULL,
  `udate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='タイミング';

--
-- ダンプしたテーブルのインデックス
--

--
-- テーブルのインデックス `timing`
--
ALTER TABLE `timing`
  ADD PRIMARY KEY (`timing_id`);

--
-- ダンプしたテーブルの AUTO_INCREMENT
--

--
-- テーブルの AUTO_INCREMENT `timing`
--
ALTER TABLE `timing`
  MODIFY `timing_id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
