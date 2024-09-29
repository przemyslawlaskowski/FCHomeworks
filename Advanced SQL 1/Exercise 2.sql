-- 1.Create a transaction that attempts to add a new course but fails due to a primary key violation (a course with the same name already exists). Apply rollback transaction in case of error.

START TRANSACTION;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
    ROLLBACK;
END;

INSERT INTO courses (course_name, course_description) 
VALUES ('Mathematics', 'Duplicate course description.');

COMMIT;


-- 2.Create a stored procedure that returns all courses a given student is enrolled in.

DELIMITER //

CREATE PROCEDURE GetCoursesByStudent(IN studentId INT)
BEGIN
    SELECT 
        c.course_id,
        c.course_name,
        c.course_description
    FROM 
        courses c
    JOIN 
        enrollments e ON c.course_id = e.course_id
    WHERE 
        e.student_id = studentId;
END //

DELIMITER ;


-- 3.Create a stored procedure that updates the enrollment date for a specific student in a specified course.

DELIMITER //

CREATE PROCEDURE UpdateEnrollmentDate(IN studentId INT, IN courseId INT, IN newDate DATE)
BEGIN
    UPDATE enrollments 
    SET enrollment_date = newDate 
    WHERE student_id = studentId AND course_id = courseId;
END //

DELIMITER ;


-- 4.Create a stored procedure that removes a student from all courses they are enrolled in.

DELIMITER //

CREATE PROCEDURE RemoveStudentFromAllCourses(IN studentId INT)
BEGIN
    DELETE FROM enrollments 
    WHERE student_id = studentId;
END //

DELIMITER ;

-- 5.Create a transaction that adds a new course and updates the description of an existing course. Commit the transaction only if both operations are successful.

START TRANSACTION;


DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
    ROLLBACK;
END;

INSERT INTO courses (course_name, course_description) 
VALUES ('Astronomy', 'Description.');

UPDATE courses 
SET course_description = 'Updated description' 
WHERE course_name = 'Mathematics';

COMMIT;
