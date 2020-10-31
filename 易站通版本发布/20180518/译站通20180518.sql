CREATE OR REPLACE VIEW V_AMZX_PROJECT AS
SELECT A."TB_ID",
       A."PROJECTID",
       A."REMARKS",
       A."TOTALUNIT",
       A."SRC_LAN_NAME",
       A."DEST_LAN_NAME",
       A."UNIT_PRICE",
       A."TOTALPRICE",
       A."STATE",
       A."PAYTIME",
       A."PREFINISHTIME",
       ROUND((CASE WHEN A.RECEIVER IS NULL THEN 0
                   WHEN A.STATE < 50 AND SYSDATE > A.PREFINISHTIME THEN 98
                   WHEN A.STATE >= 50 THEN 100
                   ELSE (SYSDATE-(SELECT R.RECEIVETIME FROM AMZX_PROJECT_RECEIVERS R WHERE R.PROJECTID=A.PROJECTID))
                        /(A.PREFINISHTIME-(SELECT R.RECEIVETIME FROM AMZX_PROJECT_RECEIVERS R WHERE R.PROJECTID=A.PROJECTID))
                        * 100 END), 0) FINISH_RATE,
       A."ACTFINISHTIME",
       A."TRANS_LEVEL",
       A."TRANS_LEVEL_NAME",
       A."ACTUAL_MONEY",
       A."FRONT_MONEY",
       A."REST_MONEY",
       A."FILE_TYPEID",
       A."FILE_TYPENAME",
       A."INDUSTRYID",
       A."INDUSTRYNAME",
       A."CREATOR",
       A."CREATETIME",
       A."UPDATETIME",
       A."RECEIVER",
       A."SRC_LAN_ID",
       A."DEST_LAN_ID",
       A."ANGECYSTATE",
       DECODE(A.WAITTIME,
              0,
              0,
              DECODE(SIGN(A.WAITTIME * 60 - (SYSDATE - A.CREATETIME) * 24 * 60 * 60),
                     -1,
                     0,
                     TRUNC(A.WAITTIME * 60 - (SYSDATE - A.CREATETIME) * 24 * 60 * 60))) WAITTIME,
       A."SYNC_FLAG",
       A."PROJECTSOURCE",
       A."UNPAY_NOTICED",
       A."PROJECT_TYPE",
       A."BOOKING_TYPE",
       A."TEST_TYPE",
       A."DOMAIN_STR",
       A."PAY_TYPE",
       A."UNITTYPE",
       A."BOSSID",
       A."BUSINESS_PLATFORM_ID",
       A."DEDUCT_MONEY",
       A."DEDUCT_TYPE",
       A."COMMISSION",
       A."BONUS",
       A."IS_TIMEOUT",
       A."COMMISSION_PRECENT",
       A."BOUNS_PRECENT",
       A."CREDIT_STATE",
       A."HAS_NOEDIT",
       A."COMPOSE_REMARK",
       A."TPAYPAYTYPE",
       A."ISYH",
       A."DEDUCT_RECEIVER_PRICE",
       A."BACK_CREATOR_PRICE",
       A."MID_REMARKS",
       A."RISK_LEVEL",
       A."IS_OPEN",
       A."ORDER_PURPOSES",
       A."ORDER_PURPOSES_REMARK",
       A."SUBSIDY_RECEIVER_PRICE",
       A."RES_PROJECTID",
       A."BZ",
       A."VALUEADDED_SERVICE",
       A."VS_PRICE",
       A."VIDEO_SERVICE_TYPE",
       A."VIDEO_DELIVERY_FILE",
       A."VIDEO_PARAMETERS",
       A."VIDEO_TERM",
       A."BUSINESS_TYPE",
       A."IS_NEED_VAT",
       A."LAYOUT_TOOLS",
       A."DOC_FORMAT",
       A."ISREVIEWQUALITY",
       A."VIDEO_THEME",
       A."VIDEO_CHANNEL",
       A."VIDEO_TYPE",
       A."BAOJIA_NUM",
       A."IS_CONSIGN",
       A."IS_NOTIFY_PLANPRICE",
       A.FILE_TYPE,
       A.LIAISON_IOLCODE,
       A.IS_PACT,
       A.IS_SIGN,
       A.PREPAID_PRECENT,
       A.PAY_REST_MONEY_TIME,
       (A.ACTFINISHTIME + A.PAY_REST_MONEY_TIME) PAY_REST_MONEY_DATE,
       (CASE WHEN A.ACTFINISHTIME + A.PAY_REST_MONEY_TIME > SYSDATE THEN 1 ELSE 0 END) PAY_REST_STATE,
       A.PAY_REST_MONEY,
       A.REST_MONEY_PAY_TYPE,
       A.REST_MONEY_TPAYPAYTYPE,
       A.TRANSN_CONFIRMTIME,
       A.TRANSN_AFTERPAY_STATE,
       A.NEGOEMAIL_FLAG,
       A.QUALITYTIME,
       NVL(A.QUALITYDATE, A.ACTFINISHTIME+A.QUALITYTIME) QUALITYDATE,
       NVL(ROUND((NVL(A.QUALITYDATE, A.ACTFINISHTIME+A.QUALITYTIME) - SYSDATE), 3), 0) QUALITY_RMTIME, --返稿之后剩余质保时间（天数）
       A.IS_ONLINETRAN,
       A.IS_INTERNATIONAL,
       I.REPEAT_DISCOUNT,
       I.REPEAT_DISCOUNT_TOOL,
       I.SERVIE_TYPE,
       I.PROJECT_NAME,
       I.TRANSLATION_FORMAT,
       I.IS_INCOMPANY,
       I.HOPE_FILE_CONTENT,
       I.DTP_TOOLS,
       I.WEBPAGE_TOOLS,
       I.EDITING_TOOLS,
       I.EXPERTISE,
       I.AREA_OF_EXPERTISE,
       I.CERTIFICATES,
       I.PROFESSIONAL_FIELD,
       I.NATIVE_LANGUAGE,
       I.TRANSLATION_NOTE,
       I.REPEAT_DISCOUNT_TYPE,
       I.OTHER_REMARK,
       B.UNIT_PRICE AS CUNIT_PRICE,
       B.TOTALUNIT AS CTOTALUNIT,
       B.PREFINISHTIME AS CPREFINISHTIME,
       B.TOTALPRICE CTOTALPRICE,
       NVL((SELECT NICKNAME FROM SHARK_EDIT_NICKNAME N WHERE N.IOLCODE = A.CREATOR AND N.MODIFIEDIOLCODE=A.RECEIVER),
           (SELECT UI.INTER_NAME FROM UTC_DEV.TR_USER_INFO UI WHERE UI.IOLCODE=A.RECEIVER)) AS RECEIVER_NICK_NAME,
       A.SVRMANAGERID,--服务经理ID
       (SELECT I.NIKENAME FROM UTC_DEV.TR_USER_INFO I WHERE I.IOLCODE=A.SVRMANAGERID) SVR_NICKNAME,--服务经理昵称
       (SELECT T.VALUE FROM T_SHARK_CONSTANT T WHERE T.KEY=A.SVRMANAGERID) DING_NO,--服务经理对应钉钉号
       (SELECT UPLOAD_NAME
          FROM FILE_INFO F
         WHERE F.OTHER_TB_ID = A.TB_ID
           AND F.FILE_TYPE = 2
           AND ROWNUM = 1) AS UPLOAD_NAME,
       U.NAME AS XDR,
       (SELECT COUNT(*)
          FROM FILE_INFO
         WHERE OTHER_TB_ID = A.TB_ID
           AND FILE_TYPE = 2) AS FILENUM,
       (SELECT COUNT(*)
          FROM AMZX_NODE
         WHERE PROJECTID = A.PROJECTID
           AND STATE = 60) AS DHCS,
       (SELECT COUNT(*) FROM T_SHARK_APPOINT WHERE PROJECTID = A.PROJECTID) AS SFZP,
       (SELECT COUNT(*)
          FROM T_SHARK_PRICE_PLAN
         WHERE PROJECTID = A.PROJECTID) AS BJFAZS,
       CASE
         WHEN (A.PROJECT_TYPE = '1' AND
              ((A.STATE >= 50 AND A.IS_TIMEOUT = '2') OR
              (A.STATE = 40 AND SYSDATE > A.PREFINISHTIME))) THEN 1
         ELSE 0 END CSFG,--超时返稿
       (SELECT SUM(OPERATE_PRICE)
          FROM AMZX_PROJECT_DEDUCT
         WHERE PROJECTID = A.PROJECTID
           AND OPERATE_TYPE = 2
           AND (STATE = 2 OR STATE = 3)) AS SUMBACK,
       (SELECT SUM(OPERATE_PRICE)
          FROM AMZX_PROJECT_DEDUCT
         WHERE PROJECTID = A.PROJECTID
           AND OPERATE_TYPE = 2
           AND STATE != -2
           AND STATE != 2) AS NOSUMBACK,
       (SELECT COUNT(*)
          FROM SHARK_CHAT_ROOM
         WHERE PROJECTID = A.PROJECTID) AS CHATROOMNUM,
       (SELECT COUNT(1) FROM t_shark_evaluation_add EA WHERE EA.PROJECTID = A.PROJECTID) RE_EVAL_COUNT
  FROM AMZX_PROJECT A, AMZX_PROJECT_HISTORY B, UTC_DEV.TR_USER_INFO U, AMZX_PROJECT_INTL I
 WHERE A.PROJECTID = B.PROJECTID(+)
   AND A.CREATOR = U.IOLCODE
   AND A.PROJECTID = I.PROJECTID(+)
   AND (A.PROJECT_TYPE <> 6 OR (A.PROJECT_TYPE = 6 AND (A.STATE >= 40 OR A.STATE=31)));

