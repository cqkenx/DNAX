SET ECHO ON
SET VERIFY ON
SET FEEDBACK OFF
SET DEFINE ON
CLEAR SCREEN
set serveroutput on

COLUMN date_time NEW_VAL filename noprint;
SELECT to_char(systimestamp,'yyyy-mm-dd_hh24-mi-ssxff') date_time FROM DUAL;
spool "208MySQL迁移Oracle_&filename..log"

-- Password file execution
@passworddefinition.sql

PROMPT Dropping Role ROLE_208MySQL迁移Oracle ...
DROP ROLE ROLE_208MySQL迁移Oracle ;
PROMPT Creating Role ROLE_208MySQL迁移Oracle ...
CREATE ROLE ROLE_208MySQL迁移Oracle ;

set define on
prompt connecting to Emulation
connect Emulation/&&Emulation_password;
set define off

set define on
prompt connecting to term_cloud_208
connect term_cloud_208/&&term_cloud_208_password;
set define off

-- DROP SEQUENCE label_id_id_SEQ;


PROMPT Creating Sequence label_id_id_SEQ ...
CREATE SEQUENCE  label_id_id_SEQ  
  MINVALUE 1 MAXVALUE 999999999999999999999999 INCREMENT BY 1  NOCYCLE ;

-- DROP SEQUENCE library_join_category_id_SEQ;


PROMPT Creating Sequence library_join_category_id_SEQ ...
CREATE SEQUENCE  library_join_category_id_SEQ  
  MINVALUE 1 MAXVALUE 999999999999999999999999 INCREMENT BY 1  NOCYCLE ;

-- DROP SEQUENCE library_id_id_SEQ;


PROMPT Creating Sequence library_id_id_SEQ ...
CREATE SEQUENCE  library_id_id_SEQ  
  MINVALUE 1 MAXVALUE 999999999999999999999999 INCREMENT BY 1  NOCYCLE ;

-- DROP TABLE label CASCADE CONSTRAINTS;


PROMPT Creating Table label ...
CREATE TABLE label (
  label_id NUMBER(10,0) NOT NULL,
  label_pid NUMBER(10,0),
  label_name VARCHAR2(255 CHAR),
  hot NUMBER(10,0),
  create_time NUMBER(10,0),
  hide NUMBER(3,0)
);


ALTER TABLE label MODIFY (label_pid DEFAULT '0');
ALTER TABLE label MODIFY (hot DEFAULT '0');
ALTER TABLE label MODIFY (create_time DEFAULT '0');
ALTER TABLE label MODIFY (hide DEFAULT '0');
COMMENT ON COLUMN label.label_id IS '标签ID'
;

COMMENT ON COLUMN label.label_pid IS '父ID'
;

COMMENT ON COLUMN label.label_name IS '标签名称'
;

COMMENT ON COLUMN label.hot IS '标签使用热度'
;

COMMENT ON COLUMN label.create_time IS '创建时间'
;

COMMENT ON COLUMN label.hide IS '隐藏标签：0隐藏，1显示'
;

PROMPT Creating Primary Key Constraint PRIMARY on table label ... 
ALTER TABLE label
ADD CONSTRAINT PRIMARY PRIMARY KEY
(
  label_id
)
ENABLE
;
PROMPT Creating Unique Constraint idx_label_name on table label
ALTER TABLE label
ADD CONSTRAINT idx_label_name UNIQUE (
  label_name
)
ENABLE
;

GRANT ALL ON label TO ROLE_208MySQL迁移Oracle;
-- DROP TABLE label_id CASCADE CONSTRAINTS;


PROMPT Creating Table label_id ...
CREATE TABLE label_id (
  id NUMBER(10,0) NOT NULL,
  number_ NUMBER(3,0)
);


ALTER TABLE label_id MODIFY (number_ DEFAULT '0');
COMMENT ON COLUMN label_id.id IS '自增'
;

COMMENT ON COLUMN label_id.number_ IS 'ORIGINAL NAME:number , 填充'
;

PROMPT Creating Primary Key Constraint PRIMARY_1 on table label_id ... 
ALTER TABLE label_id
ADD CONSTRAINT PRIMARY_1 PRIMARY KEY
(
  id
)
ENABLE
;

GRANT ALL ON label_id TO ROLE_208MySQL迁移Oracle;
-- DROP TABLE library CASCADE CONSTRAINTS;


