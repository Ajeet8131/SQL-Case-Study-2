Create database caseStudy2
CREATE TABLE LOCATION (
  Location_ID INT PRIMARY KEY,
  City VARCHAR(50)
);

INSERT INTO LOCATION (Location_ID, City)
VALUES (122, 'New York'),
       (123, 'Dallas'),
       (124, 'Chicago'),
       (167, 'Boston');


  CREATE TABLE DEPARTMENT (
  Department_Id INT PRIMARY KEY,
  Name VARCHAR(50),
  Location_Id INT,
  FOREIGN KEY (Location_Id) REFERENCES LOCATION(Location_ID)
);


INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id)
VALUES (10, 'Accounting', 122),
       (20, 'Sales', 124),
       (30, 'Research', 123),
       (40, 'Operations', 167);

	   CREATE TABLE JOB (
  Job_ID INT PRIMARY KEY,
  Designation VARCHAR(50)
);

INSERT  INTO JOB VALUES
(667, 'CLERK'),
(668,'STAFF'),
(669,'ANALYST'),
(670,'SALES_PERSON'),
(671,'MANAGER'),
(672, 'PRESIDENT')


CREATE TABLE EMPLOYEE
(EMPLOYEE_ID INT,
LAST_NAME VARCHAR(20),
FIRST_NAME VARCHAR(20),
MIDDLE_NAME CHAR(1),
JOB_ID INT FOREIGN KEY
REFERENCES JOB(JOB_ID),
MANAGER_ID INT,
HIRE_DATE DATE,
SALARY INT,
COMM INT,
DEPARTMENT_ID  INT FOREIGN KEY
REFERENCES DEPARTMENT(DEPARTMENT_ID))

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','JOHN','Q',667,7902,'17-DEC-84',800,NULL,20),
(7499,'ALLEN','KEVIN','J',670,7698,'20-FEB-84',1600,300,30),
(7505,'DOYLE','JEAN','K',671,7839,'04-APR-85',2850,NULl,30),
(7506,'DENNIS','LYNN','S',671,7839,'15-MAY-85',2750,NULL,30),
(7507,'BAKER','LESLIE','D',671,7839,'10-JUN-85',2200,NULL,40),
(7521,'WARK','CYNTHIA','D',670,7698,'22-FEB-85',1250,500,30)

--List all the employee details.
SELECT * FROM EMPLOYEE;

--List all the department details.
SELECT * FROM DEPARTMENT;

--List all job details.
SELECT * FROM JOB;

--List all the locations.
SELECT * FROM LOCATION;

--List out the First Name, Last Name, Salary, and Commission for all Employees.
SELECT FIRST_NAME, LAST_NAME, SALARY, COMM FROM EMPLOYEE;

--List out the Employee ID, Last Name, Department ID for all employees and alias:
SELECT EMPLOYEE_ID AS "ID of the Employee", 
       LAST_NAME AS "Name of the Employee", 
       DEPARTMENT_ID AS "Dep_id" 
FROM EMPLOYEE;

--List out the annual salary of the employees with their names only.
SELECT FIRST_NAME, LAST_NAME, (SALARY * 12) AS "Annual Salary" 
FROM EMPLOYEE;

--List the details about "Smith".
SELECT * FROM EMPLOYEE WHERE LAST_NAME = 'SMITH';

--List out the employees who are working in department 20.
SELECT * FROM EMPLOYEE WHERE DEPARTMENT_ID = 20;

--List out the employees who are earning salary between 2000 and 3000.
SELECT * FROM EMPLOYEE WHERE SALARY BETWEEN 2000 AND 3000;

--List out the employees who are working in department 10 or 20.
SELECT * FROM EMPLOYEE WHERE DEPARTMENT_ID IN (10, 20);

--Find out the employees who are not working in department 10 or 30.
SELECT * FROM EMPLOYEE WHERE DEPARTMENT_ID NOT IN (10, 30);

--List out the employees whose name starts with 'L'.
SELECT * FROM EMPLOYEE WHERE FIRST_NAME LIKE 'L%';

--List out the employees whose name starts with 'L' and ends with 'E'.
SELECT * FROM EMPLOYEE WHERE FIRST_NAME LIKE 'L%E';

--List out the employees whose name length is 4 and starts with 'J'.
SELECT * FROM EMPLOYEE WHERE FIRST_NAME LIKE 'J___';

--List out the employees who are working in department 30 and draw salaries more than 2500.
SELECT * FROM EMPLOYEE WHERE DEPARTMENT_ID = 30 AND SALARY > 2500;

--List out the employees who are not receiving commission.
SELECT * FROM EMPLOYEE WHERE COMM IS NULL;

--List out the Employee ID and Last Name in ascending order based on the Employee ID.
SELECT EMPLOYEE_ID, LAST_NAME 
FROM EMPLOYEE 
ORDER BY EMPLOYEE_ID ASC;

