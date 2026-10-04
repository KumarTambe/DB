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