-- 1. Identify Students with the Highest Number of Enrollments
WITH StudentEnrollments AS (
    SELECT 
        s.student_id,
        s.first_name,
        s.last_name,
        COUNT(e.enrollment_id) AS enrollment_count
    FROM 
        students s
    JOIN 
        enrollments e ON s.student_id = e.student_id
    GROUP BY 
        s.student_id, s.first_name, s.last_name
)
SELECT 
    student_id, 
    first_name, 
    last_name, 
    enrollment_count
FROM 
    StudentEnrollments
WHERE 
    enrollment_count = (SELECT MAX(enrollment_count) FROM StudentEnrollments);

   
-- 2. Calculate Percentage of Enrollments for Each Course
WITH CourseEnrollments AS (
    SELECT 
        c.course_id,
        c.course_name,
        COUNT(e.enrollment_id) AS enrollment_count
    FROM 
        courses c
    LEFT JOIN 
        enrollments e ON c.course_id = e.course_id
    GROUP BY 
        c.course_id, c.course_name
),
TotalEnrollments AS (
    SELECT SUM(enrollment_count) AS total_count FROM CourseEnrollments
)
SELECT 
    ce.course_id,
    ce.course_name,
    ce.enrollment_count,
    (ce.enrollment_count * 100.0 / te.total_count) AS enrollment_percentage
FROM 
    CourseEnrollments ce, TotalEnrollments te;

   
-- 3. Identify Courses with the Highest Number of Enrollments
WITH CourseEnrollments AS (
    SELECT 
        c.course_id,
        c.course_name,
        COUNT(e.enrollment_id) AS enrollment_count
    FROM 
        courses c
    LEFT JOIN 
        enrollments e ON c.course_id = e.course_id
    GROUP BY 
        c.course_id, c.course_name
)
SELECT 
    course_id, 
    course_name, 
    enrollment_count
FROM 
    CourseEnrollments
WHERE 
    enrollment_count = (SELECT MAX(enrollment_count) FROM CourseEnrollments);

   
-- 4. Calculate Total Scores for Students in Each Course (Assuming a 'scores' table exists)
WITH StudentScores AS (
    SELECT 
        e.student_id,
        e.course_id,
        SUM(s.score) AS total_score -- Assuming 'score' is a column in 'scores' table.
    FROM 
        enrollments e
    JOIN 
        scores s ON e.student_id = s.student_id AND e.course_id = s.course_id -- Join on both student and course IDs.
    GROUP BY 
        e.student_id, e.course_id
)
SELECT 
    student_id,
    course_id,
    total_score
FROM 
    StudentScores;

   
-- 5. Create a Transaction to Add a New Student and Their Enrollment in a Course
START TRANSACTION;

-- Insert new student data.
INSERT INTO students (first_name, last_name, date_of_birth, email) VALUES ('Bill', 'Anderson', '2003-01-01', 'new.student@mail.com');

-- Get the last inserted student ID.
SET @new_student_id = LAST_INSERT_ID();

-- Insert enrollment for the new student in a specific course (e.g., course ID 1).
INSERT INTO enrollments (student_id, course_id, enrollment_date) VALUES (@new_student_id, 1, CURDATE());

COMMIT;
