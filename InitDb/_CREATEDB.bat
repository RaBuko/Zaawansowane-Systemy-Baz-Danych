
echo @2_drop_tables.sql | sqlplus -s C##test1/password1
echo @3_create_tables.sql | sqlplus -s C##test1/password1
echo @4_insert_data.sql | sqlplus -s C##test1/password1
echo @PRODUCTS.sql | sqlplus -s C##test1/password1
echo @OFFICES.sql | sqlplus -s C##test1/password1
echo @EMPLOYEES.sql | sqlplus -s C##test1/password1
echo @CUSTOMERS.sql | sqlplus -s C##test1/password1
echo @PAYMENTS.sql | sqlplus -s C##test1/password1
echo @ORDERS.sql | sqlplus -s C##test1/password1
echo @ORDERDETAILS.sql | sqlplus -s C##test1/password1

