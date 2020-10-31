-- 系统配置参数
INSERT INTO `config` VALUES ('15', 'coreServer', 'coreServer配置', 'CORE_SERVER', '1', '1', now(), now());
INSERT INTO `config_data` (config_id,name,data_type,value,description,is_enabled,create_time,update_time) VALUES ('15', 'commit_scheduled_time', 'String', '100', '微订单返稿后完成订单倒计时时间，单位分钟', '1', now(), now());
INSERT INTO `config_data` (config_id,name,data_type,value,description,is_enabled,create_time,update_time) VALUES ('15', 'translator_estimate_time', 'String', '8', '订单译员预估时间每超过该时间，则加对应24-8的时间', '1', now(), now());
INSERT INTO `config_data` (config_id,name,data_type,value,description,is_enabled,create_time,update_time) VALUES ('15', 'specifies_unclaimed90_timeout', 'String', '您有一个直连订单超过90秒未领取，请尽快领取，否则可能派单给其他译员。', '直连译员在线，90s没领', '1', now(), now());
INSERT INTO `config_data` (config_id,name,data_type,value,description,is_enabled,create_time,update_time) VALUES ('15', 'specifies_no_one_answered', 'String', '您有一个直连订单待领取，快上线接单吧！', '直连译员不在线', '1', now(), now());
INSERT INTO `config_data` (config_id,name,data_type,value,description,is_enabled,create_time,update_time) VALUES ('15', 'random_no_one_answered', 'String', '有用户正在呼叫A—B语翻译，快上线接单吧！', '随机有在线译员，90s没人领或者匹配译员不在线', '1', now(), now());
INSERT INTO `config_data` (config_id,name,data_type,value,description,is_enabled,create_time,update_time) VALUES ('15', 'system_translator_commit_timeout', 'String', '【预警】有订单超出截稿时间，请立刻处理。', '微订单译员超出截稿时间未返稿，运营预警', '1', now(), now());
INSERT INTO `config_data` (config_id,name,data_type,value,description,is_enabled,create_time,update_time) VALUES ('15', 'system_warning_phone', 'String', '13667265127#15629158255#15927368654', '运营预警通知运营手机号', '1', now(), now());
INSERT INTO `config_data` (config_id,name,data_type,value,description,is_enabled,create_time,update_time) VALUES ('15', 'system_warning_two_msg', 'String', '【预警】有订单超过预估时间1倍未返稿，请立刻处理。', '超过预估时间1倍预警短信内容', '1', now(), now());
INSERT INTO `config_data` (config_id,name,data_type,value,description,is_enabled,create_time,update_time) VALUES ('15', 'system_warning_feedback', 'String', '【预警】有译员反馈订单，请立刻处理。', '译员反馈预警预警短信内容', '1', now(), now());
INSERT INTO `config_data` (config_id,name,data_type,value,description,is_enabled,create_time,update_time) VALUES ('15', 'system_warning_5min_msg', 'String', '【预警】派单5分钟无人领取订单进入异常。', '派单5分钟无人领取订单进入异常。', '1', now(), now());