PROMPT Creating Table library ...
CREATE TABLE library (
  library_prefix_id NUMBER(10,0),
  library_id NUMBER(10,0) NOT NULL,
  library_name VARCHAR2(255 CHAR) NOT NULL,
  source_language_id NUMBER(10,0) NOT NULL,
  target_language_id NUMBER(10,0) NOT NULL,
  owner_type NUMBER(3,0),
  owner_id VARCHAR2(20 CHAR) NOT NULL,
  manager_id VARCHAR2(20 CHAR) NOT NULL,
  explain VARCHAR2(255 CHAR) NOT NULL,
  count NUMBER(10,0) NOT NULL,
  create_user_id VARCHAR2(20 CHAR) NOT NULL,
  create_time NUMBER(10,0) NOT NULL,
  last_modify_user_id VARCHAR2(20 CHAR),
  last_modify_time NUMBER(10,0),
  delete_ NUMBER(3,0),
  share_ NUMBER(3,0),
  share_time NUMBER(10,0),
  share_hot NUMBER(10,0),
  sale NUMBER(3,0),
  sale_time NUMBER(10,0),
  sale_score NUMBER(10,0),
  collect_score NUMBER(10,0),
  remarks CLOB,
  lock_ NUMBER(3,0),
  lock_time NUMBER(10,0),
  task_id NUMBER(10,0),
  time_delete NUMBER(10,0),
  time_recover NUMBER(10,0),
  shadow_library_id NUMBER(10,0),
  shadow_library_create_time NUMBER(10,0),
  version NUMBER(24,0) NOT NULL,
  version_unshare NUMBER(24,0),
  library_local_id NUMBER(10,0),
  from_ VARCHAR2(50 CHAR),
  recommend NUMBER(10,0),
  type NUMBER(10,0),
  usecount NUMBER(10,0),
  private_memo CLOB NOT NULL
);


ALTER TABLE library MODIFY (library_prefix_id DEFAULT '0');
ALTER TABLE library MODIFY (library_id DEFAULT '0');
ALTER TABLE library MODIFY (source_language_id DEFAULT '0');
ALTER TABLE library MODIFY (target_language_id DEFAULT '0');
ALTER TABLE library MODIFY (owner_type DEFAULT '0');
ALTER TABLE library MODIFY (owner_id DEFAULT '0');
ALTER TABLE library MODIFY (count DEFAULT '0');
ALTER TABLE library MODIFY (create_user_id DEFAULT '0');
ALTER TABLE library MODIFY (create_time DEFAULT '0');
ALTER TABLE library MODIFY (last_modify_user_id DEFAULT '0');
ALTER TABLE library MODIFY (last_modify_time DEFAULT '0');
ALTER TABLE library MODIFY (delete_ DEFAULT '1');
ALTER TABLE library MODIFY (share_ DEFAULT '0');
ALTER TABLE library MODIFY (share_time DEFAULT '0');
ALTER TABLE library MODIFY (share_hot DEFAULT '0');
ALTER TABLE library MODIFY (sale DEFAULT '0');
ALTER TABLE library MODIFY (sale_time DEFAULT '0');
ALTER TABLE library MODIFY (sale_score DEFAULT '0');
ALTER TABLE library MODIFY (collect_score DEFAULT '0');
ALTER TABLE library MODIFY (lock_ DEFAULT '0');
ALTER TABLE library MODIFY (lock_time DEFAULT '0');
ALTER TABLE library MODIFY (task_id DEFAULT '0');
ALTER TABLE library MODIFY (time_delete DEFAULT '0');
ALTER TABLE library MODIFY (time_recover DEFAULT '0');
ALTER TABLE library MODIFY (shadow_library_id DEFAULT '0');
ALTER TABLE library MODIFY (shadow_library_create_time DEFAULT '0');
ALTER TABLE library MODIFY (version DEFAULT '1');
ALTER TABLE library MODIFY (version_unshare DEFAULT '0');
ALTER TABLE library MODIFY (library_local_id DEFAULT '0');
ALTER TABLE library MODIFY (recommend DEFAULT '0');
ALTER TABLE library MODIFY (type DEFAULT '1');
ALTER TABLE library MODIFY (usecount DEFAULT '0');
COMMENT ON COLUMN library.library_prefix_id IS '库前缀ID'
;

COMMENT ON COLUMN library.library_id IS '库ID'
;

COMMENT ON COLUMN library.library_name IS '库名称'
;

COMMENT ON COLUMN library.source_language_id IS '源语言ID'
;

