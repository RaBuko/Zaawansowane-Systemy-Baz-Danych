--RULE_2
-- FLUSH 
ALTER SYSTEM FLUSH buffer_cache;
ALTER SYSTEM FLUSH shared_pool;

VARIABLE  START_TIME_RULE_2 NUMBER;
EXEC :START_TIME_RULE_2 := EXTRACT(SECOND FROM SYSTIMESTAMP);
-- START MIERZENIA CZASU

insert  into payments(customerNumber,checkNumber,paymentDate,amount) 
values (103,'NEW236335',to_date('2020-02-19','YYYY-MM-DD'),6066.78); 

insert  into payments(customerNumber,checkNumber,paymentDate,amount) 
values (103,'NEW236336',to_date('2020-02-19','YYYY-MM-DD'),6066.78); 

insert  into payments(customerNumber,checkNumber,paymentDate,amount) 
values (103,'NEW236337',to_date('2020-02-19','YYYY-MM-DD'),6066.78);
 
 insert  into payments(customerNumber,checkNumber,paymentDate,amount) 
values (103,'NEW236338',to_date('2020-02-19','YYYY-MM-DD'),6066.78);
 
 insert  into payments(customerNumber,checkNumber,paymentDate,amount) 
values (103,'NEW236339',to_date('2020-02-19','YYYY-MM-DD'),6066.78);

VARIABLE  TIME_FOR_RULE_2 NUMBER;
EXEC :TIME_FOR_RULE_2 := EXTRACT(SECOND FROM SYSTIMESTAMP)-:START_TIME_RULE_2;
spool etap2_results.txt append;
PRINT TIME_FOR_RULE_2;
spool off;
ROLLBACK;