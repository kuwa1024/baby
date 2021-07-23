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
-- テーブルの構造 `timing_type`
--

CREATE TABLE `timing_type` (
  `type_id` int(11) NOT NULL,
  `name` text NOT NULL,
  `sort` int(11) NOT NULL COMMENT '並び順',
  `cdate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='タイミングタイプ';

--
-- テーブルのデータのダンプ `timing_type`
--

INSERT INTO `timing_type` (`type_id`, `name`, `sort`, `cdate`) VALUES
(1, '母乳', 10, '2021-05-12 00:00:00'),
(2, 'ミルク', 20, '2021-05-12 00:00:00'),
(3, 'おしっこ', 40, '2021-05-12 00:00:00'),
(4, 'うんこ', 50, '2021-05-12 00:00:00'),
(5, '搾乳', 30, '2021-06-02 00:00:00');

--
-- ダンプしたテーブルのインデックス
--

--
-- テーブルのインデックス `timing_type`
--
ALTER TABLE `timing_type`
  ADD PRIMARY KEY (`type_id`);

--
-- ダンプしたテーブルの AUTO_INCREMENT
--

--
-- テーブルの AUTO_INCREMENT `timing_type`
--
ALTER TABLE `timing_type`
  MODIFY `type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
