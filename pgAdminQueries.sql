CREATE TABLE Department (
    depart_id SERIAL PRIMARY KEY,
    depart_name VARCHAR(100) NOT NULL,
    depart_city VARCHAR(100) NOT NULL
);

CREATE TABLE Roles (
    role_id SERIAL PRIMARY KEY,
    role VARCHAR(100) NOT NULL
);

CREATE TABLE Salaries (
    salary_id SERIAL PRIMARY KEY,
    salary_pa NUMERIC(10, 2) NOT NULL
);

CREATE TABLE Overtime_Hours (
    overtime_id SERIAL PRIMARY KEY,
    overtime_hours INTEGER NOT NULL
);

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

INSERT INTO Employees (first_name, surname, gender, address, email, depart_id, role_id, salary_id, overtime_id) VALUES
('Invalid', 'User', 'Female', '123 Test St', 'invalid.user@example.com', 99, 99, 99, 99);