--List out the Employee ID and Name in descending order based on salary.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME 
FROM EMPLOYEE 
ORDER BY SALARY DESC;

--List out the employee details according to their Last Name in ascending order.
SELECT * 
FROM EMPLOYEE 
ORDER BY LAST_NAME ASC;

--List out the employee details according to their Last Name in ascending order and then Department ID in descending order.
SELECT * 
FROM EMPLOYEE 
ORDER BY LAST_NAME ASC, DEPARTMENT_ID DESC;

--List out the department-wise maximum salary, minimum salary, and average salary of the employees.
SELECT DEPARTMENT_ID, 
       MAX(SALARY) AS Max_Salary, 
       MIN(SALARY) AS Min_Salary, 
       AVG(SALARY) AS Avg_Salary
FROM EMPLOYEE
GROUP BY DEPARTMENT_ID;

--List out the job-wise maximum salary, minimum salary, and average salary of the employees.
SELECT JOB_ID, 
       MAX(SALARY) AS Max_Salary, 
       MIN(SALARY) AS Min_Salary, 
       AVG(SALARY) AS Avg_Salary
FROM EMPLOYEE
GROUP BY JOB_ID;

--List out the number of employees who joined each month in ascending order.
SELECT DATEPART(MONTH, HIRE_DATE) AS Month, COUNT(*) AS Employee_Count
FROM EMPLOYEE
GROUP BY DATEPART(MONTH, HIRE_DATE)
ORDER BY Month ASC;

--List out the number of employees for each month and year in ascending order based on the year and month.
SELECT DATEPART(YEAR, HIRE_DATE) AS Year, 
       DATEPART(MONTH, HIRE_DATE) AS Month, 
       COUNT(*) AS Employee_Count
FROM EMPLOYEE
GROUP BY DATEPART(YEAR, HIRE_DATE), DATEPART(MONTH, HIRE_DATE)
ORDER BY Year ASC, Month ASC;

--5. List out the Department ID having at least four employees.
SELECT DEPARTMENT_ID, COUNT(*) AS Employee_Count
FROM EMPLOYEE
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 4;

--6. How many employees joined in February month?
SELECT COUNT(*) AS Employee_Count
FROM EMPLOYEE
WHERE DATEPART(MONTH, HIRE_DATE) = 2;

--7. How many employees joined in May or June month?
SELECT COUNT(*) AS Employee_Count
FROM EMPLOYEE
WHERE DATEPART(MONTH, HIRE_DATE) IN (5, 6);

--8. How many employees joined in 1985?
SELECT COUNT(*) AS Employee_Count
FROM EMPLOYEE
WHERE DATEPART(YEAR, HIRE_DATE) = 1985;

--9. How many employees joined each month in 1985?
SELECT DATEPART(MONTH, HIRE_DATE) AS Month, COUNT(*) AS Employee_Count
FROM EMPLOYEE
WHERE DATEPART(YEAR, HIRE_DATE) = 1985
GROUP BY DATEPART(MONTH, HIRE_DATE)
ORDER BY Month ASC;

--10. How many employees were joined in April 1985?
SELECT COUNT(*) AS Employee_Count
FROM EMPLOYEE
WHERE DATEPART(MONTH, HIRE_DATE) = 4 AND DATEPART(YEAR, HIRE_DATE) = 1985;

--11. Which is the Department ID having greater than or equal to 3 employees joining in April 1985?
SELECT DEPARTMENT_ID, COUNT(*) AS Employee_Count
FROM EMPLOYEE
WHERE DATEPART(MONTH, HIRE_DATE) = 4 AND DATEPART(YEAR, HIRE_DATE) = 1985
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 3;

--1. List out employees with their department names.
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.LAST_NAME, D.Name AS Department_Name
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id;

--2. Display employees with their designations.
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.LAST_NAME, J.Designation
FROM EMPLOYEE E
JOIN JOB J ON E.JOB_ID = J.Job_ID;

--3. Display the employees with their department names and city.
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.LAST_NAME, D.Name AS Department_Name, L.City
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
JOIN LOCATION L ON D.Location_Id = L.Location_ID;

--4. How many employees are working in different departments? Display with department names.
SELECT D.Name AS Department_Name, COUNT(E.EMPLOYEE_ID) AS Employee_Count
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
GROUP BY D.Name;

--5. How many employees are working in the sales department?
SELECT COUNT(E.EMPLOYEE_ID) AS Employee_Count
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
WHERE D.Name = 'Sales';

--6. Which is the department having greater than or equal to 3 employees and display the department names in ascending order.
SELECT D.Name AS Department_Name, COUNT(E.EMPLOYEE_ID) AS Employee_Count
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
GROUP BY D.Name
HAVING COUNT(E.EMPLOYEE_ID) >= 3
ORDER BY D.Name ASC;