drop table if EXISTS `micro_order`;
CREATE TABLE `micro_order` (
  `flow_id` varchar(64) NOT NULL COMMENT '订单ID',
  `source_id` varchar(100) NOT NULL COMMENT '业务方订单id',
  `service_type` varchar(45) DEFAULT NULL COMMENT 'Specifies-直连  Random-随机',
  `order_type` varchar(45) NOT NULL COMMENT 'pic,text,voice',
  `content` text NOT NULL COMMENT '文本内容（或者资源地址）',
  `source_language_id` int(11) DEFAULT NULL COMMENT '源语种ID',
  `target_language_id` int(11) DEFAULT NULL COMMENT '目标语种ID',
  `remark` varchar(500) DEFAULT NULL COMMENT '用户下单时的留言备注',
  `extra_params` varchar(100) DEFAULT NULL COMMENT '客户自定义参数，Json格式（在回调中原样返回）',
  `word_number` int(11) DEFAULT NULL COMMENT '稿件字数',
  `call_back` varchar(200) DEFAULT NULL COMMENT '返稿回调地址',
  `trans_estimate` int(11) DEFAULT NULL COMMENT '预估完成时间(针对译员的要求完成时间)  分钟',
  `user_estimate` int(11) DEFAULT NULL COMMENT '预估完成时间(报给用户看的)  分钟',
  `quoted_price` varchar(50) DEFAULT NULL COMMENT '给用户的报价',
  `app_key` varchar(100) NOT NULL COMMENT '下单方APPKey',
  `caller_id` varchar(100) NOT NULL COMMENT '下单用户ID',
  `client_caller_id` varchar(100) DEFAULT NULL COMMENT '接入方下单用户ID',
  `translator_id` varchar(100) DEFAULT NULL COMMENT '接单或者直连用户ID',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `received_time` datetime DEFAULT NULL COMMENT '译员领取时间',
  `end_time` datetime DEFAULT NULL COMMENT '订单完结时间',
  `last_status` varchar(100) NOT NULL COMMENT '订单状态',
  `syn_status` int(11) DEFAULT '0' COMMENT '0-未同步到订单中心  1-已同步到订单中心',
  `email` varchar(100) DEFAULT NULL COMMENT '下单用户邮箱',
  `phone` varchar(45) DEFAULT NULL COMMENT '下单用户手机',
  `exchange` int(11) DEFAULT '0' COMMENT '是否转随机0否1是',
  `commit_time` datetime DEFAULT NULL COMMENT '返稿时间',
  `system_commit_time` datetime DEFAULT NULL COMMENT '运营贴答案时间',
  `system_remark` varchar(200) DEFAULT NULL COMMENT '运营备注信息',
  `system_ratio_price` varchar(4) DEFAULT NULL COMMENT '给译员支付金额比例（运营设定）',
  PRIMARY KEY (`flow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='微订单记录表';



drop table if EXISTS `micro_order_commit`;
CREATE TABLE `micro_order_commit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `flow_id` varchar(64) DEFAULT NULL COMMENT '订单ID',
  `commit_content` text NOT NULL COMMENT '返稿内容',
  `type` int(11) DEFAULT '1' COMMENT '1-译员返稿2-运营返稿',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `yn` int(11) DEFAULT '1' COMMENT '是否有效0否1有',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1446 DEFAULT CHARSET=utf8mb4 COMMENT='微订单返稿记录';


drop table if EXISTS `micro_order_estimate`;
CREATE TABLE `micro_order_estimate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `src_lang` int(11) NOT NULL COMMENT '源语种ID',
  `tar_lang` int(11) DEFAULT NULL COMMENT '目标语种ID',
  `remark` varchar(45) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL COMMENT '订单类型   pic,text',
  `word_100` varchar(10) DEFAULT NULL COMMENT '100字以内 时间上浮比例',
  `word_500` varchar(10) DEFAULT NULL COMMENT '100~500字以内 时间上浮比例',
  `word_max` varchar(10) DEFAULT NULL COMMENT '500字以上 时间上浮比例',
  `standard` varchar(10) DEFAULT NULL COMMENT '基础时间（小时）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COMMENT='微订单预估完成时间配置';

drop table if EXISTS `micro_order_feedback`;
CREATE TABLE `micro_order_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `flow_id` varchar(64) NOT NULL COMMENT '订单ID',
  `feedback` varchar(200) NOT NULL COMMENT '反馈内容',
  `remark` varchar(1000) DEFAULT NULL COMMENT '反馈备注',
  `translator_id` varchar(100) DEFAULT NULL COMMENT '译员ID',
  `type` int(11) DEFAULT '1' COMMENT '1-译员未领取前反馈2-译员领取后反馈3-用户售后',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `yn` int(11) DEFAULT '1' COMMENT '是否有效0否1有',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1154 DEFAULT CHARSET=utf8mb4 COMMENT='微订单反馈售后记录';

drop table if EXISTS `micro_order_leavemsg`;
CREATE TABLE `micro_order_leavemsg` (
  `msg_id` varchar(64) NOT NULL COMMENT '消息ID  主键',
  `flow_id` varchar(45) NOT NULL COMMENT '订单ID',
  `direction` varchar(10) DEFAULT NULL COMMENT '发送方向(toTrans-用户发给译员 toCaller-译员发给用户)',
  `type` varchar(10) DEFAULT NULL COMMENT 'pic,text,voice',
  `content` varchar(1000) DEFAULT NULL COMMENT '消息内容（文本 或 图片url）',
  `create_time` bigint(20) DEFAULT NULL COMMENT '创建时间（存储毫秒数）',
  PRIMARY KEY (`msg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='微订单留言';


drop table if EXISTS `micro_order_node`;
CREATE TABLE `micro_order_node` (
  `node_id` varchar(64) NOT NULL,
  `flow_id` varchar(64) DEFAULT NULL,
  `service_status` varchar(45) DEFAULT NULL,
  `status_time` bigint(20) DEFAULT NULL,
  `operator` varchar(45) DEFAULT NULL,
  `msg` varchar(1000) DEFAULT NULL,
  `allocate_translators` text,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='微订单流转节点';



-- 以下微订单预估完成时间配置

INSERT INTO `micro_order_estimate` VALUES ('1', '1', '2', '中文-英语', 'text', '0', '0.15', '0.3', '0.2');
INSERT INTO `micro_order_estimate` VALUES ('2', '1', '3', '中文-日语', 'text', '0', '0.15', '0.3', '0.4');
INSERT INTO `micro_order_estimate` VALUES ('3', '1', '7', '中文-韩语', 'text', '0', '0.15', '0.3', '0.26');
INSERT INTO `micro_order_estimate` VALUES ('4', '1', '20', '中文-泰语', 'text', '0', '0.15', '0.3', '0.3');
INSERT INTO `micro_order_estimate` VALUES ('5', '1', '6', '中文-俄语', 'text', '0', '0.15', '0.3', '0.54');
INSERT INTO `micro_order_estimate` VALUES ('6', '1', '5', '中文-德语', 'text', '0', '0.15', '0.3', '0.54');
INSERT INTO `micro_order_estimate` VALUES ('7', '1', '4', '中文-法语', 'text', '0', '0.15', '0.3', '0.44');
INSERT INTO `micro_order_estimate` VALUES ('8', '1', '10', '中文-意大利语', 'text', '0', '0.15', '0.3', '0.4');
INSERT INTO `micro_order_estimate` VALUES ('9', '1', '11', '中文-西班牙语', 'text', '0', '0.15', '0.3', '0.5');
INSERT INTO `micro_order_estimate` VALUES ('10', '1', '12', '中文-葡萄牙语', 'text', '0', '0.15', '0.3', '0.6');
INSERT INTO `micro_order_estimate` VALUES ('11', '1', '13', '中文-阿拉伯语', 'text', '0', '0.15', '0.3', '0.5');
INSERT INTO `micro_order_estimate` VALUES ('12', '2', '1', '英语-中文', 'text', '0', '0.15', '0.3', '0.2');
INSERT INTO `micro_order_estimate` VALUES ('13', '3', '1', '日语-中文', 'text', '0', '0.15', '0.3', '0.4');
INSERT INTO `micro_order_estimate` VALUES ('14', '7', '1', '韩语-中文', 'text', '0', '0.15', '0.3', '0.26');
INSERT INTO `micro_order_estimate` VALUES ('15', '20', '1', '泰语-中文', 'text', '0', '0.15', '0.3', '0.3');
INSERT INTO `micro_order_estimate` VALUES ('16', '6', '1', '俄语-中文', 'text', '0', '0.15', '0.3', '0.54');
INSERT INTO `micro_order_estimate` VALUES ('17', '5', '1', '德语-中文', 'text', '0', '0.15', '0.3', '0.54');
INSERT INTO `micro_order_estimate` VALUES ('18', '4', '1', '法语-中文', 'text', '0', '0.15', '0.3', '0.44');
INSERT INTO `micro_order_estimate` VALUES ('19', '10', '1', '意大利语-中文', 'text', '0', '0.15', '0.3', '0.44');
INSERT INTO `micro_order_estimate` VALUES ('20', '11', '1', '西班牙语-中文', 'text', '0', '0.15', '0.3', '0.46');
INSERT INTO `micro_order_estimate` VALUES ('21', '12', '1', '葡萄牙语-中文', 'text', '0', '0.15', '0.3', '0.6');
INSERT INTO `micro_order_estimate` VALUES ('22', '13', '1', '阿拉伯语-中文', 'text', '0', '0.15', '0.3', '0.8');
INSERT INTO `micro_order_estimate` VALUES ('23', '1', '2', '中文-英语', 'pic', '0', '0.15', '0.3', '0.24');
INSERT INTO `micro_order_estimate` VALUES ('24', '1', '3', '中文-日语', 'pic', '0', '0.15', '0.3', '0.48');
INSERT INTO `micro_order_estimate` VALUES ('25', '1', '7', '中文-韩语', 'pic', '0', '0.15', '0.3', '0.32');
INSERT INTO `micro_order_estimate` VALUES ('26', '1', '20', '中文-泰语', 'pic', '0', '0.15', '0.3', '0.36');
INSERT INTO `micro_order_estimate` VALUES ('27', '1', '6', '中文-俄语', 'pic', '0', '0.15', '0.3', '0.62');
INSERT INTO `micro_order_estimate` VALUES ('28', '1', '5', '中文-德语', 'pic', '0', '0.15', '0.3', '0.62');
INSERT INTO `micro_order_estimate` VALUES ('29', '1', '4', '中文-法语', 'pic', '0', '0.15', '0.3', '0.62');
INSERT INTO `micro_order_estimate` VALUES ('30', '1', '10', '中文-意大利语', 'pic', '0', '0.15', '0.3', '0.48');
INSERT INTO `micro_order_estimate` VALUES ('31', '1', '11', '中文-西班牙语', 'pic', '0', '0.15', '0.3', '0.6');
INSERT INTO `micro_order_estimate` VALUES ('32', '1', '12', '中文-葡萄牙语', 'pic', '0', '0.15', '0.3', '0.72');
INSERT INTO `micro_order_estimate` VALUES ('33', '1', '13', '中文-阿拉伯语', 'pic', '0', '0.15', '0.3', '0.6');
INSERT INTO `micro_order_estimate` VALUES ('34', '2', '1', '英语-中文', 'pic', '0', '0.15', '0.3', '0.24');
INSERT INTO `micro_order_estimate` VALUES ('35', '3', '1', '日语-中文', 'pic', '0', '0.15', '0.3', '0.48');
INSERT INTO `micro_order_estimate` VALUES ('36', '7', '1', '韩语-中文', 'pic', '0', '0.15', '0.3', '0.32');
INSERT INTO `micro_order_estimate` VALUES ('37', '20', '1', '泰语-中文', 'pic', '0', '0.15', '0.3', '0.36');
INSERT INTO `micro_order_estimate` VALUES ('38', '6', '1', '俄语-中文', 'pic', '0', '0.15', '0.3', '0.62');
INSERT INTO `micro_order_estimate` VALUES ('39', '5', '1', '德语-中文', 'pic', '0', '0.15', '0.3', '0.62');
INSERT INTO `micro_order_estimate` VALUES ('40', '4', '1', '法语-中文', 'pic', '0', '0.15', '0.3', '0.62');
INSERT INTO `micro_order_estimate` VALUES ('41', '10', '1', '意大利语-中文', 'pic', '0', '0.15', '0.3', '0.62');
INSERT INTO `micro_order_estimate` VALUES ('42', '11', '1', '西班牙语-中文', 'pic', '0', '0.15', '0.3', '0.6');
INSERT INTO `micro_order_estimate` VALUES ('43', '12', '1', '葡萄牙语-中文', 'pic', '0', '0.15', '0.3', '0.72');
INSERT INTO `micro_order_estimate` VALUES ('44', '13', '1', '阿拉伯语-中文', 'pic', '0', '0.15', '0.3', '0.8');
