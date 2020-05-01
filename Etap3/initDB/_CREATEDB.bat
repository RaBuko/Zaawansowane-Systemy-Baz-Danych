
echo @0Create.sql | sqlplus -s C##test2/password1
echo @1in_offices.sql | sqlplus -s C##test2/password1
echo @2in_employees.sql | sqlplus -s C##test2/password1
echo @3in_customers.sql | sqlplus -s C##test2/password1
echo @4in_payments.sql | sqlplus -s C##test2/password1
echo @5in_productlines.sql | sqlplus -s C##test2/password1
echo @6in_products.sql | sqlplus -s C##test2/password1
echo @7in_orders.sql | sqlplus -s C##test2/password1
