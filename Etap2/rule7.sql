CREATE TABLE tables_log(
  action_id int GENERATED ALWAYS AS IDENTITY,
  object_name VARCHAR2(30) NOT NULL,
  object_type VARCHAR2(30) NOT NULL,
  action VARCHAR2(30) NOT NULL,
  action_date TIMESTAMP NOT NULL,
  who VARCHAR2(30) NOT NULL
);
 
 
CREATE OR REPLACE TRIGGER create_table_log
BEFORE CREATE OR DROP ON SCHEMA
BEGIN
    INSERT INTO tables_log(object_name, object_type, action, action_date, who)
VALUES(SYS.DICTIONARY_OBJ_NAME,SYS.DICTIONARY_OBJ_TYPE,SYS.sysevent,systimestamp,USER);
END;