COMMENT ON COLUMN library.target_language_id IS '目标语言ID'
;

COMMENT ON COLUMN library.owner_type IS '所有者类型：1用户库，2组织库，3公共通用库，4公共专业库'
;

COMMENT ON COLUMN library.owner_id IS '所有者ID'
;

COMMENT ON COLUMN library.manager_id IS '管理者ID'
;

COMMENT ON COLUMN library.explain IS '备注'
;

COMMENT ON COLUMN library.count IS '术语个数统计'
;

COMMENT ON COLUMN library.create_user_id IS '创建者ID'
;

COMMENT ON COLUMN library.create_time IS '创建时间'
;

COMMENT ON COLUMN library.last_modify_user_id IS '最后一次修改人ID'
;

COMMENT ON COLUMN library.last_modify_time IS '最后一次修改时间'
;

COMMENT ON COLUMN library.delete_ IS 'ORIGINAL NAME:delete , 删除标记'
;

COMMENT ON COLUMN library.share_ IS 'ORIGINAL NAME:share , 分享：0 未分享，1 已分享'
;

COMMENT ON COLUMN library.share_time IS '分享时间'
;

COMMENT ON COLUMN library.share_hot IS '收藏数量'
;

COMMENT ON COLUMN library.sale IS '是否出售'
;

COMMENT ON COLUMN library.sale_time IS '出售时间'
;

COMMENT ON COLUMN library.sale_score IS '出售价格'
;

COMMENT ON COLUMN library.collect_score IS '收藏价格'
;

COMMENT ON COLUMN library.remarks IS '备注信息'
;

COMMENT ON COLUMN library.lock_ IS 'ORIGINAL NAME:lock , 术语库锁：0未锁、1锁'
;

COMMENT ON COLUMN library.task_id IS '对应的async的任务ID'
;

COMMENT ON COLUMN library.time_delete IS '术语库删除时间'
;

COMMENT ON COLUMN library.time_recover IS '术语库回复时间'
;

COMMENT ON COLUMN library.shadow_library_id IS '影子库（当前最新的复制库）的ID'
;

COMMENT ON COLUMN library.shadow_library_create_time IS '影子库（当前最新的复制库）创建时间'
;

COMMENT ON COLUMN library.version IS '版本号'
;

COMMENT ON COLUMN library.version_unshare IS '该库取消分享时的版本'
;

COMMENT ON COLUMN library.library_local_id IS '客户端的库ID，防止在add操作时用来比较是否是重复提交同一个库（超时情况下）'
;

COMMENT ON COLUMN library.from_ IS 'ORIGINAL NAME:from , 来源'
;

COMMENT ON COLUMN library.recommend IS '推荐指数'
;

COMMENT ON COLUMN library.type IS '库类型：1-术语库、2-语料、3-文件'
;

COMMENT ON COLUMN library.usecount IS '使用次数'
;

COMMENT ON COLUMN library.private_memo IS '私有备注'
;

PROMPT Creating Primary Key Constraint PRIMARY_2 on table library ... 
ALTER TABLE library
ADD CONSTRAINT PRIMARY_2 PRIMARY KEY
(
  library_id
)
ENABLE
;
PROMPT Creating Unique Constraint idx_user_libname_type on table library
ALTER TABLE library
ADD CONSTRAINT idx_user_libname_type UNIQUE (
  library_name,
  create_user_id,
  type
)
ENABLE
;

GRANT ALL ON library TO ROLE_208MySQL迁移Oracle;
-- DROP TABLE library_collect CASCADE CONSTRAINTS;


PROMPT Creating Table library_collect ...
CREATE TABLE library_collect (
  collect_type NUMBER(3,0) NOT NULL,
  collect_id VARCHAR2(20 CHAR) NOT NULL,
  library_id NUMBER(10,0) NOT NULL,
  owner_type NUMBER(3,0) NOT NULL,
  owner_id VARCHAR2(20 CHAR) NOT NULL,
  create_time NUMBER(10,0) NOT NULL,
  is_available NUMBER(3,0) NOT NULL,
  lib_type NUMBER(3,0) NOT NULL,
  version NUMBER(24,0) NOT NULL
);


