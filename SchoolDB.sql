create schema SchoolDB;
USE SchoolDB;

-- Create Courses Table
Create Table Courses (
course_id INT AUTO_INCREMENT PRIMARY KEY,
course_name VARCHAR(100),
credits int
);

-- Create Student Table
Create Table Students (
student_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
course_id INT,
Foreign Key (course_id) References Courses(course_id)
);

-- Insert sample data into Courses
Insert into Courses (course_name, credits) Values
('Mathematics', 4),
('Computer Science', 5), 
('History', 3),
('Biology', 4);

--  Insert sample date into Students
Insert into Students (first_name, last_name, course_id) Values
('Alice', 'Smith', 1),
('Bob', 'Johnson', 2),
('Charlie', 'Brown', 2),
('Diana', 'Taylor', 3),
('Evan', 'Walker', NULL);

-- =====================================================
-- Queries Section
-- =====================================================

-- Only students that are registered for courses
Select students.student_id, students.first_name, students.last_name, courses.course_name
FROM Students 
Inner Join Courses ON students.course_id = courses.course_id;

-- Inner Join: Students with their courses
Select s.student_id, s.first_name, s.last_name, c.course_name
From Students s
Inner Join Courses c ON s.course_id = c.course_id;

-- Left Join: All students, even without courses
Select s.student_id, s.first_name, s.last_name, c.course_name
From Students s
Left Join Courses c ON s.course_id = c.course_id;

-- Right Join: All courses, even if no students enrolled
Select s.student_id, s.first_name, s.last_name, c.course_name
From Students s
Right Join Courses c ON s.course_id = c.course_id;

-- COUNT - counts the number of values in a column
-- MAX - the highest value in the column
-- MIN - the lowest value in a column
-- AVG - works out the average value in a column
-- SUM - gives you the total of a column

-- Aggregation: Count students per course
-- Group by shows the output by the course names
Select c.course_name, COUNT(s.student_id) AS num_students
From Courses c
Left Join Students s ON c.course_id = s.course_id
Group By c.course_name;

-- Aggregation: with Having: Courses with 2 or more students
-- Having is used ONLY when you uses a GROUP BY statement
Select c.course_name, COUNT(s.student_id) AS num_students
FROM Courses c
Left Join Students s ON c.course_id = s.course_id
GROUP BY c.course_name
HAVING COUNT(s.student_id) >=2;

-- Students no enrolled in any course
SELECT s.student_id, s.first_name, s.last_name
From Students s
Left Join Courses c ON s.course_id = c.course_id
WHERE s.course_id IS NULL;

-- Courses with no students
Select c.course_id, c.course_name
From Courses c
Left Join Students s ON c.course_id = s.course_id
WHERE s.student_id IS NULL;

-- Students with course credits
Select s.first_name, s.last_name, c.course_name, c.credits
FROM Students s
Inner Join Courses c ON s.course_id = c.course_id;

