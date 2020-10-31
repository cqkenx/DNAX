-- 零壹财经订单
DROP TABLE if EXISTS `developer_zero_order`;
CREATE TABLE `developer_zero_order` (
  `order_id` varchar(32) NOT NULL DEFAULT '' COMMENT '订单id',
  `order_type` varchar(10) DEFAULT 'text' COMMENT '业务类型 pic图片 text文本',
  `order_status` varchar(20) NOT NULL DEFAULT 'CREATE' COMMENT '订单状态(CREATE下单TRANSLATE翻译完成NOTICE通知成功)',
  `source_id` varchar(50) NOT NULL DEFAULT '' COMMENT '业务方订单id',
  `app_key` varchar(32) NOT NULL DEFAULT '' COMMENT '业务方appKey',
  `src_lang` varchar(10) NOT NULL DEFAULT '' COMMENT '源语种',
  `tar_lang` varchar(10) NOT NULL DEFAULT '' COMMENT '目标语种',
  `src_title` varchar(100) DEFAULT '' COMMENT '原标题',
  `src_file_url` varchar(300) NOT NULL DEFAULT '' COMMENT '原文件URL',
  `file_id` varchar(500) NOT NULL DEFAULT '' COMMENT '需要翻译的文件编号',
  `translate_title` varchar(100) DEFAULT '' COMMENT '翻译后标题',
  `translate_file_url` varchar(300) DEFAULT '' COMMENT '翻译后文件URL',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '总字数',
  `task_id` varchar(120) DEFAULT '' COMMENT '翻译文件任务编号',
  `remark` varchar(500) DEFAULT '' COMMENT '备注',
  `ref_params` varchar(500) DEFAULT '' COMMENT '回调参数',
  `callback` varchar(500) DEFAULT '' COMMENT '回调地址',
  `callback_times` int(10) unsigned DEFAULT '0' COMMENT '回调次数',
  `last_callback_time` datetime DEFAULT NULL COMMENT '最后回调时间',
  `translate_time` datetime DEFAULT NULL COMMENT '翻译时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '下单时间',
  `update_time` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='零壹财经订单';


-- 正式环境的零壹财经KEY
INSERT INTO developer_application VALUES ('0F8E45666DB80E7651C7CCA710EF82F2', '9cbae87fe0c41e56a77aa17e80b0f49e', 'TR1100389753', '零壹财经', '', 1, NULL, '', '', now());
-- 返稿通知零壹财经的时间
INSERT INTO `config` VALUES ('16', 'ZORDER', '零壹财经订单配置', 'SDKAPI', '1', '1', now(), now());

INSERT INTO `config_data` (config_id,name,data_type,value,description,is_enabled,create_time,update_time) VALUES 
    ('16', 'job_notice_time', 'String', '300', '定时通知零壹财经返稿时间（分钟）', '1', now(), now());

ALTER TABLE `iol_core_server`.`developer_micro_order` ADD COLUMN `is_refund` TINYINT DEFAULT 0 NOT NULL COMMENT '是否赔付' AFTER `remark`; 