ALTER TABLE library_collect MODIFY (collect_type DEFAULT '1');
ALTER TABLE library_collect MODIFY (library_id DEFAULT '0');
ALTER TABLE library_collect MODIFY (owner_type DEFAULT '0');
ALTER TABLE library_collect MODIFY (create_time DEFAULT '0');
ALTER TABLE library_collect MODIFY (is_available DEFAULT '1');
ALTER TABLE library_collect MODIFY (lib_type DEFAULT '1');
ALTER TABLE library_collect MODIFY (version DEFAULT '0');
COMMENT ON COLUMN library_collect.collect_type IS '收藏者类型：1用户，2组织'
;

COMMENT ON COLUMN library_collect.collect_id IS '收藏者ID'
;

COMMENT ON COLUMN library_collect.library_id IS '库ID'
;

COMMENT ON COLUMN library_collect.owner_type IS '所有者类型：1用户，2组织'
;

COMMENT ON COLUMN library_collect.owner_id IS '所有者ID'
;

COMMENT ON COLUMN library_collect.create_time IS '收藏时间'
;

COMMENT ON COLUMN library_collect.is_available IS '是否可用'
;

COMMENT ON COLUMN library_collect.lib_type IS '库类型：1-术语库、2-语料、3-文件'
;

PROMPT Creating Unique Constraint idx_user_library on table library_collect
ALTER TABLE library_collect
ADD CONSTRAINT idx_user_library UNIQUE (
  collect_id,
  library_id
)
ENABLE
;

GRANT ALL ON library_collect TO ROLE_208MySQL迁移Oracle;
-- DROP TABLE library_collect_hide CASCADE CONSTRAINTS;


PROMPT Creating Table library_collect_hide ...
CREATE TABLE library_collect_hide (
  collect_type NUMBER(3,0) NOT NULL,
  collect_id VARCHAR2(20 CHAR) NOT NULL,
  library_id NUMBER(10,0) NOT NULL,
  owner_type NUMBER(3,0) NOT NULL,
  owner_id VARCHAR2(20 CHAR) NOT NULL,
  create_time NUMBER(10,0) NOT NULL,
  is_available NUMBER(3,0) NOT NULL,
  operator VARCHAR2(20 CHAR) NOT NULL,
  lib_type NUMBER(3,0) NOT NULL,
  is_next NUMBER(3,0) NOT NULL,
  valid_time NUMBER(10,0) NOT NULL,
  share_path CLOB NOT NULL,
  version NUMBER(24,0) NOT NULL,
  share_type NUMBER(10,0) NOT NULL
);


ALTER TABLE library_collect_hide MODIFY (collect_type DEFAULT '0');
ALTER TABLE library_collect_hide MODIFY (library_id DEFAULT '0');
ALTER TABLE library_collect_hide MODIFY (owner_type DEFAULT '0');
ALTER TABLE library_collect_hide MODIFY (create_time DEFAULT '0');
ALTER TABLE library_collect_hide MODIFY (is_available DEFAULT '0');
ALTER TABLE library_collect_hide MODIFY (lib_type DEFAULT '1');
ALTER TABLE library_collect_hide MODIFY (is_next DEFAULT '0');
ALTER TABLE library_collect_hide MODIFY (valid_time DEFAULT '0');
ALTER TABLE library_collect_hide MODIFY (version DEFAULT '0');
ALTER TABLE library_collect_hide MODIFY (share_type DEFAULT '1');
COMMENT ON COLUMN library_collect_hide.collect_type IS '收藏者类型：1用户，2组织'
;

COMMENT ON COLUMN library_collect_hide.collect_id IS '收藏者ID'
;

COMMENT ON COLUMN library_collect_hide.library_id IS '库ID'
;

COMMENT ON COLUMN library_collect_hide.owner_type IS '所有者类型：1用户，2组织'
;

COMMENT ON COLUMN library_collect_hide.owner_id IS '所有者ID'
;

COMMENT ON COLUMN library_collect_hide.is_available IS '是否可用'
;

COMMENT ON COLUMN library_collect_hide.lib_type IS '库类型：1-术语库、2-语料、3-文件'
;

COMMENT ON COLUMN library_collect_hide.is_next IS '是否允许继续分享'
;

COMMENT ON COLUMN library_collect_hide.valid_time IS '有效期'
;

COMMENT ON COLUMN library_collect_hide.share_path IS '分享树的路径'
;

PROMPT Creating Primary Key Constraint PRIMARY_4 on table library_collect_hide ... 
ALTER TABLE library_collect_hide
ADD CONSTRAINT PRIMARY_4 PRIMARY KEY
(
  collect_id,
  library_id
)
ENABLE
;

