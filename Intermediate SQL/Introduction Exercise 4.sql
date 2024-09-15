-- 1. Ensure tables exist (these will not recreate if they already exist)

CREATE TABLE IF NOT EXISTS employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department_id INT,
    salary DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    project_name VARCHAR(100) NOT NULL,
    start_date DATE,
    project_type VARCHAR(50)

CREATE TABLE IF NOT EXISTS assignments (
    assignment_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    project_id INT,
    start_date DATE,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);


-- 2. Insert additional sample data

INSERT INTO employees (first_name, last_name, department_id, salary) VALUES
('Sarah', 'Wilson', 3, 62000),
('Tom', 'Harris', 1, 53000),
('Lisa', 'Clark', 2, 59000);

INSERT INTO projects (project_name, start_date, project_type) VALUES
('Project D', '2023-05-01', 'Development'),
('Project E', '2023-06-15', 'Research');

INSERT INTO assignments (employee_id, project_id, start_date) VALUES
(6, 4, '2023-05-05'),
(7, 5, '2023-06-20'),
(3, 4, '2023-05-10');


-- Update existing projects with project_type

UPDATE projects SET project_type = 'Development' WHERE project_id IN (1, 2);
UPDATE projects SET project_type = 'Research' WHERE project_id = 3;


-- 3. Display all employees and their assigned projects

SELECT e.employee_id, e.first_name, e.last_name, p.project_name
FROM employees e
LEFT JOIN assignments a ON e.employee_id = a.employee_id
LEFT JOIN projects p ON a.project_id = p.project_id
ORDER BY e.employee_id, p.project_name;


-- 4. Identify employees who are not currently assigned to any project

SELECT e.employee_id, e.first_name, e.last_name
FROM employees e
LEFT JOIN assignments a ON e.employee_id = a.employee_id
WHERE a.employee_id IS NULL;


-- 5. List projects with their assigned employees, including those without employees

SELECT p.project_id, p.project_name, e.first_name, e.last_name
FROM projects p
LEFT JOIN assignments a ON p.project_id = a.project_id
LEFT JOIN employees e ON a.employee_id = e.employee_id
ORDER BY p.project_id, e.last_name, e.first_name;


-- 6. Calculate the percentage of employees assigned to each project

WITH employee_count AS (
    SELECT COUNT(*) as total FROM employees
)
SELECT 
    p.project_id, 
    p.project_name, 
    COUNT(DISTINCT a.employee_id) as assigned_employees,
    (COUNT(DISTINCT a.employee_id) * 100.0 / ec.total) as percentage
FROM 
    projects p
LEFT JOIN 
    assignments a ON p.project_id = a.project_id
CROSS JOIN 
    employee_count ec
GROUP BY 
    p.project_id, p.project_name, ec.total
ORDER BY 
    percentage DESC;


-- 7. Compare assignment statistics between different project types

SELECT 
    p.project_type,
    COUNT(DISTINCT p.project_id) as number_of_projects,
    COUNT(DISTINCT a.employee_id) as assigned_employees,
    AVG(e.salary) as average_salary
FROM 
    projects p
LEFT JOIN 
    assignments a ON p.project_id = a.project_id
LEFT JOIN 
    employees e ON a.employee_id = e.employee_id
GROUP BY 
    p.project_type
ORDER BY 
    assigned_employees DESC;
