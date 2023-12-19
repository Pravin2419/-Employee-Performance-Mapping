#task 1
Create database Employee;
--------------------------------------------------
SELECT * FROM employee.emp_record_table;
SELECT * FROM employee.data_science_team;
SELECT * FROM employee.proj_table;
--------------------------------------------------------------------
#task 3
# employee details and department
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT
FROM employee.emp_record_table;

--------------------------------------------------------------------------------
#task 4
# employee details and rating based on different conditions
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
FROM employee.emp_record_table
WHERE EMP_RATING < 2 OR EMP_RATING > 4 OR (EMP_RATING >= 2 AND EMP_RATING <= 4);
----------------------------------------------------------------------------------------------------
#task 5
# Concatenate FIRST_NAME and LAST_NAME of Finance employees
SELECT CONCAT(FIRST_NAME," ", LAST_NAME) AS NAME
FROM employee.emp_record_table
WHERE DEPT = 'Finance';

------------------------------------------------------------------------------------------------------
# task 6
#List employees with direct reports and count of reporters
SELECT E1.EMP_ID, E1.FIRST_NAME, E1.LAST_NAME, E1.DEPT, COUNT(E2.EMP_ID) AS REPORTERS
FROM employee.emp_record_table E1
JOIN employee.emp_record_table E2 ON E1.EMP_ID = E2.MANAGER_ID
GROUP BY E1.EMP_ID, E1.FIRST_NAME, E1.LAST_NAME, E1.DEPT;

------------------------------------------------------------------------------------------------------------
#task 7
# List employees from healthcare and finance departments using UNION
SELECT EMP_ID, FIRST_NAME, LAST_NAME, DEPT
FROM employee.emp_record_table
WHERE DEPT = 'Healthcare'
UNION
SELECT EMP_ID, FIRST_NAME, LAST_NAME, DEPT
FROM employee.emp_record_table
WHERE DEPT = 'Finance';
-----------------------------------------------------------------------------------------------------------------------
# task 8
# List employee details grouped by department with max rating
SELECT EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT, EMP_RATING, MAX(EMP_RATING) OVER (PARTITION BY DEPT) AS MAX_RATING
FROM employee.emp_record_table;
-----------------------------------------------------------------------------------------------------------------------------------------
#task 9
#Calculate min and max salary for each role
SELECT role,  MIN(SALARY) AS MIN_SALARY, MAX(SALARY) AS MAX_SALARY
FROM employee.emp_record_table
GROUP BY ROLE;
-----------------------------------------------------------------------------------------------------------------------------------------
#task 10
# Assign ranks based on experience
SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP,
RANK() OVER (ORDER BY EXP DESC) AS EXPERIENCE_RANK
FROM employee.emp_record_table;

----------------------------------------------------------------------------------------------------------------------------------------------
#task 11
# Create a view of employees in various countries with salary more than 6000

CREATE VIEW HighSalaryEmployees AS
SELECT EMP_ID, FIRST_NAME, LAST_NAME, COUNTRY, SALARY
FROM emp_record_table
WHERE SALARY > 6000;

SELECT * FROM HighSalaryEmployees;
---------------------------------------------------------------------------------------------------------------------------------------------------
#task 12
#Nested query to find employees with experience more than 10 years
SELECT EMP_ID, FIRST_NAME, LAST_NAME
FROM employee.emp_record_table
WHERE EXP > 10;
------------------------------------------------------------------------------------------------------------------------------------------------------
#task 13
# Create a stored procedure to retrieve employees with experience more than 3 years
DELIMITER //
CREATE PROCEDURE GetExperiencedEmployees()
BEGIN
    SELECT EMP_ID, FIRST_NAME, LAST_NAME
    FROM employee.emp_record_table
    WHERE EXP > 3;
END //
DELIMITER ;
-------------------------------------------------------------------------------------------------------
#task 14
#Create a stored function to check job profile based on experience
	DELIMITER //

	CREATE FUNCTION GetJobProfile(experience_years INT) RETURNS VARCHAR(255)
	BEGIN
		DECLARE job_profile VARCHAR(255);

		IF experience_years <= 2 THEN
			SET job_profile = 'JUNIOR DATA SCIENTIST';
		ELSEIF experience_years <= 5 THEN
			SET job_profile = 'ASSOCIATE DATA SCIENTIST';
		ELSEIF experience_years <= 10 THEN
			SET job_profile = 'SENIOR DATA SCIENTIST';
		ELSEIF experience_years <= 12 THEN
			SET job_profile = 'LEAD DATA SCIENTIST';
		ELSE
			SET job_profile = 'MANAGER';
		END IF;

		RETURN job_profile;
	END //

	DELIMITER ;
    
----------------------------------------------------------------------------------------------------------------------
#task 15
# Create an index on FIRST_NAME column
CREATE INDEX idx_first_name ON employee .emp_record_table(FIRST_NAME(255));

EXPLAIN SELECT * FROM employee.emp_record_table WHERE FIRST_NAME = 'Eric';
---------------------------------------------------------------------------------------------------------------------------------------
#task 16
# Calculate bonus for all employees
SELECT EMP_ID, FIRST_NAME, LAST_NAME, SALARY, EMP_RATING, 0.05 * SALARY * EMP_RATING AS BONUS
FROM employee.emp_record_table;

----------------------------------------------------------------------------------------------------------------------------
#task 17
#Calculate average salary distribution based on continent and country
SELECT CONTINENT, COUNTRY, AVG(SALARY) AS AVG_SALARY
FROM employee.emp_record_table
GROUP BY CONTINENT, COUNTRY;

---------------------------------------------------------------------------------------------------------------------------------------