GRANT ALL ON library_collect_hide TO ROLE_208MySQL迁移Oracle;
-- DROP TABLE library_id CASCADE CONSTRAINTS;


PROMPT Creating Table library_id ...
CREATE TABLE library_id (
  id NUMBER(10,0) NOT NULL,
  number_ NUMBER(3,0)
);


ALTER TABLE library_id MODIFY (number_ DEFAULT '0');
COMMENT ON COLUMN library_id.id IS '自增'
;

COMMENT ON COLUMN library_id.number_ IS 'ORIGINAL NAME:number , 填充'
;

PROMPT Creating Primary Key Constraint PRIMARY_5 on table library_id ... 
ALTER TABLE library_id
ADD CONSTRAINT PRIMARY_5 PRIMARY KEY
(
  id
)
ENABLE
;

GRANT ALL ON library_id TO ROLE_208MySQL迁移Oracle;
-- DROP TABLE library_join_category CASCADE CONSTRAINTS;


PROMPT Creating Table library_join_category ...
CREATE TABLE library_join_category (
  id NUMBER(10,0) NOT NULL,
  label_id NUMBER(10,0) NOT NULL,
  library_id NUMBER(10,0) NOT NULL,
  user_id CHAR(20 CHAR) NOT NULL,
  create_time NUMBER(10,0) NOT NULL,
  is_deleted NUMBER(3,0) NOT NULL,
  sort NUMBER(3,0) NOT NULL,
  updated_at NUMBER(10,0) NOT NULL,
  version NUMBER(24,0) NOT NULL
);


ALTER TABLE library_join_category MODIFY (label_id DEFAULT '0');
ALTER TABLE library_join_category MODIFY (library_id DEFAULT '0');
ALTER TABLE library_join_category MODIFY (create_time DEFAULT '0');
ALTER TABLE library_join_category MODIFY (is_deleted DEFAULT '0');
ALTER TABLE library_join_category MODIFY (sort DEFAULT '0');
ALTER TABLE library_join_category MODIFY (updated_at DEFAULT '0');
ALTER TABLE library_join_category MODIFY (version DEFAULT '0');
COMMENT ON COLUMN library_join_category.id IS '分类id，主键'
;

COMMENT ON COLUMN library_join_category.label_id IS '标签id，来自label表'
;

COMMENT ON COLUMN library_join_category.library_id IS '库id，来自library表。值如果为0，表示用户创建了一个空的分类，还没有往该分类中添加元素'
;

COMMENT ON COLUMN library_join_category.user_id IS '用户id'
;

COMMENT ON COLUMN library_join_category.create_time IS '添加时间'
;

COMMENT ON COLUMN library_join_category.is_deleted IS '是否删除了，0表示没有删除，1表示删除了'
;

COMMENT ON COLUMN library_join_category.sort IS '排序'
;

COMMENT ON COLUMN library_join_category.version IS '版本号'
;

PROMPT Creating Primary Key Constraint PRIMARY_3 on table library_join_category ... 
ALTER TABLE library_join_category
ADD CONSTRAINT PRIMARY_3 PRIMARY KEY
(
  id
)
ENABLE
;
PROMPT Creating Unique Constraint idx_user_label_lib_del on table library_join_category
ALTER TABLE library_join_category
ADD CONSTRAINT idx_user_label_lib_del UNIQUE (
  label_id,
  library_id,
  user_id,
  is_deleted
)
ENABLE
;

