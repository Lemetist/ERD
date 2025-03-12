use EnterpriseManagementDB;
CREATE TABLE Departments (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(255) NOT NULL UNIQUE,
    ManagerID INT NULL,
    Budget DECIMAL(15,2) NOT NULL CHECK (Budget >= 0),
    CreatedAt DATE NOT NULL DEFAULT (CURRENT_DATE),
    CONSTRAINT fk_manager FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID) ON DELETE SET NULL
);

CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    LastName VARCHAR(255) NOT NULL,
    FirstName VARCHAR(255) NOT NULL,
    BirthDate DATE NOT NULL,
    HireDate DATE NOT NULL,
    Position VARCHAR(255) NOT NULL,
    Salary DECIMAL(15,2) NOT NULL CHECK (Salary >= 30000),
    DepartmentID INT NOT NULL,
    CONSTRAINT fk_department FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) ON DELETE SET NULL,
    CONSTRAINT chk_age CHECK (BirthDate <= DATE_SUB(CURRENT_DATE, INTERVAL 18 YEAR)),
    CONSTRAINT chk_hire CHECK (HireDate >= DATE_ADD(BirthDate, INTERVAL 18 YEAR))
);

ALTER TABLE Departments ADD CONSTRAINT fk_manager FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID) ON DELETE SET NULL;

CREATE TABLE Projects (
    ProjectID INT AUTO_INCREMENT PRIMARY KEY,
    ProjectName VARCHAR(255) NOT NULL UNIQUE,
    StartDate DATE NOT NULL CHECK (StartDate >= CURRENT_DATE),
    EndDate DATE NULL CHECK (EndDate IS NULL OR EndDate >= StartDate),
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
    PaymentDate DATE NOT NULL CHECK (PaymentDate <= CURRENT_DATE),
    CONSTRAINT fk_salaries_employee FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) ON DELETE CASCADE
);