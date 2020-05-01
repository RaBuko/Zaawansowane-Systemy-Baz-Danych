DROP INDEX salesRepEmployeeNumber;
DROP INDEX reportsTo;
DROP INDEX officeCode;
DROP INDEX productLine;
DROP INDEX productCode;
DROP INDEX customerNumber;
DROP TABLE orderdetails;
DROP TABLE orders;
DROP TABLE products;
DROP TABLE payments;
DROP TABLE customers;
DROP TABLE employees;
DROP TABLE productlines;
DROP TABLE offices;

CREATE TABLE offices(
 officeCode varchar2(10) NOT NULL,
 details XMLType,
 PRIMARY KEY (officeCode)
);


CREATE TABLE employees (
  employeeNumber number(10) NOT NULL,
  lastName varchar2(50) NOT NULL,
  firstName varchar2(50) NOT NULL,
  extension varchar2(10) NOT NULL,
  email varchar2(100) NOT NULL,
  officeCode varchar2(10) NOT NULL,
  reportsTo number(10) DEFAULT NULL,
  jobTitle varchar2(50) NOT NULL,
  PRIMARY KEY (employeeNumber),
  CONSTRAINT employees_ibfk_1 FOREIGN KEY (reportsTo) REFERENCES employees (employeeNumber) ON delete cascade,
  CONSTRAINT employees_ibfk_2 FOREIGN KEY (officeCode) REFERENCES offices (officeCode) ON delete cascade
);

CREATE TABLE customers (
  customerNumber number(11) NOT NULL,
  customerName varchar2(50) NOT NULL,
  contactLastName varchar2(50) NOT NULL,
  contactFirstName varchar2(50) NOT NULL,
  phone varchar2(50) NOT NULL,
  addressLine1 varchar2(50) NOT NULL,
  addressLine2 varchar2(50) DEFAULT NULL,
  city varchar2(50) NOT NULL,
  state varchar2(50) DEFAULT NULL,
  postalCode varchar2(15) DEFAULT NULL,
  country varchar2(50) NOT NULL,
  salesRepEmployeeNumber number(11) DEFAULT NULL,
  creditLimit number(10,2) DEFAULT NULL,
  PRIMARY KEY (customerNumber),
  CONSTRAINT customers_ibfk_1 FOREIGN KEY (salesRepEmployeeNumber) REFERENCES employees (employeeNumber) ON delete cascade
);

CREATE TABLE payments(payment clob);

CREATE TABLE productlines (
  productLine varchar2(50) NOT NULL,
  textDescription varchar2(4000) DEFAULT NULL,
  htmlDescription clob,
  image clob,
  PRIMARY KEY (productLine)
);

CREATE TABLE products (
  productCode varchar2(15) NOT NULL,
  productName varchar2(70) NOT NULL,
  productLine varchar2(50) NOT NULL,
  productScale varchar2(10) NOT NULL,
  productVendor varchar2(50) NOT NULL,
  productDescription clob NOT NULL,
  quantityInStock number(5) NOT NULL,
  buyPrice number(10,2) NOT NULL,
  MSRP number(10,2) NOT NULL,
  PRIMARY KEY (productCode),
  CONSTRAINT products_ibfk_1 FOREIGN KEY (productLine) REFERENCES productlines (productLine) ON delete cascade
);


CREATE TABLE orders (
  orderNumber number(10) NOT NULL,
  orderDate date NOT NULL,
  requiredDate date NOT NULL,
  shippedDate date DEFAULT NULL,
  status varchar2(15) NOT NULL,
  comments clob,
  customerNumber number(10) NOT NULL,
  PRIMARY KEY (orderNumber),
  details XMLType,
  CONSTRAINT orders_ibfk_1 FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber) ON delete cascade
);


CREATE INDEX salesRepEmployeeNumber ON customers (salesRepEmployeeNumber);
CREATE INDEX reportsTo ON employees (reportsTo);
CREATE INDEX officeCode ON employees (officeCode);
CREATE INDEX productLine ON products (productLine);
CREATE INDEX customerNumber ON orders (customerNumber);