--7. How many employees are working in 'Dallas'?
SELECT COUNT(E.EMPLOYEE_ID) AS Employee_Count
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
JOIN LOCATION L ON D.Location_Id = L.Location_ID
WHERE L.City = 'Dallas';

--8. Display all employees in sales or operation departments.
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.LAST_NAME, D.Name AS Department_Name
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
WHERE D.Name IN ('Sales', 'Operations');

--1. Display the employee details with salary grades. Use a conditional statement to create a grade column.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY,
    CASE
        WHEN SALARY >= 5000 THEN 'A'
        WHEN SALARY >= 3000 AND SALARY < 5000 THEN 'B'
        WHEN SALARY >= 2000 AND SALARY < 3000 THEN 'C'
        WHEN SALARY < 2000 THEN 'D'
        ELSE 'No Grade'
    END AS Salary_Grade
FROM EMPLOYEE;

--2. List out the number of employees grade-wise. Use a conditional statement to create a grade column.
SELECT 
    CASE
        WHEN SALARY >= 5000 THEN 'A'
        WHEN SALARY >= 3000 AND SALARY < 5000 THEN 'B'
        WHEN SALARY >= 2000 AND SALARY < 3000 THEN 'C'
        WHEN SALARY < 2000 THEN 'D'
        ELSE 'No Grade'
    END AS Salary_Grade,
    COUNT(*) AS Employee_Count
FROM EMPLOYEE
GROUP BY 
    CASE
        WHEN SALARY >= 5000 THEN 'A'
        WHEN SALARY >= 3000 AND SALARY < 5000 THEN 'B'
        WHEN SALARY >= 2000 AND SALARY < 3000 THEN 'C'
        WHEN SALARY < 2000 THEN 'D'
        ELSE 'No Grade'
    END;

--3. Display the employee salary grades and the number of employees between 2000 to 5000 range of salary.
SELECT 
    CASE
        WHEN SALARY >= 5000 THEN 'A'
        WHEN SALARY >= 3000 AND SALARY < 5000 THEN 'B'
        WHEN SALARY >= 2000 AND SALARY < 3000 THEN 'C'
    END AS Salary_Grade,
    COUNT(*) AS Employee_Count
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000 AND 5000
GROUP BY 
    CASE
        WHEN SALARY >= 5000 THEN 'A'
        WHEN SALARY >= 3000 AND SALARY < 5000 THEN 'B'
        WHEN SALARY >= 2000 AND SALARY < 3000 THEN 'C'
    END;

--1. Display the employees list who got the maximum salary.
SELECT * 
FROM EMPLOYEE
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE);

--2. Display the employees who are working in the sales department.
SELECT * 
FROM EMPLOYEE
WHERE DEPARTMENT_ID = (SELECT Department_Id FROM DEPARTMENT WHERE Name = 'Sales');

--3. Display the employees who are working as 'Clerk'.
SELECT * 
FROM EMPLOYEE
WHERE JOB_ID = (SELECT Job_ID FROM JOB WHERE Designation = 'CLERK');

--4. Display the list of employees who are living in 'Boston'.
SELECT * 
FROM EMPLOYEE
WHERE DEPARTMENT_ID IN 
   (SELECT Department_Id FROM DEPARTMENT WHERE Location_Id = 
      (SELECT Location_ID FROM LOCATION WHERE City = 'Boston'));

--5. Find out the number of employees working in the sales department.
SELECT COUNT(*) AS Employee_Count 
FROM EMPLOYEE
WHERE DEPARTMENT_ID = (SELECT Department_Id FROM DEPARTMENT WHERE Name = 'Sales');

--6. Update the salaries of employees who are working as clerks on the basis of 10%.
UPDATE EMPLOYEE
SET SALARY = SALARY * 1.10
WHERE JOB_ID = (SELECT Job_ID FROM JOB WHERE Designation = 'CLERK');

--7. Display the second highest salary drawing employee details.
SELECT * 
FROM EMPLOYEE
WHERE SALARY = (SELECT MAX(SALARY) 
                FROM EMPLOYEE 
                WHERE SALARY < (SELECT MAX(SALARY) FROM EMPLOYEE));

--8. List out the employees who earn more than every employee in department 30.
SELECT * 
FROM EMPLOYEE
WHERE SALARY > (SELECT MAX(SALARY) FROM EMPLOYEE WHERE DEPARTMENT_ID = 30);

--9. Find out which department has no employees.
SELECT Name 
FROM DEPARTMENT 
WHERE Department_Id NOT IN (SELECT DISTINCT DEPARTMENT_ID FROM EMPLOYEE);

--10. Find out the employees who earn greater than the average salary for their department.
SELECT * 
FROM EMPLOYEE E
WHERE SALARY > (SELECT AVG(SALARY) 
                FROM EMPLOYEE 
                WHERE DEPARTMENT_ID = E.DEPARTMENT_ID);