CREATE OR REPLACE VIEW V_ORDERING_DETAIL_NEW AS
SELECT SUBSTR(P.PROJECTID, 0, 10) PROJECTID_SUB, --显示订单ID
       PR.PROJECT_TYPE, /*--订单类型*/
       DECODE(P.Project_Type, 6, p.rece_tprice, P.ACTUAL_MONEY) ACTUAL_MONEY,  --下单原始金额
       P.ACTUAL_MONEY - P.TOTALPRICE YHJE, --优惠劵
       p.totalprice, --应付金额
       (P.BACK_CREATOR_PRICE + NVL(P.DEDUCT_MONEY, 0)) TKJE, /**退款金额*/
       NVL(P.SUBSIDY_RECEIVER_PRICE, 0) FILLPRICE,  ---补差价
       (NVL(DECODE(P.Project_Type, 6, p.rece_tprice, P.Totalprice), 0) - NVL(P.DEDUCT_MONEY, 0) -
       NVL(P.BACK_CREATOR_PRICE, 0) + NVL(P.SUBSIDY_RECEIVER_PRICE, 0)) SFJE, --下单方实得金额
       P.PROJECTID, --订单ID
       P.TOTALPRICE  PAY_MONEY,  --已支付金额
       NVL(PR.ACTUAL_MONEY, 0) REC_ORIGINALL_MONEY, --接单原始金额
       NVL(PR.COMMISSION, 0) COMMISSION, --平台服务费
       NVL(PR.BONUS, 0) BONUS, --奖金
       NVL(P.DEDUCT_RECEIVER_PRICE, 0) + NVL(P.DEDUCT_MONEY, 0) REC_DEDUCT_MONEY,--扣款金额
       NVL(PR.SUBSIDY_RECEIVER_PRICE, 0) REC_SYBSIDY_PRICE, --补差价
       NVL(PR.ACTUAL_MONEY, 0) - NVL(PR.COMMISSION, 0) + NVL(PR.BONUS, 0) -
       NVL(P.DEDUCT_RECEIVER_PRICE, 0) - NVL(P.DEDUCT_MONEY, 0) +
       NVL(PR.SUBSIDY_RECEIVER_PRICE, 0) REC_ACTUAL_MONEY, /*原始接单总额-抽佣金额+奖励金额-扣款金额+补贴金额*/
       P.PAY_TYPE,       --支付类型
       P.TPAYPAYTYPE,   --TPAY支付类型
       P.CREATETIME,   --创建时间
       P.PAYTIME,       --支付时间
       pr.firstsubmittime, --首次交稿时间
       pr.submittime,    --提交时间
       PR.CONFIRMTIME, --确认时间
       PR.FINANCE_ID,
       PR.CREATOR CREATOR,  --下单公司
       PR.COMP_BOSS_ID REC_BOSS_ID, --接单公司
       P.IS_NEED_VAT IS_INVOICE,  --是否开具发票,
        (case
            when
             p.PAY_TYPE  in (0,1,2,4,6,9)
             then 'yes'
     when
          p.PAY_TYPE in (3,5,7,8) and
          exists(select 1 from V_SHARK_CREDIT_MONTH vcm where
          vcm.IOLCODE=p.bossid and  vcm.FINAL_MONEY=0  and vcm.MONTH=to_char(p.paytime,'yyyy-mm') )
        then 'yes'
     when
          p.PAY_TYPE in (3,5,7,8) and
          not exists(select 1 from V_SHARK_CREDIT_MONTH vcm where
          vcm.IOLCODE=p.bossid and  vcm.FINAL_MONEY=0  and vcm.MONTH=to_char(p.paytime,'yyyy-mm') )
         then 'no'
     end) isPayback,  --是否已还款  yes:已还  no:末还
      (SELECT SUM(br.tran_money) FROM  SHARK_BALANCE_RECORDS br WHERE br.tran_type=2 AND br.tran_way=1 AND br.projectid=p.projectid) remain_money, --余额支付
      (SELECT ti.status FROM Utc_Dev.t_Invoice_Order ti WHERE ti.order_no=p.projectid AND ti.u_id=p.bossid AND ti.status<>-1)  Invoice_Order_status ---下单方开具发票状态
  FROM AMZX_PROJECT P, AMZX_PROJECT_RECEIVERS PR
 WHERE PR.PROJECTID = P.PROJECTID
   AND P.TEST_TYPE=0
 --  AND  P.CREATETIME>=TO_DATE('2016-08-01','YYYY-MM-DD')
   AND ((PR.PROJECT_TYPE in ( '1','6','7') AND PR.STATE >= 70)
    OR (PR.PROJECT_TYPE = '2' AND PR.STATE >= 50))
