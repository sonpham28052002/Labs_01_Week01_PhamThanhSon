-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th9 20, 2023 lúc 07:55 PM
-- Phiên bản máy phục vụ: 10.4.28-MariaDB
-- Phiên bản PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `mydbweek_01`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `account`
--

CREATE TABLE `account` (
  `account_id` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `status` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `account`
--

INSERT INTO `account` (`account_id`, `email`, `full_name`, `password`, `phone`, `status`) VALUES
('user1', 'sonpham28052002@gmail.com', 'Phạm Thanh Sơn', 'sonpham123', '0346676956', b'1'),
('user2', 'leonpham17042002@gmail.com', 'Leon Phạm', 'leonpham123', '0346676957', b'1'),
('user3', 'haonguyen18052002@gmail.com', 'Hào Nguyễn', 'hoanguyen123', '0346676958', b'1'),
('user4', 'hanguyen11012001@gmail.com', 'Hạ Nguyễn', 'hanguyen123', '0346676959', b'1'),
('user5', 'sangvo21042002@gmail.com', 'Sang Võ', 'sangvo123', '0346676960', b'1'),
('user6', 'hiennguyen06012005@gmail.com', 'Hiền Nguyễn', 'hiennguyen123', '0346676961', b'1'),
('user7', 'hienle01012005@gmail.com', 'Hiền Lê', 'hienle123', '0346676962', b'1');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `grant_access`
--

CREATE TABLE `grant_access` (
  `is_gant` bit(1) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `account_id` varchar(255) NOT NULL,
  `role_id` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `grant_access`
--

INSERT INTO `grant_access` (`is_gant`, `note`, `account_id`, `role_id`) VALUES
(b'1', NULL, 'user1', 'role5'),
(b'1', NULL, 'user2', 'role1'),
(b'1', NULL, 'user2', 'role3'),
(b'1', NULL, 'user2', 'role4'),
(b'1', NULL, 'user3', 'role1'),
(b'1', NULL, 'user3', 'role2'),
(b'1', NULL, 'user3', 'role4'),
(b'1', NULL, 'user4', 'role1'),
(b'1', NULL, 'user4', 'role4'),
(b'1', NULL, 'user5', 'role3'),
(b'1', NULL, 'user5', 'role4'),
(b'1', NULL, 'user6', 'role2'),
(b'1', NULL, 'user6', 'role4'),
(b'1', NULL, 'user7', 'role1'),
(b'1', NULL, 'user7', 'role3'),
(b'1', NULL, 'user7', 'role4');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `log`
--

CREATE TABLE `log` (
  `id` bigint(20) NOT NULL,
  `login_time` datetime(6) DEFAULT NULL,
  `logout_time` datetime(6) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `account_account_id` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `log_seq`
--

CREATE TABLE `log_seq` (
  `next_not_cached_value` bigint(21) NOT NULL,
  `minimum_value` bigint(21) NOT NULL,
  `maximum_value` bigint(21) NOT NULL,
  `start_value` bigint(21) NOT NULL COMMENT 'start value when sequences is created or value if RESTART is used',
  `increment` bigint(21) NOT NULL COMMENT 'increment value',
  `cache_size` bigint(21) UNSIGNED NOT NULL,
  `cycle_option` tinyint(1) UNSIGNED NOT NULL COMMENT '0 if no cycles are allowed, 1 if the sequence should begin a new cycle when maximum_value is passed',
  `cycle_count` bigint(21) NOT NULL COMMENT 'How many cycles have been done'
) ENGINE=InnoDB;

--
-- Đang đổ dữ liệu cho bảng `log_seq`
--

INSERT INTO `log_seq` (`next_not_cached_value`, `minimum_value`, `maximum_value`, `start_value`, `increment`, `cache_size`, `cycle_option`, `cycle_count`) VALUES
(1, 1, 9223372036854775806, 1, 50, 1000, 0, 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `role`
--

CREATE TABLE `role` (
  `role_id` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `role_name` varchar(255) DEFAULT NULL,
  `status` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `role`
--

INSERT INTO `role` (`role_id`, `description`, `role_name`, `status`) VALUES
('role1', 'Cho phép người dùng thực hiện cập nhật thông tin.', 'Cập Nhật', b'1'),
('role2', 'Cho phép người dùng thực hiện xoá thông tin.', 'Xoá Thông tin', b'1'),
('role3', 'Cho phép người dùng thực hiện cập nhật mật khẩu.', 'Cập Nhật Mật Khẩu', b'1'),
('role4', 'Cho phép người dùng thực hiện xem thông tin.', 'User', b'1'),
('role5', 'admin', 'admin', b'1');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`account_id`);

--
-- Chỉ mục cho bảng `grant_access`
--
ALTER TABLE `grant_access`
  ADD PRIMARY KEY (`account_id`,`role_id`),
  ADD KEY `FKn8vuhdmux6pxjr90wu37ppej0` (`role_id`);

--
-- Chỉ mục cho bảng `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`account_account_id`,`id`);

--
-- Chỉ mục cho bảng `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`role_id`);

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `grant_access`
--
ALTER TABLE `grant_access`
  ADD CONSTRAINT `FK6d5l1bbvt3fbq9wtn94s22hxq` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FKn8vuhdmux6pxjr90wu37ppej0` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `log`
--
ALTER TABLE `log`
  ADD CONSTRAINT `FKjx87fei2dcbnlla71xypimxs1` FOREIGN KEY (`account_account_id`) REFERENCES `account` (`account_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
