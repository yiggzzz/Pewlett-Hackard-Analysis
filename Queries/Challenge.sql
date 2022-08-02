-- Deliverable 1: The Number of Retiring Employees by Title

SELECT emp_no, first_name, last_name FROM employees;

SELECT title, from_date, to_date FROM titles;

SELECT e.emp_no, e.first_name, e.last_name, 
	t.title, t.from_date, t.to_date
INTO retir_titles
FROM employees AS e
INNER JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

SELECT * FROM retir_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO uniq_titles
FROM retir_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no,title DESC;

SELECT * FROM uniq_titles;

--retrieve the number of employees by their most recent job title who are about to retire.
SELECT COUNT(title), title
INTO retiringg_titles
FROM uniq_titles
GROUP BY title
ORDER BY count(emp_no) DESC;

SELECT * FROM retiringg_titles;


-- Deliverable 2: The Employees Eligible for the Mentorship Program
-- create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program
SELECT emp_no, first_name, last_name, birth_date 
FROM employees;

SELECT emp_no, from_date, to_date
FROM dept_emp;

SELECT emp_no, title FROM titles;

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