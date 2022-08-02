# Pewlett-Hackard-Analysis

## Project OverView
In this project, we learn about data modeling, engineering, and analysis. Applying our knowledge of DataFrames and tabular data, we create entity relationship diagrams (ERDs), import data into a database, troubleshoot common errors, and create queries that use data to answer questions using SQL techniques.

### Challenge
A company's baby boomer cohort will be retiring at a rapid rate. The company wants to 
who would be retiring in the next few years, who would meet the criteria for retirement packages
and how many positions will come available as a result. The database analysis will future proof 
the company by generating a list of all employees getting ready to retire, who is eligible for the retirement package and retirees       who could be potential mentors and a resource for the company. 

### APPROACH
* Use an ERD to understand relationships between SQL tables.
* Create new tables in pgAdmin by using different joins.
* Write basic- to intermediate-level SQL statements.
* Export new tables to a CSV file.

### RESULTS
The following are the findings from the database analysis:   
* Number of Individuals retiring: 443,308
* Number of Individuals being hired: 32,860
* Number of individuals available for mentorship role:2382
             

![ERD](EmployeeDB.png)


-----------------------------------CODE (Code for the requested queries, with examples of each output)----------------------

-----------------------Get a list of current employees eligible for retirement,including thieir most recent titles----------

SELECT e.emp_no, e.first_name, e.last_name, 
	t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

SELECT * FROM retirement_titles;

EXAMPLES OF EACH OUTPUT
![retirees](retirement_titles_output.PNG)

-------------------------------- Unique &  Most Recent Titles Use Partitioning-------------------------------------------------
	Get the final list with recent titles, by partitioning the data so that each employee is only included on the list once.

SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no,title DESC;

SELECT * FROM unique_titles;


EXAMPLES OF EACH OUTPUT
![unique](unique_titles_output.PNG)

----------------------------------------------- Aggregate Level--------------------------------------------------------------------
	In descending order (by date), list the frequency count of employee titles (i.e., how many employees share the same title?)


SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count(emp_no) DESC;

SELECT * FROM retiring_titles;

EXAMPLES OF EACH OUTPUT
![retirees_emp](retiring_titles_output.PNG)

----------------------------------------------------Mentorship----------------------------------------------------------------------
				Should return the potential mentor’s


SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date,
	d.from_date, d.to_date, t.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS d
ON e.emp_no = d.emp_no
INNER JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE d.to_date = '9999-01-01' AND e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY e.emp_no;

SELECT * FROM mentorship_eligibility;

EXAMPLES OF EACH OUTPUT
![Mentor](mentorship_output.PNG)

### THINGS LEARNED
* Designing an ERD that applies to the data.
* Creating and using a SQL database.
* Importing and exporting large CSV datasets into pgAdmin.
* Practice using different joins to create new tables in pgAdmin.
* Writing basic- to intermediate-level SQL statements.

### SOFTWARE/TOOLS
Postgres, pgAdmin

### RECOMMENDATION FOR FURTHER ANALYSIS 
Further analysis of this data set could involve querying for a list of eligible retirees per department by title by date.
