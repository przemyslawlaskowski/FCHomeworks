/* 1.Create tables `employees`, `projects`, and `assignments` with appropriate constraints and keys.
employees

employee_id
 first_name
 last_name
 department_id
 salary
projects

project_id
project_name
start_date
assignments

assignment_id
employee_id
project_id
start_date
*/

CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department_id INT,
    salary DECIMAL(10, 2)
);

CREATE TABLE projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    project_name VARCHAR(100) NOT NULL,
    start_date DATE
);

CREATE TABLE assignments (
    assignment_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    project_id INT,
    start_date DATE,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);


-- 2.Insert sample data into these tables

INSERT INTO employees (first_name, last_name, department_id, salary) VALUES
('John', 'Doe', 1, 50000),
('Jane', 'Smith', 2, 60000),
('Mike', 'Johnson', 1, 55000),
('Emily', 'Brown', 3, 65000),
('David', 'Lee', 2, 58000);

INSERT INTO projects (project_name, start_date) VALUES
('Project A', '2023-01-01'),
('Project B', '2023-02-15'),
('Project C', '2023-03-30');

INSERT INTO assignments (employee_id, project_id, start_date) VALUES
(1, 1, '2023-01-05'),
(2, 1, '2023-01-10'),
(3, 2, '2023-02-20'),
(4, 2, '2023-02-25'),
(5, 3, '2023-04-01'),
(1, 3, '2023-04-05'),
(2, 2, '2023-03-01');


-- 3. Retrieve all employees and their assigned projects

SELECT e.employee_id, e.first_name, e.last_name, p.project_name
FROM employees e
JOIN assignments a ON e.employee_id = a.employee_id
JOIN projects p ON a.project_id = p.project_id;


-- 4. Count the number of employees assigned to each project

SELECT p.project_id, p.project_name, COUNT(DISTINCT a.employee_id) as employee_count
FROM projects p
LEFT JOIN assignments a ON p.project_id = a.project_id
GROUP BY p.project_id, p.project_name;


-- 5. Calculate the average salary of employees assigned to each project

SELECT p.project_id, p.project_name, AVG(e.salary) as avg_salary
FROM projects p
JOIN assignments a ON p.project_id = a.project_id
JOIN employees e ON a.employee_id = e.employee_id
GROUP BY p.project_id, p.project_name;


-- 6. List projects with assignment start dates for each employee

SELECT p.project_name, e.first_name, e.last_name, a.start_date
FROM projects p
JOIN assignments a ON p.project_id = a.project_id
JOIN employees e ON a.employee_id = e.employee_id
ORDER BY p.project_name, a.start_date;


-- 7. Identify projects with more than a certain number of assignments
SELECT p.project_id, p.project_name, COUNT(a.assignment_id) as assignment_count
FROM projects p
JOIN assignments a ON p.project_id = a.project_id
GROUP BY p.project_id, p.project_name
HAVING COUNT(a.assignment_id) > 2;
