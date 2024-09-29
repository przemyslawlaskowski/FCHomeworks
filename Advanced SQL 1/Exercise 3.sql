-- 1. Create a view that displays all students along with their dates of birth

CREATE VIEW StudentDetails AS
SELECT 
    student_id,
    first_name,
    last_name,
    date_of_birth
FROM 
    students;


-- 2. Create a view that shows all courses along with the number of students enrolled in each course
   
CREATE VIEW CourseEnrollments AS
SELECT 
    c.course_id,
    c.course_name,
    COUNT(e.student_id) AS num_students_enrolled
FROM 
    courses c
LEFT JOIN 
    enrollments e ON c.course_id = e.course_id
GROUP BY 
    c.course_id, c.course_name;


-- 3. Update the existing view to show only active students (those born after the year 2000)

CREATE OR REPLACE VIEW StudentDetails AS
SELECT 
    student_id,
    first_name,
    last_name,
    date_of_birth
FROM 
    students
WHERE 
    YEAR(date_of_birth) > 2000;
    
-- 4. Drop a view that is no longer needed
DROP VIEW IF EXISTS ViewName;   
