## Lab Program 2
## Consider the schema for Company Database:
## EMPLOYEE (SSN, Name, Address, Sex, Salary, SuperSSN,DNo)
## DEPARTMENT (DNo, DName, MgrSSN, MgrStartDate) 
## DLOCATION (DNo,DLoc)
## PROJECT (PNo, PName, PLocation,DNo)
## WORKS_ON (SSN, PNo, Hours)
## Write SQL queries to
## 1. Make a list of all project numbers for projects that involve an employee whose last name is 
## ‘Scott’, either as a worker or as a manager of the department that controls the project. 
## 2. Show the resulting salaries if every employee working on the ‘IoT’ project is given a 10 percent raise. 
## 3. Find the sum of the salaries of all employees of the ‘Accounts’ department, as well as the 
## maximum salary, the minimum salary, and the average salary in this department. 
## 4. Retrieve the name of each employee who works on all the projects controlled by department number 5 (use NOT EXISTS operator). 
## 5. For each department that has more than five employees, retrieve the department number and the 
## number of its employees who are making more than Rs. 6,00,000
-- drop schema company;
create schema company;
use company;

CREATE TABLE EMPLOYEE
(SSN VARCHAR (20) PRIMARY KEY,
FNAME VARCHAR (20),
LNAME VARCHAR (20),
ADDRESS VARCHAR (20),
SEX CHAR,
SALARY INTEGER,DNO varchar(20),
SUPERSSN VARCHAR(20) REFERENCES EMPLOYEE (SSN),
FOREIGN KEY (DNO) REFERENCES DEPARTMENT (DNO));

CREATE TABLE DEPARTMENT
(DNO VARCHAR (20) PRIMARY KEY,
DNAME VARCHAR (20),
MGRSSN VARCHAR(20) REFERENCES EMPLOYEE (SSN),
MGRSTARTDATE VARCHAR(10));

CREATE TABLE DLOCATION
(DLOC VARCHAR (20),
DNO VARCHAR(20) REFERENCES DEPARTMENT (DNO),
PRIMARY KEY (DNO, DLOC));

CREATE TABLE PROJECT
(PNO INTEGER PRIMARY KEY,
PNAME VARCHAR (20),
PLOCATION VARCHAR (20),
DNO VARCHAR(20) REFERENCES DEPARTMENT (DNO));

CREATE TABLE WORKS_ON
(HOURS_NUMBER VARCHAR(2),
SSN VARCHAR(20) REFERENCES EMPLOYEE (SSN),
PNO INT REFERENCES PROJECT(PNO),
PRIMARY KEY (SSN, PNO));

INSERT INTO EMPLOYEE (SSN, FNAME, LNAME, ADDRESS, SEX, SALARY) VALUES
 ('RNSECE01','JOHN','SCOTT','BANGALORE','M', 450000);
INSERT INTO EMPLOYEE (SSN, FNAME, LNAME, ADDRESS, SEX, SALARY) VALUES
 ('RNSCSE01','JAMES','SMITH','BANGALORE','M', 500000);
INSERT INTO EMPLOYEE (SSN, FNAME, LNAME, ADDRESS, SEX, SALARY) VALUES
 ('RNSCSE02','HEARN','BAKER','BANGALORE','M', 700000);
INSERT INTO EMPLOYEE (SSN, FNAME, LNAME, ADDRESS, SEX, SALARY) VALUES
 ('RNSCSE03','EDWARD','SCOTT','MYSORE','M', 500000);
INSERT INTO EMPLOYEE (SSN, FNAME, LNAME, ADDRESS, SEX, SALARY) VALUES
 ('RNSCSE04','PAVAN','HEGDE','MANGALORE','M', 650000);
INSERT INTO EMPLOYEE (SSN, FNAME, LNAME, ADDRESS, SEX, SALARY) VALUES
 ('RNSCSE05','GIRISH','MALYA','MYSORE','M', 450000);
