use EnterpriseManagementDB;
CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    LastName VARCHAR(255) NOT NULL,
    FirstName VARCHAR(255) NOT NULL,
    BirthDate DATE NOT NULL,
    HireDate DATE NOT NULL,
    Position VARCHAR(255) NOT NULL,
    Salary DECIMAL(15,2) NOT NULL CHECK (Salary >= 30000)
);

CREATE TABLE Departments (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(255) NOT NULL UNIQUE,
    ManagerID INT NULL,
    Budget DECIMAL(15,2) NOT NULL CHECK (Budget >= 0),
    CreatedAt DATE NOT NULL DEFAULT (CURRENT_DATE),
    CONSTRAINT fk_manager FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID) ON DELETE SET NULL
);

ALTER TABLE Employees ADD COLUMN DepartmentID INT NULL;
ALTER TABLE Employees ADD CONSTRAINT fk_department FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) ON DELETE SET NULL;

CREATE TABLE Projects (
    ProjectID INT AUTO_INCREMENT PRIMARY KEY,
    ProjectName VARCHAR(255) NOT NULL UNIQUE,
    StartDate DATE NOT NULL,
    EndDate DATE NULL,
    Budget DECIMAL(15,2) NOT NULL CHECK (Budget >= 0),
    DepartmentID INT NOT NULL,
    CONSTRAINT fk_project_department FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) ON DELETE CASCADE
);

CREATE TABLE EmployeeProjects (
    EmployeeID INT NOT NULL,
    ProjectID INT NOT NULL,
    Role VARCHAR(255) NOT NULL,
    HoursWorked INT NOT NULL CHECK (HoursWorked >= 0),
    PRIMARY KEY (EmployeeID, ProjectID),
    CONSTRAINT fk_emp_proj_employee FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) ON DELETE CASCADE,
    CONSTRAINT fk_emp_proj_project FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID) ON DELETE CASCADE
);

CREATE TABLE Salaries (
    SalaryID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT NOT NULL,
    Amount DECIMAL(15,2) NOT NULL CHECK (Amount >= 30000),
    PaymentDate DATE NOT NULL,
    CONSTRAINT fk_salaries_employee FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) ON DELETE CASCADE
);

-- Триггер для проверки возраста
DELIMITER //
CREATE TRIGGER before_insert_employee
BEFORE INSERT ON Employees
FOR EACH ROW
BEGIN
    IF NEW.BirthDate > DATE_SUB(CURDATE(), INTERVAL 18 YEAR) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Employee must be at least 18 years old';
    END IF;
    IF NEW.HireDate < DATE_ADD(NEW.BirthDate, INTERVAL 18 YEAR) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'HireDate must be at least 18 years after BirthDate';
    END IF;
END;
//
DELIMITER ;

-- Триггер для проверки даты проекта
DELIMITER //
CREATE TRIGGER before_insert_project
BEFORE INSERT ON Projects
FOR EACH ROW
BEGIN
    IF NEW.StartDate < CURDATE() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'StartDate must be today or later';
    END IF;
    IF NEW.EndDate IS NOT NULL AND NEW.EndDate < NEW.StartDate THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EndDate cannot be before StartDate';
    END IF;
END;
//
DELIMITER ;

-- Триггер для проверки даты выплаты зарплаты
DELIMITER //
CREATE TRIGGER before_insert_salary
BEFORE INSERT ON Salaries
FOR EACH ROW
BEGIN
    IF NEW.PaymentDate > CURDATE() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'PaymentDate cannot be in the future';
    END IF;
END;
//
DELIMITER ;