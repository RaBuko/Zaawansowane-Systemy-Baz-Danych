declare
   c int;
begin
   select count(*) into c from user_tables where table_name = upper('cities');
   if c = 1 then
      execute immediate 'drop table cities';
   end if;
end;


CREATE TABLE "CITIES"
(  
	"CITY" VARCHAR2(50) NOT NULL ENABLE,
	"LOCATION" ST_GEOMETRY,
	 PRIMARY KEY ("CITY")
);

ALTER TABLE PRODUCTS 
ADD RECTANGLE ST_GEOMETRY;

ALTER TABLE ORDERS 
ADD RECTANGLE ST_GEOMETRY;
