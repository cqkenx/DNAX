use iol_core_server;

CREATE TABLE `developer_micro_order` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '订单id',
  `source_id` VARCHAR(50) NOT NULL DEFAULT '' COMMENT '业务方订单id',
  `app_key` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '业务方appKey',
  `user_id` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '业务方用户id',
  `translator_id` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '接单译员id',
  `src_lang` VARCHAR(10) NOT NULL DEFAULT '' COMMENT '源语种',
  `tar_lang` VARCHAR(10) NOT NULL DEFAULT '' COMMENT '目标语种',
  `files` VARCHAR(500) NOT NULL DEFAULT '' COMMENT '需要翻译的文件',
  `translate_files` TEXT COMMENT '译稿，Json',
  `count` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '总字数',
  `minutes` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '预估时长',
  `remark` VARCHAR(500) NOT NULL DEFAULT '' COMMENT '备注',
  `biz_result` VARCHAR(500) NOT NULL DEFAULT '' COMMENT '回调参数',
  `callback` VARCHAR(500) NOT NULL DEFAULT '' COMMENT '回调地址',
  `callback_type` TINYINT(4) NOT NULL DEFAULT '0' COMMENT '回调方式',
  `callback_times` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '回调次数',
  `last_callback_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后回调时间',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '下单时间',
  `receive_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '接单时间',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '返稿时间',
  `order_status` VARCHAR(20) NOT NULL DEFAULT 'normal' COMMENT '订单状态',
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=191 DEFAULT CHARSET=utf8mb4;
CREATE TABLE `developer_micro_message` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '内部订单id',
  `msg_id` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '留言id',
  `role` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '角色',
  `content_type` VARCHAR(10) NOT NULL DEFAULT '' COMMENT '类型 pic图片 text文本',
  `content` VARCHAR(500) NOT NULL DEFAULT '' COMMENT '内容',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '留言时间',
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=193 DEFAULT CHARSET=utf8mb4;
CREATE TABLE `developer_micro_feedback` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '订单记录id',
  `reason` VARCHAR(200) NOT NULL DEFAULT '' COMMENT '原因',
  `content` TEXT COMMENT '描述',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '反馈时间',
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `developer_micro_appeal` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '订单id',
  `content` VARCHAR(500) NOT NULL DEFAULT '' COMMENT '描述',
  `contact` VARCHAR(50) NOT NULL DEFAULT '' COMMENT '联系人',
  `phone` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '联系电话',
  `result` TEXT COMMENT '处理结果',
  `score` DECIMAL(5,2) UNSIGNED NOT NULL DEFAULT '0.00' COMMENT '译员成绩',
  `deal` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '处理 refuse售后不接受  translate售后返稿  cancelOrder取消订单',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '提交时间',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '处理时间',
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;

INSERT INTO `developer_application` (`app_key`,`app_secret`,`app_name`,`create_time`) VALUES ("7D1060188E4F8DEA1841CCEB50401A83", "fa5c5c59ab531efe7f1fb1e9eef67da6","百度",NOW());