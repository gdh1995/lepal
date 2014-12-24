/*
Navicat MySQL Data Transfer

Source Server         : lepai-remote
Source Server Version : 50537
Source Host           : 115.28.88.10:3306
Source Database       : health_miner

Target Server Type    : MYSQL
Target Server Version : 50537
File Encoding         : 65001

Date: 2014-12-16 15:21:40
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `auth_group`
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_group_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`) USING BTREE,
  KEY `auth_group_permissions_5f412f9a` (`group_id`) USING BTREE,
  KEY `auth_group_permissions_83d7f98b` (`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissions_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_group_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_permission`
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`) USING BTREE,
  KEY `auth_permission_37ef4eb4` (`content_type_id`) USING BTREE,
  CONSTRAINT `auth_permission_ibfk_1` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add permission', '1', 'add_permission');
INSERT INTO `auth_permission` VALUES ('2', 'Can change permission', '1', 'change_permission');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete permission', '1', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('4', 'Can add group', '2', 'add_group');
INSERT INTO `auth_permission` VALUES ('5', 'Can change group', '2', 'change_group');
INSERT INTO `auth_permission` VALUES ('6', 'Can delete group', '2', 'delete_group');
INSERT INTO `auth_permission` VALUES ('7', 'Can add user', '3', 'add_user');
INSERT INTO `auth_permission` VALUES ('8', 'Can change user', '3', 'change_user');
INSERT INTO `auth_permission` VALUES ('9', 'Can delete user', '3', 'delete_user');
INSERT INTO `auth_permission` VALUES ('10', 'Can add content type', '4', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('11', 'Can change content type', '4', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('12', 'Can delete content type', '4', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('13', 'Can add session', '5', 'add_session');
INSERT INTO `auth_permission` VALUES ('14', 'Can change session', '5', 'change_session');
INSERT INTO `auth_permission` VALUES ('15', 'Can delete session', '5', 'delete_session');
INSERT INTO `auth_permission` VALUES ('16', 'Can add site', '6', 'add_site');
INSERT INTO `auth_permission` VALUES ('17', 'Can change site', '6', 'change_site');
INSERT INTO `auth_permission` VALUES ('18', 'Can delete site', '6', 'delete_site');
INSERT INTO `auth_permission` VALUES ('19', 'Can add user', '7', 'add_user');
INSERT INTO `auth_permission` VALUES ('20', 'Can change user', '7', 'change_user');
INSERT INTO `auth_permission` VALUES ('21', 'Can delete user', '7', 'delete_user');
INSERT INTO `auth_permission` VALUES ('22', 'Can add administrator', '8', 'add_administrator');
INSERT INTO `auth_permission` VALUES ('23', 'Can change administrator', '8', 'change_administrator');
INSERT INTO `auth_permission` VALUES ('24', 'Can delete administrator', '8', 'delete_administrator');
INSERT INTO `auth_permission` VALUES ('25', 'Can add doctor', '9', 'add_doctor');
INSERT INTO `auth_permission` VALUES ('26', 'Can change doctor', '9', 'change_doctor');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete doctor', '9', 'delete_doctor');
INSERT INTO `auth_permission` VALUES ('28', 'Can add advisor', '10', 'add_advisor');
INSERT INTO `auth_permission` VALUES ('29', 'Can change advisor', '10', 'change_advisor');
INSERT INTO `auth_permission` VALUES ('30', 'Can delete advisor', '10', 'delete_advisor');
INSERT INTO `auth_permission` VALUES ('31', 'Can add patient', '11', 'add_patient');
INSERT INTO `auth_permission` VALUES ('32', 'Can change patient', '11', 'change_patient');
INSERT INTO `auth_permission` VALUES ('33', 'Can delete patient', '11', 'delete_patient');
INSERT INTO `auth_permission` VALUES ('34', 'Can add r e_ oversee patients', '12', 'add_re_overseepatients');
INSERT INTO `auth_permission` VALUES ('35', 'Can change r e_ oversee patients', '12', 'change_re_overseepatients');
INSERT INTO `auth_permission` VALUES ('36', 'Can delete r e_ oversee patients', '12', 'delete_re_overseepatients');
INSERT INTO `auth_permission` VALUES ('37', 'Can add medical record', '13', 'add_medicalrecord');
INSERT INTO `auth_permission` VALUES ('38', 'Can change medical record', '13', 'change_medicalrecord');
INSERT INTO `auth_permission` VALUES ('39', 'Can delete medical record', '13', 'delete_medicalrecord');
INSERT INTO `auth_permission` VALUES ('40', 'Can add record comment', '14', 'add_recordcomment');
INSERT INTO `auth_permission` VALUES ('41', 'Can change record comment', '14', 'change_recordcomment');
INSERT INTO `auth_permission` VALUES ('42', 'Can delete record comment', '14', 'delete_recordcomment');
INSERT INTO `auth_permission` VALUES ('43', 'Can add registration code', '15', 'add_registrationcode');
INSERT INTO `auth_permission` VALUES ('44', 'Can change registration code', '15', 'change_registrationcode');
INSERT INTO `auth_permission` VALUES ('45', 'Can delete registration code', '15', 'delete_registrationcode');

-- ----------------------------
-- Table structure for `auth_user`
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_user_groups`
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`) USING BTREE,
  KEY `auth_user_groups_6340c63c` (`user_id`) USING BTREE,
  KEY `auth_user_groups_5f412f9a` (`group_id`) USING BTREE,
  CONSTRAINT `auth_user_groups_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `auth_user_groups_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_user_user_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`) USING BTREE,
  KEY `auth_user_user_permissions_6340c63c` (`user_id`) USING BTREE,
  KEY `auth_user_user_permissions_83d7f98b` (`permission_id`) USING BTREE,
  CONSTRAINT `auth_user_user_permissions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `auth_user_user_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for `core_administrator`
-- ----------------------------
DROP TABLE IF EXISTS `core_administrator`;
CREATE TABLE `core_administrator` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`) USING BTREE,
  CONSTRAINT `core_administrator_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of core_administrator
-- ----------------------------
INSERT INTO `core_administrator` VALUES ('1', '1', '0');

-- ----------------------------
-- Table structure for `core_advisor`
-- ----------------------------
DROP TABLE IF EXISTS `core_advisor`;
CREATE TABLE `core_advisor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`) USING BTREE,
  CONSTRAINT `core_advisor_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of core_advisor
-- ----------------------------
INSERT INTO `core_advisor` VALUES ('1', '7', '0');
INSERT INTO `core_advisor` VALUES ('2', '8', '0');
INSERT INTO `core_advisor` VALUES ('3', '9', '0');
INSERT INTO `core_advisor` VALUES ('4', '10', '0');
INSERT INTO `core_advisor` VALUES ('5', '11', '0');
INSERT INTO `core_advisor` VALUES ('6', '18', '1');

-- ----------------------------
-- Table structure for `core_doctor`
-- ----------------------------
DROP TABLE IF EXISTS `core_doctor`;
CREATE TABLE `core_doctor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`) USING BTREE,
  CONSTRAINT `core_doctor_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of core_doctor
-- ----------------------------
INSERT INTO `core_doctor` VALUES ('1', '2', '0');
INSERT INTO `core_doctor` VALUES ('2', '3', '0');
INSERT INTO `core_doctor` VALUES ('3', '4', '0');
INSERT INTO `core_doctor` VALUES ('4', '5', '0');
INSERT INTO `core_doctor` VALUES ('5', '6', '0');
INSERT INTO `core_doctor` VALUES ('6', '17', '1');

-- ----------------------------
-- Table structure for `core_medicalrecord`
-- ----------------------------
DROP TABLE IF EXISTS `core_medicalrecord`;
CREATE TABLE `core_medicalrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uploader_id` int(11) DEFAULT NULL,
  `upload_time` datetime NOT NULL,
  `record_time` datetime NOT NULL,
  `patient_id` int(11) NOT NULL,
  `serial_number` varchar(150) NOT NULL,
  `data_id` varchar(250) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `data_id` (`data_id`) USING BTREE,
  KEY `core_medicalrecord_8a3cba94` (`uploader_id`) USING BTREE,
  KEY `core_medicalrecord_1fe1df59` (`patient_id`) USING BTREE,
  CONSTRAINT `core_medicalrecord_ibfk_1` FOREIGN KEY (`uploader_id`) REFERENCES `core_user` (`id`),
  CONSTRAINT `core_medicalrecord_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `core_patient` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of core_medicalrecord
-- ----------------------------
INSERT INTO `core_medicalrecord` VALUES ('1', '7', '2014-06-15 15:38:03', '2014-06-16 04:38:11', '7', 'M041000000020_0004', '539dbddb99f09357fbddf3e6', '0');
INSERT INTO `core_medicalrecord` VALUES ('2', '7', '2014-06-15 15:38:11', '2014-06-16 04:38:11', '7', 'M041000000020_0004', '539dbde399f09357fbddf3e7', '0');
INSERT INTO `core_medicalrecord` VALUES ('3', '7', '2014-06-15 15:38:22', '2014-06-16 04:38:11', '7', 'M041000000020_0004', '539dbdee99f09357fbddf3e8', '0');
INSERT INTO `core_medicalrecord` VALUES ('4', '7', '2014-06-15 15:38:35', '2014-06-16 04:30:26', '7', 'M041000000020_0001', '539dbdfb99f09357fbddf3e9', '0');
INSERT INTO `core_medicalrecord` VALUES ('5', '7', '2014-06-15 15:38:45', '2014-06-16 04:32:11', '7', 'M041000000020_0002', '539dbe0599f09357fbddf3ea', '0');
INSERT INTO `core_medicalrecord` VALUES ('6', '7', '2014-06-15 15:38:55', '2014-06-16 04:36:35', '7', 'M041000000020_0003', '539dbe0f99f09357fbddf3eb', '0');
INSERT INTO `core_medicalrecord` VALUES ('7', '7', '2014-06-15 16:26:23', '2014-06-16 05:23:57', '7', 'M041000000020_0005', '539dc92f99f09357fbddf3ec', '1');
INSERT INTO `core_medicalrecord` VALUES ('8', '7', '2014-06-16 03:04:59', '2014-06-16 16:03:04', '8', 'M041000000021_0001', '539e5edb99f09357fbddf3ed', '0');
INSERT INTO `core_medicalrecord` VALUES ('9', '1', '2014-06-17 03:19:29', '2014-06-17 16:19:29', '1', '31aa640ca8d4', '539fb3c199f09346840a486a', '0');
INSERT INTO `core_medicalrecord` VALUES ('10', '1', '2014-06-17 03:19:30', '2014-06-17 16:19:29', '4', '31d010c6a8d4', '539fb3c299f09346840a486b', '0');
INSERT INTO `core_medicalrecord` VALUES ('11', '1', '2014-06-17 03:19:30', '2014-06-17 16:19:30', '5', '31edbda6a8d4', '539fb3c299f09346840a486c', '0');
INSERT INTO `core_medicalrecord` VALUES ('12', '1', '2014-06-17 03:19:30', '2014-06-17 16:19:30', '7', '32195448a8d4', '539fb3c299f09346840a486d', '0');
INSERT INTO `core_medicalrecord` VALUES ('13', '1', '2014-06-17 03:19:30', '2014-06-17 16:19:30', '6', '322dfaa6a8d4', '539fb3c299f09346840a486e', '0');
INSERT INTO `core_medicalrecord` VALUES ('14', '1', '2014-06-17 03:21:23', '2014-06-17 16:21:23', '3', '756bbb96a8d4', '539fb43399f09347c661b21f', '0');
INSERT INTO `core_medicalrecord` VALUES ('15', '1', '2014-06-17 03:21:23', '2014-06-17 16:21:23', '2', '7589b150a8d4', '539fb43399f09347c661b220', '1');
INSERT INTO `core_medicalrecord` VALUES ('16', '1', '2014-06-17 03:21:23', '2014-06-17 16:21:23', '6', '75a232b6a8d4', '539fb43399f09347c661b221', '0');
INSERT INTO `core_medicalrecord` VALUES ('17', '1', '2014-06-17 03:21:23', '2014-06-17 16:21:23', '8', '75b901daa8d4', '539fb43399f09347c661b222', '0');
INSERT INTO `core_medicalrecord` VALUES ('18', '1', '2014-06-17 03:21:24', '2014-06-17 16:21:24', '5', '75d42a5aa8d4', '539fb43499f09347c661b223', '0');
INSERT INTO `core_medicalrecord` VALUES ('19', '1', '2014-06-17 03:29:14', '2014-06-17 16:29:14', '5', '8e09e2e4a8d4', '539fb60a99f09349328b94ce', '0');
INSERT INTO `core_medicalrecord` VALUES ('20', '1', '2014-06-17 03:29:14', '2014-06-17 16:29:14', '4', '8e49a992a8d4', '539fb60a99f09349328b94d7', '0');
INSERT INTO `core_medicalrecord` VALUES ('21', '1', '2014-06-17 03:29:14', '2014-06-17 16:29:14', '8', '8e6aa0f2a8d4', '539fb60a99f09349328b94e0', '0');
INSERT INTO `core_medicalrecord` VALUES ('22', '1', '2014-06-17 03:29:14', '2014-06-17 16:29:14', '7', '8e817b1aa8d4', '539fb60a99f09349328b94e9', '0');
INSERT INTO `core_medicalrecord` VALUES ('23', '1', '2014-06-17 03:29:15', '2014-06-17 16:29:15', '3', '8e991a4aa8d4', '539fb60b99f09349328b94f2', '0');
INSERT INTO `core_medicalrecord` VALUES ('24', '1', '2014-06-17 04:22:40', '2014-06-17 17:22:40', '4', '055701fea8d4', '539fc29099f09350eae1c25a', '0');
INSERT INTO `core_medicalrecord` VALUES ('25', '1', '2014-06-17 04:22:41', '2014-06-17 17:22:40', '6', '05767b92a8d4', '539fc29199f09350eae1c26f', '0');
INSERT INTO `core_medicalrecord` VALUES ('26', '1', '2014-06-17 04:22:41', '2014-06-17 17:22:41', '1', '05943952a8d4', '539fc29199f09350eae1c284', '0');
INSERT INTO `core_medicalrecord` VALUES ('27', '1', '2014-06-17 04:22:41', '2014-06-17 17:22:41', '5', '05aba4caa8d4', '539fc29199f09350eae1c299', '0');
INSERT INTO `core_medicalrecord` VALUES ('28', '1', '2014-06-17 04:22:41', '2014-06-17 17:22:41', '7', '05cd11e6a8d4', '539fc29199f09350eae1c2ae', '0');
INSERT INTO `core_medicalrecord` VALUES ('29', '1', '2014-06-17 04:49:38', '2014-06-17 17:49:38', '2', 'c9ca551aa8d4', '539fc8e299f09350eae1c2c3', '0');
INSERT INTO `core_medicalrecord` VALUES ('30', '1', '2014-06-17 04:49:39', '2014-06-17 17:49:39', '6', 'c9e34908a8d4', '539fc8e399f09350eae1c2d8', '0');
INSERT INTO `core_medicalrecord` VALUES ('31', '1', '2014-06-17 04:49:39', '2014-06-17 17:49:39', '7', 'ca037f0ca8d4', '539fc8e399f09350eae1c2ed', '0');
INSERT INTO `core_medicalrecord` VALUES ('32', '1', '2014-06-17 04:49:39', '2014-06-17 17:49:39', '4', 'ca2366faa8d4', '539fc8e399f09350eae1c302', '0');
INSERT INTO `core_medicalrecord` VALUES ('33', '1', '2014-06-17 04:49:39', '2014-06-17 17:49:39', '3', 'ca394286a8d4', '539fc8e399f09350eae1c317', '1');
INSERT INTO `core_medicalrecord` VALUES ('34', '1', '2014-06-17 04:49:40', '2014-06-17 17:49:40', '4', 'cae1558ea8d4', '539fc8e499f09350eae1c32c', '0');
INSERT INTO `core_medicalrecord` VALUES ('35', '1', '2014-06-17 04:49:40', '2014-06-17 17:49:40', '8', 'caf99b62a8d4', '539fc8e499f09350eae1c341', '0');
INSERT INTO `core_medicalrecord` VALUES ('36', '1', '2014-06-17 04:49:41', '2014-06-17 17:49:40', '1', 'cb10915aa8d4', '539fc8e599f09350eae1c356', '0');
INSERT INTO `core_medicalrecord` VALUES ('37', '1', '2014-06-17 04:49:41', '2014-06-17 17:49:41', '5', 'cb2d4b38a8d4', '539fc8e599f09350eae1c36b', '0');
INSERT INTO `core_medicalrecord` VALUES ('38', '1', '2014-06-17 04:49:41', '2014-06-17 17:49:41', '7', 'cb5ce19aa8d4', '539fc8e599f09350eae1c380', '0');
INSERT INTO `core_medicalrecord` VALUES ('39', '1', '2014-06-17 04:49:42', '2014-06-17 17:49:42', '5', 'cbfc06b2a8d4', '539fc8e699f09350eae1c395', '0');
INSERT INTO `core_medicalrecord` VALUES ('40', '1', '2014-06-17 04:49:42', '2014-06-17 17:49:42', '6', 'cc1ad038a8d4', '539fc8e699f09350eae1c3aa', '0');
INSERT INTO `core_medicalrecord` VALUES ('41', '1', '2014-06-17 04:49:42', '2014-06-17 17:49:42', '1', 'cc31fe7aa8d4', '539fc8e699f09350eae1c3bf', '0');
INSERT INTO `core_medicalrecord` VALUES ('42', '1', '2014-06-17 04:49:43', '2014-06-17 17:49:43', '2', 'cc48c826a8d4', '539fc8e799f09350eae1c3d4', '0');
INSERT INTO `core_medicalrecord` VALUES ('43', '1', '2014-06-17 04:49:43', '2014-06-17 17:49:43', '3', 'cc6658c8a8d4', '539fc8e799f09350eae1c3e9', '0');
INSERT INTO `core_medicalrecord` VALUES ('44', '7', '2014-06-18 08:22:27', '2014-06-18 21:21:08', '10', 'M041000000023_0001', '53a14c4399f093675c40fabe', '0');
INSERT INTO `core_medicalrecord` VALUES ('45', '7', '2014-06-18 08:23:43', '2014-06-18 21:23:09', '10', 'M041000000023_0002', '53a14c8f99f093675c40fac3', '0');
INSERT INTO `core_medicalrecord` VALUES ('46', '7', '2014-06-18 08:24:45', '2014-06-18 21:24:07', '10', 'M041000000023_0003', '53a14ccd99f093675c40fac8', '0');
INSERT INTO `core_medicalrecord` VALUES ('47', '7', '2014-06-18 08:25:03', '2014-06-18 21:21:08', '10', 'M041000000023_0001', '53a14cdf99f093675c40facd', '0');
INSERT INTO `core_medicalrecord` VALUES ('48', '7', '2014-06-18 08:26:02', '2014-06-18 21:23:09', '10', 'M041000000023_0002', '53a14d1a99f093675c40fad2', '0');
INSERT INTO `core_medicalrecord` VALUES ('49', '7', '2014-06-18 08:26:44', '2014-06-18 21:26:35', '10', 'M041000000023_0004', '53a14d4499f093675c40fad7', '0');
INSERT INTO `core_medicalrecord` VALUES ('50', '7', '2014-06-19 08:08:47', '2014-06-19 20:59:20', '10', 'M041000000023_0005', '53a29a8f99f093675c40fadc', '0');
INSERT INTO `core_medicalrecord` VALUES ('51', '7', '2014-06-19 09:15:04', '2014-06-19 20:59:20', '10', 'M041000000023_0005', '53a2aa1899f093675c40fae1', '0');
INSERT INTO `core_medicalrecord` VALUES ('52', '7', '2014-06-19 09:20:00', '2014-06-19 22:20:13', '10', 'M041000000023_0006', '53a2ab4099f093675c40fae6', '0');
INSERT INTO `core_medicalrecord` VALUES ('53', '7', '2014-06-19 09:21:17', '2014-06-19 22:20:13', '10', 'M041000000023_0006', '53a2ab8d99f093675c40fae7', '0');
INSERT INTO `core_medicalrecord` VALUES ('54', '7', '2014-06-19 09:39:37', '2014-06-19 22:20:13', '10', 'M041000000023_0006', '53a2afd999f093675c40fae9', '0');
INSERT INTO `core_medicalrecord` VALUES ('55', '7', '2014-06-19 09:44:28', '2014-06-19 22:44:41', '10', 'M041000000023_0007', '53a2b0fc99f093675c40faeb', '0');
INSERT INTO `core_medicalrecord` VALUES ('56', '7', '2014-06-19 09:45:44', '2014-06-19 22:44:41', '10', 'M041000000023_0007', '53a2b14899f093675c40faec', '0');
INSERT INTO `core_medicalrecord` VALUES ('57', '7', '2014-06-21 07:48:13', '2014-06-19 22:44:41', '10', 'M041000000023_0007', '53a538bd99f093675c40faed', '0');
INSERT INTO `core_medicalrecord` VALUES ('58', '7', '2014-06-24 03:56:37', '2014-06-19 22:44:41', '10', 'M041000000023_0007', '53a8f6f599f093675c40faf2', '0');
INSERT INTO `core_medicalrecord` VALUES ('59', '1', '2014-07-02 04:31:09', '2014-07-02 17:31:09', '1', 'b0ad0f00a8d4', '53b38b0d99f0931b0afa9ab3', '0');
INSERT INTO `core_medicalrecord` VALUES ('60', '1', '2014-07-02 04:31:10', '2014-07-02 17:31:09', '1', 'b102d6e2a8d4', '53b38b0e99f0931b0afa9ac8', '0');
INSERT INTO `core_medicalrecord` VALUES ('61', '1', '2014-07-02 04:31:10', '2014-07-02 17:31:10', '1', 'b122080aa8d4', '53b38b0e99f0931b0afa9add', '0');
INSERT INTO `core_medicalrecord` VALUES ('62', '1', '2014-07-02 04:31:10', '2014-07-02 17:31:10', '1', 'b14115f6a8d4', '53b38b0e99f0931b0afa9af2', '0');
INSERT INTO `core_medicalrecord` VALUES ('63', '1', '2014-07-02 04:31:10', '2014-07-02 17:31:10', '1', 'b15fde8ca8d4', '53b38b0e99f0931b0afa9b07', '0');
INSERT INTO `core_medicalrecord` VALUES ('64', '1', '2014-07-02 04:31:49', '2014-07-02 17:31:48', '8', 'c84cfe18a8d4', '53b38b3599f0931b7e659a73', '0');
INSERT INTO `core_medicalrecord` VALUES ('65', '1', '2014-07-02 04:31:49', '2014-07-02 17:31:49', '8', 'c86b471aa8d4', '53b38b3599f0931b7e659a88', '0');
INSERT INTO `core_medicalrecord` VALUES ('66', '1', '2014-07-02 04:31:49', '2014-07-02 17:31:49', '8', 'c8901ca2a8d4', '53b38b3599f0931b7e659a9d', '0');
INSERT INTO `core_medicalrecord` VALUES ('67', '1', '2014-07-02 04:31:49', '2014-07-02 17:31:49', '8', 'c8b2a1f0a8d4', '53b38b3599f0931b7e659ab2', '0');
INSERT INTO `core_medicalrecord` VALUES ('68', '1', '2014-07-02 04:31:49', '2014-07-02 17:31:49', '8', 'c8d0ebf6a8d4', '53b38b3599f0931b7e659ac7', '0');
INSERT INTO `core_medicalrecord` VALUES ('69', '1', '2014-07-02 04:32:38', '2014-07-02 17:32:38', '8', 'e5f50352a8d4', '53b38b6699f0931be9a134d7', '0');
INSERT INTO `core_medicalrecord` VALUES ('70', '1', '2014-07-02 04:32:39', '2014-07-02 17:32:38', '8', 'e61accd6a8d4', '53b38b6799f0931be9a134ec', '0');
INSERT INTO `core_medicalrecord` VALUES ('71', '1', '2014-07-02 04:32:39', '2014-07-02 17:32:39', '8', 'e645e07ea8d4', '53b38b6799f0931be9a13501', '0');
INSERT INTO `core_medicalrecord` VALUES ('72', '1', '2014-07-02 04:32:39', '2014-07-02 17:32:39', '8', 'e6712068a8d4', '53b38b6799f0931be9a13516', '0');
INSERT INTO `core_medicalrecord` VALUES ('73', '1', '2014-07-02 04:32:39', '2014-07-02 17:32:39', '8', 'e6963a42a8d4', '53b38b6799f0931be9a1352b', '0');
INSERT INTO `core_medicalrecord` VALUES ('74', '1', '2014-07-02 04:33:07', '2014-07-02 17:33:06', '10', 'f6c9fd18a8d4', '53b38b8399f0931c3a8e0ae3', '0');
INSERT INTO `core_medicalrecord` VALUES ('75', '1', '2014-07-02 04:33:07', '2014-07-02 17:33:07', '10', 'f6f228eca8d4', '53b38b8399f0931c3a8e0af8', '0');
INSERT INTO `core_medicalrecord` VALUES ('76', '1', '2014-07-02 04:33:07', '2014-07-02 17:33:07', '10', 'f7159124a8d4', '53b38b8399f0931c3a8e0b0d', '0');
INSERT INTO `core_medicalrecord` VALUES ('77', '1', '2014-07-02 04:33:07', '2014-07-02 17:33:07', '10', 'f737a1d8a8d4', '53b38b8399f0931c3a8e0b22', '1');
INSERT INTO `core_medicalrecord` VALUES ('78', '1', '2014-07-02 04:33:08', '2014-07-02 17:33:07', '10', 'f75f8108a8d4', '53b38b8499f0931c3a8e0b37', '0');
INSERT INTO `core_medicalrecord` VALUES ('79', '1', '2014-07-02 04:33:08', '2014-07-02 17:33:08', '9', 'f795cb8ca8d4', '53b38b8499f0931c3a8e0b4c', '0');
INSERT INTO `core_medicalrecord` VALUES ('80', '1', '2014-07-02 04:33:08', '2014-07-02 17:33:08', '9', 'f7a9aa12a8d4', '53b38b8499f0931c3a8e0b61', '0');
INSERT INTO `core_medicalrecord` VALUES ('81', '1', '2014-07-02 04:33:08', '2014-07-02 17:33:08', '9', 'f7c3cda2a8d4', '53b38b8499f0931c3a8e0b76', '0');
INSERT INTO `core_medicalrecord` VALUES ('82', '1', '2014-07-02 04:33:08', '2014-07-02 17:33:08', '9', 'f7db4c16a8d4', '53b38b8499f0931c3a8e0b8b', '1');
INSERT INTO `core_medicalrecord` VALUES ('83', '1', '2014-07-02 04:33:09', '2014-07-02 17:33:08', '9', 'f7f2cc56a8d4', '53b38b8599f0931c3a8e0ba0', '0');
INSERT INTO `core_medicalrecord` VALUES ('84', '1', '2014-07-02 04:33:09', '2014-07-02 17:33:09', '8', 'f823df3aa8d4', '53b38b8599f0931c3a8e0bb5', '0');
INSERT INTO `core_medicalrecord` VALUES ('85', '1', '2014-07-02 04:33:09', '2014-07-02 17:33:09', '8', 'f8496a16a8d4', '53b38b8599f0931c3a8e0bca', '0');
INSERT INTO `core_medicalrecord` VALUES ('86', '1', '2014-07-02 04:33:09', '2014-07-02 17:33:09', '8', 'f870a022a8d4', '53b38b8599f0931c3a8e0bdf', '1');
INSERT INTO `core_medicalrecord` VALUES ('87', '1', '2014-07-02 04:33:10', '2014-07-02 17:33:10', '8', 'f89e3776a8d4', '53b38b8699f0931c3a8e0bf4', '0');
INSERT INTO `core_medicalrecord` VALUES ('88', '1', '2014-07-02 04:33:10', '2014-07-02 17:33:10', '8', 'f8c84dcca8d4', '53b38b8699f0931c3a8e0c09', '0');
INSERT INTO `core_medicalrecord` VALUES ('89', '1', '2014-07-02 04:33:10', '2014-07-02 17:33:10', '2', 'f90f320aa8d4', '53b38b8699f0931c3a8e0c1e', '1');
INSERT INTO `core_medicalrecord` VALUES ('90', '1', '2014-07-02 04:33:11', '2014-07-02 17:33:11', '2', 'f94ab41aa8d4', '53b38b8799f0931c3a8e0c33', '0');
INSERT INTO `core_medicalrecord` VALUES ('91', '1', '2014-07-02 04:33:11', '2014-07-02 17:33:11', '2', 'f968d3e6a8d4', '53b38b8799f0931c3a8e0c48', '0');
INSERT INTO `core_medicalrecord` VALUES ('92', '1', '2014-07-02 04:33:11', '2014-07-02 17:33:11', '2', 'f9831ca6a8d4', '53b38b8799f0931c3a8e0c5d', '0');
INSERT INTO `core_medicalrecord` VALUES ('93', '1', '2014-07-02 04:33:12', '2014-07-02 17:33:11', '2', 'f9c70a4ca8d4', '53b38b8899f0931c3a8e0c72', '0');
INSERT INTO `core_medicalrecord` VALUES ('94', '1', '2014-07-02 04:33:12', '2014-07-02 17:33:12', '1', 'fa0c84f0a8d4', '53b38b8899f0931c3a8e0c87', '1');
INSERT INTO `core_medicalrecord` VALUES ('95', '1', '2014-07-02 04:33:12', '2014-07-02 17:33:12', '1', 'fa306fdca8d4', '53b38b8899f0931c3a8e0c9c', '0');
INSERT INTO `core_medicalrecord` VALUES ('96', '1', '2014-07-02 04:33:13', '2014-07-02 17:33:13', '1', 'fa8662aca8d4', '53b38b8999f0931c3a8e0cb1', '0');
INSERT INTO `core_medicalrecord` VALUES ('97', '1', '2014-07-02 04:33:13', '2014-07-02 17:33:13', '1', 'fad50006a8d4', '53b38b8999f0931c3a8e0cc6', '0');
INSERT INTO `core_medicalrecord` VALUES ('98', '1', '2014-07-02 04:33:14', '2014-07-02 17:33:14', '1', 'fb19fbcaa8d4', '53b38b8a99f0931c3a8e0cdb', '0');
INSERT INTO `core_medicalrecord` VALUES ('99', '7', '2014-07-06 15:39:12', '2014-07-07 04:39:51', '10', 'M041000000023_0009', '53b96da04288843d792cacda', '0');
INSERT INTO `core_medicalrecord` VALUES ('100', '7', '2014-07-07 15:11:31', '2014-07-07 04:39:51', '10', 'M041000000023_0009', '53bab8a34288843d792cacdb', '0');
INSERT INTO `core_medicalrecord` VALUES ('101', '1', '2014-07-08 04:18:11', '2014-07-08 17:18:02', '4', 'da13e396a8d4', '53bb71034288843d7a12f58c', '1');
INSERT INTO `core_medicalrecord` VALUES ('102', '1', '2014-07-08 04:18:21', '2014-07-08 17:18:12', '4', 'e002fc56a8d4', '53bb710d4288843d792cace0', '0');
INSERT INTO `core_medicalrecord` VALUES ('103', '1', '2014-07-08 04:18:31', '2014-07-08 17:18:22', '4', 'e5ea16b8a8d4', '53bb71174288843d7a12f5a1', '0');
INSERT INTO `core_medicalrecord` VALUES ('104', '1', '2014-07-08 04:18:41', '2014-07-08 17:18:32', '4', 'ebe9a452a8d4', '53bb71214288843d792cacf5', '0');
INSERT INTO `core_medicalrecord` VALUES ('105', '1', '2014-07-08 04:18:51', '2014-07-08 17:18:42', '4', 'f1fa060ca8d4', '53bb712b4288843d7a12f5b6', '0');
INSERT INTO `core_medicalrecord` VALUES ('106', '1', '2014-07-08 04:19:02', '2014-07-08 17:18:53', '2', 'f8787ea0a8d4', '53bb71364288843d7a12f5cb', '0');
INSERT INTO `core_medicalrecord` VALUES ('107', '1', '2014-07-08 04:19:12', '2014-07-08 17:19:03', '2', 'fe75ce98a8d4', '53bb71404288843d792cad0a', '0');
INSERT INTO `core_medicalrecord` VALUES ('108', '1', '2014-07-08 04:19:23', '2014-07-08 17:19:13', '2', '048a234ca8d4', '53bb714b4288843d7a12f5e0', '0');
INSERT INTO `core_medicalrecord` VALUES ('109', '1', '2014-07-08 04:19:33', '2014-07-08 17:19:23', '2', '0aaff30aa8d4', '53bb71554288843d792cad1f', '0');
INSERT INTO `core_medicalrecord` VALUES ('110', '1', '2014-07-08 04:19:43', '2014-07-08 17:19:34', '2', '10d643cea8d4', '53bb715f4288843d7a12f5f5', '0');
INSERT INTO `core_medicalrecord` VALUES ('111', '1', '2014-07-08 04:19:54', '2014-07-08 17:19:45', '3', '176965fea8d4', '53bb716a4288843d7a12f60a', '0');
INSERT INTO `core_medicalrecord` VALUES ('112', '1', '2014-07-08 04:20:04', '2014-07-08 17:19:55', '3', '1d3f9bd8a8d4', '53bb71744288843d792cad34', '0');
INSERT INTO `core_medicalrecord` VALUES ('113', '1', '2014-07-08 04:20:14', '2014-07-08 17:20:04', '3', '23243cfca8d4', '53bb717e4288843d7a12f61f', '0');
INSERT INTO `core_medicalrecord` VALUES ('114', '1', '2014-07-08 04:20:24', '2014-07-08 17:20:14', '3', '290acd48a8d4', '53bb71884288843d792cad49', '0');
INSERT INTO `core_medicalrecord` VALUES ('115', '1', '2014-07-08 04:20:34', '2014-07-08 17:20:24', '3', '2f075eaaa8d4', '53bb71924288843d7a12f634', '0');
INSERT INTO `core_medicalrecord` VALUES ('116', '1', '2014-07-08 04:20:45', '2014-07-08 17:20:35', '7', '3571500ca8d4', '53bb719d4288843d7a12f649', '0');
INSERT INTO `core_medicalrecord` VALUES ('117', '1', '2014-07-08 04:20:55', '2014-07-08 17:20:45', '7', '3b87f1b2a8d4', '53bb71a74288843d792cad5e', '0');
INSERT INTO `core_medicalrecord` VALUES ('118', '1', '2014-07-08 04:21:05', '2014-07-08 17:20:56', '7', '41aed754a8d4', '53bb71b14288843d7a12f65e', '0');
INSERT INTO `core_medicalrecord` VALUES ('119', '1', '2014-07-08 04:21:16', '2014-07-08 17:21:06', '7', '47df930ca8d4', '53bb71bc4288843d792cad73', '0');
INSERT INTO `core_medicalrecord` VALUES ('120', '1', '2014-07-08 04:21:26', '2014-07-08 17:21:16', '7', '4e0e5b00a8d4', '53bb71c64288843d7a12f673', '0');
INSERT INTO `core_medicalrecord` VALUES ('121', '1', '2014-07-08 04:21:37', '2014-07-08 17:21:28', '9', '54c2fe60a8d4', '53bb71d14288843d7a12f688', '0');
INSERT INTO `core_medicalrecord` VALUES ('122', '1', '2014-07-08 04:21:47', '2014-07-08 17:21:38', '9', '5aa785a8a8d4', '53bb71db4288843d792cad88', '1');
INSERT INTO `core_medicalrecord` VALUES ('123', '1', '2014-07-08 04:21:57', '2014-07-08 17:21:48', '9', '6094b1f2a8d4', '53bb71e54288843d7a12f69d', '0');
INSERT INTO `core_medicalrecord` VALUES ('124', '1', '2014-07-08 04:22:07', '2014-07-08 17:21:58', '9', '66a1116ca8d4', '53bb71ef4288843d792cad9d', '0');
INSERT INTO `core_medicalrecord` VALUES ('125', '1', '2014-07-08 04:22:17', '2014-07-08 17:22:08', '9', '6ca67c5aa8d4', '53bb71f94288843d7a12f6b2', '0');
INSERT INTO `core_medicalrecord` VALUES ('126', '7', '2014-07-08 04:40:10', '2014-07-07 04:39:51', '10', 'M041000000023_0009', '53bb762a4288843d792cadb2', '0');
INSERT INTO `core_medicalrecord` VALUES ('127', '7', '2014-07-08 04:41:02', '2014-06-30 15:15:53', '10', 'M041000000023_0008', '53bb765e4288843d7a12f6c7', '0');
INSERT INTO `core_medicalrecord` VALUES ('128', '7', '2014-07-09 03:05:08', '2014-07-09 16:04:24', '13', 'M041000000026_0001', '53bcb16442888445e5725041', '0');
INSERT INTO `core_medicalrecord` VALUES ('129', '7', '2014-07-09 03:20:17', '2014-07-09 16:04:24', '13', 'M041000000026_0001', '53bcb4f142888445e658cd02', '0');
INSERT INTO `core_medicalrecord` VALUES ('130', '7', '2014-07-18 09:46:38', '2014-07-18 22:46:29', '14', 'M041000000027_0001', '53c8ecfe428884512e22f559', '0');
INSERT INTO `core_medicalrecord` VALUES ('131', '7', '2014-11-19 03:28:20', '2014-11-19 17:06:51', '16', 'M041000000029_0001', '546c0e544288840c4b8a416b', '0');
INSERT INTO `core_medicalrecord` VALUES ('132', '7', '2014-11-19 08:49:35', '2014-11-19 17:06:51', '16', 'M041000000029_0001', '546c599f4288840c4b8a416c', '0');
INSERT INTO `core_medicalrecord` VALUES ('133', '7', '2014-11-20 08:22:22', '2014-11-20 22:20:56', '16', 'M041000000029_0002', '546da4be4288840c4c177e5d', '0');
INSERT INTO `core_medicalrecord` VALUES ('134', '7', '2014-11-21 00:10:15', '2014-11-21 14:09:04', '16', 'M041000000029_0003', '546e82e74288840c4b8a4171', '0');
INSERT INTO `core_medicalrecord` VALUES ('135', '7', '2014-11-21 02:21:00', '2014-11-21 14:09:04', '16', 'M041000000029_0003', '546ea18c4288840c4b8a4176', '0');
INSERT INTO `core_medicalrecord` VALUES ('136', '7', '2014-11-27 03:55:32', '2014-11-21 14:09:04', '16', 'M041000000029_0003', '5476a0b4428884108e03c11a', '0');
INSERT INTO `core_medicalrecord` VALUES ('137', '7', '2014-11-27 03:56:44', '2014-11-27 17:55:34', '16', 'M041000000029_0004', '5476a0fc428884108d9e3050', '0');
INSERT INTO `core_medicalrecord` VALUES ('138', '7', '2014-11-30 06:08:04', '2014-11-30 20:07:36', '16', 'M041000000029_0005', '547ab4444288841d6573626e', '0');
INSERT INTO `core_medicalrecord` VALUES ('139', '7', '2014-12-03 15:08:15', '2014-06-07 17:23:20', '16', 'M041000000029_0003', '547f275f4288841d66b01357', '0');
INSERT INTO `core_medicalrecord` VALUES ('140', '7', '2014-12-03 15:15:36', '2014-06-07 17:23:20', '16', 'M041000000029_0003', '547f29184288841d66b0135c', '0');
INSERT INTO `core_medicalrecord` VALUES ('141', '7', '2014-12-03 15:15:39', '2014-06-07 17:23:20', '16', 'M041000000029_0003', '547f291b4288841d66b01361', '0');
INSERT INTO `core_medicalrecord` VALUES ('142', '7', '2014-12-03 15:17:24', '2014-01-07 18:23:20', '16', 'M041000000029_0003', '547f29844288841d65736271', '0');
INSERT INTO `core_medicalrecord` VALUES ('143', '7', '2014-12-10 07:41:52', '2014-01-07 18:23:20', '16', 'M041000000029_0003', '5487f94042888431f9d3cdce', '0');
INSERT INTO `core_medicalrecord` VALUES ('144', '7', '2014-12-10 07:45:58', '2014-01-07 18:23:20', '16', 'M041000000029_0003', '5487fa3642888431f8c1c9b7', '0');

-- ----------------------------
-- Table structure for `core_patient`
-- ----------------------------
DROP TABLE IF EXISTS `core_patient`;
CREATE TABLE `core_patient` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`) USING BTREE,
  CONSTRAINT `core_patient_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of core_patient
-- ----------------------------
INSERT INTO `core_patient` VALUES ('1', '12', '1');
INSERT INTO `core_patient` VALUES ('2', '13', '1');
INSERT INTO `core_patient` VALUES ('3', '14', '1');
INSERT INTO `core_patient` VALUES ('4', '15', '1');
INSERT INTO `core_patient` VALUES ('5', '16', '1');
INSERT INTO `core_patient` VALUES ('6', '19', '1');
INSERT INTO `core_patient` VALUES ('7', '20', '1');
INSERT INTO `core_patient` VALUES ('8', '21', '0');
INSERT INTO `core_patient` VALUES ('9', '22', '1');
INSERT INTO `core_patient` VALUES ('10', '23', '1');
INSERT INTO `core_patient` VALUES ('11', '24', '1');
INSERT INTO `core_patient` VALUES ('12', '25', '1');
INSERT INTO `core_patient` VALUES ('13', '26', '1');
INSERT INTO `core_patient` VALUES ('14', '27', '1');
INSERT INTO `core_patient` VALUES ('15', '28', '1');
INSERT INTO `core_patient` VALUES ('16', '29', '0');

-- ----------------------------
-- Table structure for `core_re_overseepatients`
-- ----------------------------
DROP TABLE IF EXISTS `core_re_overseepatients`;
CREATE TABLE `core_re_overseepatients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `overseer_id` int(11) NOT NULL,
  `overseer_type` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_re_overseepatients_883d4ea5` (`overseer_id`) USING BTREE,
  KEY `core_re_overseepatients_1fe1df59` (`patient_id`) USING BTREE,
  CONSTRAINT `core_re_overseepatients_ibfk_1` FOREIGN KEY (`overseer_id`) REFERENCES `core_user` (`id`),
  CONSTRAINT `core_re_overseepatients_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `core_patient` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of core_re_overseepatients
-- ----------------------------
INSERT INTO `core_re_overseepatients` VALUES ('1', '7', '2', '7', '0');
INSERT INTO `core_re_overseepatients` VALUES ('2', '7', '2', '8', '0');
INSERT INTO `core_re_overseepatients` VALUES ('3', '7', '2', '2', '1');
INSERT INTO `core_re_overseepatients` VALUES ('4', '7', '2', '9', '0');
INSERT INTO `core_re_overseepatients` VALUES ('5', '7', '2', '10', '0');
INSERT INTO `core_re_overseepatients` VALUES ('6', '4', '1', '10', '1');
INSERT INTO `core_re_overseepatients` VALUES ('7', '2', '1', '6', '0');
INSERT INTO `core_re_overseepatients` VALUES ('8', '2', '1', '1', '0');
INSERT INTO `core_re_overseepatients` VALUES ('9', '6', '1', '10', '0');
INSERT INTO `core_re_overseepatients` VALUES ('10', '11', '2', '11', '0');
INSERT INTO `core_re_overseepatients` VALUES ('11', '7', '2', '13', '0');
INSERT INTO `core_re_overseepatients` VALUES ('12', '8', '2', '10', '0');
INSERT INTO `core_re_overseepatients` VALUES ('13', '7', '2', '14', '0');
INSERT INTO `core_re_overseepatients` VALUES ('14', '8', '2', '15', '0');
INSERT INTO `core_re_overseepatients` VALUES ('15', '8', '2', '16', '1');
INSERT INTO `core_re_overseepatients` VALUES ('16', '7', '2', '16', '0');
INSERT INTO `core_re_overseepatients` VALUES ('17', '2', '1', '8', '0');

-- ----------------------------
-- Table structure for `core_recordcomment`
-- ----------------------------
DROP TABLE IF EXISTS `core_recordcomment`;
CREATE TABLE `core_recordcomment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `record_id` int(11) NOT NULL,
  `commentor_id` int(11) NOT NULL,
  `target_comment_id` int(11) DEFAULT NULL,
  `content` longtext NOT NULL,
  `comment_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_recordcomment_52103e4c` (`record_id`) USING BTREE,
  KEY `core_recordcomment_eb03c25c` (`commentor_id`) USING BTREE,
  KEY `core_recordcomment_e354450f` (`target_comment_id`) USING BTREE,
  CONSTRAINT `core_recordcomment_ibfk_1` FOREIGN KEY (`commentor_id`) REFERENCES `core_user` (`id`),
  CONSTRAINT `core_recordcomment_ibfk_2` FOREIGN KEY (`record_id`) REFERENCES `core_medicalrecord` (`id`),
  CONSTRAINT `core_recordcomment_ibfk_3` FOREIGN KEY (`target_comment_id`) REFERENCES `core_recordcomment` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of core_recordcomment
-- ----------------------------
INSERT INTO `core_recordcomment` VALUES ('1', '41', '1', null, '赞！', '2014-06-17 08:10:14', '2014-06-17 08:10:14', '0');
INSERT INTO `core_recordcomment` VALUES ('2', '41', '1', null, '筛选功能碉堡啊~', '2014-06-17 09:05:01', '2014-06-17 09:05:01', '0');
INSERT INTO `core_recordcomment` VALUES ('3', '57', '1', null, '刚刚', '2014-06-24 03:29:37', '2014-06-24 03:29:37', '0');
INSERT INTO `core_recordcomment` VALUES ('4', '98', '2', null, 'gsdgsg', '2014-07-18 09:32:09', '2014-07-18 09:32:09', '0');
INSERT INTO `core_recordcomment` VALUES ('5', '98', '1', null, 'jjjj', '2014-11-02 07:10:10', '2014-11-02 07:10:10', '0');
INSERT INTO `core_recordcomment` VALUES ('6', '132', '1', null, '很健康！', '2014-11-19 08:51:03', '2014-11-19 08:51:03', '0');
INSERT INTO `core_recordcomment` VALUES ('7', '134', '1', null, '系统时间有误', '2014-11-21 00:55:25', '2014-11-21 00:55:25', '0');

-- ----------------------------
-- Table structure for `core_registrationcode`
-- ----------------------------
DROP TABLE IF EXISTS `core_registrationcode`;
CREATE TABLE `core_registrationcode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(100) NOT NULL,
  `generator_id` int(11) NOT NULL,
  `generate_time` datetime NOT NULL,
  `user_role` int(11) NOT NULL,
  `state` int(11) NOT NULL,
  `used_user_id` int(11) DEFAULT NULL,
  `used_time` datetime DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`) USING BTREE,
  KEY `core_registrationcode_fce70a46` (`generator_id`) USING BTREE,
  KEY `core_registrationcode_de27dd13` (`used_user_id`) USING BTREE,
  CONSTRAINT `core_registrationcode_ibfk_1` FOREIGN KEY (`used_user_id`) REFERENCES `core_user` (`id`),
  CONSTRAINT `core_registrationcode_ibfk_2` FOREIGN KEY (`generator_id`) REFERENCES `core_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of core_registrationcode
-- ----------------------------
INSERT INTO `core_registrationcode` VALUES ('1', 'a92a5c2ca8d4', '1', '2014-06-15 15:28:11', '2', '2', '17', '2014-06-15 15:28:11', '0');
INSERT INTO `core_registrationcode` VALUES ('2', 'a938945ea8d4', '1', '2014-06-15 15:28:11', '3', '2', '18', '2014-06-15 15:28:11', '0');
INSERT INTO `core_registrationcode` VALUES ('3', 'a942ef4ea8d4', '1', '2014-06-15 15:28:11', '4', '2', '19', '2014-06-15 15:28:11', '0');
INSERT INTO `core_registrationcode` VALUES ('4', 'e2dd2a3aa8d4', '7', '2014-06-15 15:29:48', '4', '2', '20', '2014-06-15 15:29:48', '0');
INSERT INTO `core_registrationcode` VALUES ('5', '4cbed2fea8d4', '7', '2014-06-16 02:59:57', '4', '2', '21', '2014-06-16 02:59:58', '0');
INSERT INTO `core_registrationcode` VALUES ('6', '476c3948a8d4', '7', '2014-06-17 09:03:42', '4', '2', '22', '2014-06-17 09:03:42', '0');
INSERT INTO `core_registrationcode` VALUES ('7', '5df9aa74a8d4', '7', '2014-06-18 08:20:11', '4', '2', '23', '2014-06-18 08:20:15', '0');
INSERT INTO `core_registrationcode` VALUES ('8', 'd5143f90862a', '11', '2014-07-08 12:31:49', '4', '2', '24', '2014-07-08 12:31:49', '0');
INSERT INTO `core_registrationcode` VALUES ('9', 'bade513a863f', '1', '2014-07-09 02:35:45', '4', '2', '25', '2014-07-09 02:35:46', '0');
INSERT INTO `core_registrationcode` VALUES ('10', '7ec369ac93be', '7', '2014-07-09 03:02:43', '4', '1', null, null, '0');
INSERT INTO `core_registrationcode` VALUES ('11', 'a243050eada5', '7', '2014-07-09 03:03:42', '4', '2', '26', '2014-07-09 03:03:42', '0');
INSERT INTO `core_registrationcode` VALUES ('12', '1f6f3cb8bb83', '7', '2014-07-18 09:44:33', '4', '2', '27', '2014-07-18 09:44:33', '0');
INSERT INTO `core_registrationcode` VALUES ('13', '6f6510deb89f', '8', '2014-11-19 02:47:43', '4', '2', '28', '2014-11-19 02:47:43', '0');
INSERT INTO `core_registrationcode` VALUES ('14', '74a17afebc1b', '8', '2014-11-19 03:02:11', '4', '1', null, null, '0');
INSERT INTO `core_registrationcode` VALUES ('15', '7ba393e6871a', '8', '2014-11-19 03:02:22', '4', '1', null, null, '0');
INSERT INTO `core_registrationcode` VALUES ('16', '8bda53e4a95f', '8', '2014-11-19 03:02:50', '4', '1', null, null, '0');
INSERT INTO `core_registrationcode` VALUES ('17', '8deb930093d2', '8', '2014-11-19 03:02:53', '4', '1', null, null, '0');
INSERT INTO `core_registrationcode` VALUES ('18', '168486d6a6a0', '8', '2014-11-19 03:06:42', '4', '2', '29', '2014-11-19 03:06:42', '0');

-- ----------------------------
-- Table structure for `core_user`
-- ----------------------------
DROP TABLE IF EXISTS `core_user`;
CREATE TABLE `core_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `guid` varchar(50) DEFAULT NULL,
  `name` varchar(250) NOT NULL,
  `email` varchar(250) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `sex` int(11) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `register_time` datetime NOT NULL,
  `role` int(11) NOT NULL,
  `avatar_url` longtext,
  `deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of core_user
-- ----------------------------
INSERT INTO `core_user` VALUES ('1', 'admin', '21232f297a57a5a743894a0e4a801fc3', 'M011000000001', 'admin', 'aaa', '111', '1', null, '', '2014-06-16 04:26:35', '1', null, '0');
INSERT INTO `core_user` VALUES ('2', 'doctor0', '202cb962ac59075b964b07152d234b70', 'M021000000002', 'doctor0', null, null, null, null, null, '2014-06-16 04:26:40', '2', null, '0');
INSERT INTO `core_user` VALUES ('3', 'doctor1', '45f678b147fdf275c35b60bac2360984', 'M021000000003', 'doctor1', null, null, null, null, null, '2014-06-16 04:26:40', '2', null, '0');
INSERT INTO `core_user` VALUES ('4', 'doctor2', '3b02a6fdd669efe9083cc84d15e5699b', 'M021000000004', 'doctor2', null, null, null, null, null, '2014-06-16 04:26:40', '2', null, '0');
INSERT INTO `core_user` VALUES ('5', 'doctor3', 'c5771df124ed6073ae4e2d09b2b20ac0', 'M021000000005', 'doctor3', null, null, null, null, null, '2014-06-16 04:26:40', '2', null, '0');
INSERT INTO `core_user` VALUES ('6', 'doctor4', 'd9dd5a031723455173d4336914b17f2b', 'M021000000006', 'doctor4', null, null, null, null, null, '2014-06-16 04:26:40', '2', null, '0');
INSERT INTO `core_user` VALUES ('7', 'advisor0', '202cb962ac59075b964b07152d234b70', 'M031000000007', 'advisor0', null, null, null, null, null, '2014-06-16 04:26:40', '3', null, '0');
INSERT INTO `core_user` VALUES ('8', 'advisor1', 'f00fea67eaa512cbd06954ac3db46e63', 'M031000000008', 'advisor1', null, null, null, null, null, '2014-06-16 04:26:40', '3', null, '0');
INSERT INTO `core_user` VALUES ('9', 'advisor2', '2ecd1b4a519515cb66630ad1969e1faa', 'M031000000009', 'advisor2', null, null, null, null, null, '2014-06-16 04:26:40', '3', null, '0');
INSERT INTO `core_user` VALUES ('10', 'advisor3', '86491e174a842bd168b6d4bd166f4ae4', 'M031000000010', 'advisor3', null, null, null, null, null, '2014-06-16 04:26:40', '3', null, '0');
INSERT INTO `core_user` VALUES ('11', 'advisor4', '1f36c15d6a3d18d52e8d493bc8187cb9', 'M031000000011', 'advisor4', null, null, null, null, null, '2014-06-16 04:26:40', '3', null, '0');
INSERT INTO `core_user` VALUES ('12', 'patient0', '202cb962ac59075b964b07152d234b70', 'M041000000012', 'patient0', null, null, null, null, null, '2014-06-16 04:26:40', '4', null, '1');
INSERT INTO `core_user` VALUES ('13', 'patient1', '8103cfda42d725cd38e8bdf9610ef9a6', 'M041000000013', 'patient1', null, null, null, null, null, '2014-06-16 04:26:40', '4', null, '1');
INSERT INTO `core_user` VALUES ('14', 'patient2', '3d47080f1445cd844c3390b15c835ffa', 'M041000000014', 'patient2', null, null, null, null, null, '2014-06-16 04:26:40', '4', null, '1');
INSERT INTO `core_user` VALUES ('15', 'patient3', '03ede2bfbf54e1352444d524f782ae74', 'M041000000015', 'patient3', null, null, null, null, null, '2014-06-16 04:26:40', '4', null, '1');
INSERT INTO `core_user` VALUES ('16', 'patient4', '9bac701f330431c4de52e835b8ebf661', 'M041000000016', 'patient4', null, null, null, null, null, '2014-06-16 04:26:40', '4', null, '1');
INSERT INTO `core_user` VALUES ('17', 'a92d2254a8d4', '8ccf2b96f1fb3a6fbe1111c54950558d', 'M021000000017', 'a92dff26a8d4', null, null, null, null, null, '2014-06-15 15:28:11', '2', null, '1');
INSERT INTO `core_user` VALUES ('18', 'a93ad4daa8d4', '1e9acc332a06c552f2304636f445d8f4', 'M031000000018', 'a93bbab2a8d4', null, null, null, null, null, '2014-06-15 15:28:11', '3', null, '1');
INSERT INTO `core_user` VALUES ('19', 'a9454b5ea8d4', '95d8baaf0a2d8bf99caef1716576d30d', 'M041000000019', 'a9455482a8d4', null, null, null, null, null, '2014-06-15 15:28:11', '4', null, '1');
INSERT INTO `core_user` VALUES ('20', 'test4', '86985e105f79b95d6bc918fb45ec7727', 'M041000000020', '测试四', null, null, null, null, null, '2014-06-15 15:29:48', '4', null, '1');
INSERT INTO `core_user` VALUES ('21', 'wxq', 'dd78b5f11755d1aab0ebd2c42f9867e2', 'M041000000021', '王晓强', null, null, null, null, null, '2014-06-16 02:59:58', '4', '/uploads/image/2014-06-15/0813ea52a8d4.jpg', '0');
INSERT INTO `core_user` VALUES ('22', 'test5', 'e3d704f3542b44a621ebed70dc0efe13', 'M041000000022', '测试五', null, null, null, null, null, '2014-06-17 09:03:42', '4', null, '1');
INSERT INTO `core_user` VALUES ('23', 'test6', '4cfad7076129962ee70c36839a1e3e15', 'M041000000023', '测试六', null, null, null, null, null, '2014-06-18 08:20:15', '4', null, '1');
INSERT INTO `core_user` VALUES ('24', 'wu', '1f36c15d6a3d18d52e8d493bc8187cb9', 'M041000000024', '吴威', null, null, null, null, null, '2014-07-08 12:31:49', '4', null, '1');
INSERT INTO `core_user` VALUES ('25', 'ww', 'c4ca4238a0b923820dcc509a6f75849b', 'M041000000025', '吴为', null, null, null, null, null, '2014-07-09 02:35:45', '4', null, '1');
INSERT INTO `core_user` VALUES ('26', 'wuwei', 'ee502e40e5aec84d113221e361e6d508', 'M041000000026', '吴威', null, null, null, null, null, '2014-07-09 03:03:42', '4', null, '1');
INSERT INTO `core_user` VALUES ('27', 'test8', '5e40d09fa0529781afd1254a42913847', 'M041000000027', '你把', null, null, null, null, null, '2014-07-18 09:44:33', '4', null, '1');
INSERT INTO `core_user` VALUES ('28', 'wusheng', 'f0eb4b5205ef2e799f2ecd7f3c43b701', 'M041000000028', '吴胜', null, null, null, null, null, '2014-11-19 02:47:43', '4', null, '1');
INSERT INTO `core_user` VALUES ('29', 'aa', '4124bc0a9335c27f086f24ba207a4912', 'M041000000029', '无需吧', null, null, null, null, null, '2014-11-19 03:06:42', '4', null, '0');

-- ----------------------------
-- Table structure for `django_content_type`
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('1', 'permission', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('2', 'group', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('3', 'user', 'auth', 'user');
INSERT INTO `django_content_type` VALUES ('4', 'content type', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('5', 'session', 'sessions', 'session');
INSERT INTO `django_content_type` VALUES ('6', 'site', 'sites', 'site');
INSERT INTO `django_content_type` VALUES ('7', 'user', 'core', 'user');
INSERT INTO `django_content_type` VALUES ('8', 'administrator', 'core', 'administrator');
INSERT INTO `django_content_type` VALUES ('9', 'doctor', 'core', 'doctor');
INSERT INTO `django_content_type` VALUES ('10', 'advisor', 'core', 'advisor');
INSERT INTO `django_content_type` VALUES ('11', 'patient', 'core', 'patient');
INSERT INTO `django_content_type` VALUES ('12', 'r e_ oversee patients', 'core', 're_overseepatients');
INSERT INTO `django_content_type` VALUES ('13', 'medical record', 'core', 'medicalrecord');
INSERT INTO `django_content_type` VALUES ('14', 'record comment', 'core', 'recordcomment');
INSERT INTO `django_content_type` VALUES ('15', 'registration code', 'core', 'registrationcode');

-- ----------------------------
-- Table structure for `django_session`
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_b7b81f0c` (`expire_date`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('0c4o0t3o0onb8p4jargba0z8rixg77b9', 'OTBiYzBmMDEyMzIwM2M3NTdiZDcwYWY1MDhlY2UxNjBiODcxNTNjODp7InVzZXIiOnsidXNlcm5hbWUiOiJhYSIsImd1aWQiOiJNMDQxMDAwMDAwMDI5IiwibmFtZSI6Ilx1NjVlMFx1OTcwMFx1NTQyNyIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTExLTE5IDAzOjA2OjQyIiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyOSwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNDEyNGJjMGE5MzM1YzI3ZjA4NmYyNGJhMjA3YTQ5MTIiLCJlbWFpbCI6bnVsbH19', '2014-12-10 03:46:37');
INSERT INTO `django_session` VALUES ('0od0g84hh94fg4wzum5oe7t5xluwrvxh', 'ODZmNDVkZDVlNjE0YzMyMjYwNWFiNWVkODJkMDA1OTA1Zjc3MDk2MDp7InVzZXIiOnsidXNlcm5hbWUiOiJhZG1pbiIsImd1aWQiOiJNMDExMDAwMDAwMDAxIiwibmFtZSI6ImFkbWluIiwicmVnaXN0ZXJfdGltZSI6IjIwMTQtMDYtMTYgMDQ6MjY6MzUiLCJhZ2UiOm51bGwsInNleCI6MSwiaWQiOjEsInBob25lIjoiMTExIiwiYXZhdGFyX3VybCI6bnVsbCwicm9sZSI6eyJpZCI6MSwibmFtZSI6ImFkbWluIn0sImFkZHJlc3MiOiIiLCJwYXNzd29yZCI6IjIxMjMyZjI5N2E1N2E1YTc0Mzg5NGEwZTRhODAxZmMzIiwiZW1haWwiOiJhYWEifX0=', '2014-07-28 07:45:23');
INSERT INTO `django_session` VALUES ('0uatjls6ffmu33mzhwcthm4a8ilbfdip', 'OTBiYzBmMDEyMzIwM2M3NTdiZDcwYWY1MDhlY2UxNjBiODcxNTNjODp7InVzZXIiOnsidXNlcm5hbWUiOiJhYSIsImd1aWQiOiJNMDQxMDAwMDAwMDI5IiwibmFtZSI6Ilx1NjVlMFx1OTcwMFx1NTQyNyIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTExLTE5IDAzOjA2OjQyIiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyOSwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNDEyNGJjMGE5MzM1YzI3ZjA4NmYyNGJhMjA3YTQ5MTIiLCJlbWFpbCI6bnVsbH19', '2014-12-14 05:59:45');
INSERT INTO `django_session` VALUES ('1e8zt4nsdnvc26i715hc9jjowidgcfrv', 'ODZmNDVkZDVlNjE0YzMyMjYwNWFiNWVkODJkMDA1OTA1Zjc3MDk2MDp7InVzZXIiOnsidXNlcm5hbWUiOiJhZG1pbiIsImd1aWQiOiJNMDExMDAwMDAwMDAxIiwibmFtZSI6ImFkbWluIiwicmVnaXN0ZXJfdGltZSI6IjIwMTQtMDYtMTYgMDQ6MjY6MzUiLCJhZ2UiOm51bGwsInNleCI6MSwiaWQiOjEsInBob25lIjoiMTExIiwiYXZhdGFyX3VybCI6bnVsbCwicm9sZSI6eyJpZCI6MSwibmFtZSI6ImFkbWluIn0sImFkZHJlc3MiOiIiLCJwYXNzd29yZCI6IjIxMjMyZjI5N2E1N2E1YTc0Mzg5NGEwZTRhODAxZmMzIiwiZW1haWwiOiJhYWEifX0=', '2014-08-11 10:16:20');
INSERT INTO `django_session` VALUES ('1y9c6k6owq079n6snjqxdfpmsehr2jpk', 'ODZmNDVkZDVlNjE0YzMyMjYwNWFiNWVkODJkMDA1OTA1Zjc3MDk2MDp7InVzZXIiOnsidXNlcm5hbWUiOiJhZG1pbiIsImd1aWQiOiJNMDExMDAwMDAwMDAxIiwibmFtZSI6ImFkbWluIiwicmVnaXN0ZXJfdGltZSI6IjIwMTQtMDYtMTYgMDQ6MjY6MzUiLCJhZ2UiOm51bGwsInNleCI6MSwiaWQiOjEsInBob25lIjoiMTExIiwiYXZhdGFyX3VybCI6bnVsbCwicm9sZSI6eyJpZCI6MSwibmFtZSI6ImFkbWluIn0sImFkZHJlc3MiOiIiLCJwYXNzd29yZCI6IjIxMjMyZjI5N2E1N2E1YTc0Mzg5NGEwZTRhODAxZmMzIiwiZW1haWwiOiJhYWEifX0=', '2014-12-10 08:35:07');
INSERT INTO `django_session` VALUES ('2cdm6zcsu6f6ejq5hr4pcc1jotv1cg7x', 'Y2MxYTM4MjBjMTIzNGI1NTc0ODc0ZjlmM2JiNGFiNThmMTZlNmVkNjp7fQ==', '2014-12-16 13:07:57');
INSERT INTO `django_session` VALUES ('2cfxm4odt1aby597siu703zkflwwoxlx', 'Y2MxYTM4MjBjMTIzNGI1NTc0ODc0ZjlmM2JiNGFiNThmMTZlNmVkNjp7fQ==', '2014-06-29 15:26:30');
INSERT INTO `django_session` VALUES ('2gi52zj1sozu17t1bqw5czywrwjmezb2', 'MThmZTEzMmUxODFlMGZiNGY3OGI0ZDc4YTEwOGFlMTRlNjY4NGQwMzp7InVzZXIiOnsidXNlcm5hbWUiOiJ0ZXN0NCIsImd1aWQiOiJNMDQxMDAwMDAwMDIwIiwibmFtZSI6Ilx1NmQ0Ylx1OGJkNVx1NTZkYiIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA2LTE1IDE1OjI5OjQ4IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyMCwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiODY5ODVlMTA1Zjc5Yjk1ZDZiYzkxOGZiNDVlYzc3MjciLCJlbWFpbCI6bnVsbH19', '2014-06-29 15:37:56');
INSERT INTO `django_session` VALUES ('3p2580d2wvjexny6lwz2ar3dcwo9jsfx', 'ZWI3MzZiN2RkZTBkZDM1MWJiODgxNDBiNzgxZWFiZGM2ZWM3YmY5Mjp7InVzZXIiOnsidXNlcm5hbWUiOiJ3eHEiLCJndWlkIjoiTTA0MTAwMDAwMDAyMSIsIm5hbWUiOiJcdTczOGJcdTY2NTNcdTVmM2EiLCJyZWdpc3Rlcl90aW1lIjoiMjAxNC0wNi0xNiAwMjo1OTo1OCIsImFnZSI6bnVsbCwic2V4IjpudWxsLCJpZCI6MjEsInBob25lIjpudWxsLCJhdmF0YXJfdXJsIjoiL3VwbG9hZHMvaW1hZ2UvMjAxNC0wNi0xNS8wODEzZWE1MmE4ZDQuanBnIiwicm9sZSI6eyJpZCI6NCwibmFtZSI6InBhdGllbnQifSwiYWRkcmVzcyI6bnVsbCwicGFzc3dvcmQiOiJkZDc4YjVmMTE3NTVkMWFhYjBlYmQyYzQyZjk4NjdlMiIsImVtYWlsIjpudWxsfX0=', '2014-06-30 03:34:04');
INSERT INTO `django_session` VALUES ('4c8l17ccjpmyfva28dg9afw1tjelf3zr', 'MThmZTEzMmUxODFlMGZiNGY3OGI0ZDc4YTEwOGFlMTRlNjY4NGQwMzp7InVzZXIiOnsidXNlcm5hbWUiOiJ0ZXN0NCIsImd1aWQiOiJNMDQxMDAwMDAwMDIwIiwibmFtZSI6Ilx1NmQ0Ylx1OGJkNVx1NTZkYiIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA2LTE1IDE1OjI5OjQ4IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyMCwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiODY5ODVlMTA1Zjc5Yjk1ZDZiYzkxOGZiNDVlYzc3MjciLCJlbWFpbCI6bnVsbH19', '2014-06-29 16:26:06');
INSERT INTO `django_session` VALUES ('50urz0nx4gvgn5kifo9c7majuk3o4d17', 'Y2MxYTM4MjBjMTIzNGI1NTc0ODc0ZjlmM2JiNGFiNThmMTZlNmVkNjp7fQ==', '2014-07-22 12:39:30');
INSERT INTO `django_session` VALUES ('67vz5r4fbga0ha7wwanz52ihtrlzbhiu', 'OTBiYzBmMDEyMzIwM2M3NTdiZDcwYWY1MDhlY2UxNjBiODcxNTNjODp7InVzZXIiOnsidXNlcm5hbWUiOiJhYSIsImd1aWQiOiJNMDQxMDAwMDAwMDI5IiwibmFtZSI6Ilx1NjVlMFx1OTcwMFx1NTQyNyIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTExLTE5IDAzOjA2OjQyIiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyOSwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNDEyNGJjMGE5MzM1YzI3ZjA4NmYyNGJhMjA3YTQ5MTIiLCJlbWFpbCI6bnVsbH19', '2014-12-05 00:08:53');
INSERT INTO `django_session` VALUES ('698ts2akqpyp1owfg8j44b4f72o046ae', 'ZmZiOTVlZGExM2E1ODc3Y2RmMzNjZmFjMmZhN2EyMjk0YzEzNjk1NDp7InVzZXIiOnsidXNlcm5hbWUiOiJ0ZXN0NiIsImd1aWQiOiJNMDQxMDAwMDAwMDIzIiwibmFtZSI6Ilx1NmQ0Ylx1OGJkNVx1NTE2ZCIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA2LTE4IDA4OjIwOjE1IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyMywicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNGNmYWQ3MDc2MTI5OTYyZWU3MGMzNjgzOWExZTNlMTUiLCJlbWFpbCI6bnVsbH19', '2014-07-22 04:39:46');
INSERT INTO `django_session` VALUES ('6cj8dvzuci00tnkk1qmawi30svchbca6', 'MjBjMzZmOGJlZTg1OGMyNDU3NzA0MDQ3NWIwNzkxNWYzNDg3NDZlNzp7InVzZXIiOnsidXNlcm5hbWUiOiJhOTNhZDRkYWE4ZDQiLCJndWlkIjoiTTAzMTAwMDAwMDAxOCIsIm5hbWUiOiJhOTNiYmFiMmE4ZDQiLCJyZWdpc3Rlcl90aW1lIjoiMjAxNC0wNi0xNSAxNToyODoxMSIsImFnZSI6bnVsbCwic2V4IjpudWxsLCJpZCI6MTgsInBob25lIjpudWxsLCJhdmF0YXJfdXJsIjpudWxsLCJyb2xlIjp7ImlkIjozLCJuYW1lIjoiYWR2aXNvciJ9LCJhZGRyZXNzIjpudWxsLCJwYXNzd29yZCI6IjFlOWFjYzMzMmEwNmM1NTJmMjMwNDYzNmY0NDVkOGY0IiwiZW1haWwiOm51bGx9fQ==', '2014-06-29 15:28:11');
INSERT INTO `django_session` VALUES ('77d7q513yoatutan7f72m1162ywm4lu4', 'ZmZiOTVlZGExM2E1ODc3Y2RmMzNjZmFjMmZhN2EyMjk0YzEzNjk1NDp7InVzZXIiOnsidXNlcm5hbWUiOiJ0ZXN0NiIsImd1aWQiOiJNMDQxMDAwMDAwMDIzIiwibmFtZSI6Ilx1NmQ0Ylx1OGJkNVx1NTE2ZCIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA2LTE4IDA4OjIwOjE1IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyMywicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNGNmYWQ3MDc2MTI5OTYyZWU3MGMzNjgzOWExZTNlMTUiLCJlbWFpbCI6bnVsbH19', '2014-07-03 09:40:34');
INSERT INTO `django_session` VALUES ('7en4hxp7cmzr0jppfbttild3k152yb4c', 'ODZmNDVkZDVlNjE0YzMyMjYwNWFiNWVkODJkMDA1OTA1Zjc3MDk2MDp7InVzZXIiOnsidXNlcm5hbWUiOiJhZG1pbiIsImd1aWQiOiJNMDExMDAwMDAwMDAxIiwibmFtZSI6ImFkbWluIiwicmVnaXN0ZXJfdGltZSI6IjIwMTQtMDYtMTYgMDQ6MjY6MzUiLCJhZ2UiOm51bGwsInNleCI6MSwiaWQiOjEsInBob25lIjoiMTExIiwiYXZhdGFyX3VybCI6bnVsbCwicm9sZSI6eyJpZCI6MSwibmFtZSI6ImFkbWluIn0sImFkZHJlc3MiOiIiLCJwYXNzd29yZCI6IjIxMjMyZjI5N2E1N2E1YTc0Mzg5NGEwZTRhODAxZmMzIiwiZW1haWwiOiJhYWEifX0=', '2014-08-11 09:30:42');
INSERT INTO `django_session` VALUES ('87iysd3120ls6cgzqpz7wnc7z0xsvv0v', 'ODkwMDI4OGNiZjQyNzA0MDU4NTJlM2M4ODM5NWYwYTQzZmIwZDcyNzp7InVzZXIiOnsidXNlcm5hbWUiOiJhZHZpc29yMCIsImd1aWQiOiJNMDMxMDAwMDAwMDA3IiwibmFtZSI6ImFkdmlzb3IwIiwicmVnaXN0ZXJfdGltZSI6IjIwMTQtMDYtMTYgMDQ6MjY6NDAiLCJhZ2UiOm51bGwsInNleCI6bnVsbCwiaWQiOjcsInBob25lIjpudWxsLCJhdmF0YXJfdXJsIjpudWxsLCJyb2xlIjp7ImlkIjozLCJuYW1lIjoiYWR2aXNvciJ9LCJhZGRyZXNzIjpudWxsLCJwYXNzd29yZCI6IjIwMmNiOTYyYWM1OTA3NWI5NjRiMDcxNTJkMjM0YjcwIiwiZW1haWwiOm51bGx9fQ==', '2014-09-16 06:52:08');
INSERT INTO `django_session` VALUES ('8iz1asibqub08dz4w23x9ghku6b3an5z', 'ODZmNDVkZDVlNjE0YzMyMjYwNWFiNWVkODJkMDA1OTA1Zjc3MDk2MDp7InVzZXIiOnsidXNlcm5hbWUiOiJhZG1pbiIsImd1aWQiOiJNMDExMDAwMDAwMDAxIiwibmFtZSI6ImFkbWluIiwicmVnaXN0ZXJfdGltZSI6IjIwMTQtMDYtMTYgMDQ6MjY6MzUiLCJhZ2UiOm51bGwsInNleCI6MSwiaWQiOjEsInBob25lIjoiMTExIiwiYXZhdGFyX3VybCI6bnVsbCwicm9sZSI6eyJpZCI6MSwibmFtZSI6ImFkbWluIn0sImFkZHJlc3MiOiIiLCJwYXNzd29yZCI6IjIxMjMyZjI5N2E1N2E1YTc0Mzg5NGEwZTRhODAxZmMzIiwiZW1haWwiOiJhYWEifX0=', '2014-12-29 02:51:01');
INSERT INTO `django_session` VALUES ('8qhjywm0dqscjenkr8k1dh2rp42vdx51', 'ODkwMDI4OGNiZjQyNzA0MDU4NTJlM2M4ODM5NWYwYTQzZmIwZDcyNzp7InVzZXIiOnsidXNlcm5hbWUiOiJhZHZpc29yMCIsImd1aWQiOiJNMDMxMDAwMDAwMDA3IiwibmFtZSI6ImFkdmlzb3IwIiwicmVnaXN0ZXJfdGltZSI6IjIwMTQtMDYtMTYgMDQ6MjY6NDAiLCJhZ2UiOm51bGwsInNleCI6bnVsbCwiaWQiOjcsInBob25lIjpudWxsLCJhdmF0YXJfdXJsIjpudWxsLCJyb2xlIjp7ImlkIjozLCJuYW1lIjoiYWR2aXNvciJ9LCJhZGRyZXNzIjpudWxsLCJwYXNzd29yZCI6IjIwMmNiOTYyYWM1OTA3NWI5NjRiMDcxNTJkMjM0YjcwIiwiZW1haWwiOm51bGx9fQ==', '2014-12-15 12:45:10');
INSERT INTO `django_session` VALUES ('917xjq00bhpy4nk9jt6ntrbpb9mxv2h2', 'ZDRmNzcwYmY0MGQ1YmQ3NWFhNGJhNDhmNTQ4YWFmNTRhYjQ4ZDkyOTp7InVzZXIiOnsidXNlcm5hbWUiOiJ3dXdlaSIsImd1aWQiOiJNMDQxMDAwMDAwMDI2IiwibmFtZSI6Ilx1NTQzNFx1NWEwMSIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA3LTA5IDAzOjAzOjQyIiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyNiwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiMjAyY2I5NjJhYzU5MDc1Yjk2NGIwNzE1MmQyMzRiNzAiLCJlbWFpbCI6bnVsbH19', '2014-08-11 09:51:20');
INSERT INTO `django_session` VALUES ('91kgsbo3sm7e2ftqjp4wh9ul15itb3hr', 'MThmZTEzMmUxODFlMGZiNGY3OGI0ZDc4YTEwOGFlMTRlNjY4NGQwMzp7InVzZXIiOnsidXNlcm5hbWUiOiJ0ZXN0NCIsImd1aWQiOiJNMDQxMDAwMDAwMDIwIiwibmFtZSI6Ilx1NmQ0Ylx1OGJkNVx1NTZkYiIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA2LTE1IDE1OjI5OjQ4IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyMCwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiODY5ODVlMTA1Zjc5Yjk1ZDZiYzkxOGZiNDVlYzc3MjciLCJlbWFpbCI6bnVsbH19', '2014-06-29 16:23:40');
INSERT INTO `django_session` VALUES ('98s16669ldfj2buq3g1ajvnbswb1o6t3', 'ZDc3Y2M0ZGNkOWY5ZDM5MDQwN2JhNzhhYWFjY2JlNmE3NWUxMjhmMTp7InVzZXIiOnsidXNlcm5hbWUiOiJ3dXdlaSIsImd1aWQiOiJNMDQxMDAwMDAwMDI2IiwibmFtZSI6Ilx1NTQzNFx1NWEwMSIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA3LTA5IDAzOjAzOjQyIiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyNiwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiYzRjYTQyMzhhMGI5MjM4MjBkY2M1MDlhNmY3NTg0OWIiLCJlbWFpbCI6bnVsbH19', '2014-07-23 03:19:01');
INSERT INTO `django_session` VALUES ('9hki7v04ffi3adlr0kdvgm42zono2o1s', 'MmYwMTAyNTgwNjNiMGNhNjliYzQzZGFiODAxMTllN2U2NjY4ZTRmZTp7InVzZXIiOnsidXNlcm5hbWUiOiJ3dSIsImd1aWQiOiJNMDQxMDAwMDAwMDI0IiwibmFtZSI6Ilx1NTQzNFx1NWEwMSIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA3LTA4IDEyOjMxOjQ5IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyNCwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiMWYzNmMxNWQ2YTNkMThkNTJlOGQ0OTNiYzgxODdjYjkiLCJlbWFpbCI6bnVsbH19', '2014-07-23 02:33:24');
INSERT INTO `django_session` VALUES ('aakafcuqoztkgetucy8y3jos3fwo9wsx', 'Y2MxYTM4MjBjMTIzNGI1NTc0ODc0ZjlmM2JiNGFiNThmMTZlNmVkNjp7fQ==', '2014-07-20 23:59:01');
INSERT INTO `django_session` VALUES ('ahm34fyueextwp3uq4ew52yiykgpg0fy', 'ZmZiOTVlZGExM2E1ODc3Y2RmMzNjZmFjMmZhN2EyMjk0YzEzNjk1NDp7InVzZXIiOnsidXNlcm5hbWUiOiJ0ZXN0NiIsImd1aWQiOiJNMDQxMDAwMDAwMDIzIiwibmFtZSI6Ilx1NmQ0Ylx1OGJkNVx1NTE2ZCIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA2LTE4IDA4OjIwOjE1IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyMywicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNGNmYWQ3MDc2MTI5OTYyZWU3MGMzNjgzOWExZTNlMTUiLCJlbWFpbCI6bnVsbH19', '2014-07-03 07:58:54');
INSERT INTO `django_session` VALUES ('ayk9bwschind9166bbd0nuu0vc3h80n1', 'ODkwMDI4OGNiZjQyNzA0MDU4NTJlM2M4ODM5NWYwYTQzZmIwZDcyNzp7InVzZXIiOnsidXNlcm5hbWUiOiJhZHZpc29yMCIsImd1aWQiOiJNMDMxMDAwMDAwMDA3IiwibmFtZSI6ImFkdmlzb3IwIiwicmVnaXN0ZXJfdGltZSI6IjIwMTQtMDYtMTYgMDQ6MjY6NDAiLCJhZ2UiOm51bGwsInNleCI6bnVsbCwiaWQiOjcsInBob25lIjpudWxsLCJhdmF0YXJfdXJsIjpudWxsLCJyb2xlIjp7ImlkIjozLCJuYW1lIjoiYWR2aXNvciJ9LCJhZGRyZXNzIjpudWxsLCJwYXNzd29yZCI6IjIwMmNiOTYyYWM1OTA3NWI5NjRiMDcxNTJkMjM0YjcwIiwiZW1haWwiOm51bGx9fQ==', '2014-12-24 07:41:16');
INSERT INTO `django_session` VALUES ('b83c8pk7h758bnzgnq5s2c414x9gl3cw', 'ODkwMDI4OGNiZjQyNzA0MDU4NTJlM2M4ODM5NWYwYTQzZmIwZDcyNzp7InVzZXIiOnsidXNlcm5hbWUiOiJhZHZpc29yMCIsImd1aWQiOiJNMDMxMDAwMDAwMDA3IiwibmFtZSI6ImFkdmlzb3IwIiwicmVnaXN0ZXJfdGltZSI6IjIwMTQtMDYtMTYgMDQ6MjY6NDAiLCJhZ2UiOm51bGwsInNleCI6bnVsbCwiaWQiOjcsInBob25lIjpudWxsLCJhdmF0YXJfdXJsIjpudWxsLCJyb2xlIjp7ImlkIjozLCJuYW1lIjoiYWR2aXNvciJ9LCJhZGRyZXNzIjpudWxsLCJwYXNzd29yZCI6IjIwMmNiOTYyYWM1OTA3NWI5NjRiMDcxNTJkMjM0YjcwIiwiZW1haWwiOm51bGx9fQ==', '2014-12-17 12:17:06');
INSERT INTO `django_session` VALUES ('b8a6n7wmr9li67ygsxc2nb9vaf9mwor1', 'ZDRmNzcwYmY0MGQ1YmQ3NWFhNGJhNDhmNTQ4YWFmNTRhYjQ4ZDkyOTp7InVzZXIiOnsidXNlcm5hbWUiOiJ3dXdlaSIsImd1aWQiOiJNMDQxMDAwMDAwMDI2IiwibmFtZSI6Ilx1NTQzNFx1NWEwMSIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA3LTA5IDAzOjAzOjQyIiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyNiwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiMjAyY2I5NjJhYzU5MDc1Yjk2NGIwNzE1MmQyMzRiNzAiLCJlbWFpbCI6bnVsbH19', '2014-08-11 10:09:15');
INSERT INTO `django_session` VALUES ('bchv59zjglcrq09pb4co0qno15j696or', 'MmYwMTAyNTgwNjNiMGNhNjliYzQzZGFiODAxMTllN2U2NjY4ZTRmZTp7InVzZXIiOnsidXNlcm5hbWUiOiJ3dSIsImd1aWQiOiJNMDQxMDAwMDAwMDI0IiwibmFtZSI6Ilx1NTQzNFx1NWEwMSIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA3LTA4IDEyOjMxOjQ5IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyNCwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiMWYzNmMxNWQ2YTNkMThkNTJlOGQ0OTNiYzgxODdjYjkiLCJlbWFpbCI6bnVsbH19', '2014-07-22 12:37:52');
INSERT INTO `django_session` VALUES ('bl7o4nyl5ihwq51jm4r3k09atimhllz3', 'ZmZiOTVlZGExM2E1ODc3Y2RmMzNjZmFjMmZhN2EyMjk0YzEzNjk1NDp7InVzZXIiOnsidXNlcm5hbWUiOiJ0ZXN0NiIsImd1aWQiOiJNMDQxMDAwMDAwMDIzIiwibmFtZSI6Ilx1NmQ0Ylx1OGJkNVx1NTE2ZCIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA2LTE4IDA4OjIwOjE1IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyMywicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNGNmYWQ3MDc2MTI5OTYyZWU3MGMzNjgzOWExZTNlMTUiLCJlbWFpbCI6bnVsbH19', '2014-08-05 04:14:08');
INSERT INTO `django_session` VALUES ('bq8qnrtmb1eynwggjisdwgl7139dhd6a', 'MmYwMTAyNTgwNjNiMGNhNjliYzQzZGFiODAxMTllN2U2NjY4ZTRmZTp7InVzZXIiOnsidXNlcm5hbWUiOiJ3dSIsImd1aWQiOiJNMDQxMDAwMDAwMDI0IiwibmFtZSI6Ilx1NTQzNFx1NWEwMSIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA3LTA4IDEyOjMxOjQ5IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyNCwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiMWYzNmMxNWQ2YTNkMThkNTJlOGQ0OTNiYzgxODdjYjkiLCJlbWFpbCI6bnVsbH19', '2014-07-22 12:34:14');
INSERT INTO `django_session` VALUES ('bs36chgp8cxw48tnnljzrqux6q9yl3at', 'ODZmNDVkZDVlNjE0YzMyMjYwNWFiNWVkODJkMDA1OTA1Zjc3MDk2MDp7InVzZXIiOnsidXNlcm5hbWUiOiJhZG1pbiIsImd1aWQiOiJNMDExMDAwMDAwMDAxIiwibmFtZSI6ImFkbWluIiwicmVnaXN0ZXJfdGltZSI6IjIwMTQtMDYtMTYgMDQ6MjY6MzUiLCJhZ2UiOm51bGwsInNleCI6MSwiaWQiOjEsInBob25lIjoiMTExIiwiYXZhdGFyX3VybCI6bnVsbCwicm9sZSI6eyJpZCI6MSwibmFtZSI6ImFkbWluIn0sImFkZHJlc3MiOiIiLCJwYXNzd29yZCI6IjIxMjMyZjI5N2E1N2E1YTc0Mzg5NGEwZTRhODAxZmMzIiwiZW1haWwiOiJhYWEifX0=', '2014-07-16 04:42:58');
INSERT INTO `django_session` VALUES ('c01kimgh6a1qeckdv2x12oonwobk9yc9', 'OTBiYzBmMDEyMzIwM2M3NTdiZDcwYWY1MDhlY2UxNjBiODcxNTNjODp7InVzZXIiOnsidXNlcm5hbWUiOiJhYSIsImd1aWQiOiJNMDQxMDAwMDAwMDI5IiwibmFtZSI6Ilx1NjVlMFx1OTcwMFx1NTQyNyIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTExLTE5IDAzOjA2OjQyIiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyOSwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNDEyNGJjMGE5MzM1YzI3ZjA4NmYyNGJhMjA3YTQ5MTIiLCJlbWFpbCI6bnVsbH19', '2014-12-05 02:19:30');
INSERT INTO `django_session` VALUES ('ccmg0oz5tu5jn73agxek8bcozqsmza1a', 'MThmZTEzMmUxODFlMGZiNGY3OGI0ZDc4YTEwOGFlMTRlNjY4NGQwMzp7InVzZXIiOnsidXNlcm5hbWUiOiJ0ZXN0NCIsImd1aWQiOiJNMDQxMDAwMDAwMDIwIiwibmFtZSI6Ilx1NmQ0Ylx1OGJkNVx1NTZkYiIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA2LTE1IDE1OjI5OjQ4IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyMCwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiODY5ODVlMTA1Zjc5Yjk1ZDZiYzkxOGZiNDVlYzc3MjciLCJlbWFpbCI6bnVsbH19', '2014-06-29 15:31:56');
INSERT INTO `django_session` VALUES ('cepi09epklccdgmbod9fcchao5qm1x3g', 'MmYwMTAyNTgwNjNiMGNhNjliYzQzZGFiODAxMTllN2U2NjY4ZTRmZTp7InVzZXIiOnsidXNlcm5hbWUiOiJ3dSIsImd1aWQiOiJNMDQxMDAwMDAwMDI0IiwibmFtZSI6Ilx1NTQzNFx1NWEwMSIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA3LTA4IDEyOjMxOjQ5IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyNCwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiMWYzNmMxNWQ2YTNkMThkNTJlOGQ0OTNiYzgxODdjYjkiLCJlbWFpbCI6bnVsbH19', '2014-07-23 02:33:42');
INSERT INTO `django_session` VALUES ('cg1reu7mkcnegx55uybrsxsev8x3ph9r', 'OWFjZjQ2M2M0MWZjMDYyMTZiYzU4NjY5YWUxNjM2ZWUwNjYyODJiZDp7InVzZXIiOnsidXNlcm5hbWUiOiJhOTJkMjI1NGE4ZDQiLCJndWlkIjoiTTAyMTAwMDAwMDAxNyIsIm5hbWUiOiJhOTJkZmYyNmE4ZDQiLCJyZWdpc3Rlcl90aW1lIjoiMjAxNC0wNi0xNSAxNToyODoxMSIsImFnZSI6bnVsbCwic2V4IjpudWxsLCJpZCI6MTcsInBob25lIjpudWxsLCJhdmF0YXJfdXJsIjpudWxsLCJyb2xlIjp7ImlkIjoyLCJuYW1lIjoiZG9jdG9yIn0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiOGNjZjJiOTZmMWZiM2E2ZmJlMTExMWM1NDk1MDU1OGQiLCJlbWFpbCI6bnVsbH19', '2014-06-29 15:28:11');
INSERT INTO `django_session` VALUES ('cww4bpiza1qy8cjgjujv79yvq3cwhfz5', 'OTBiYzBmMDEyMzIwM2M3NTdiZDcwYWY1MDhlY2UxNjBiODcxNTNjODp7InVzZXIiOnsidXNlcm5hbWUiOiJhYSIsImd1aWQiOiJNMDQxMDAwMDAwMDI5IiwibmFtZSI6Ilx1NjVlMFx1OTcwMFx1NTQyNyIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTExLTE5IDAzOjA2OjQyIiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyOSwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNDEyNGJjMGE5MzM1YzI3ZjA4NmYyNGJhMjA3YTQ5MTIiLCJlbWFpbCI6bnVsbH19', '2014-12-10 07:15:21');
INSERT INTO `django_session` VALUES ('d1n8iy3y0dk613fb0fn0lrtumtu93y01', 'ODZmNDVkZDVlNjE0YzMyMjYwNWFiNWVkODJkMDA1OTA1Zjc3MDk2MDp7InVzZXIiOnsidXNlcm5hbWUiOiJhZG1pbiIsImd1aWQiOiJNMDExMDAwMDAwMDAxIiwibmFtZSI6ImFkbWluIiwicmVnaXN0ZXJfdGltZSI6IjIwMTQtMDYtMTYgMDQ6MjY6MzUiLCJhZ2UiOm51bGwsInNleCI6MSwiaWQiOjEsInBob25lIjoiMTExIiwiYXZhdGFyX3VybCI6bnVsbCwicm9sZSI6eyJpZCI6MSwibmFtZSI6ImFkbWluIn0sImFkZHJlc3MiOiIiLCJwYXNzd29yZCI6IjIxMjMyZjI5N2E1N2E1YTc0Mzg5NGEwZTRhODAxZmMzIiwiZW1haWwiOiJhYWEifX0=', '2014-08-11 09:52:15');
INSERT INTO `django_session` VALUES ('de7d1erkl01zt9ktiztr8vliq0zvuhs6', 'ODkwMDI4OGNiZjQyNzA0MDU4NTJlM2M4ODM5NWYwYTQzZmIwZDcyNzp7InVzZXIiOnsidXNlcm5hbWUiOiJhZHZpc29yMCIsImd1aWQiOiJNMDMxMDAwMDAwMDA3IiwibmFtZSI6ImFkdmlzb3IwIiwicmVnaXN0ZXJfdGltZSI6IjIwMTQtMDYtMTYgMDQ6MjY6NDAiLCJhZ2UiOm51bGwsInNleCI6bnVsbCwiaWQiOjcsInBob25lIjpudWxsLCJhdmF0YXJfdXJsIjpudWxsLCJyb2xlIjp7ImlkIjozLCJuYW1lIjoiYWR2aXNvciJ9LCJhZGRyZXNzIjpudWxsLCJwYXNzd29yZCI6IjIwMmNiOTYyYWM1OTA3NWI5NjRiMDcxNTJkMjM0YjcwIiwiZW1haWwiOm51bGx9fQ==', '2014-08-01 12:53:28');
INSERT INTO `django_session` VALUES ('deeo2wl04sjpproh8lpegwdyb4cbebhc', 'ZmZiOTVlZGExM2E1ODc3Y2RmMzNjZmFjMmZhN2EyMjk0YzEzNjk1NDp7InVzZXIiOnsidXNlcm5hbWUiOiJ0ZXN0NiIsImd1aWQiOiJNMDQxMDAwMDAwMDIzIiwibmFtZSI6Ilx1NmQ0Ylx1OGJkNVx1NTE2ZCIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA2LTE4IDA4OjIwOjE1IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyMywicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNGNmYWQ3MDc2MTI5OTYyZWU3MGMzNjgzOWExZTNlMTUiLCJlbWFpbCI6bnVsbH19', '2014-07-03 09:44:16');
INSERT INTO `django_session` VALUES ('dpmgcyx3yy4rot067uspyeat290hlc9q', 'OTBiYzBmMDEyMzIwM2M3NTdiZDcwYWY1MDhlY2UxNjBiODcxNTNjODp7InVzZXIiOnsidXNlcm5hbWUiOiJhYSIsImd1aWQiOiJNMDQxMDAwMDAwMDI5IiwibmFtZSI6Ilx1NjVlMFx1OTcwMFx1NTQyNyIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTExLTE5IDAzOjA2OjQyIiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyOSwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNDEyNGJjMGE5MzM1YzI3ZjA4NmYyNGJhMjA3YTQ5MTIiLCJlbWFpbCI6bnVsbH19', '2014-12-04 08:18:11');
INSERT INTO `django_session` VALUES ('dw2prhijfst36bi47ht7hiatzdzmybmq', 'ODZmNDVkZDVlNjE0YzMyMjYwNWFiNWVkODJkMDA1OTA1Zjc3MDk2MDp7InVzZXIiOnsidXNlcm5hbWUiOiJhZG1pbiIsImd1aWQiOiJNMDExMDAwMDAwMDAxIiwibmFtZSI6ImFkbWluIiwicmVnaXN0ZXJfdGltZSI6IjIwMTQtMDYtMTYgMDQ6MjY6MzUiLCJhZ2UiOm51bGwsInNleCI6MSwiaWQiOjEsInBob25lIjoiMTExIiwiYXZhdGFyX3VybCI6bnVsbCwicm9sZSI6eyJpZCI6MSwibmFtZSI6ImFkbWluIn0sImFkZHJlc3MiOiIiLCJwYXNzd29yZCI6IjIxMjMyZjI5N2E1N2E1YTc0Mzg5NGEwZTRhODAxZmMzIiwiZW1haWwiOiJhYWEifX0=', '2014-07-29 10:06:36');
INSERT INTO `django_session` VALUES ('eaezq8i4kzteofr8ws6gc8f7zppbwu6w', 'ODZmNDVkZDVlNjE0YzMyMjYwNWFiNWVkODJkMDA1OTA1Zjc3MDk2MDp7InVzZXIiOnsidXNlcm5hbWUiOiJhZG1pbiIsImd1aWQiOiJNMDExMDAwMDAwMDAxIiwibmFtZSI6ImFkbWluIiwicmVnaXN0ZXJfdGltZSI6IjIwMTQtMDYtMTYgMDQ6MjY6MzUiLCJhZ2UiOm51bGwsInNleCI6MSwiaWQiOjEsInBob25lIjoiMTExIiwiYXZhdGFyX3VybCI6bnVsbCwicm9sZSI6eyJpZCI6MSwibmFtZSI6ImFkbWluIn0sImFkZHJlc3MiOiIiLCJwYXNzd29yZCI6IjIxMjMyZjI5N2E1N2E1YTc0Mzg5NGEwZTRhODAxZmMzIiwiZW1haWwiOiJhYWEifX0=', '2014-08-11 10:07:00');
INSERT INTO `django_session` VALUES ('eeur9ds99fsax65xe2hk42uzp4okdsk1', 'ODZmNDVkZDVlNjE0YzMyMjYwNWFiNWVkODJkMDA1OTA1Zjc3MDk2MDp7InVzZXIiOnsidXNlcm5hbWUiOiJhZG1pbiIsImd1aWQiOiJNMDExMDAwMDAwMDAxIiwibmFtZSI6ImFkbWluIiwicmVnaXN0ZXJfdGltZSI6IjIwMTQtMDYtMTYgMDQ6MjY6MzUiLCJhZ2UiOm51bGwsInNleCI6MSwiaWQiOjEsInBob25lIjoiMTExIiwiYXZhdGFyX3VybCI6bnVsbCwicm9sZSI6eyJpZCI6MSwibmFtZSI6ImFkbWluIn0sImFkZHJlc3MiOiIiLCJwYXNzd29yZCI6IjIxMjMyZjI5N2E1N2E1YTc0Mzg5NGEwZTRhODAxZmMzIiwiZW1haWwiOiJhYWEifX0=', '2014-07-13 13:05:40');
INSERT INTO `django_session` VALUES ('eiec0r828zvjx3dfyrcwx8u4g2mhr81x', 'Y2MxYTM4MjBjMTIzNGI1NTc0ODc0ZjlmM2JiNGFiNThmMTZlNmVkNjp7fQ==', '2014-06-30 03:33:50');
INSERT INTO `django_session` VALUES ('eu4qt83v60glfl7w2dhpugsc9t6islxc', 'Y2MxYTM4MjBjMTIzNGI1NTc0ODc0ZjlmM2JiNGFiNThmMTZlNmVkNjp7fQ==', '2014-06-29 15:26:30');
INSERT INTO `django_session` VALUES ('frfmamj2105kctukw9nu9xk11tnfkdun', 'ZmZiOTVlZGExM2E1ODc3Y2RmMzNjZmFjMmZhN2EyMjk0YzEzNjk1NDp7InVzZXIiOnsidXNlcm5hbWUiOiJ0ZXN0NiIsImd1aWQiOiJNMDQxMDAwMDAwMDIzIiwibmFtZSI6Ilx1NmQ0Ylx1OGJkNVx1NTE2ZCIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA2LTE4IDA4OjIwOjE1IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyMywicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNGNmYWQ3MDc2MTI5OTYyZWU3MGMzNjgzOWExZTNlMTUiLCJlbWFpbCI6bnVsbH19', '2014-07-03 09:19:52');
INSERT INTO `django_session` VALUES ('gidt6nwgezczqrde91n849d5gp01o4w1', 'ZmZiOTVlZGExM2E1ODc3Y2RmMzNjZmFjMmZhN2EyMjk0YzEzNjk1NDp7InVzZXIiOnsidXNlcm5hbWUiOiJ0ZXN0NiIsImd1aWQiOiJNMDQxMDAwMDAwMDIzIiwibmFtZSI6Ilx1NmQ0Ylx1OGJkNVx1NTE2ZCIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA2LTE4IDA4OjIwOjE1IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyMywicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNGNmYWQ3MDc2MTI5OTYyZWU3MGMzNjgzOWExZTNlMTUiLCJlbWFpbCI6bnVsbH19', '2014-07-03 08:07:46');
INSERT INTO `django_session` VALUES ('gzwxmb2rj621928didxt9ylamcpwuapz', 'ZmZiOTVlZGExM2E1ODc3Y2RmMzNjZmFjMmZhN2EyMjk0YzEzNjk1NDp7InVzZXIiOnsidXNlcm5hbWUiOiJ0ZXN0NiIsImd1aWQiOiJNMDQxMDAwMDAwMDIzIiwibmFtZSI6Ilx1NmQ0Ylx1OGJkNVx1NTE2ZCIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA2LTE4IDA4OjIwOjE1IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyMywicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNGNmYWQ3MDc2MTI5OTYyZWU3MGMzNjgzOWExZTNlMTUiLCJlbWFpbCI6bnVsbH19', '2014-07-03 09:39:28');
INSERT INTO `django_session` VALUES ('h7887xdogwhd0w07l46nlx3fn5izcba4', 'ODZmNDVkZDVlNjE0YzMyMjYwNWFiNWVkODJkMDA1OTA1Zjc3MDk2MDp7InVzZXIiOnsidXNlcm5hbWUiOiJhZG1pbiIsImd1aWQiOiJNMDExMDAwMDAwMDAxIiwibmFtZSI6ImFkbWluIiwicmVnaXN0ZXJfdGltZSI6IjIwMTQtMDYtMTYgMDQ6MjY6MzUiLCJhZ2UiOm51bGwsInNleCI6MSwiaWQiOjEsInBob25lIjoiMTExIiwiYXZhdGFyX3VybCI6bnVsbCwicm9sZSI6eyJpZCI6MSwibmFtZSI6ImFkbWluIn0sImFkZHJlc3MiOiIiLCJwYXNzd29yZCI6IjIxMjMyZjI5N2E1N2E1YTc0Mzg5NGEwZTRhODAxZmMzIiwiZW1haWwiOiJhYWEifX0=', '2014-12-29 02:49:48');
INSERT INTO `django_session` VALUES ('i17kxqssg2rpsfre3hg0mol3uipx7up5', 'ZmZiOTVlZGExM2E1ODc3Y2RmMzNjZmFjMmZhN2EyMjk0YzEzNjk1NDp7InVzZXIiOnsidXNlcm5hbWUiOiJ0ZXN0NiIsImd1aWQiOiJNMDQxMDAwMDAwMDIzIiwibmFtZSI6Ilx1NmQ0Ylx1OGJkNVx1NTE2ZCIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA2LTE4IDA4OjIwOjE1IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyMywicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNGNmYWQ3MDc2MTI5OTYyZWU3MGMzNjgzOWExZTNlMTUiLCJlbWFpbCI6bnVsbH19', '2014-07-23 07:32:48');
INSERT INTO `django_session` VALUES ('ibvh98xw79nbwib47m4jkmtj5vtg79o9', 'ZDRmNzcwYmY0MGQ1YmQ3NWFhNGJhNDhmNTQ4YWFmNTRhYjQ4ZDkyOTp7InVzZXIiOnsidXNlcm5hbWUiOiJ3dXdlaSIsImd1aWQiOiJNMDQxMDAwMDAwMDI2IiwibmFtZSI6Ilx1NTQzNFx1NWEwMSIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA3LTA5IDAzOjAzOjQyIiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyNiwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiMjAyY2I5NjJhYzU5MDc1Yjk2NGIwNzE1MmQyMzRiNzAiLCJlbWFpbCI6bnVsbH19', '2014-08-05 11:44:22');
INSERT INTO `django_session` VALUES ('ip31w3jb6bqfzcoex42960kg7ctuzu3k', 'Y2MxYTM4MjBjMTIzNGI1NTc0ODc0ZjlmM2JiNGFiNThmMTZlNmVkNjp7fQ==', '2014-12-11 07:26:27');
INSERT INTO `django_session` VALUES ('it7kdystewisztmfirp7a1mrvwv1fg4q', 'ZmZiOTVlZGExM2E1ODc3Y2RmMzNjZmFjMmZhN2EyMjk0YzEzNjk1NDp7InVzZXIiOnsidXNlcm5hbWUiOiJ0ZXN0NiIsImd1aWQiOiJNMDQxMDAwMDAwMDIzIiwibmFtZSI6Ilx1NmQ0Ylx1OGJkNVx1NTE2ZCIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA2LTE4IDA4OjIwOjE1IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyMywicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNGNmYWQ3MDc2MTI5OTYyZWU3MGMzNjgzOWExZTNlMTUiLCJlbWFpbCI6bnVsbH19', '2014-07-21 15:09:58');
INSERT INTO `django_session` VALUES ('ixzxfbng0mu31apgxdip342gc7i981ha', 'OTBiYzBmMDEyMzIwM2M3NTdiZDcwYWY1MDhlY2UxNjBiODcxNTNjODp7InVzZXIiOnsidXNlcm5hbWUiOiJhYSIsImd1aWQiOiJNMDQxMDAwMDAwMDI5IiwibmFtZSI6Ilx1NjVlMFx1OTcwMFx1NTQyNyIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTExLTE5IDAzOjA2OjQyIiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyOSwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNDEyNGJjMGE5MzM1YzI3ZjA4NmYyNGJhMjA3YTQ5MTIiLCJlbWFpbCI6bnVsbH19', '2014-12-17 13:38:34');
INSERT INTO `django_session` VALUES ('jpnx8bfvhitj3av63muwwtsyrr5ilbwk', 'MmYwMTAyNTgwNjNiMGNhNjliYzQzZGFiODAxMTllN2U2NjY4ZTRmZTp7InVzZXIiOnsidXNlcm5hbWUiOiJ3dSIsImd1aWQiOiJNMDQxMDAwMDAwMDI0IiwibmFtZSI6Ilx1NTQzNFx1NWEwMSIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA3LTA4IDEyOjMxOjQ5IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyNCwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiMWYzNmMxNWQ2YTNkMThkNTJlOGQ0OTNiYzgxODdjYjkiLCJlbWFpbCI6bnVsbH19', '2014-07-23 02:34:11');
INSERT INTO `django_session` VALUES ('kjyprwj0wm30k0ebs89ygbnn3e9ci2n2', 'ZmZiOTVlZGExM2E1ODc3Y2RmMzNjZmFjMmZhN2EyMjk0YzEzNjk1NDp7InVzZXIiOnsidXNlcm5hbWUiOiJ0ZXN0NiIsImd1aWQiOiJNMDQxMDAwMDAwMDIzIiwibmFtZSI6Ilx1NmQ0Ylx1OGJkNVx1NTE2ZCIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA2LTE4IDA4OjIwOjE1IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyMywicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNGNmYWQ3MDc2MTI5OTYyZWU3MGMzNjgzOWExZTNlMTUiLCJlbWFpbCI6bnVsbH19', '2014-07-03 08:10:47');
INSERT INTO `django_session` VALUES ('l2nfnweq3xj2vl4nfccxr4623d4fmbrr', 'ZmZiOTVlZGExM2E1ODc3Y2RmMzNjZmFjMmZhN2EyMjk0YzEzNjk1NDp7InVzZXIiOnsidXNlcm5hbWUiOiJ0ZXN0NiIsImd1aWQiOiJNMDQxMDAwMDAwMDIzIiwibmFtZSI6Ilx1NmQ0Ylx1OGJkNVx1NTE2ZCIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA2LTE4IDA4OjIwOjE1IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyMywicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNGNmYWQ3MDc2MTI5OTYyZWU3MGMzNjgzOWExZTNlMTUiLCJlbWFpbCI6bnVsbH19', '2014-07-03 08:01:05');
INSERT INTO `django_session` VALUES ('lpvjp3v3muflomrzsby0si8tnrr5i4ml', 'MmYwMTAyNTgwNjNiMGNhNjliYzQzZGFiODAxMTllN2U2NjY4ZTRmZTp7InVzZXIiOnsidXNlcm5hbWUiOiJ3dSIsImd1aWQiOiJNMDQxMDAwMDAwMDI0IiwibmFtZSI6Ilx1NTQzNFx1NWEwMSIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA3LTA4IDEyOjMxOjQ5IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyNCwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiMWYzNmMxNWQ2YTNkMThkNTJlOGQ0OTNiYzgxODdjYjkiLCJlbWFpbCI6bnVsbH19', '2014-07-23 02:34:18');
INSERT INTO `django_session` VALUES ('n09xmkrzsf9fld6ktbn7riazy8shhmvw', 'ZmZiOTVlZGExM2E1ODc3Y2RmMzNjZmFjMmZhN2EyMjk0YzEzNjk1NDp7InVzZXIiOnsidXNlcm5hbWUiOiJ0ZXN0NiIsImd1aWQiOiJNMDQxMDAwMDAwMDIzIiwibmFtZSI6Ilx1NmQ0Ylx1OGJkNVx1NTE2ZCIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA2LTE4IDA4OjIwOjE1IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyMywicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNGNmYWQ3MDc2MTI5OTYyZWU3MGMzNjgzOWExZTNlMTUiLCJlbWFpbCI6bnVsbH19', '2014-08-01 09:29:03');
INSERT INTO `django_session` VALUES ('n64bnk342b0ps741xtc58bpovpw3adu1', 'ZmZiOTVlZGExM2E1ODc3Y2RmMzNjZmFjMmZhN2EyMjk0YzEzNjk1NDp7InVzZXIiOnsidXNlcm5hbWUiOiJ0ZXN0NiIsImd1aWQiOiJNMDQxMDAwMDAwMDIzIiwibmFtZSI6Ilx1NmQ0Ylx1OGJkNVx1NTE2ZCIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA2LTE4IDA4OjIwOjE1IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyMywicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNGNmYWQ3MDc2MTI5OTYyZWU3MGMzNjgzOWExZTNlMTUiLCJlbWFpbCI6bnVsbH19', '2014-07-20 15:39:00');
INSERT INTO `django_session` VALUES ('o3gi5to8gpbjmvc1pvd5aqvhfuva7o0c', 'Y2MxYTM4MjBjMTIzNGI1NTc0ODc0ZjlmM2JiNGFiNThmMTZlNmVkNjp7fQ==', '2014-12-17 04:15:51');
INSERT INTO `django_session` VALUES ('o77q2dzdc57celkmttrv9c1iitcw3gqr', 'ODZmNDVkZDVlNjE0YzMyMjYwNWFiNWVkODJkMDA1OTA1Zjc3MDk2MDp7InVzZXIiOnsidXNlcm5hbWUiOiJhZG1pbiIsImd1aWQiOiJNMDExMDAwMDAwMDAxIiwibmFtZSI6ImFkbWluIiwicmVnaXN0ZXJfdGltZSI6IjIwMTQtMDYtMTYgMDQ6MjY6MzUiLCJhZ2UiOm51bGwsInNleCI6MSwiaWQiOjEsInBob25lIjoiMTExIiwiYXZhdGFyX3VybCI6bnVsbCwicm9sZSI6eyJpZCI6MSwibmFtZSI6ImFkbWluIn0sImFkZHJlc3MiOiIiLCJwYXNzd29yZCI6IjIxMjMyZjI5N2E1N2E1YTc0Mzg5NGEwZTRhODAxZmMzIiwiZW1haWwiOiJhYWEifX0=', '2014-08-11 09:51:59');
INSERT INTO `django_session` VALUES ('oiryfux7faeeq6p41rrsfcttru36k0qm', 'ODZmNDVkZDVlNjE0YzMyMjYwNWFiNWVkODJkMDA1OTA1Zjc3MDk2MDp7InVzZXIiOnsidXNlcm5hbWUiOiJhZG1pbiIsImd1aWQiOiJNMDExMDAwMDAwMDAxIiwibmFtZSI6ImFkbWluIiwicmVnaXN0ZXJfdGltZSI6IjIwMTQtMDYtMTYgMDQ6MjY6MzUiLCJhZ2UiOm51bGwsInNleCI6MSwiaWQiOjEsInBob25lIjoiMTExIiwiYXZhdGFyX3VybCI6bnVsbCwicm9sZSI6eyJpZCI6MSwibmFtZSI6ImFkbWluIn0sImFkZHJlc3MiOiIiLCJwYXNzd29yZCI6IjIxMjMyZjI5N2E1N2E1YTc0Mzg5NGEwZTRhODAxZmMzIiwiZW1haWwiOiJhYWEifX0=', '2014-08-11 10:16:53');
INSERT INTO `django_session` VALUES ('p0zno7wblcqb56drs38ex6w5fnshduga', 'ZmZiOTVlZGExM2E1ODc3Y2RmMzNjZmFjMmZhN2EyMjk0YzEzNjk1NDp7InVzZXIiOnsidXNlcm5hbWUiOiJ0ZXN0NiIsImd1aWQiOiJNMDQxMDAwMDAwMDIzIiwibmFtZSI6Ilx1NmQ0Ylx1OGJkNVx1NTE2ZCIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA2LTE4IDA4OjIwOjE1IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyMywicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNGNmYWQ3MDc2MTI5OTYyZWU3MGMzNjgzOWExZTNlMTUiLCJlbWFpbCI6bnVsbH19', '2014-07-03 09:38:36');
INSERT INTO `django_session` VALUES ('p1n17mcn4vr6hqfa1mkee292q7fmcgrq', 'ODZmNDVkZDVlNjE0YzMyMjYwNWFiNWVkODJkMDA1OTA1Zjc3MDk2MDp7InVzZXIiOnsidXNlcm5hbWUiOiJhZG1pbiIsImd1aWQiOiJNMDExMDAwMDAwMDAxIiwibmFtZSI6ImFkbWluIiwicmVnaXN0ZXJfdGltZSI6IjIwMTQtMDYtMTYgMDQ6MjY6MzUiLCJhZ2UiOm51bGwsInNleCI6MSwiaWQiOjEsInBob25lIjoiMTExIiwiYXZhdGFyX3VybCI6bnVsbCwicm9sZSI6eyJpZCI6MSwibmFtZSI6ImFkbWluIn0sImFkZHJlc3MiOiIiLCJwYXNzd29yZCI6IjIxMjMyZjI5N2E1N2E1YTc0Mzg5NGEwZTRhODAxZmMzIiwiZW1haWwiOiJhYWEifX0=', '2014-07-01 09:06:10');
INSERT INTO `django_session` VALUES ('p78p99crvjtsszf8tibo4o0cgwwk1677', 'Y2MxYTM4MjBjMTIzNGI1NTc0ODc0ZjlmM2JiNGFiNThmMTZlNmVkNjp7fQ==', '2014-07-23 09:26:11');
INSERT INTO `django_session` VALUES ('pmz6qjvsmq9d1mt1lzdd7m0m9j9z1b5y', 'OTBiYzBmMDEyMzIwM2M3NTdiZDcwYWY1MDhlY2UxNjBiODcxNTNjODp7InVzZXIiOnsidXNlcm5hbWUiOiJhYSIsImd1aWQiOiJNMDQxMDAwMDAwMDI5IiwibmFtZSI6Ilx1NjVlMFx1OTcwMFx1NTQyNyIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTExLTE5IDAzOjA2OjQyIiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyOSwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNDEyNGJjMGE5MzM1YzI3ZjA4NmYyNGJhMjA3YTQ5MTIiLCJlbWFpbCI6bnVsbH19', '2014-12-03 08:44:30');
INSERT INTO `django_session` VALUES ('pq781d9r9154gez390i7ietgp7a6luml', 'Y2MxYTM4MjBjMTIzNGI1NTc0ODc0ZjlmM2JiNGFiNThmMTZlNmVkNjp7fQ==', '2014-08-05 11:44:00');
INSERT INTO `django_session` VALUES ('qf7ryhn040l4b2j9c4i2xi2ejsupsstd', 'M2NhZDNhMTk5Yjc5ZDBjNTdhNjk5YjIwM2QxODg5ZGI3YTI3ZDY3Nzp7InVzZXIiOnsidXNlcm5hbWUiOiJ3dXdlaSIsImd1aWQiOiJNMDQxMDAwMDAwMDI2IiwibmFtZSI6Ilx1NTQzNFx1NWEwMSIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA3LTA5IDAzOjAzOjQyIiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyNiwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiZWU1MDJlNDBlNWFlYzg0ZDExMzIyMWUzNjFlNmQ1MDgiLCJlbWFpbCI6bnVsbH19', '2014-12-03 02:55:37');
INSERT INTO `django_session` VALUES ('qjmnq8pups0w6iui25m4p5fbuh2mbuzm', 'ZmY1Y2EzOWI3NGFjMjExODVmZWM3ZmQ4MDg2NjA3NTVjOGI2MGUzZDp7InVzZXIiOnsidXNlcm5hbWUiOiJhOTQ1NGI1ZWE4ZDQiLCJndWlkIjoiTTA0MTAwMDAwMDAxOSIsIm5hbWUiOiJhOTQ1NTQ4MmE4ZDQiLCJyZWdpc3Rlcl90aW1lIjoiMjAxNC0wNi0xNSAxNToyODoxMSIsImFnZSI6bnVsbCwic2V4IjpudWxsLCJpZCI6MTksInBob25lIjpudWxsLCJhdmF0YXJfdXJsIjpudWxsLCJyb2xlIjp7ImlkIjo0LCJuYW1lIjoicGF0aWVudCJ9LCJhZGRyZXNzIjpudWxsLCJwYXNzd29yZCI6Ijk1ZDhiYWFmMGEyZDhiZjk5Y2FlZjE3MTY1NzZkMzBkIiwiZW1haWwiOm51bGx9fQ==', '2014-06-29 15:28:11');
INSERT INTO `django_session` VALUES ('qn17v79onq5veh5ncjup867d22q0uvc3', 'Y2MxYTM4MjBjMTIzNGI1NTc0ODc0ZjlmM2JiNGFiNThmMTZlNmVkNjp7fQ==', '2014-08-01 12:57:51');
INSERT INTO `django_session` VALUES ('r7y867arwc8020n5617p599sxbt3eam3', 'ODZmNDVkZDVlNjE0YzMyMjYwNWFiNWVkODJkMDA1OTA1Zjc3MDk2MDp7InVzZXIiOnsidXNlcm5hbWUiOiJhZG1pbiIsImd1aWQiOiJNMDExMDAwMDAwMDAxIiwibmFtZSI6ImFkbWluIiwicmVnaXN0ZXJfdGltZSI6IjIwMTQtMDYtMTYgMDQ6MjY6MzUiLCJhZ2UiOm51bGwsInNleCI6MSwiaWQiOjEsInBob25lIjoiMTExIiwiYXZhdGFyX3VybCI6bnVsbCwicm9sZSI6eyJpZCI6MSwibmFtZSI6ImFkbWluIn0sImFkZHJlc3MiOiIiLCJwYXNzd29yZCI6IjIxMjMyZjI5N2E1N2E1YTc0Mzg5NGEwZTRhODAxZmMzIiwiZW1haWwiOiJhYWEifX0=', '2014-07-24 09:11:36');
INSERT INTO `django_session` VALUES ('rbcm2b19rhagbrofyz8okav5m5uoa9s3', 'OTBiYzBmMDEyMzIwM2M3NTdiZDcwYWY1MDhlY2UxNjBiODcxNTNjODp7InVzZXIiOnsidXNlcm5hbWUiOiJhYSIsImd1aWQiOiJNMDQxMDAwMDAwMDI5IiwibmFtZSI6Ilx1NjVlMFx1OTcwMFx1NTQyNyIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTExLTE5IDAzOjA2OjQyIiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyOSwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNDEyNGJjMGE5MzM1YzI3ZjA4NmYyNGJhMjA3YTQ5MTIiLCJlbWFpbCI6bnVsbH19', '2014-12-17 15:02:46');
INSERT INTO `django_session` VALUES ('rtghtg3aoudc50e6te68b592jnq3r0yz', 'Y2MxYTM4MjBjMTIzNGI1NTc0ODc0ZjlmM2JiNGFiNThmMTZlNmVkNjp7fQ==', '2014-06-30 16:40:20');
INSERT INTO `django_session` VALUES ('ryzocqrta5bcvvp6tuei30445z0ilflg', 'ZmZiOTVlZGExM2E1ODc3Y2RmMzNjZmFjMmZhN2EyMjk0YzEzNjk1NDp7InVzZXIiOnsidXNlcm5hbWUiOiJ0ZXN0NiIsImd1aWQiOiJNMDQxMDAwMDAwMDIzIiwibmFtZSI6Ilx1NmQ0Ylx1OGJkNVx1NTE2ZCIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA2LTE4IDA4OjIwOjE1IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyMywicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNGNmYWQ3MDc2MTI5OTYyZWU3MGMzNjgzOWExZTNlMTUiLCJlbWFpbCI6bnVsbH19', '2014-07-08 03:55:55');
INSERT INTO `django_session` VALUES ('rz1x6quw1cmva3f014v8q93cyxkurd4k', 'ZmZiOTVlZGExM2E1ODc3Y2RmMzNjZmFjMmZhN2EyMjk0YzEzNjk1NDp7InVzZXIiOnsidXNlcm5hbWUiOiJ0ZXN0NiIsImd1aWQiOiJNMDQxMDAwMDAwMDIzIiwibmFtZSI6Ilx1NmQ0Ylx1OGJkNVx1NTE2ZCIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA2LTE4IDA4OjIwOjE1IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyMywicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNGNmYWQ3MDc2MTI5OTYyZWU3MGMzNjgzOWExZTNlMTUiLCJlbWFpbCI6bnVsbH19', '2014-07-05 07:46:58');
INSERT INTO `django_session` VALUES ('s2icjfeoc49pjix963r3nm3squfxon2d', 'ZDRmNzcwYmY0MGQ1YmQ3NWFhNGJhNDhmNTQ4YWFmNTRhYjQ4ZDkyOTp7InVzZXIiOnsidXNlcm5hbWUiOiJ3dXdlaSIsImd1aWQiOiJNMDQxMDAwMDAwMDI2IiwibmFtZSI6Ilx1NTQzNFx1NWEwMSIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA3LTA5IDAzOjAzOjQyIiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyNiwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiMjAyY2I5NjJhYzU5MDc1Yjk2NGIwNzE1MmQyMzRiNzAiLCJlbWFpbCI6bnVsbH19', '2014-08-11 09:33:35');
INSERT INTO `django_session` VALUES ('sprnnu2avxwmqqn7czuyjrb35tx9ebll', 'Y2MxYTM4MjBjMTIzNGI1NTc0ODc0ZjlmM2JiNGFiNThmMTZlNmVkNjp7fQ==', '2014-08-01 10:20:41');
INSERT INTO `django_session` VALUES ('t5cjl8423e8my5yfug3vzf047qcngcvy', 'ODZmNDVkZDVlNjE0YzMyMjYwNWFiNWVkODJkMDA1OTA1Zjc3MDk2MDp7InVzZXIiOnsidXNlcm5hbWUiOiJhZG1pbiIsImd1aWQiOiJNMDExMDAwMDAwMDAxIiwibmFtZSI6ImFkbWluIiwicmVnaXN0ZXJfdGltZSI6IjIwMTQtMDYtMTYgMDQ6MjY6MzUiLCJhZ2UiOm51bGwsInNleCI6MSwiaWQiOjEsInBob25lIjoiMTExIiwiYXZhdGFyX3VybCI6bnVsbCwicm9sZSI6eyJpZCI6MSwibmFtZSI6ImFkbWluIn0sImFkZHJlc3MiOiIiLCJwYXNzd29yZCI6IjIxMjMyZjI5N2E1N2E1YTc0Mzg5NGEwZTRhODAxZmMzIiwiZW1haWwiOiJhYWEifX0=', '2014-12-05 00:57:07');
INSERT INTO `django_session` VALUES ('thyjqidzgkomq7lez2dxe01kd2f4xmjf', 'ODZmNDVkZDVlNjE0YzMyMjYwNWFiNWVkODJkMDA1OTA1Zjc3MDk2MDp7InVzZXIiOnsidXNlcm5hbWUiOiJhZG1pbiIsImd1aWQiOiJNMDExMDAwMDAwMDAxIiwibmFtZSI6ImFkbWluIiwicmVnaXN0ZXJfdGltZSI6IjIwMTQtMDYtMTYgMDQ6MjY6MzUiLCJhZ2UiOm51bGwsInNleCI6MSwiaWQiOjEsInBob25lIjoiMTExIiwiYXZhdGFyX3VybCI6bnVsbCwicm9sZSI6eyJpZCI6MSwibmFtZSI6ImFkbWluIn0sImFkZHJlc3MiOiIiLCJwYXNzd29yZCI6IjIxMjMyZjI5N2E1N2E1YTc0Mzg5NGEwZTRhODAxZmMzIiwiZW1haWwiOiJhYWEifX0=', '2014-07-08 03:01:15');
INSERT INTO `django_session` VALUES ('twicdy0z8z4haw2teadynwgj9cr6ia92', 'ODZmNDVkZDVlNjE0YzMyMjYwNWFiNWVkODJkMDA1OTA1Zjc3MDk2MDp7InVzZXIiOnsidXNlcm5hbWUiOiJhZG1pbiIsImd1aWQiOiJNMDExMDAwMDAwMDAxIiwibmFtZSI6ImFkbWluIiwicmVnaXN0ZXJfdGltZSI6IjIwMTQtMDYtMTYgMDQ6MjY6MzUiLCJhZ2UiOm51bGwsInNleCI6MSwiaWQiOjEsInBob25lIjoiMTExIiwiYXZhdGFyX3VybCI6bnVsbCwicm9sZSI6eyJpZCI6MSwibmFtZSI6ImFkbWluIn0sImFkZHJlc3MiOiIiLCJwYXNzd29yZCI6IjIxMjMyZjI5N2E1N2E1YTc0Mzg5NGEwZTRhODAxZmMzIiwiZW1haWwiOiJhYWEifX0=', '2014-09-24 03:03:05');
INSERT INTO `django_session` VALUES ('u1y4dea3foli20wlyzz3hroqw13x6x5n', 'ODZmNDVkZDVlNjE0YzMyMjYwNWFiNWVkODJkMDA1OTA1Zjc3MDk2MDp7InVzZXIiOnsidXNlcm5hbWUiOiJhZG1pbiIsImd1aWQiOiJNMDExMDAwMDAwMDAxIiwibmFtZSI6ImFkbWluIiwicmVnaXN0ZXJfdGltZSI6IjIwMTQtMDYtMTYgMDQ6MjY6MzUiLCJhZ2UiOm51bGwsInNleCI6MSwiaWQiOjEsInBob25lIjoiMTExIiwiYXZhdGFyX3VybCI6bnVsbCwicm9sZSI6eyJpZCI6MSwibmFtZSI6ImFkbWluIn0sImFkZHJlc3MiOiIiLCJwYXNzd29yZCI6IjIxMjMyZjI5N2E1N2E1YTc0Mzg5NGEwZTRhODAxZmMzIiwiZW1haWwiOiJhYWEifX0=', '2014-07-25 08:11:29');
INSERT INTO `django_session` VALUES ('uejjh24lgpaiqoa9nyqi1rcebwcth7fj', 'ZmZiOTVlZGExM2E1ODc3Y2RmMzNjZmFjMmZhN2EyMjk0YzEzNjk1NDp7InVzZXIiOnsidXNlcm5hbWUiOiJ0ZXN0NiIsImd1aWQiOiJNMDQxMDAwMDAwMDIzIiwibmFtZSI6Ilx1NmQ0Ylx1OGJkNVx1NTE2ZCIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA2LTE4IDA4OjIwOjE1IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyMywicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNGNmYWQ3MDc2MTI5OTYyZWU3MGMzNjgzOWExZTNlMTUiLCJlbWFpbCI6bnVsbH19', '2014-07-03 09:14:50');
INSERT INTO `django_session` VALUES ('uj0p6k1q3lpbspkvatza342ugs9fbbrs', 'YTUxMTdhMjQ4OGM5NjE3NDJlZjlmNjBlMDQ3NWI2MDE4NGIyZmRmMTp7InVzZXIiOnsidXNlcm5hbWUiOiJ3dXNoZW5nIiwiZ3VpZCI6Ik0wNDEwMDAwMDAwMjgiLCJuYW1lIjoiXHU1NDM0XHU4MGRjIiwicmVnaXN0ZXJfdGltZSI6IjIwMTQtMTEtMTkgMDI6NDc6NDMiLCJhZ2UiOm51bGwsInNleCI6bnVsbCwiaWQiOjI4LCJwaG9uZSI6bnVsbCwiYXZhdGFyX3VybCI6bnVsbCwicm9sZSI6eyJpZCI6NCwibmFtZSI6InBhdGllbnQifSwiYWRkcmVzcyI6bnVsbCwicGFzc3dvcmQiOiJmMGViNGI1MjA1ZWYyZTc5OWYyZWNkN2YzYzQzYjcwMSIsImVtYWlsIjpudWxsfX0=', '2014-12-03 03:00:47');
INSERT INTO `django_session` VALUES ('ulc0w5igk4r9cfexn2df4xwja79jaqu5', 'Y2MxYTM4MjBjMTIzNGI1NTc0ODc0ZjlmM2JiNGFiNThmMTZlNmVkNjp7fQ==', '2014-09-30 13:57:28');
INSERT INTO `django_session` VALUES ('umkhr15k3liy424c1dccbnxn8malbz72', 'ODZmNDVkZDVlNjE0YzMyMjYwNWFiNWVkODJkMDA1OTA1Zjc3MDk2MDp7InVzZXIiOnsidXNlcm5hbWUiOiJhZG1pbiIsImd1aWQiOiJNMDExMDAwMDAwMDAxIiwibmFtZSI6ImFkbWluIiwicmVnaXN0ZXJfdGltZSI6IjIwMTQtMDYtMTYgMDQ6MjY6MzUiLCJhZ2UiOm51bGwsInNleCI6MSwiaWQiOjEsInBob25lIjoiMTExIiwiYXZhdGFyX3VybCI6bnVsbCwicm9sZSI6eyJpZCI6MSwibmFtZSI6ImFkbWluIn0sImFkZHJlc3MiOiIiLCJwYXNzd29yZCI6IjIxMjMyZjI5N2E1N2E1YTc0Mzg5NGEwZTRhODAxZmMzIiwiZW1haWwiOiJhYWEifX0=', '2014-07-20 15:08:30');
INSERT INTO `django_session` VALUES ('uwadzc2vpdcziajxn5clq0wplm0e6jtv', 'ZTIzNTY0ZmY5Mjc5MjIxNDRiNGIyM2M3ZWU1ZWYzNjA5MTVjZDgzMzp7InVzZXIiOnsidXNlcm5hbWUiOiJhZG1pbiIsImd1aWQiOiJNMDExMDAwMDAwMDAxIiwibmFtZSI6ImFkbWluIiwicmVnaXN0ZXJfdGltZSI6IjIwMTQtMDYtMTYgMDQ6MjY6MzUiLCJhZ2UiOm51bGwsInNleCI6bnVsbCwiaWQiOjEsInBob25lIjpudWxsLCJhdmF0YXJfdXJsIjpudWxsLCJyb2xlIjp7ImlkIjoxLCJuYW1lIjoiYWRtaW4ifSwiYWRkcmVzcyI6bnVsbCwicGFzc3dvcmQiOiIyMTIzMmYyOTdhNTdhNWE3NDM4OTRhMGU0YTgwMWZjMyIsImVtYWlsIjpudWxsfX0=', '2014-07-01 04:57:40');
INSERT INTO `django_session` VALUES ('uyai4kobks2xn0nxb49r437llc9ghdni', 'OTBiYzBmMDEyMzIwM2M3NTdiZDcwYWY1MDhlY2UxNjBiODcxNTNjODp7InVzZXIiOnsidXNlcm5hbWUiOiJhYSIsImd1aWQiOiJNMDQxMDAwMDAwMDI5IiwibmFtZSI6Ilx1NjVlMFx1OTcwMFx1NTQyNyIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTExLTE5IDAzOjA2OjQyIiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyOSwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNDEyNGJjMGE5MzM1YzI3ZjA4NmYyNGJhMjA3YTQ5MTIiLCJlbWFpbCI6bnVsbH19', '2014-12-17 15:02:07');
INSERT INTO `django_session` VALUES ('v7fft7h57hlg2c9fsueol36mdo9afvlh', 'OTBiYzBmMDEyMzIwM2M3NTdiZDcwYWY1MDhlY2UxNjBiODcxNTNjODp7InVzZXIiOnsidXNlcm5hbWUiOiJhYSIsImd1aWQiOiJNMDQxMDAwMDAwMDI5IiwibmFtZSI6Ilx1NjVlMFx1OTcwMFx1NTQyNyIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTExLTE5IDAzOjA2OjQyIiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyOSwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNDEyNGJjMGE5MzM1YzI3ZjA4NmYyNGJhMjA3YTQ5MTIiLCJlbWFpbCI6bnVsbH19', '2014-12-17 13:47:44');
INSERT INTO `django_session` VALUES ('vlnlw5z7aa5it8s8vv82qbixai7d5zvu', 'ODZmNDVkZDVlNjE0YzMyMjYwNWFiNWVkODJkMDA1OTA1Zjc3MDk2MDp7InVzZXIiOnsidXNlcm5hbWUiOiJhZG1pbiIsImd1aWQiOiJNMDExMDAwMDAwMDAxIiwibmFtZSI6ImFkbWluIiwicmVnaXN0ZXJfdGltZSI6IjIwMTQtMDYtMTYgMDQ6MjY6MzUiLCJhZ2UiOm51bGwsInNleCI6MSwiaWQiOjEsInBob25lIjoiMTExIiwiYXZhdGFyX3VybCI6bnVsbCwicm9sZSI6eyJpZCI6MSwibmFtZSI6ImFkbWluIn0sImFkZHJlc3MiOiIiLCJwYXNzd29yZCI6IjIxMjMyZjI5N2E1N2E1YTc0Mzg5NGEwZTRhODAxZmMzIiwiZW1haWwiOiJhYWEifX0=', '2014-12-10 09:15:06');
INSERT INTO `django_session` VALUES ('w70t8g1q6h6p3oxy45fcks2lo7xqkirr', 'M2NhZDNhMTk5Yjc5ZDBjNTdhNjk5YjIwM2QxODg5ZGI3YTI3ZDY3Nzp7InVzZXIiOnsidXNlcm5hbWUiOiJ3dXdlaSIsImd1aWQiOiJNMDQxMDAwMDAwMDI2IiwibmFtZSI6Ilx1NTQzNFx1NWEwMSIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA3LTA5IDAzOjAzOjQyIiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyNiwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiZWU1MDJlNDBlNWFlYzg0ZDExMzIyMWUzNjFlNmQ1MDgiLCJlbWFpbCI6bnVsbH19', '2014-12-03 02:55:28');
INSERT INTO `django_session` VALUES ('w9g6fjyx6j05dat92hvu6rvtfbnqae9x', 'OTBiYzBmMDEyMzIwM2M3NTdiZDcwYWY1MDhlY2UxNjBiODcxNTNjODp7InVzZXIiOnsidXNlcm5hbWUiOiJhYSIsImd1aWQiOiJNMDQxMDAwMDAwMDI5IiwibmFtZSI6Ilx1NjVlMFx1OTcwMFx1NTQyNyIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTExLTE5IDAzOjA2OjQyIiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyOSwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNDEyNGJjMGE5MzM1YzI3ZjA4NmYyNGJhMjA3YTQ5MTIiLCJlbWFpbCI6bnVsbH19', '2014-12-11 03:54:28');
INSERT INTO `django_session` VALUES ('wama64we4en2qdi7bywi5gaanqknyeor', 'Y2MxYTM4MjBjMTIzNGI1NTc0ODc0ZjlmM2JiNGFiNThmMTZlNmVkNjp7fQ==', '2014-12-18 09:54:57');
INSERT INTO `django_session` VALUES ('wna6wo56cyzq2ist3rq1pquvsw9x00dy', 'OTBiYzBmMDEyMzIwM2M3NTdiZDcwYWY1MDhlY2UxNjBiODcxNTNjODp7InVzZXIiOnsidXNlcm5hbWUiOiJhYSIsImd1aWQiOiJNMDQxMDAwMDAwMDI5IiwibmFtZSI6Ilx1NjVlMFx1OTcwMFx1NTQyNyIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTExLTE5IDAzOjA2OjQyIiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyOSwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNDEyNGJjMGE5MzM1YzI3ZjA4NmYyNGJhMjA3YTQ5MTIiLCJlbWFpbCI6bnVsbH19', '2014-12-03 03:07:55');
INSERT INTO `django_session` VALUES ('wzldxaljoj6dh5z92srdrjrp0erzrh8j', 'YWIyYzI4Yzk2YjIyYzgxYmFkOWIxNGQ1OTJkYmE2YjBiNmFiYmE5ODp7InVzZXIiOnsidXNlcm5hbWUiOiJwYXRpZW50MCIsImd1aWQiOiJNMDQxMDAwMDAwMDEyIiwibmFtZSI6InBhdGllbnQwIiwicmVnaXN0ZXJfdGltZSI6IjIwMTQtMDYtMTYgMDQ6MjY6NDAiLCJhZ2UiOm51bGwsInNleCI6bnVsbCwiaWQiOjEyLCJwaG9uZSI6bnVsbCwiYXZhdGFyX3VybCI6bnVsbCwicm9sZSI6eyJpZCI6NCwibmFtZSI6InBhdGllbnQifSwiYWRkcmVzcyI6bnVsbCwicGFzc3dvcmQiOiIyMDJjYjk2MmFjNTkwNzViOTY0YjA3MTUyZDIzNGI3MCIsImVtYWlsIjpudWxsfX0=', '2014-11-16 07:12:03');
INSERT INTO `django_session` VALUES ('y0ss57qlwgqa47p7hx6l6isv5hkyqytr', 'MmYwMTAyNTgwNjNiMGNhNjliYzQzZGFiODAxMTllN2U2NjY4ZTRmZTp7InVzZXIiOnsidXNlcm5hbWUiOiJ3dSIsImd1aWQiOiJNMDQxMDAwMDAwMDI0IiwibmFtZSI6Ilx1NTQzNFx1NWEwMSIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA3LTA4IDEyOjMxOjQ5IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyNCwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiMWYzNmMxNWQ2YTNkMThkNTJlOGQ0OTNiYzgxODdjYjkiLCJlbWFpbCI6bnVsbH19', '2014-07-23 02:34:24');
INSERT INTO `django_session` VALUES ('z4o2a6yrn8zjk0a65qrrq29emvzfxs8o', 'MmYwMTAyNTgwNjNiMGNhNjliYzQzZGFiODAxMTllN2U2NjY4ZTRmZTp7InVzZXIiOnsidXNlcm5hbWUiOiJ3dSIsImd1aWQiOiJNMDQxMDAwMDAwMDI0IiwibmFtZSI6Ilx1NTQzNFx1NWEwMSIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA3LTA4IDEyOjMxOjQ5IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyNCwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiMWYzNmMxNWQ2YTNkMThkNTJlOGQ0OTNiYzgxODdjYjkiLCJlbWFpbCI6bnVsbH19', '2014-07-23 02:32:58');
INSERT INTO `django_session` VALUES ('zlheo1fdyf924t2balbt7agu0pcvankg', 'Y2MxYTM4MjBjMTIzNGI1NTc0ODc0ZjlmM2JiNGFiNThmMTZlNmVkNjp7fQ==', '2014-12-14 06:37:02');
INSERT INTO `django_session` VALUES ('znzl1axk11ededzhw087ebt3t2ueqmbt', 'MThmZTEzMmUxODFlMGZiNGY3OGI0ZDc4YTEwOGFlMTRlNjY4NGQwMzp7InVzZXIiOnsidXNlcm5hbWUiOiJ0ZXN0NCIsImd1aWQiOiJNMDQxMDAwMDAwMDIwIiwibmFtZSI6Ilx1NmQ0Ylx1OGJkNVx1NTZkYiIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTA2LTE1IDE1OjI5OjQ4IiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyMCwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiODY5ODVlMTA1Zjc5Yjk1ZDZiYzkxOGZiNDVlYzc3MjciLCJlbWFpbCI6bnVsbH19', '2014-06-29 15:36:20');
INSERT INTO `django_session` VALUES ('zwg7yvs5q4hvpdr6a4vgz8sbnzemscho', 'OTBiYzBmMDEyMzIwM2M3NTdiZDcwYWY1MDhlY2UxNjBiODcxNTNjODp7InVzZXIiOnsidXNlcm5hbWUiOiJhYSIsImd1aWQiOiJNMDQxMDAwMDAwMDI5IiwibmFtZSI6Ilx1NjVlMFx1OTcwMFx1NTQyNyIsInJlZ2lzdGVyX3RpbWUiOiIyMDE0LTExLTE5IDAzOjA2OjQyIiwiYWdlIjpudWxsLCJzZXgiOm51bGwsImlkIjoyOSwicGhvbmUiOm51bGwsImF2YXRhcl91cmwiOm51bGwsInJvbGUiOnsiaWQiOjQsIm5hbWUiOiJwYXRpZW50In0sImFkZHJlc3MiOm51bGwsInBhc3N3b3JkIjoiNDEyNGJjMGE5MzM1YzI3ZjA4NmYyNGJhMjA3YTQ5MTIiLCJlbWFpbCI6bnVsbH19', '2014-12-05 02:13:41');

-- ----------------------------
-- Table structure for `django_site`
-- ----------------------------
DROP TABLE IF EXISTS `django_site`;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_site
-- ----------------------------
INSERT INTO `django_site` VALUES ('1', 'example.com', 'example.com');
