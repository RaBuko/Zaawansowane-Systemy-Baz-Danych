/*Table structure for table `productlines` */

CREATE TABLE productlines (
  productLine varchar2(50) NOT NULL,
  textDescription varchar2(4000) DEFAULT NULL,
  htmlDescription clob,
  image blob,
  PRIMARY KEY (productLine)
) ;

/*Table structure for table `products` */
CREATE TABLE products (
  productCode varchar2(15) NOT NULL,
  productName varchar2(70) NOT NULL,
  productLine varchar2(50) NOT NULL,
  productScale varchar2(10) NOT NULL,
  productVendor varchar2(50) NOT NULL,
  productDescription clob NOT NULL,
  quantityInStock number(6) NOT NULL,
  buyPrice number(10,2) NOT NULL,
  MSRP number(10,2) NOT NULL,
  PRIMARY KEY (productCode)
 ,
  CONSTRAINT products_ibfk_1 FOREIGN KEY (productLine) REFERENCES productlines (productLine)
  ON delete cascade
) ;

CREATE INDEX productLine ON products (productLine);

/*Table structure for table `offices` */

CREATE TABLE offices (
  officeCode varchar2(10) NOT NULL,
  city varchar2(50) NOT NULL,
  phone varchar2(50) NOT NULL,
  addressLine1 varchar2(50) NOT NULL,
  addressLine2 varchar2(50) DEFAULT NULL,
  state varchar2(50) DEFAULT NULL,
  country varchar2(50) NOT NULL,
  postalCode varchar2(15) NOT NULL,
  territory varchar2(10) NOT NULL,
  PRIMARY KEY (officeCode)
) ;

/*Table structure for table `employees` */

CREATE TABLE employees (
  employeeNumber number(10) NOT NULL,
  lastName varchar2(50) NOT NULL,
  firstName varchar2(50) NOT NULL,
  extension varchar2(10) NOT NULL,
  email varchar2(100) NOT NULL,
  officeCode varchar2(10) NOT NULL,
  reportsTo number(10) DEFAULT NULL,
  jobTitle varchar2(50) NOT NULL,
  PRIMARY KEY (employeeNumber)
 ,
  CONSTRAINT employees_ibfk_1 FOREIGN KEY (reportsTo) REFERENCES employees (employeeNumber) on delete cascade,
  CONSTRAINT employees_ibfk_2 FOREIGN KEY (officeCode) REFERENCES offices (officeCode) on delete cascade
) ;

CREATE INDEX reportsTo ON employees (reportsTo);
CREATE INDEX officeCode ON employees (officeCode);


/*Table structure for table `customers` */

CREATE TABLE customers (
  customerNumber number(10) NOT NULL,
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
  salesRepEmployeeNumber number(10) DEFAULT NULL,
  creditLimit number(10,2) DEFAULT NULL,
  PRIMARY KEY (customerNumber)
 ,
  CONSTRAINT customers_ibfk_1 FOREIGN KEY (salesRepEmployeeNumber) REFERENCES employees (employeeNumber) on delete cascade
) ;

CREATE INDEX salesRepEmployeeNumber ON customers (salesRepEmployeeNumber);

/*Table structure for table `payments` */

CREATE TABLE payments (
  customerNumber number(10) NOT NULL,
  checkNumber varchar2(50) NOT NULL,
  paymentDate date NOT NULL,
  amount number(10,2) NOT NULL,
  PRIMARY KEY (customerNumber,checkNumber),
  CONSTRAINT payments_ibfk_1 FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber) on delete cascade
) ;

/*Table structure for table `orders` */

CREATE TABLE orders (
  orderNumber number(10) NOT NULL,
  orderDate date NOT NULL,
  requiredDate date NOT NULL,
  shippedDate date DEFAULT NULL,
  status varchar2(15) NOT NULL,
  comments clob,
  customerNumber number(10) NOT NULL,
  PRIMARY KEY (orderNumber)
 ,
  CONSTRAINT orders_ibfk_1 FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber) on delete cascade
) ;

CREATE INDEX customerNumber ON orders (customerNumber);



/*Table structure for table `orderdetails` */

CREATE TABLE orderdetails (
  orderNumber number(10) NOT NULL,
  productCode varchar2(15) NOT NULL,
  quantityOrdered number(10) NOT NULL,
  priceEach number(10,2) NOT NULL,
  orderLineNumber number(5) NOT NULL,
  PRIMARY KEY (orderNumber,productCode)
 ,
  CONSTRAINT orderdetails_ibfk_1 FOREIGN KEY (orderNumber) REFERENCES orders (orderNumber) on delete cascade,
  CONSTRAINT orderdetails_ibfk_2 FOREIGN KEY (productCode) REFERENCES products (productCode) on delete cascade
) ;

CREATE INDEX productCode ON orderdetails (productCode);