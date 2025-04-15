-- Create the Department table
CREATE TABLE Department (
    depart_id SERIAL PRIMARY KEY,
    depart_name VARCHAR(100) NOT NULL,
    depart_city VARCHAR(100) NOT NULL
);

-- Create the Roles table
CREATE TABLE Roles (
    role_id SERIAL PRIMARY KEY,
    role VARCHAR(100) NOT NULL
);

-- Create the Salaries table
CREATE TABLE Salaries (
    salary_id SERIAL PRIMARY KEY,
    salary_pa NUMERIC(10, 2) NOT NULL
);

-- Create the Overtime_Hours table
CREATE TABLE Overtime_Hours (
    overtime_id SERIAL PRIMARY KEY,
    overtime_hours INTEGER NOT NULL
);

-- Create the Employees table with foreign key constraints
CREATE TABLE Employees (
    emp_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    surname VARCHAR(100) NOT NULL,
    gender VARCHAR(10),
    address VARCHAR(255),
    email VARCHAR(100),
    depart_id INTEGER REFERENCES Department(depart_id),
    role_id INTEGER REFERENCES Roles(role_id),
    salary_id INTEGER REFERENCES Salaries(salary_id),
    overtime_id INTEGER REFERENCES Overtime_Hours(overtime_id)
);

-- Insert sample data into the Department table
INSERT INTO Department (depart_name, depart_city) VALUES
('Human Resources', 'New York'),
('Engineering', 'San Francisco'),
('Marketing', 'Los Angeles');

-- Insert sample data into the Roles table
INSERT INTO Roles (role) VALUES
('Manager'),
('Engineer'),
('Marketing Specialist');

-- Insert sample data into the Salaries table
INSERT INTO Salaries (salary_pa) VALUES
(80000.00),
(95000.00),
(70000.00);

-- Insert sample data into the Overtime_Hours table
INSERT INTO Overtime_Hours (overtime_hours) VALUES
(5),
(10),
(0);

-- Insert sample data into the Employees table
INSERT INTO Employees (first_name, surname, gender, address, email, depart_id, role_id, salary_id, overtime_id) VALUES
('Alice', 'Johnson', 'Female', '123 Main St, New York', 'alice.johnson@example.com', 1, 1, 1, 1),
('Bob', 'Smith', 'Male', '456 Elm St, San Francisco', 'bob.smith@example.com', 2, 2, 2, 2),
('Charlie', 'Brown', 'Male', '789 Pine St, Los Angeles', 'charlie.brown@example.com', 3, 3, 3, 3);

-- Verify foreign key constraints by attempting an invalid insert (This will cause an error)
-- Test constraint violation:
-- INSERT INTO Employees (first_name, surname, gender, address, email, depart_id, role_id, salary_id, overtime_id) VALUES
-- ('Invalid', 'User', 'Female', '123 Test St', 'invalid.user@example.com', 99, 99, 99, 99);
--Produces the following error;
--ERROR:  Key (depart_id)=(99) is not present in table "department".insert or update on table "employees" violates foreign key constraint "employees_depart_id_fkey"
--ERROR:  insert or update on table "employees" violates foreign key constraint "employees_depart_id_fkey"
--SQL state: 23503
--Detail: Key (depart_id)=(99) is not present in table "department".

-- Perform a LEFT JOIN to display department name, job title, salary, and overtime hours
SELECT 
    e.first_name,
    e.surname,
    d.depart_name, 
    r.role, 
    s.salary_pa, 
    o.overtime_hours
FROM Employees e
LEFT JOIN Department d ON e.depart_id = d.depart_id
LEFT JOIN Roles r ON e.role_id = r.role_id
LEFT JOIN Salaries s ON e.salary_id = s.salary_id
LEFT JOIN Overtime_Hours o ON e.overtime_id = o.overtime_id;


-- Constraint Testing Inserts

-- INVALID INSERT: All foreign keys are invalid (none of these referenced IDs exist)
-- Expected: FAIL - foreign keys (depart_id, role_id, salary_id, overtime_id) = 99 do not exist
INSERT INTO Employees (first_name, surname, gender, address, email, depart_id, role_id, salary_id, overtime_id) VALUES
('Invalid', 'User', 'Female', '123 Test St', 'invalid.user@example.com', 99, 99, 99, 99);

-- INVALID INSERT: NULL first_name (violates NOT NULL)
-- Expected: FAIL - first_name is NOT NULL
INSERT INTO Employees (first_name, surname, gender, address, email, depart_id, role_id, salary_id, overtime_id) VALUES
(NULL, 'Smith', 'Male', '101 Maple St', 'null.firstname@example.com', 1, 1, 1, 1);

-- INVALID INSERT: Invalid email format (passes unless additional constraints or regex applied)
-- Expected: SUCCESS (unless email has CHECK or pattern validation — which it doesn't here)
INSERT INTO Employees (first_name, surname, gender, address, email, depart_id, role_id, salary_id, overtime_id) VALUES
('Dan', 'Example', 'Male', '999 Fake St', 'not-an-email', 2, 2, 2, 2);

-- VALID INSERT: Unique contact with valid foreign key references
INSERT INTO Employees (first_name, surname, gender, address, email,depart_id, role_id, salary_id, overtime_id) VALUES 
('Bruce', 'Wayne', 'Male', '100 Gotham Ave, Gotham','bruce.wayne@wayneenterprises.com', 2, 1, 2, 1);

-- ALREADY INSERTED
-- VALID INSERT: All references and fields are valid
-- INSERT INTO Employees (first_name, surname, gender, address, email, depart_id, role_id, salary_id, overtime_id) VALUES
-- ('Diana', 'Prince', 'Female', '100 Themyscira Rd', 'diana.prince@example.com', 1, 1, 1, 1);