INSERT INTO EMPLOYEE (SSN, FNAME, LNAME, ADDRESS, SEX, SALARY) VALUES
 ('RNSCSE06','NEHA','SN','BANGALORE','F', 800000);
INSERT INTO EMPLOYEE (SSN, FNAME, LNAME, ADDRESS, SEX, SALARY) VALUES
 ('RNSACC01','AHANA','K','MANGALORE','F', 350000);
INSERT INTO EMPLOYEE (SSN, FNAME, LNAME, ADDRESS, SEX, SALARY) VALUES
 ('RNSACC02','SANTHOSH','KUMAR','MANGALORE','M', 300000);
INSERT INTO EMPLOYEE (SSN, FNAME, LNAME, ADDRESS, SEX, SALARY) VALUES
 ('RNSISE01','VEENA','M','MYSORE','F', 600000);
INSERT INTO EMPLOYEE (SSN, FNAME, LNAME, ADDRESS, SEX, SALARY) VALUES
 ('RNSIT01','NAGESH','HR','BANGALORE','M', 500000);

INSERT INTO DEPARTMENT VALUES ('1','ACCOUNTS','2021-01-11','RNSACC02');
INSERT INTO DEPARTMENT VALUES ('2','IT','2011-08-24','RNSIT01');
INSERT INTO DEPARTMENT VALUES ('3','ECE','2013-03-30','RNSECE01');
INSERT INTO DEPARTMENT VALUES ('4','ISE','2014-09-21','RNSISE01');
INSERT INTO DEPARTMENT VALUES ('5','CSE','2015-10-28','RNSCSE05');

UPDATE EMPLOYEE 
SET SUPERSSN=NULL, DNO='3'
WHERE SSN='RNSECE01';

UPDATE EMPLOYEE SET
SUPERSSN='RNSCSE02', DNO='5'
WHERE SSN='RNSCSE01';

UPDATE EMPLOYEE SET
SUPERSSN='RNSCSE03', DNO='5'
WHERE SSN='RNSCSE02';

UPDATE EMPLOYEE SET
SUPERSSN='RNSCSE04', DNO='5'
WHERE SSN='RNSCSE03';

UPDATE EMPLOYEE SET
DNO='5', SUPERSSN='RNSCSE05'
WHERE SSN='RNSCSE04';

UPDATE EMPLOYEE SET
DNO='5', SUPERSSN='RNSCSE06'
WHERE SSN='RNSCSE05';

UPDATE EMPLOYEE SET
DNO='5', SUPERSSN=NULL
WHERE SSN='RNSCSE06';

UPDATE EMPLOYEE SET
DNO='1', SUPERSSN='RNSACC02'
WHERE SSN='RNSACC01';

UPDATE EMPLOYEE SET
DNO='1', SUPERSSN=NULL
WHERE SSN='RNSACC02';

UPDATE EMPLOYEE SET
DNO='4', SUPERSSN=NULL
WHERE SSN='RNSISE01';

INSERT INTO DLOCATION VALUES ('BANGALORE', '1');
INSERT INTO DLOCATION VALUES ('BANGALORE', '2');
INSERT INTO DLOCATION VALUES ('BANGALORE', '3');
INSERT INTO DLOCATION VALUES ('MANGALORE', '4');
INSERT INTO DLOCATION VALUES ('MANGALORE', '5');

INSERT INTO PROJECT VALUES (100,'IOT','BANGALORE','5');
INSERT INTO PROJECT VALUES (101,'CLOUD','BANGALORE','5');
INSERT INTO PROJECT VALUES (102,'BIGDATA','BANGALORE','5');
INSERT INTO PROJECT VALUES (103,'SENSORS','BANGALORE','3');
INSERT INTO PROJECT VALUES (104,'BANK MANAGEMENT','BANGALORE','1');
INSERT INTO PROJECT VALUES (105,'SALARY MANAGEMENT','BANGALORE','1');
INSERT INTO PROJECT VALUES (106,'OPENSTACK','BANGALORE','4');
INSERT INTO PROJECT VALUES (107,'SMART CITY','BANGALORE','2');