GRANT ALL ON library_join_category TO ROLE_208MySQL迁移Oracle;
PROMPT Creating Index user_id on library ...
CREATE INDEX user_id ON library
(
  create_user_id
) 
;
PROMPT Creating Index idx_owner_id on library ...
CREATE INDEX idx_owner_id ON library
(
  owner_id
) 
;
PROMPT Creating Index idx_share on library ...
CREATE INDEX idx_share ON library
(
  share_
) 
;
PROMPT Creating Index idx_reviewer on library ...
CREATE INDEX idx_reviewer ON library
(
  manager_id
) 
;
PROMPT Creating Index idx_term_count on library ...
CREATE INDEX idx_term_count ON library
(
  count
) 
;
PROMPT Creating Index idx_lang on library ...
CREATE INDEX idx_lang ON library
(
  source_language_id,
  target_language_id
) 
;
PROMPT Creating Index idx_modify on library ...
CREATE INDEX idx_modify ON library
(
  last_modify_time
) 
;
PROMPT Creating Index idx_recommend on library ...
CREATE INDEX idx_recommend ON library
(
  recommend
) 
;
PROMPT Creating Index idx_share_hot on library ...
CREATE INDEX idx_share_hot ON library
(
  share_hot
) 
;
PROMPT Creating Index idx_version on library ...
CREATE INDEX idx_version ON library
(
  version,
  create_user_id
) 
;
PROMPT Creating Index idx_library_id on library_collect ...
CREATE INDEX idx_library_id ON library_collect
(
  library_id
) 
;
PROMPT Creating Index idx_libID on library_collect_hide ...
CREATE INDEX idx_libID ON library_collect_hide
(
  library_id
) 
;
PROMPT Creating Index idx_user_lib on library_join_category ...
CREATE INDEX idx_user_lib ON library_join_category
(
  library_id,
  user_id
) 
;
PROMPT Creating Index idx_user on library_join_category ...
CREATE INDEX idx_user ON library_join_category
(
  user_id,
  label_id
) 
;
set define on
prompt connecting to term_cloud_208
connect term_cloud_208/&&term_cloud_208_password;
set define off

CREATE OR REPLACE TRIGGER label_id_id_TRG BEFORE INSERT ON label_id
FOR EACH ROW
DECLARE 
v_newVal NUMBER(12) := 0;
v_incval NUMBER(12) := 0;
BEGIN
  IF INSERTING AND :new.id IS NULL THEN
    SELECT  label_id_id_SEQ.NEXTVAL INTO v_newVal FROM DUAL;
    -- If this is the first time this table have been inserted into (sequence == 1)
    IF v_newVal = 1 THEN 
      --get the max indentity value from the table
      SELECT NVL(max(id),0) INTO v_newVal FROM label_id;
      v_newVal := v_newVal + 1;
      --set the sequence to that value
      LOOP
           EXIT WHEN v_incval>=v_newVal;
           SELECT label_id_id_SEQ.nextval INTO v_incval FROM dual;
      END LOOP;
    END IF;
    --used to emulate LAST_INSERT_ID()
    --mysql_utilities.identity := v_newVal; 
   -- assign the value from the sequence to emulate the identity column
   :new.id := v_newVal;
  END IF;
END;

/

CREATE OR REPLACE TRIGGER library_join_category_id_TRG BEFORE INSERT ON library_join_category
FOR EACH ROW
DECLARE 
v_newVal NUMBER(12) := 0;
v_incval NUMBER(12) := 0;
BEGIN
  IF INSERTING AND :new.id IS NULL THEN
    SELECT  library_join_category_id_SEQ.NEXTVAL INTO v_newVal FROM DUAL;
    -- If this is the first time this table have been inserted into (sequence == 1)
    IF v_newVal = 1 THEN 
      --get the max indentity value from the table
      SELECT NVL(max(id),0) INTO v_newVal FROM library_join_category;
      v_newVal := v_newVal + 1;
      --set the sequence to that value
      LOOP
           EXIT WHEN v_incval>=v_newVal;
           SELECT library_join_category_id_SEQ.nextval INTO v_incval FROM dual;
      END LOOP;
    END IF;
    --used to emulate LAST_INSERT_ID()
    --mysql_utilities.identity := v_newVal; 
   -- assign the value from the sequence to emulate the identity column
   :new.id := v_newVal;
  END IF;
END;

/

CREATE OR REPLACE TRIGGER library_id_id_TRG BEFORE INSERT ON library_id
FOR EACH ROW
DECLARE 
v_newVal NUMBER(12) := 0;
v_incval NUMBER(12) := 0;
BEGIN
  IF INSERTING AND :new.id IS NULL THEN
    SELECT  library_id_id_SEQ.NEXTVAL INTO v_newVal FROM DUAL;
    -- If this is the first time this table have been inserted into (sequence == 1)
    IF v_newVal = 1 THEN 
      --get the max indentity value from the table
      SELECT NVL(max(id),0) INTO v_newVal FROM library_id;
      v_newVal := v_newVal + 1;
      --set the sequence to that value
      LOOP
           EXIT WHEN v_incval>=v_newVal;
           SELECT library_id_id_SEQ.nextval INTO v_incval FROM dual;
      END LOOP;
    END IF;
    --used to emulate LAST_INSERT_ID()
    --mysql_utilities.identity := v_newVal; 
   -- assign the value from the sequence to emulate the identity column
   :new.id := v_newVal;
  END IF;
END;

/

spool off;

COMMIT;

