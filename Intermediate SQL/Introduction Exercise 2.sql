-- Using the data provided in the classes, complete the following exercises:
-- 1.List the last names of students who enrolled in courses before January 1, 2023, and did not enroll in any course after that date.

SELECT last_name
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM enrollments
    WHERE enrollment_date < '2023-01-01'
)
AND student_id NOT IN (
    SELECT student_id
    FROM enrollments
    WHERE enrollment_date >= '2023-01-01'
);


--2. Display the list of courses with students enrolled, grouped by the year and month of enrollment:

SELECT YEAR(enrollment_date) AS enrollment_year, MONTH(enrollment_date) AS enrollment_month, course_name
FROM enrollments
INNER JOIN students ON enrollments.student_id = students.student_id
INNER JOIN courses ON enrollments.course_id = courses.course_id
GROUP BY enrollment_year, enrollment_month, course_name;


--3. Identify and list the last names of students who have enrolled in courses only once:

SELECT last_name
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM enrollments
    GROUP BY student_id
    HAVING COUNT(*) = 1
);


--4. Display the courses that have enrollments from students in more than one age group (e.g., under 20, 20-30, over 30 years):

SELECT
    c.course_id,
    c.course_name,
    c.course_description
FROM courses c
JOIN (
    SELECT
        e.course_id
    FROM enrollments e
    JOIN (
        SELECT
            student_id,
            CASE
                WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) < 20 THEN 'Under 20'
                WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 20 AND 30 THEN '20-30'
                ELSE 'Over 30'
            END AS age_group
        FROM students
    ) AS age_groups ON e.student_id = age_groups.student_id
    GROUP BY e.course_id
    HAVING COUNT(DISTINCT age_groups.age_group) > 1
) AS filtered_courses ON c.course_id = filtered_courses.course_id;


--5. Show the number of courses students are enrolled in, sorted by the enrollment year:

SELECT 
    s.first_name,
    s.last_name,
    YEAR(e.enrollment_date) AS enrollment_year,
    COUNT(DISTINCT e.course_id) AS number_of_courses
FROM 
    students s
JOIN 
    enrollments e ON s.student_id = e.student_id
GROUP BY 
    s.student_id, s.first_name, s.last_name, YEAR(e.enrollment_date)
ORDER BY 
    enrollment_year, s.last_name, s.first_name;