;

insert into t_shark_constant (TB_ID, KEY, VALUE, NOTE)
values (238, 'MARKET_PKG_CHECK', 'function MARKET_PKG_CHECK(nowTime,rys,zys,num){
        var startDate = new Date(("2018-5-11 00:00:00").replace(/-/g,"/")).getTime(); 
        var endDate = new Date(("2018-5-31 23:59:59").replace(/-/g,"/")).getTime(); 
        var nowDate = new Date(nowTime.replace(/-/g,"/")).getTime(); 
        var result=false;
        if(startDate <= nowDate && endDate >= nowDate){
          if(rys<=166 && zys<=2000 && num<=3){
            result = true;
          }
        }
        return result;
    }', '统一订单中心运营活动');

insert into t_shark_constant (TB_ID, KEY, VALUE, NOTE)
values (239, 'MARKET_PKG_IOLCODES', 'TR1100155967,TR1100155970,TR1100270647,TO1100020773,TR1100346220,TR1100346389,TR1100354006,TR1100354096,TR1100352777,TR1100345788,TR1100345827,TR1100351026,TR1100344145,TR1100344177,TR1100344297,TR1100346056,TR1100344395,TR1100391259,TR1100331743,TR1100359308,TR1100354251,TR1100056343', '统一订单中心运营活动指定公司ID');

insert into t_shark_constant (TB_ID, KEY, VALUE, NOTE)
values (240, 'MARKET_PKG_INTERVAL', '10', '统一订单中心时间间隔');

insert into t_shark_constant (TB_ID, KEY, VALUE, NOTE)
values (241, 'MARKET_PKG_MONEY_RANGE', '1-99', '统一订单中心运营奖金区间');
commit;
