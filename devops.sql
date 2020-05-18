/*
Navicat MySQL Data Transfer

Source Server         : 10.20.7.98_3306
Source Server Version : 50727
Source Host           : 10.20.7.98:3306
Source Database       : devops

Target Server Type    : MYSQL
Target Server Version : 50727
File Encoding         : 65001

Date: 2020-05-07 11:38:24
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for alarm_app
-- ----------------------------
DROP TABLE IF EXISTS `alarm_app`;
CREATE TABLE `alarm_app` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_code` varchar(128) DEFAULT NULL COMMENT '应用编号',
  `app_name` varchar(64) DEFAULT NULL COMMENT '应用名称',
  `app_version` varchar(255) DEFAULT NULL,
  `app_desc` varchar(255) DEFAULT NULL COMMENT '应用描述',
  `is_online` smallint(2) DEFAULT '1' COMMENT '应用是否在线：1在线，0下架',
  `create_time` datetime DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `is_del` varchar(255) DEFAULT '0' COMMENT '是否删除,1:是，0：否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for alarm_exception
-- ----------------------------
DROP TABLE IF EXISTS `alarm_exception`;
CREATE TABLE `alarm_exception` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` int(11) DEFAULT NULL COMMENT '应用id',
  `exce_name` varchar(255) DEFAULT NULL COMMENT '异常名称',
  `exce_content` longtext COMMENT '异常内容',
  `exce_status` tinyint(2) DEFAULT '0' COMMENT '0: 未处理，1：处理人接收，2：处理完成',
  `exce_num` int(11) DEFAULT '1' COMMENT '异常次数',
  `exce_keys` varchar(255) DEFAULT NULL COMMENT '关键字',
  `bussiness_id` varchar(256) DEFAULT NULL COMMENT '业务标识',
  `service_ip` varchar(255) DEFAULT NULL COMMENT '服务器ip，多个以逗号隔开',
  `trace_id` varchar(256) DEFAULT NULL COMMENT '链路id',
  `span` varchar(255) DEFAULT NULL COMMENT '链路span',
  `action` varchar(255) DEFAULT NULL COMMENT '父action',
  `sub_action` varchar(255) DEFAULT NULL COMMENT '子action',
  `service_cd` varchar(255) DEFAULT NULL COMMENT '服务代码',
  `front_cd` varchar(255) DEFAULT NULL COMMENT '前端代码',
  `channel_cd` varchar(255) DEFAULT NULL COMMENT '渠道代码',
  `log_time` varchar(64) DEFAULT NULL COMMENT ' 日志产生时间',
  `create_time` datetime DEFAULT NULL,
  `service_id` bigint(20) DEFAULT NULL COMMENT '服务id',
  `service_instance_id` bigint(20) DEFAULT NULL COMMENT '服务实例id',
  `is_error` tinyint(1) DEFAULT NULL COMMENT '是否是error日志',
  `is_time_out` tinyint(1) DEFAULT NULL COMMENT '是否是超时日志',
  `segment_id` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for alarm_group
-- ----------------------------
DROP TABLE IF EXISTS `alarm_group`;
CREATE TABLE `alarm_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(32) DEFAULT NULL COMMENT '组名',
  `group_desc` varchar(255) DEFAULT NULL COMMENT '组描述',
  `group_seq` int(2) DEFAULT '1' COMMENT '排序',
  `create_time` datetime DEFAULT NULL,
  `status` smallint(2) DEFAULT '1' COMMENT '1:可用，0：禁用',
  `is_del` smallint(2) DEFAULT '0' COMMENT '是否删除：1：删除，0:未删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for alarm_group_user
-- ----------------------------
DROP TABLE IF EXISTS `alarm_group_user`;
CREATE TABLE `alarm_group_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `group_id` int(11) NOT NULL COMMENT '分组id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for alarm_job_info
-- ----------------------------
DROP TABLE IF EXISTS `alarm_job_info`;
CREATE TABLE `alarm_job_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` int(11) DEFAULT NULL COMMENT '应用id',
  `exce_id` int(11) DEFAULT NULL COMMENT '异常id',
  `trigger_status` tinyint(4) DEFAULT '1' COMMENT '调度状态：0-停止，1-运行',
  `trigger_last_time` bigint(13) DEFAULT '0' COMMENT '上次调度时间',
  `trigger_next_time` bigint(13) DEFAULT '0' COMMENT '下次调度时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `last_num` int(2) DEFAULT '1' COMMENT '调度次数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for alarm_process_relation
-- ----------------------------
DROP TABLE IF EXISTS `alarm_process_relation`;
CREATE TABLE `alarm_process_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` int(11) DEFAULT NULL COMMENT '应用id',
  `relation_id` int(11) DEFAULT NULL COMMENT '处理id:userId or  groupId',
  `relation_type` smallint(2) DEFAULT NULL COMMENT '处理类型：1：处理人，关联就是userId；2接受组，关联的说就是groupId',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for alarm_send_record
-- ----------------------------
DROP TABLE IF EXISTS `alarm_send_record`;
CREATE TABLE `alarm_send_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) DEFAULT NULL COMMENT '告警标题',
  `content` longtext COMMENT '告警内容',
  `app_id` int(11) DEFAULT NULL COMMENT '应用id',
  `exce_id` int(11) DEFAULT NULL COMMENT '异常id',
  `app_code` varchar(255) DEFAULT NULL COMMENT '应用编号',
  `app_name` varchar(255) DEFAULT NULL COMMENT '应用名称',
  `process_user_name` varchar(255) DEFAULT NULL COMMENT '告警处理人,多个人以逗号隔开',
  `group_name` varchar(255) DEFAULT NULL COMMENT '告警信息接收组，多个以逗号隔开',
  `alarm_send_type` varchar(255) DEFAULT NULL COMMENT '告警信息发送类型, 例如：短信+邮件，短信+邮件+钉钉',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for alarm_statistics_config
-- ----------------------------
DROP TABLE IF EXISTS `alarm_statistics_config`;
CREATE TABLE `alarm_statistics_config` (
  `config_id` varchar(64) NOT NULL,
  `sys_allow_max_delay_time` int(11) DEFAULT NULL COMMENT '系统允许的最大延迟时间,单位：毫秒',
  `window_time_size` int(11) DEFAULT NULL COMMENT '时间窗口大小：单位 秒',
  `window_time_slide` int(11) DEFAULT NULL COMMENT '时间窗口滑动时长：单位秒',
  `max_count` int(11) DEFAULT NULL COMMENT '时间窗口内异常阀值，超过了就被记录',
  `max_time_out` int(11) DEFAULT NULL COMMENT '接口最大超时时间：单位秒',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '菜单表主键',
  `name` varchar(50) NOT NULL COMMENT '名称',
  `parent_id` int(11) NOT NULL COMMENT '上级菜单主键',
  `level` tinyint(4) NOT NULL COMMENT '菜单类型：1目录；2菜单；3按钮',
  `request_mode` tinyint(4) DEFAULT NULL COMMENT '跳转方式：1请求转发；2请求重定向',
  `icon` varchar(50) DEFAULT NULL COMMENT '图标',
  `url` varchar(100) DEFAULT NULL COMMENT '请求地址',
  `path` varchar(100) DEFAULT NULL COMMENT '路由地址',
  `open_mode` tinyint(4) DEFAULT NULL COMMENT '打开方式：1当前窗口；2新窗口',
  `permission` varchar(50) DEFAULT NULL COMMENT '权限标识：如 user:add，@RequiresPermissions("")',
  `sort` int(11) unsigned NOT NULL COMMENT '排序',
  `status` tinyint(4) NOT NULL COMMENT '状态：1生效；0无效',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_organization
-- ----------------------------
DROP TABLE IF EXISTS `sys_organization`;
CREATE TABLE `sys_organization` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '组织表主键',
  `name` varchar(50) NOT NULL COMMENT '名称',
  `parent_id` int(11) NOT NULL COMMENT '上级组织主键',
  `sort` int(11) NOT NULL COMMENT '排序',
  `status` tinyint(4) NOT NULL COMMENT '状态：1生效；0无效',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_position
-- ----------------------------
DROP TABLE IF EXISTS `sys_position`;
CREATE TABLE `sys_position` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '岗位表主键',
  `name` varchar(50) NOT NULL COMMENT '名称',
  `data_scope` tinyint(4) NOT NULL COMMENT '数据权限级别：1：所有数据权限；2：自定义数据权限；3：本部门数据权限；4：本部门及以下数据权限',
  `sort` int(11) NOT NULL COMMENT '排序',
  `status` tinyint(4) NOT NULL COMMENT '状态：1生效；0无效',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_position_org
-- ----------------------------
DROP TABLE IF EXISTS `sys_position_org`;
CREATE TABLE `sys_position_org` (
  `position_id` int(11) unsigned NOT NULL COMMENT '岗位主键',
  `org_id` int(11) unsigned NOT NULL COMMENT '组织主键',
  PRIMARY KEY (`position_id`,`org_id`),
  KEY `po_position_id` (`position_id`) USING BTREE,
  KEY `po_org_id` (`org_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '角色表主键',
  `role_key` varchar(50) NOT NULL COMMENT '角色标识',
  `name` varchar(50) NOT NULL COMMENT '名称',
  `is_admin` tinyint(4) NOT NULL COMMENT '是否为管理员：1是；0否',
  `status` tinyint(4) NOT NULL COMMENT '状态：1生效；0无效',
  `sort` int(11) unsigned NOT NULL COMMENT '排序',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` int(11) unsigned NOT NULL COMMENT '角色主键',
  `menu_id` int(11) unsigned NOT NULL COMMENT '菜单主键',
  PRIMARY KEY (`role_id`,`menu_id`),
  KEY `rm_role_id` (`role_id`) USING BTREE,
  KEY `rm_menu_id` (`menu_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户表主键',
  `name` varchar(50) NOT NULL COMMENT '用户姓名',
  `code` varchar(30) NOT NULL COMMENT '登录账号',
  `password` varchar(30) NOT NULL COMMENT '登录密码',
  `org_id` int(11) NOT NULL COMMENT '所属组织主键',
  `phone` char(11) NOT NULL COMMENT '手机号码',
  `email` varchar(30) NOT NULL COMMENT '邮箱地址',
  `sex` tinyint(4) NOT NULL COMMENT '性别：1男；0女；-1未知',
  `status` tinyint(4) NOT NULL COMMENT '状态：1生效；0无效',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_user_position
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_position`;
CREATE TABLE `sys_user_position` (
  `user_id` int(11) unsigned NOT NULL COMMENT '用户主键',
  `position_id` int(11) unsigned NOT NULL COMMENT '岗位主键',
  PRIMARY KEY (`user_id`,`position_id`),
  KEY `up_user_id_i` (`user_id`) USING BTREE,
  KEY `up_position_id_i` (`position_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` int(11) unsigned NOT NULL COMMENT '用户主键',
  `role_id` int(11) unsigned NOT NULL COMMENT '角色主键',
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `ur_user_id` (`user_id`) USING BTREE,
  KEY `ur_role_id` (`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
