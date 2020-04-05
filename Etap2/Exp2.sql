CREATE TABLE exp2_log (
	LogID int GENERATED ALWAYS AS IDENTITY,
	rule_name VARCHAR2(30),
	event_time TIMESTAMP
);



CREATE OR REPLACE TRIGGER exp2_1
AFTER INSERT ON EMPLOYEES
BEGIN
	INSERT INTO exp2_log  (rule_name, event_time)
	VALUES ('exp2_r1', CURRENT_TIMESTAMP);
END;

CREATE OR REPLACE TRIGGER exp2_2
AFTER INSERT ON EMPLOYEES
BEGIN
	INSERT INTO exp2_log  (rule_name, event_time)
	VALUES ('exp2_r2', CURRENT_TIMESTAMP);
END;

CREATE OR REPLACE TRIGGER exp2_3
AFTER INSERT ON EMPLOYEES
BEGIN
	INSERT INTO exp2_log  (rule_name, event_time)
	VALUES ('exp2_r3', CURRENT_TIMESTAMP);
END;




--Test:
INSERT INTO employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle) 
VALUES (17003,'Gerard','Martin','x2312','mgerard@classicmodelcars.com','4',2501,'Sales Rep');

