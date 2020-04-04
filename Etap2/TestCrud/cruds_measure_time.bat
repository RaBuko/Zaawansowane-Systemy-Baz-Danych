echo @DISABLE_TRIGGERS.sql | sqlplus -s C##test1/password1
echo @CRUD_1.sql | sqlplus -s C##test1/password1
echo @CRUD_2.sql | sqlplus -s C##test1/password1
echo @CRUD_3.sql | sqlplus -s C##test1/password1
echo @CRUD_4.sql | sqlplus -s C##test1/password1
echo @ENABLE_TRIGGERS.sql | sqlplus -s C##test1/password1