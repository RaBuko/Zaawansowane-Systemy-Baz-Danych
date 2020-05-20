
declare
   c int;
begin
   select count(*) into c from user_tables where table_name = upper('payments');
   if c = 1 then
      execute immediate 'drop table payments';
   end if;
end;

declare
   c int;
begin
   select count(*) into c from user_tables where table_name = upper('orderdetails');
   if c = 1 then
      execute immediate 'drop table orderdetails';
   end if;
end;

declare
   c int;
begin
   select count(*) into c from user_tables where table_name = upper('orders');
   if c = 1 then
      execute immediate 'drop table orders';
   end if;
end;

declare
   c int;
begin
   select count(*) into c from user_tables where table_name = upper('products');
   if c = 1 then
      execute immediate 'drop table products';
   end if;
end;

declare
   c int;
begin
   select count(*) into c from user_tables where table_name = upper('productlines');
   if c = 1 then
      execute immediate 'drop table productlines';
   end if;
end;

declare
   c int;
begin
   select count(*) into c from user_tables where table_name = upper('customers');
   if c = 1 then
      execute immediate 'drop table customers';
   end if;
end;

declare
   c int;
begin
   select count(*) into c from user_tables where table_name = upper('employees');
   if c = 1 then
      execute immediate 'drop table employees';
   end if;
end;

declare
   c int;
begin
   select count(*) into c from user_tables where table_name = upper('offices');
   if c = 1 then
      execute immediate 'drop table offices';
   end if;
end;






