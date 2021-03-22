CREATE DATABASE IF NOT EXISTS scratch;

USE scratch;

CREATE TABLE IF NOT EXISTS country
(
    country_id   VARCHAR(2),
    country_name VARCHAR(40),
    region_id    DECIMAL(10, 0)
);

DESCRIBE country;

INSERT INTO country
VALUES ('IN', 'India', 1);

SELECT *
FROM country;

INSERT INTO country (country_id, country_name)
VALUES ('AU', 'Australia');

INSERT INTO country (country_id, country_name, region_id)
VALUES ('NZ', 'New Zealand', NULL);

INSERT INTO country (country_id, country_name, region_id)
VALUES ('UK', 'United Kingdom', 2),
       ('GR', 'Germany', 3),
       ('JP', 'Japan', 4);

CREATE TABLE IF NOT EXISTS employee
(
    employee_id   DECIMAL(10, 0) PRIMARY KEY,
    first_name    VARCHAR(20)    NOT NULL,
    last_name     VARCHAR(20),
    email         varchar(20),
    phone_number  DECIMAL(10, 0),
    hire_date     DATE,
    job_title     VARCHAR(30)    NOT NULL,
    department_id DECIMAL(10, 0) NOT NULL,
    salary        DECIMAL(10, 2),
    commission    DECIMAL(10, 2) DEFAULT 0.00
);

DESCRIBE employee;

INSERT INTO employee (employee_id, first_name, last_name, email, phone_number, hire_date, job_title, department_id,
                      salary)
VALUES (100, 'Steven', 'King', 'SKING', 5151234567, '1987-06-17', 'President', 10, 24000.00),
       (101, 'Neena', 'Kochhar', 'NKOCHHAR', 5151234568, '1987-06-18', 'Vice-President', 10, 17000.00),
       (102, 'Lex', 'De Haan', 'LDEHAAN', 5151234569, '1987-06-19', 'Vice President', 20, 17000.00),
       (103, 'Alexander', 'Hunold', 'AHUNOLD', 5904234567, '1987-06-20', 'Programmer', 50, 15000.00),
       (104, 'Bruce', 'Ernst', 'BERNST', 5904234568, '1987-06-21', 'Programmer', 50, 6000.00),
       (105, 'David', 'Austin', 'DAUSTIN', 5904234569, '1987-06-22', 'Shipping Clerk', 10, 4000.00),
       (106, 'Valli', 'Pataballa', 'VPATABAL', 5904234560, '1987-06-23', 'Programmer', 50, 4000.00),
       (107, 'Amit', 'Tandon', 'ATANDON', 5904234565, '1987-06-24', 'Manager', 20, 14000.00);

SELECT *
FROM employee;

SELECT first_name AS 'First Name', last_name AS 'Last Name'
FROM employee;

SELECT DISTINCT department_id AS 'Department ID'
FROM employee;

SELECT *
FROM employee
ORDER BY first_name DESC;

SELECT first_name, last_name, salary
FROM employee;

SELECT employee_id, CONCAT(first_name, ' ', last_name) AS 'Name', salary
FROM employee
ORDER BY salary;

SELECT SUM(salary) AS 'Total Salaries Payable'
from employee;

SELECT MAX(salary) AS 'Maximum Salary', MIN(salary) AS 'Minimum Salary'
FROM employee;

SELECT ROUND(AVG(salary), 2) AS 'Average Salary', COUNT(*) AS 'Number of Employees'
FROM employee;

SELECT COUNT(*) AS 'Number of Employees'
FROM employee;

SELECT COUNT(DISTINCT job_title) AS 'Number of Jobs Available'
FROM employee;

SELECT CONCAT(first_name, ' ', last_name) AS 'Employee Name', ROUND(salary, 2) AS 'Monthly Salary'
FROM employee;

SELECT first_name, last_name, salary
FROM employee
WHERE salary NOT BETWEEN 10000 AND 15000;

SELECT first_name, last_name, department_id
FROM employee
ORDER BY first_name, last_name, department_id;

SELECT CONCAT(first_name, ' ', last_name) AS 'Name', salary AS 'Salary'
FROM employee
WHERE (salary NOT BETWEEN 10000 AND 15000)
  AND department_id = 50;

SELECT last_name, job_title, salary
FROM employee
WHERE job_title IN ('Programmer', 'Shipping Clerk')
  AND salary <> 15000;

SELECT DISTINCT job_title AS 'Available Jobs'
FROM employee;

CREATE TABLE IF NOT EXISTS student
(
    roll_number DECIMAL(5, 0) PRIMARY KEY,
    name        VARCHAR(50) NOT NULL,
    address     VARCHAR(100),
    phone       DECIMAL(10, 0),
    age         DECIMAL(2, 0)
);

DESCRIBE student;

INSERT INTO student
VALUES (1, 'Harsh', 'Delhi', 5151234569, 18),
       (2, 'Pratik', 'Bihar', 5151234568, 19),
       (3, 'Riyanka', 'Siliguri', 5151234567, 20),
       (4, 'Deep', 'Ramnagar', 5151234566, 18),
       (5, 'Saptarhi', 'Kolkata', 5151234565, 19),
       (6, 'Dhanraj', 'Raipur', 5151234564, 20),
       (7, 'Rohit', 'Balurghat', 5151234563, 18),
       (8, 'Niraj', 'Alipur', 5151234562, 19);

SELECT *
FROM student
ORDER BY roll_number;

SELECT *
FROM student
ORDER BY age, roll_number DESC;
