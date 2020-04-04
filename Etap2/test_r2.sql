--R2 -PRUBKA
--------------------------------
--crud
insert  into payments(customerNumber,checkNumber,paymentDate,amount) 
values (103,'NEW236335',to_date('2020-02-19','YYYY-MM-DD'),6066.78);

 UPDATE CUSTOMERS CUST
 SET CUST.CREDITLIMIT = CUST.CREDITLIMIT+100
 WHERE CUST.CUSTOMERNUMBER = 103;

insert  into payments(customerNumber,checkNumber,paymentDate,amount) 
values (103,'NEW236336',to_date('2020-02-19','YYYY-MM-DD'),6066.78);

 UPDATE CUSTOMERS CUST
 SET CUST.CREDITLIMIT = CUST.CREDITLIMIT+100
 WHERE CUST.CUSTOMERNUMBER = 103;

insert  into payments(customerNumber,checkNumber,paymentDate,amount) 
values (103,'NEW236337',to_date('2020-02-19','YYYY-MM-DD'),6066.78);

 UPDATE CUSTOMERS CUST
 SET CUST.CREDITLIMIT = CUST.CREDITLIMIT+100
 WHERE CUST.CUSTOMERNUMBER = 103;
 
 insert  into payments(customerNumber,checkNumber,paymentDate,amount) 
values (103,'NEW236338',to_date('2020-02-19','YYYY-MM-DD'),6066.78);

 UPDATE CUSTOMERS CUST
 SET CUST.CREDITLIMIT = CUST.CREDITLIMIT+100
 WHERE CUST.CUSTOMERNUMBER = 103;
 
 insert  into payments(customerNumber,checkNumber,paymentDate,amount) 
values (103,'NEW236339',to_date('2020-02-19','YYYY-MM-DD'),6066.78);

 UPDATE CUSTOMERS CUST
 SET CUST.CREDITLIMIT = CUST.CREDITLIMIT+100
 WHERE CUST.CUSTOMERNUMBER = 103;
 ROLLBACK;
 
 --------------------R2
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