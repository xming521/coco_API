/*
 Navicat Premium Data Transfer

 Source Server         : 阿里云
 Source Server Type    : MySQL
 Source Server Version : 50718
 Source Host           : 47.94.199.65:3306
 Source Schema         : coco

 Target Server Type    : MySQL
 Target Server Version : 50718
 File Encoding         : 65001

 Date: 21/03/2021 20:56:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for app_list
-- ----------------------------
DROP TABLE IF EXISTS `app_list`;
CREATE TABLE `app_list`  (
  `app_id` int(11) NULL DEFAULT NULL,
  `app_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `image_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `run_command` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `app_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `timeout` int(255) NULL DEFAULT NULL,
  `network` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `start_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`app_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of app_list
-- ----------------------------
INSERT INTO `app_list` VALUES (NULL, '151', 'tensorflow/tensorflow:2.2.2-py3', 'python /mnt/easy_app/main.py', '', 60, 'none', '2021-03-21 13:26:35', 'error');
INSERT INTO `app_list` VALUES (NULL, 'error1', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '', 10, 'none', '2021-03-03 16:30:50', 'error');
INSERT INTO `app_list` VALUES (NULL, 'FlaskApp', 'flask:v1', 'python /mnt/easy_app/main.py', '', 3600, 'bridge', '2021-03-21 19:19:29', 'success');
INSERT INTO `app_list` VALUES (NULL, 'success1', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '', 50000, 'none', '2021-03-18 22:45:06', 'success');
INSERT INTO `app_list` VALUES (NULL, 'tensorflow_train', 'tensorflow:xmV2', 'python /mnt/easy_app/main.py', '', 600, 'bridge', '2021-03-21 18:08:21', 'success');
INSERT INTO `app_list` VALUES (NULL, 'timeout1', 'ubuntu:18.04', 'python /mnt/easy_app/main.py', '', 5, 'none', '2021-03-21 20:55:31', 'running');
INSERT INTO `app_list` VALUES (NULL, '运行一小时', 'flask:v1', 'python /mnt/easy_app/main.py', 'easy', 3600, 'none', '2021-03-21 20:54:56', 'stopped');

-- ----------------------------
-- Table structure for container_list
-- ----------------------------
DROP TABLE IF EXISTS `container_list`;
CREATE TABLE `container_list`  (
  `app_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `container_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `image_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `run_command` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `start_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `over_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` int(5) NULL DEFAULT NULL,
  PRIMARY KEY (`container_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of container_list
-- ----------------------------
INSERT INTO `container_list` VALUES ('运行一小时', '066ccda053', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 15:46:55', '2021-02-19 15:47:00', 137);
INSERT INTO `container_list` VALUES ('运行一小时', '06e5fc075c', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-04 14:39:34', '2021-02-04 14:45:35', NULL);
INSERT INTO `container_list` VALUES ('error1', '0718ffd03e', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 18:38:10', '2021-02-19 18:38:11', 1);
INSERT INTO `container_list` VALUES ('FlaskApp', '079e7385f0', 'flask:v1', 'python /mnt/easy_app/main.py', '2021-03-21 18:13:54', '2021-03-21 18:14:25', 136);
INSERT INTO `container_list` VALUES ('运行一小时', '07f8ffdb69', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-02 12:26:45', '2021-02-02 12:26:52', NULL);
INSERT INTO `container_list` VALUES ('运行一小时', '090da28a5e', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 18:43:06', '2021-02-19 18:43:11', 136);
INSERT INTO `container_list` VALUES ('success1', '0988a1b26c', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 10:49:46', '2021-02-19 10:50:07', 0);
INSERT INTO `container_list` VALUES ('运行一小时', '0a99a48cc6', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-18 11:22:04', '2021-02-18 11:22:11', 136);
INSERT INTO `container_list` VALUES ('tensorflow_train', '0c10476262', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-03-20 22:24:32', '2021-03-20 22:24:33', 1);
INSERT INTO `container_list` VALUES ('运行一小时', '0d1a6629ff', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-03 21:42:34', '2021-02-03 21:42:37', NULL);
INSERT INTO `container_list` VALUES ('运行一小时', '0ef9da0726', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-03 21:16:02', '2021-02-03 21:16:10', NULL);
INSERT INTO `container_list` VALUES ('error1', '0f0456ecd2', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 11:36:21', '2021-02-19 11:36:22', 1);
INSERT INTO `container_list` VALUES ('151', '0f4a5a27b1', 'tensorflow/tensorflow:2.2.2-py3', 'python /mnt/easy_app/main.py', '2021-03-21 13:26:35', '2021-03-21 13:26:36', 1);
INSERT INTO `container_list` VALUES ('151', '0f695c95a5', 'theiaide/theia-python', 'python /mnt/easy_app/main.py', '2021-03-21 13:13:56', '2021-03-21 13:14:12', 136);
INSERT INTO `container_list` VALUES ('运行一小时', '110a1ada83', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-02 12:23:42', '2021-02-02 12:23:45', NULL);
INSERT INTO `container_list` VALUES ('error1', '11fd9312c1', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-15 13:34:02', '2021-02-15 13:34:12', 137);
INSERT INTO `container_list` VALUES ('error1', '136328368c', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-15 14:33:04', '2021-02-15 14:33:04', 1);
INSERT INTO `container_list` VALUES ('运行一小时', '148b61da0b', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 18:06:32', '2021-02-19 18:06:42', 136);
INSERT INTO `container_list` VALUES ('tensorflow_train', '17124e0ce6', 'tensorflow:xmV2', 'python /mnt/easy_app/main.py', '2021-03-21 14:49:22', '2021-03-21 14:52:52', 0);
INSERT INTO `container_list` VALUES ('timeout1', '176d3c9218', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 15:45:58', '2021-02-19 15:46:04', 137);
INSERT INTO `container_list` VALUES ('tensorflow_train', '1921a12e69', 'tensorflow-xm', 'python /mnt/easy_app/main.py', '2021-03-20 23:06:30', '2021-03-20 23:06:45', 0);
INSERT INTO `container_list` VALUES ('FlaskApp', '197a37b9f4', 'flask:v1', 'python /mnt/easy_app/main.py', '2021-03-21 19:18:04', NULL, NULL);
INSERT INTO `container_list` VALUES ('FlaskApp', '1994932d1e', 'flask:v1', 'python /mnt/easy_app/main.py', '2021-03-21 18:11:40', NULL, NULL);
INSERT INTO `container_list` VALUES ('运行一小时', '1a4249be85', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-07 14:11:56', NULL, NULL);
INSERT INTO `container_list` VALUES ('success1', '1c82629fc3', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-15 14:29:46', '2021-02-15 14:29:46', 0);
INSERT INTO `container_list` VALUES ('tensorflow_train', '1d18fc11ab', 'tensorflow/tensorflow:2.2.2-py3', 'python /mnt/easy_app/main.py', '2021-03-21 13:31:16', '2021-03-21 13:31:25', 1);
INSERT INTO `container_list` VALUES ('运行一小时', '1dc1054a30', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 12:53:22', '2021-02-19 12:53:31', 136);
INSERT INTO `container_list` VALUES ('运行一小时2', '1df306773c', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-01-26 13:13:04', NULL, NULL);
INSERT INTO `container_list` VALUES ('tensorflow_train', '1ea775a191', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-03-20 19:35:47', '2021-03-20 19:36:08', 0);
INSERT INTO `container_list` VALUES ('151', '1f27ac4367', 'tensorflow/tensorflow', 'python /mnt/easy_app/main.py', '2021-03-21 13:13:49', NULL, NULL);
INSERT INTO `container_list` VALUES ('运行一小时', '1f7dabb7cc', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 15:54:21', '2021-02-19 15:54:24', 136);
INSERT INTO `container_list` VALUES ('151', '1fb4b43419', 'tensorflow/tensorflow', 'python /mnt/easy_app/main.py', '2021-03-20 23:07:41', '2021-03-20 23:07:42', 0);
INSERT INTO `container_list` VALUES ('运行一小时', '208b187af1', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-11 15:16:36', '2021-02-11 15:17:43', 136);
INSERT INTO `container_list` VALUES ('error1', '20ba3327c7', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 10:35:55', '2021-02-19 10:35:55', 1);
INSERT INTO `container_list` VALUES ('error1', '22baabe5e0', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 13:11:44', '2021-02-19 13:11:45', 1);
INSERT INTO `container_list` VALUES ('tensorflow_train', '22dc4923b1', 'tensorflow:xmV1', 'python /mnt/easy_app/main.py', '2021-03-21 14:37:29', '2021-03-21 14:37:45', 1);
INSERT INTO `container_list` VALUES ('tensorflow_train', '22ea94dc7e', 'tensorflow:xmV2', 'python /mnt/easy_app/main.py', '2021-03-21 14:54:55', '2021-03-21 14:55:01', 1);
INSERT INTO `container_list` VALUES ('success1', '2471f3ae0b', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-15 14:32:54', '2021-02-15 14:32:55', 0);
INSERT INTO `container_list` VALUES ('运行一小时', '24fa7e0f58', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-01-26 15:26:47', NULL, NULL);
INSERT INTO `container_list` VALUES ('运行一小时', '251cf0916f', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-01-26 15:26:20', NULL, NULL);
INSERT INTO `container_list` VALUES ('tensorflow_train', '28724caca5', 'tensorflow:xmV2', 'python /mnt/easy_app/main.py', '2021-03-21 18:07:47', '2021-03-21 18:07:52', 1);
INSERT INTO `container_list` VALUES ('error1', '2a5206c4e5', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 13:12:53', '2021-02-19 13:12:54', 1);
INSERT INTO `container_list` VALUES ('tensorflow_train', '2bb98f35e8', 'tensorflow:xmV2', 'python /mnt/easy_app/main.py', '2021-03-21 16:22:37', '2021-03-21 16:22:51', 0);
INSERT INTO `container_list` VALUES ('error1', '2c918d9e51', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 15:45:42', '2021-02-19 15:45:42', 1);
INSERT INTO `container_list` VALUES ('error1', '2d07786ecb', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-15 14:28:43', '2021-02-15 14:28:43', 1);
INSERT INTO `container_list` VALUES ('运行一小时', '2d1880ab0b', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-15 14:33:14', '2021-02-15 14:33:19', 136);
INSERT INTO `container_list` VALUES ('一小时运行的', '2ed42efce3', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-01-26 09:48:06', NULL, NULL);
INSERT INTO `container_list` VALUES ('success1', '30a44851ed', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 11:06:02', '2021-02-19 11:06:22', 0);
INSERT INTO `container_list` VALUES ('success1', '32f436b518', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 10:34:56', '2021-02-19 10:35:08', 136);
INSERT INTO `container_list` VALUES ('运行一小时', '34dd8fbbd2', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-09 22:46:47', '2021-02-09 22:47:11', NULL);
INSERT INTO `container_list` VALUES ('error1', '38f59061e1', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 13:07:15', '2021-02-19 13:07:16', 1);
INSERT INTO `container_list` VALUES ('运行一小时', '3a9654c1e3', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-04 11:03:52', '2021-02-04 11:03:55', NULL);
INSERT INTO `container_list` VALUES ('运行一小时', '3d18cc28a3', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-03 21:07:14', NULL, NULL);
INSERT INTO `container_list` VALUES ('151', '3d53f4ed6b', 'tensorflow/tensorflow', 'python /mnt/easy_app/main.py', '2021-03-21 13:12:47', NULL, NULL);
INSERT INTO `container_list` VALUES ('error1', '3dfa923738', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-20 11:29:03', '2021-02-20 11:29:04', 1);
INSERT INTO `container_list` VALUES ('tensorflow_train', '3ec49058e1', 'tensorflow:xmV1', 'python /mnt/easy_app/main.py', '2021-03-21 14:38:14', '2021-03-21 14:38:30', 0);
INSERT INTO `container_list` VALUES ('success1', '4079dc33a7', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-20 10:18:33', '2021-02-20 10:18:54', 0);
INSERT INTO `container_list` VALUES ('error1', '4220d0c2a4', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 12:14:14', '2021-02-19 12:14:15', 1);
INSERT INTO `container_list` VALUES ('error1', '4450688f7b', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-20 10:18:06', '2021-02-20 10:18:07', 1);
INSERT INTO `container_list` VALUES ('error1', '44662ed790', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 13:10:14', '2021-02-19 13:10:15', 1);
INSERT INTO `container_list` VALUES ('运行一小时', '472802a42b', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 15:45:51', '2021-02-19 15:46:22', 137);
INSERT INTO `container_list` VALUES ('tensorflow_train', '47ed3e4271', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-03-20 20:49:44', '2021-03-20 20:49:58', 0);
INSERT INTO `container_list` VALUES ('运行一小时', '486f8d09a8', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-11 14:53:02', '2021-02-11 14:53:05', 136);
INSERT INTO `container_list` VALUES ('运行一小时', '497c5d163a', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 15:54:28', '2021-02-19 15:54:33', 136);
INSERT INTO `container_list` VALUES ('运行一小时', '4b922fea6d', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-03 21:13:50', '2021-02-03 21:13:54', NULL);
INSERT INTO `container_list` VALUES ('success1', '4cc7690d95', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 12:15:05', '2021-02-19 12:15:25', 0);
INSERT INTO `container_list` VALUES ('tensorflow_train', '4e833d9017', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-03-20 22:24:22', '2021-03-20 22:24:22', 1);
INSERT INTO `container_list` VALUES ('timeout1', '53ec536e88', 'ubuntu:18.04', 'python /mnt/easy_app/main.py', '2021-03-21 20:55:31', NULL, NULL);
INSERT INTO `container_list` VALUES ('运行一小时', '56326f8fc9', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-18 11:20:20', '2021-02-18 11:20:23', 136);
INSERT INTO `container_list` VALUES ('运行一小时', '5643377fdb', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-20 11:29:42', '2021-02-20 12:29:42', 137);
INSERT INTO `container_list` VALUES ('运行一小时', '569f33b574', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-01-26 15:28:34', '2021-01-26 15:28:41', NULL);
INSERT INTO `container_list` VALUES ('运行一小时', '5704002150', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-01-26 15:19:02', NULL, NULL);
INSERT INTO `container_list` VALUES ('error1', '59fb07c5f1', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 16:03:00', '2021-02-19 16:03:01', 1);
INSERT INTO `container_list` VALUES ('timeout1', '5a99f5732b', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-20 11:29:21', '2021-02-20 11:29:27', 137);
INSERT INTO `container_list` VALUES ('FlaskApp', '5ba6bb540b', 'flask:v1', 'python /mnt/easy_app/main.py', '2021-03-21 18:04:35', '2021-03-21 18:04:36', 0);
INSERT INTO `container_list` VALUES ('error1', '5bce9156c7', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 18:10:07', '2021-02-19 18:10:08', 1);
INSERT INTO `container_list` VALUES ('151', '5bf07bf01a', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-03-20 22:10:43', '2021-03-20 22:10:44', 0);
INSERT INTO `container_list` VALUES ('运行一小时', '60bac3962f', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-01-26 16:13:08', '2021-01-26 16:13:45', NULL);
INSERT INTO `container_list` VALUES ('error1', '611ede5d13', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 18:42:10', '2021-02-19 18:42:11', 1);
INSERT INTO `container_list` VALUES ('FlaskApp', '613db60b4d', 'flask:v1', 'python /mnt/easy_app/main.py', '2021-03-21 18:24:56', '2021-03-21 19:19:47', 137);
INSERT INTO `container_list` VALUES ('tensorflow_train', '63e9988c56', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-03-20 22:19:07', '2021-03-20 22:19:08', 1);
INSERT INTO `container_list` VALUES ('151', '661984f65d', 'tensorflow-xm', 'python /mnt/easy_app/main.py', '2021-03-21 13:13:18', NULL, NULL);
INSERT INTO `container_list` VALUES ('tensorflow_train', '668eceb961', 'tensorflow/tensorflow:2.2.2-py3', 'python /mnt/easy_app/main.py', '2021-03-21 13:39:13', '2021-03-21 13:39:36', 137);
INSERT INTO `container_list` VALUES ('tensorflow_train', '67aed7f37e', 'tensorflow/tensorflow:2.2.2-py3', 'python /mnt/easy_app/main.py', '2021-03-21 13:40:52', '2021-03-21 13:42:43', 1);
INSERT INTO `container_list` VALUES ('151', '6912ec0b92', 'tensorflow/tensorflow', 'python /mnt/easy_app/main.py', '2021-03-20 23:07:31', '2021-03-20 23:07:32', 0);
INSERT INTO `container_list` VALUES ('151', '6a80dc0d25', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-03-20 22:11:35', '2021-03-20 22:11:36', 0);
INSERT INTO `container_list` VALUES ('tensorflow_train', '6bd4aa7c16', 'tensorflow:xmV2', 'python /mnt/easy_app/main.py', '2021-03-21 18:08:21', '2021-03-21 18:08:34', 0);
INSERT INTO `container_list` VALUES ('timeout1', '6c92f5c852', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-03-19 11:12:53', '2021-03-19 11:12:59', 137);
INSERT INTO `container_list` VALUES ('运行一小时', '6c981def35', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-18 11:21:17', '2021-02-18 11:21:20', 136);
INSERT INTO `container_list` VALUES ('运行一小时', '7060e751cc', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-14 23:03:02', '2021-02-14 23:03:36', 136);
INSERT INTO `container_list` VALUES ('运行一小时', '7102df1555', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 18:05:21', '2021-02-19 18:05:33', 136);
INSERT INTO `container_list` VALUES ('运行一小时', '71f2ca8550', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-13 20:13:59', '2021-02-13 20:14:03', 136);
INSERT INTO `container_list` VALUES ('success1', '73b3c65bf8', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-20 11:28:34', '2021-02-20 11:28:45', 0);
INSERT INTO `container_list` VALUES ('运行一小时', '740a65f0d2', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-02 12:23:36', '2021-02-02 12:23:40', NULL);
INSERT INTO `container_list` VALUES ('运行一小时', '74f45168be', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-01-26 15:12:21', NULL, NULL);
INSERT INTO `container_list` VALUES ('success1', '760e5274ed', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-18 12:03:57', '2021-02-18 12:04:17', 0);
INSERT INTO `container_list` VALUES ('运行一小时', '793ed0fb93', 'flask:v1', 'python /mnt/easy_app/main.py', '2021-03-21 20:54:56', '2021-03-21 20:55:17', 136);
INSERT INTO `container_list` VALUES ('运行一小时', '795d68295a', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-11 14:20:48', NULL, NULL);
INSERT INTO `container_list` VALUES ('运行一小时', '7efe0fccc4', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-11 14:52:04', '2021-02-11 14:52:08', 136);
INSERT INTO `container_list` VALUES ('运行一小时', '806d3215c6', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-08 10:25:55', '2021-02-08 11:25:56', NULL);
INSERT INTO `container_list` VALUES ('运行一小时', '825ac1eb2b', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-02 12:19:07', '2021-02-02 12:19:14', NULL);
INSERT INTO `container_list` VALUES ('FlaskApp', '829304baad', 'flask:v1', 'python /mnt/easy_app/main.py', '2021-03-21 19:19:29', NULL, NULL);
INSERT INTO `container_list` VALUES ('error1', '83bf7d9c1d', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 16:01:26', '2021-02-19 16:01:27', 1);
INSERT INTO `container_list` VALUES ('运行一小时', '853745209e', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-01 14:05:41', '2021-02-01 14:53:44', NULL);
INSERT INTO `container_list` VALUES ('运行一小时', '88e28f9209', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 18:06:50', '2021-02-19 18:08:23', 136);
INSERT INTO `container_list` VALUES ('运行一小时', '89102564e4', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-18 11:22:44', '2021-02-18 11:22:47', 136);
INSERT INTO `container_list` VALUES ('运行一小时', '8accd3088a', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-11 14:18:25', NULL, NULL);
INSERT INTO `container_list` VALUES ('运行一小时', '8afa336284', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-18 11:21:49', '2021-02-18 11:21:52', 137);
INSERT INTO `container_list` VALUES ('error1', '8ef40315e2', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 11:10:27', '2021-02-19 11:10:28', 1);
INSERT INTO `container_list` VALUES ('error1', '8ff9860d4d', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 19:31:05', '2021-02-19 19:31:06', 1);
INSERT INTO `container_list` VALUES ('error1', '907ee02914', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 11:10:45', '2021-02-19 11:10:46', 1);
INSERT INTO `container_list` VALUES ('运行一小时', '91d5e94229', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-14 23:03:52', '2021-02-14 23:04:01', 136);
INSERT INTO `container_list` VALUES ('运行一小时', '922f519b09', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-15 13:28:44', '2021-02-15 13:28:52', 136);
INSERT INTO `container_list` VALUES ('tensorflow_train', '9355c16cde', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-03-20 22:19:48', '2021-03-20 22:20:04', 1);
INSERT INTO `container_list` VALUES ('error1', '93d23d5add', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 12:14:18', '2021-02-19 12:14:19', 1);
INSERT INTO `container_list` VALUES ('运行一小时', '948cadddae', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-02 11:05:25', '2021-02-02 11:08:55', NULL);
INSERT INTO `container_list` VALUES ('运行一小时', '9520f2e30a', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-02 12:19:16', '2021-02-02 12:19:20', NULL);
INSERT INTO `container_list` VALUES ('tensorflow_train', '9599719f1d', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-03-20 21:19:16', '2021-03-20 21:19:29', 0);
INSERT INTO `container_list` VALUES ('运行一小时', '9646ca2e70', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 18:06:19', '2021-02-19 18:06:25', 136);
INSERT INTO `container_list` VALUES ('tensorflow_train', '97fdaa816b', 'tensorflow:xmV2', 'python /mnt/easy_app/main.py', '2021-03-21 16:08:01', '2021-03-21 16:08:10', 1);
INSERT INTO `container_list` VALUES ('151', '9894839333', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-03-20 23:09:20', '2021-03-20 23:09:21', 0);
INSERT INTO `container_list` VALUES ('timeout1', '98d31f3e59', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-03-13 11:12:53', '2021-03-13 11:12:59', 137);
INSERT INTO `container_list` VALUES ('error1', '99fe747323', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 18:28:51', '2021-02-19 18:28:52', 1);
INSERT INTO `container_list` VALUES ('运行一小时', '9b0546be48', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-02 12:23:52', '2021-02-02 12:23:54', NULL);
INSERT INTO `container_list` VALUES ('FlaskApp', '9c5f9ffda6', 'flask:v1', 'python /mnt/easy_app/main.py', '2021-03-21 18:09:29', NULL, NULL);
INSERT INTO `container_list` VALUES ('运行一小时', '9d21824718', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-01-26 15:22:18', NULL, NULL);
INSERT INTO `container_list` VALUES ('运行一小时', '9de9ca2a78', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-18 11:20:29', '2021-02-18 11:20:32', 136);
INSERT INTO `container_list` VALUES ('运行一小时', '9f6b4f18e1', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-02 12:14:10', '2021-02-02 12:14:12', NULL);
INSERT INTO `container_list` VALUES ('tensorflow_train', '9f9cd549c7', 'tensorflow:xmV2', 'python /mnt/easy_app/main.py', '2021-03-21 16:14:01', '2021-03-21 16:14:29', 0);
INSERT INTO `container_list` VALUES ('运行一小时', 'a1902cd11c', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-02 11:10:43', '2021-02-02 11:10:49', NULL);
INSERT INTO `container_list` VALUES ('运行一小时', 'a2118b2627', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-03 21:14:49', '2021-02-03 21:14:51', NULL);
INSERT INTO `container_list` VALUES ('tensorflow_train', 'a472d1ca3f', 'tensorflow/tensorflow:2.2.2-py3', 'python /mnt/easy_app/main.py', '2021-03-21 13:38:22', '2021-03-21 13:38:34', 137);
INSERT INTO `container_list` VALUES ('运行一小时', 'a47ac8cc76', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 15:45:33', '2021-02-19 15:45:39', 136);
INSERT INTO `container_list` VALUES ('运行一小时', 'a4e3b0dabb', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 12:50:50', '2021-02-19 12:51:17', 136);
INSERT INTO `container_list` VALUES ('运行一小时', 'a5125283b1', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-01-26 15:10:31', NULL, NULL);
INSERT INTO `container_list` VALUES ('success1', 'a5327d9580', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-03-04 15:31:51', '2021-03-04 15:32:01', 0);
INSERT INTO `container_list` VALUES ('error1', 'a717205bf0', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 13:06:18', '2021-02-19 13:06:18', 1);
INSERT INTO `container_list` VALUES ('151', 'a72a15df3a', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-03-20 23:11:24', '2021-03-20 23:11:24', 0);
INSERT INTO `container_list` VALUES ('151', 'a7346d54e6', 'tensorflow/tensorflow', 'python /mnt/easy_app/main.py', '2021-03-20 23:09:07', '2021-03-20 23:09:07', 0);
INSERT INTO `container_list` VALUES ('运行一小时', 'a745ea687e', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-07 15:59:06', '2021-02-07 15:59:26', NULL);
INSERT INTO `container_list` VALUES ('151', 'a9c5d79e17', 'tensorflow-flask', '56', '2021-03-04 12:40:40', '2021-03-04 12:40:42', 137);
INSERT INTO `container_list` VALUES ('运行一小时', 'ac065ab783', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-18 11:20:57', '2021-02-18 11:21:14', 136);
INSERT INTO `container_list` VALUES ('运行一小时', 'acdd3bffc1', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 18:05:58', '2021-02-19 18:06:01', 136);
INSERT INTO `container_list` VALUES ('success1', 'af8294e9b7', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 11:04:35', '2021-02-19 11:04:56', 0);
INSERT INTO `container_list` VALUES ('运行一小时', 'b0f0460f8d', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-02 14:18:43', '2021-02-02 14:24:41', NULL);
INSERT INTO `container_list` VALUES ('tensorflow_train', 'b1567bf896', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-03-20 22:27:59', '2021-03-20 22:28:12', 0);
INSERT INTO `container_list` VALUES ('error1', 'b306aa411d', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 18:05:15', '2021-02-19 18:05:15', 1);
INSERT INTO `container_list` VALUES ('运行一小时', 'b5bf6df9af', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-03 21:05:05', NULL, NULL);
INSERT INTO `container_list` VALUES ('success1', 'b6f680b830', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 15:45:48', '2021-02-19 15:46:09', 0);
INSERT INTO `container_list` VALUES ('运行一小时', 'b700f639d8', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-02 12:21:02', '2021-02-02 12:21:06', NULL);
INSERT INTO `container_list` VALUES ('error1', 'b8ac8d5884', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 13:15:42', '2021-02-19 13:15:42', 1);
INSERT INTO `container_list` VALUES ('运行一小时', 'ba86dc66f1', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-02 14:24:42', NULL, NULL);
INSERT INTO `container_list` VALUES ('运行一小时', 'bd36f236d3', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-20 11:28:16', '2021-02-20 11:29:27', 136);
INSERT INTO `container_list` VALUES ('151', 'c024289f13', 'tensorflow/tensorflow', 'python /mnt/easy_app/main.py', '2021-03-21 13:13:43', NULL, NULL);
INSERT INTO `container_list` VALUES ('运行一小时', 'c036a94b83', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-18 12:02:40', '2021-02-18 12:02:49', 136);
INSERT INTO `container_list` VALUES ('tensorflow_train', 'c18ebea6af', 'tensorflow:xmV2', 'python /mnt/easy_app/main.py', '2021-03-21 15:01:52', '2021-03-21 15:03:43', 0);
INSERT INTO `container_list` VALUES ('timeout1', 'c51f529909', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 11:11:31', '2021-02-19 11:11:36', 137);
INSERT INTO `container_list` VALUES ('tensorflow_train', 'c598085096', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-03-20 22:23:30', '2021-03-20 22:23:31', 1);
INSERT INTO `container_list` VALUES ('运行一小时', 'c5b49f60ac', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-02 12:31:27', '2021-02-02 13:31:27', NULL);
INSERT INTO `container_list` VALUES ('运行一小时', 'c637c2222a', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-04 14:29:23', '2021-02-04 14:30:18', NULL);
INSERT INTO `container_list` VALUES ('运行一小时', 'c65dbae781', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-15 18:57:16', '2021-02-15 18:57:26', 136);
INSERT INTO `container_list` VALUES ('运行一小时', 'c72d6f5628', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-01-26 14:28:25', NULL, NULL);
INSERT INTO `container_list` VALUES ('success1', 'c7cd7d9823', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-20 10:18:56', '2021-02-20 10:19:06', 0);
INSERT INTO `container_list` VALUES ('运行一小时', 'c8265b2481', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-11 15:20:06', '2021-02-11 15:20:14', 136);
INSERT INTO `container_list` VALUES ('运行一小时', 'c96094ba68', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 13:03:35', NULL, 136);
INSERT INTO `container_list` VALUES ('FlaskApp', 'cb36ffbd1b', 'flask:v1', 'python /mnt/easy_app/main.py', '2021-03-21 18:09:54', NULL, NULL);
INSERT INTO `container_list` VALUES ('error1', 'ccd3435912', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 18:40:53', '2021-02-19 18:40:53', 1);
INSERT INTO `container_list` VALUES ('success1', 'cd888a6f75', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-03-18 22:45:06', '2021-03-18 22:45:17', 0);
INSERT INTO `container_list` VALUES ('运行一小时', 'd023c87c3f', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-02 11:23:26', '2021-02-02 11:24:06', NULL);
INSERT INTO `container_list` VALUES ('运行一小时', 'd1db14e165', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 12:55:48', '2021-02-19 12:55:53', 136);
INSERT INTO `container_list` VALUES ('运行一小时', 'd820424835', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-03 15:28:20', '2021-02-03 15:28:23', NULL);
INSERT INTO `container_list` VALUES ('error1', 'd866053a25', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-03-03 16:30:50', '2021-03-03 16:30:51', 1);
INSERT INTO `container_list` VALUES ('tensorflow_train', 'd875d6aafb', 'tensorflow/tensorflow:1.15.5-py3', 'python /mnt/easy_app/main.py', '2021-03-21 13:45:25', '2021-03-21 13:45:42', 0);
INSERT INTO `container_list` VALUES ('运行一小时', 'da6235f0ef', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-20 10:19:06', '2021-02-20 10:19:51', 136);
INSERT INTO `container_list` VALUES ('error1', 'db0ddacb06', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 13:08:03', '2021-02-19 13:08:04', 1);
INSERT INTO `container_list` VALUES ('error1', 'dc268bdf72', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 12:14:02', '2021-02-19 12:14:03', 1);
INSERT INTO `container_list` VALUES ('运行一小时', 'dc5483c08b', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-02 12:22:52', '2021-02-02 12:22:56', NULL);
INSERT INTO `container_list` VALUES ('success1', 'e063686a10', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 11:08:54', '2021-02-19 11:09:15', 0);
INSERT INTO `container_list` VALUES ('运行一小时', 'e0bedc2bc5', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-02 12:15:27', '2021-02-02 12:15:31', NULL);
INSERT INTO `container_list` VALUES ('success1', 'e1b06c84da', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 18:43:19', '2021-02-19 18:43:40', 0);
INSERT INTO `container_list` VALUES ('success1', 'e22163fc4b', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 10:43:39', '2021-02-19 10:43:59', 0);
INSERT INTO `container_list` VALUES ('151', 'e26143a2b3', 'tensorflow/tensorflow', 'python /mnt/easy_app/main.py', '2021-03-20 23:11:36', '2021-03-20 23:11:37', 0);
INSERT INTO `container_list` VALUES ('tensorflow_train', 'e300b26185', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-03-20 22:19:16', '2021-03-20 22:19:16', 1);
INSERT INTO `container_list` VALUES ('tensorflow_train', 'e583cb667f', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-03-20 22:22:40', '2021-03-20 22:22:54', 0);
INSERT INTO `container_list` VALUES ('151', 'e7df4ac514', 'tensorflow/tensorflow', 'python /mnt/easy_app/main.py', '2021-03-21 13:19:30', NULL, NULL);
INSERT INTO `container_list` VALUES ('运行一小时', 'e82343eaa9', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-02 11:14:52', '2021-02-02 11:15:02', NULL);
INSERT INTO `container_list` VALUES ('success1', 'eb73503236', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-03-03 16:30:54', '2021-03-03 16:31:04', 0);
INSERT INTO `container_list` VALUES ('tensorflow_train', 'eb87a897db', 'tensorflow:xmV1', 'python /mnt/easy_app/main.py', '2021-03-21 14:35:40', '2021-03-21 14:36:06', 0);
INSERT INTO `container_list` VALUES ('151', 'edd511d549', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-03-20 22:10:31', '2021-03-20 22:10:31', 0);
INSERT INTO `container_list` VALUES ('运行一小时', 'eed3db7e9a', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-03-03 16:30:48', '2021-03-03 16:32:16', 136);
INSERT INTO `container_list` VALUES ('tensorflow_train', 'f029274f74', 'tensorflow/tensorflow:2.2.2-py3', 'python /mnt/easy_app/main.py', '2021-03-21 13:30:18', '2021-03-21 13:30:23', 1);
INSERT INTO `container_list` VALUES ('error1', 'f0660d2bc2', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 13:10:47', '2021-02-19 13:10:48', 1);
INSERT INTO `container_list` VALUES ('error1', 'f097fdf5ad', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 18:39:56', '2021-02-19 18:39:56', 1);
INSERT INTO `container_list` VALUES ('tensorflow_train', 'f2ac2b7fff', 'tensorflow:xmV2', 'python /mnt/easy_app/main.py', '2021-03-21 14:55:20', '2021-03-21 14:57:47', 1);
INSERT INTO `container_list` VALUES ('tensorflow_train', 'f2ebef0025', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-03-20 19:36:25', '2021-03-20 19:36:39', 0);
INSERT INTO `container_list` VALUES ('运行一小时', 'f3e579d180', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-11 14:23:06', '2021-02-11 14:23:08', 137);
INSERT INTO `container_list` VALUES ('运行一小时', 'f4b17998ca', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-02 11:27:02', '2021-02-02 11:27:06', NULL);
INSERT INTO `container_list` VALUES ('tensorflow_train', 'f58ef17a4f', 'tensorflow/tensorflow:2.2.2-py3', 'python /mnt/easy_app/main.py', '2021-03-21 13:32:04', '2021-03-21 13:32:26', 1);
INSERT INTO `container_list` VALUES ('FlaskApp', 'f66838b215', 'flask:v1', 'python /mnt/easy_app/main.py', '2021-03-21 18:08:39', '2021-03-21 18:08:46', 1);
INSERT INTO `container_list` VALUES ('运行一小时', 'f677ea0af4', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 12:47:28', '2021-02-19 12:47:49', 136);
INSERT INTO `container_list` VALUES ('151', 'f786f0ef31', 'tensorflow-flask', '56', '2021-03-04 12:40:25', '2021-03-04 12:40:28', 137);
INSERT INTO `container_list` VALUES ('运行一小时', 'f7890b357e', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-10 22:58:07', NULL, NULL);
INSERT INTO `container_list` VALUES ('运行一小时', 'f8a4f523e0', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 18:09:50', '2021-02-19 18:09:52', 136);
INSERT INTO `container_list` VALUES ('运行一小时', 'f91cca17a3', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-01-26 15:24:00', NULL, NULL);
INSERT INTO `container_list` VALUES ('运行一小时', 'fc037b6ae8', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-19 15:47:14', '2021-02-19 15:47:25', 137);
INSERT INTO `container_list` VALUES ('运行一小时', 'fc51270c0f', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-02-02 12:23:59', '2021-02-02 12:24:02', NULL);
INSERT INTO `container_list` VALUES ('运行一小时', 'fd8709fc31', 'tensorflow-flask', 'python /mnt/easy_app/main.py', '2021-01-26 12:12:39', NULL, NULL);
INSERT INTO `container_list` VALUES ('tensorflow_train', 'fd965983f7', 'tensorflow:xmV2', 'python /mnt/easy_app/main.py', '2021-03-21 16:21:27', '2021-03-21 16:21:43', 0);

-- ----------------------------
-- Table structure for image_list
-- ----------------------------
DROP TABLE IF EXISTS `image_list`;
CREATE TABLE `image_list`  (
  `image_id` int(11) NOT NULL AUTO_INCREMENT,
  `image_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tags` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`image_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of image_list
-- ----------------------------

-- ----------------------------
-- Table structure for scheduler_jobs
-- ----------------------------
DROP TABLE IF EXISTS `scheduler_jobs`;
CREATE TABLE `scheduler_jobs`  (
  `id` varchar(191) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `next_run_time` double NULL DEFAULT NULL,
  `job_state` blob NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ix_scheduler_jobs_next_run_time`(`next_run_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of scheduler_jobs
-- ----------------------------
INSERT INTO `scheduler_jobs` VALUES ('dcf6921ce28144d3a3e645f33b27a1e4', 1616382773.764844, 0x8004950B020000000000007D94288C0776657273696F6E944B018C026964948C206463663639323163653238313434643361336536343566333362323761316534948C0466756E63948C1F6170692E726F75746572732E7363686564756C65723A6170705F7374617274948C0774726967676572948C1D61707363686564756C65722E74726967676572732E696E74657276616C948C0F496E74657276616C547269676765729493942981947D942868014B028C0874696D657A6F6E65948C047079747A948C025F70949394288C0D417369612F5368616E67686169944DE8714B008C034C4D5494749452948C0A73746172745F64617465948C086461746574696D65948C086461746574696D65949394430A07E502140B0C350BABAC94680F2868104D80704B008C034353549474945294869452948C08656E645F64617465944E8C08696E74657276616C9468158C0974696D6564656C74619493944B014B004B00879452948C066A6974746572944E75628C086578656375746F72948C0764656661756C74948C0461726773948C0874696D656F7574319485948C066B7761726773947D948C046E616D65948C096170705F7374617274948C126D6973666972655F67726163655F74696D65944B018C08636F616C6573636594888C0D6D61785F696E7374616E636573944B018C0D6E6578745F72756E5F74696D65946817430A07E503160B0C350BABAC94681B86945294752E);

SET FOREIGN_KEY_CHECKS = 1;