INSERT INTO WORKS_ON VALUES (4, 'RNSCSE01', 100);
INSERT INTO WORKS_ON VALUES (6, 'RNSCSE01', 101);
INSERT INTO WORKS_ON VALUES (8, 'RNSCSE01', 102);
INSERT INTO WORKS_ON VALUES (10, 'RNSCSE02', 100);
INSERT INTO WORKS_ON VALUES (3, 'RNSCSE04', 100);
INSERT INTO WORKS_ON VALUES (4, 'RNSCSE05', 101);
INSERT INTO WORKS_ON VALUES (5, 'RNSCSE06', 102);
INSERT INTO WORKS_ON VALUES (6, 'RNSCSE03', 102);
INSERT INTO WORKS_ON VALUES (7, 'RNSECE01', 103);
INSERT INTO WORKS_ON VALUES (5, 'RNSACC01', 104);
INSERT INTO WORKS_ON VALUES (6, 'RNSACC02', 105);
INSERT INTO WORKS_ON VALUES (4, 'RNSISE01', 106);
INSERT INTO WORKS_ON VALUES (10,'RNSITE01', 107);


-- QUERY 1
## (Make a list of all project numbers for projects that involve an employee whose last name is 
## ‘Scott’, either as a worker or as a manager of the department that controls the project.)
(SELECT DISTINCT P.PNO
FROM PROJECT P, DEPARTMENT D, EMPLOYEE E 
WHERE E.DNO=D.DNO
AND D.MGRSSN=E.SSN 
AND E.LNAME='SCOTT') 
UNION
(SELECT DISTINCT P1.PNO
FROM PROJECT P1, WORKS_ON W, EMPLOYEE E1
WHERE P1.PNO=W.PNO 
AND E1.SSN=W.SSN
AND E1.LNAME='SCOTT');

-- QUERY 2
## Show the resulting salaries if every employee working on the ‘IoT’ project is given a 10 percent raise.
SELECT E.FNAME, E.LNAME, 1.1*E.SALARY AS INCR_SAL 
FROM EMPLOYEE E, WORKS_ON W, PROJECT P
WHERE E.SSN=W.SSN 
AND W.PNO=P.PNO 
AND P.PNAME='IOT';

-- QUERY 3
## Find the sum of the salaries of all employees of the ‘Accounts’ department, as well as the 
## maximum salary, the minimum salary, and the average salary in this department
SELECT SUM(E.SALARY), MAX(E.SALARY), MIN(E.SALARY), AVG(E.SALARY)
FROM EMPLOYEE E, DEPARTMENT D 
WHERE E.DNO=D.DNO
AND D.DNAME='ACCOUNTS';


-- QUERY 4
## Retrieve the name of each employee who works on all the projects controlled by department number 5 (use NOT EXISTS operator). 
SELECT E.FNAME , E.LNAME
FROM EMPLOYEE E
WHERE NOT EXISTS (
  SELECT PNo FROM PROJECT WHERE DNo=5 AND PNo NOT IN (
    SELECT PNo FROM WORKS_ON W JOIN DEPARTMENT D ON W.SSN = E.SSN WHERE D.DNo = 5
  )
);

-- QUERY 5
## For each department that has more than five employees, retrieve the department number and the 
## number of its employees who are making more than Rs. 6,00,000.
SELECT D.DNO, COUNT(*)
FROM DEPARTMENT D, EMPLOYEE E
WHERE D.DNO = E.DNO AND E.SALARY > 600000
AND D.DNO IN 
	(SELECT E1.DNO
	FROM EMPLOYEE E1
	GROUP BY E1.DNO
	HAVING COUNT(*) > 5)
GROUP BY D.DNO;