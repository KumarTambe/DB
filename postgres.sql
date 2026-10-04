-- TABLE SETUP
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    branch VARCHAR(50),
    cgpa DECIMAL(3,1),
    city VARCHAR(50),
    is_placed BOOLEAN DEFAULT FALSE
);

CREATE TABLE placements (
    id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(id),
    company VARCHAR(100),
    salary INT,
    placed_on DATE
);



-- =============================================
-- DAY 1 — SELECT, WHERE, ORDER BY, LIMIT, INSERT, UPDATE, DELETE
-- =============================================

-- SELECT
SELECT * FROM students;
SELECT name, cgpa FROM students;
SELECT name, cgpa AS score FROM students;

-- WHERE
SELECT * FROM students WHERE cgpa > 7.5;
SELECT * FROM students WHERE branch = 'MCA';
SELECT * FROM students WHERE cgpa > 7 AND is_placed = FALSE;
SELECT * FROM students WHERE city = 'Mumbai' OR city = 'Pune';
SELECT * FROM students WHERE branch IN ('MCA', 'Btech', 'MBA');
SELECT * FROM students WHERE name LIKE 'K%';
SELECT * FROM students WHERE name LIKE '%kumar%';
SELECT * FROM students WHERE cgpa BETWEEN 7.0 AND 9.0;
SELECT * FROM students WHERE city IS NULL;
SELECT * FROM students WHERE city IS NOT NULL;

-- ORDER BY
SELECT * FROM students ORDER BY cgpa DESC;
SELECT * FROM students ORDER BY name ASC;
SELECT * FROM students ORDER BY cgpa DESC, name ASC;

-- LIMIT and OFFSET
SELECT * FROM students LIMIT 5;
SELECT * FROM students LIMIT 5 OFFSET 10;

-- INSERT
INSERT INTO students (name, branch, cgpa, city)
VALUES ('Kumar', 'MCA', 8.5, 'Mumbai');

INSERT INTO students (name, branch, cgpa, city)
VALUES 
    ('Prasad', 'Btech', 7.2, 'Pune'),
    ('Tanmay', 'MCA', 9.0, 'Mumbai');

-- UPDATE
UPDATE students SET cgpa = 9.0 WHERE id = 1;
UPDATE students SET cgpa = 9.0, city = 'Pune' WHERE name = 'Kumar';

-- DELETE
DELETE FROM students WHERE id = 1;
DELETE FROM students WHERE is_placed = TRUE;


-- =============================================
-- DAY 2 — AGGREGATES, GROUP BY, HAVING, JOINS
-- =============================================

-- AGGREGATES
SELECT COUNT(*) FROM students;
SELECT COUNT(city) FROM students;
SELECT AVG(cgpa) FROM students;
SELECT MAX(cgpa) FROM students;
SELECT MIN(cgpa) FROM students;
SELECT SUM(cgpa) FROM students;

-- GROUP BY
SELECT branch, COUNT(*) FROM students GROUP BY branch;
SELECT branch, AVG(cgpa) FROM students GROUP BY branch;
SELECT city, COUNT(*) FROM students WHERE is_placed = TRUE GROUP BY city;

-- HAVING
SELECT branch, COUNT(*) FROM students GROUP BY branch HAVING COUNT(*) > 5;
SELECT branch, AVG(cgpa) FROM students GROUP BY branch HAVING AVG(cgpa) > 7.5;

-- JOINS
-- INNER JOIN
SELECT s.name, p.company, p.salary
FROM students s
INNER JOIN placements p ON s.id = p.student_id;

-- LEFT JOIN
SELECT s.name, p.company
FROM students s
LEFT JOIN placements p ON s.id = p.student_id;

-- RIGHT JOIN
SELECT s.name, p.company
FROM students s
RIGHT JOIN placements p ON s.id = p.student_id;

-- FULL OUTER JOIN
SELECT s.name, p.company
FROM students s
FULL OUTER JOIN placements p ON s.id = p.student_id;

-- JOIN with WHERE and ORDER BY
SELECT s.name, p.company, p.salary
FROM students s
INNER JOIN placements p ON s.id = p.student_id
WHERE p.salary > 50000
ORDER BY p.salary DESC;

-- Unplaced students
SELECT s.name FROM students s
LEFT JOIN placements p ON s.id = p.student_id
WHERE p.company IS NULL;

-- Average salary per branch
SELECT s.branch, AVG(p.salary)
FROM students s
INNER JOIN placements p ON s.id = p.student_id
GROUP BY s.branch;

-- Companies with more than 1 placement
SELECT company, COUNT(student_id)
FROM placements
GROUP BY company
HAVING COUNT(student_id) > 1;


-- =============================================
-- DAY 3 — SUBQUERIES AND CASE
-- =============================================

-- Subquery in WHERE
SELECT name, cgpa FROM students
WHERE cgpa > (SELECT AVG(cgpa) FROM students);

-- Subquery with IN
SELECT name FROM students
WHERE id IN (SELECT student_id FROM placements);

-- Subquery with NOT IN
SELECT name FROM students
WHERE id NOT IN (SELECT student_id FROM placements);

-- Subquery in FROM
SELECT branch, avg_cgpa
FROM (
    SELECT branch, AVG(cgpa) AS avg_cgpa
    FROM students
    GROUP BY branch
) AS branch_stats
WHERE avg_cgpa > 7.5;

-- CASE
SELECT name, cgpa,
    CASE
        WHEN cgpa >= 9 THEN 'A'
        WHEN cgpa >= 7 THEN 'B'
        WHEN cgpa >= 5 THEN 'C'
        ELSE 'D'
    END AS grade
FROM students;

-- CASE with aggregates
SELECT 
    COUNT(CASE WHEN is_placed = TRUE THEN 1 END) AS placed,
    COUNT(CASE WHEN is_placed = FALSE THEN 1 END) AS unplaced
FROM students;