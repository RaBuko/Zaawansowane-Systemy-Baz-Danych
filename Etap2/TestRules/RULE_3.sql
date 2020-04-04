--RULE_3
-- FLUSH 
ALTER SYSTEM FLUSH buffer_cache;
ALTER SYSTEM FLUSH shared_pool;

VARIABLE  START_TIME_RULE_3 NUMBER;
EXEC :START_TIME_RULE_3 := EXTRACT(SECOND FROM SYSTIMESTAMP);
-- START MIERZENIA CZASU

INSERT INTO employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle) 
VALUES (17002,'Gerard','Martin','x2312','mgerard@classicmodelcars.com','4',2501,'Sales Rep');

VARIABLE  TIME_FOR_RULE_3 NUMBER;
EXEC :TIME_FOR_RULE_3 := EXTRACT(SECOND FROM SYSTIMESTAMP)-:START_TIME_RULE_3;
spool etap2_results.txt append;
PRINT TIME_FOR_RULE_3;
spool off;
ROLLBACK;