-- Day 5 (Set 2) --

-- Creating and Switching Database
IF DB_ID('BankDB') IS NULL BEGIN
    CREATE DATABASE BankDB;
END; GO
USE BankDB;

-- Creating Tables
CREATE TABLE Customers (
    CustomerID          INT PRIMARY KEY IDENTITY(1, 1),
    CustomerName        NVARCHAR(100) NOT NULL,
    Email               NVARCHAR(100) NOT NULL UNIQUE,
    Phone               NVARCHAR(20) NOT NULL,
    Address             NVARCHAR(200) NOT NULL,
    City                NVARCHAR(50) NOT NULL,
    State               NVARCHAR(50) NOT NULL,
    PostalCode          NVARCHAR(10) NOT NULL
);

CREATE TABLE Branches (
    BranchID            INT PRIMARY KEY IDENTITY(1, 1),
    BranchName          NVARCHAR(100) NOT NULL UNIQUE,
    IFSCCode            NVARCHAR(20) NOT NULL UNIQUE,
    City                NVARCHAR(50) NOT NULL
);

CREATE TABLE RelationshipManagers (
    ManagerID           INT PRIMARY KEY IDENTITY(1, 1),
    ManagerName         NVARCHAR(100) NOT NULL,
    Email               NVARCHAR(100) NOT NULL UNIQUE,
    Phone               NVARCHAR(20) NOT NULL,
    BranchID            INT NOT NULL REFERENCES Branches(BranchID),

    CONSTRAINT UQ_Manager_Branch UNIQUE (ManagerID, BranchID)
);

CREATE TABLE Accounts (
    AccountID           INT PRIMARY KEY IDENTITY(1, 1),
    AccountNumber       NVARCHAR(20) NOT NULL UNIQUE,
    AccountType         NVARCHAR(30) NOT NULL CHECK (AccountType IN ('Savings', 'Current', 'Fixed Deposit')),
    BranchID            INT NOT NULL REFERENCES Branches(BranchID),
    ManagerID           INT NOT NULL,
    Balance             DECIMAL(15, 2) NOT NULL DEFAULT(0),
    OpenedAt            DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT CK_Accounts_SavingsBalance CHECK (AccountType <> 'Savings' OR Balance >= 0),
    CONSTRAINT FK_Accounts_ManagerBranch FOREIGN KEY (ManagerID, BranchID) REFERENCES RelationshipManagers(ManagerID, BranchID)
);

CREATE TABLE AccountCustomers (
    AccountID           INT NOT NULL REFERENCES Accounts(AccountID) ON DELETE CASCADE,
    CustomerID          INT NOT NULL REFERENCES Customers(CustomerID) ON DELETE CASCADE,
    RelationshipRole    NVARCHAR(30) NOT NULL DEFAULT('Primary') CHECK (RelationshipRole IN ('Primary', 'Joint', 'Guardian')),

    CONSTRAINT PK_AccountCustomers PRIMARY KEY (AccountID, CustomerID)
);


-- Inserting Data

INSERT INTO Customers (CustomerName, Email, Phone, Address, City, State, PostalCode) VALUES
    ('Arun Kumar', 'arun@email.com', '+91 90000 00001', '12 Anna Nagar', 'Chennai', 'Tamil Nadu', '600040'),
    ('Priya Sharma', 'priya@email.com', '+91 90000 00002', '24 Gandhipuram', 'Coimbatore', 'Tamil Nadu', '641012'),
    ('Rahul Verma', 'rahul@email.com', '+91 90000 00003', '15 KK Nagar', 'Madurai', 'Tamil Nadu', '625020'),
    ('Sneha Reddy', 'sneha@email.com', '+91 90000 00004', '32 Thillai Nagar', 'Trichy', 'Tamil Nadu', '620018'),
    ('Vikram Singh', 'vikram@email.com', '+91 90000 00005', '18 Fairlands', 'Salem', 'Tamil Nadu', '636016'),
    ('Ananya Das', 'ananya@email.com', '+91 90000 00006', '45 Velachery', 'Chennai', 'Tamil Nadu', '600042'),
    ('Karthik Raj', 'karthik@email.com', '+91 90000 00007', '21 Peelamedu', 'Coimbatore', 'Tamil Nadu', '641004'),
    ('Meera Nair', 'meera@email.com', '+91 90000 00008', '10 Palayamkottai', 'Tirunelveli', 'Tamil Nadu', '627002'),
    ('Aditya Rao', 'aditya@email.com', '+91 90000 00009', '17 KK Nagar', 'Madurai', 'Tamil Nadu', '625020'),
    ('Divya Krishnan', 'divya@email.com', '+91 90000 00010', '29 RS Puram', 'Coimbatore', 'Tamil Nadu', '641002');


INSERT INTO Branches (BranchName, IFSCCode, City) VALUES
    ('Chennai Main Branch', 'BANK0001001', 'Chennai'),
    ('Coimbatore Branch', 'BANK0001002', 'Coimbatore'),
    ('Madurai Branch', 'BANK0001003', 'Madurai'),
    ('Trichy Branch', 'BANK0001004', 'Trichy'),
    ('Salem Branch', 'BANK0001005', 'Salem');


INSERT INTO RelationshipManagers (ManagerName, Email, Phone, BranchID) VALUES
    ('Ramesh Kumar', 'ramesh@bank.com', '+91 91000 00001', 1),
    ('Suresh Patel', 'suresh@bank.com', '+91 91000 00002', 2),
    ('Lakshmi Devi', 'lakshmi@bank.com', '+91 91000 00003', 3),
    ('Anil Sharma', 'anil@bank.com', '+91 91000 00004', 4),
    ('Kavya Menon', 'kavya@bank.com', '+91 91000 00005', 5);


INSERT INTO Accounts (AccountNumber, AccountType, BranchID, ManagerID, Balance, OpenedAt) VALUES
    ('ACC100001', 'Savings', 1, 1, 75000.00, '2026-07-05'),
    ('ACC100002', 'Current', 2, 2, 150000.00, '2026-08-12'),
    ('ACC100003', 'Savings', 3, 3, 25000.00, '2026-09-20'),
    ('ACC100004', 'Fixed Deposit', 4, 4, 200000.00, '2026-07-29'),
    ('ACC100005', 'Savings', 5, 5, 90000.00, '2026-08-30'),
    ('ACC100006', 'Current', 1, 1, -15000.00, '2026-09-28'),
    ('ACC100007', 'Savings', 2, 2, 45000.00, '2026-06-11'),
    ('ACC100008', 'Savings', 3, 3, 60000.00, '2026-10-05'),
    ('ACC100009', 'Fixed Deposit', 4, 4, 125000.00, '2026-09-15'),
    ('ACC100010', 'Savings', 5, 5, 35000.00, '2026-04-10');


INSERT INTO AccountCustomers (AccountID, CustomerID, RelationshipRole) VALUES
    (1, 1, 'Primary'),
    (2, 2, 'Primary'),
    (3, 3, 'Primary'),
    (4, 4, 'Primary'),
    (5, 5, 'Primary'),
    (6, 6, 'Primary'),
    (7, 7, 'Primary'),
    (8, 8, 'Primary'),
    (9, 9, 'Primary'),
    (10, 10, 'Primary'),
    (1, 6, 'Joint'),
    (2, 7, 'Joint');


-- Verify Inserted Data

SELECT * FROM Customers;
SELECT * FROM Branches;
SELECT * FROM RelationshipManagers;
SELECT * FROM Accounts;
SELECT * FROM AccountCustomers;

SELECT 'Customers' AS TableName, COUNT(*) AS TotalRecords FROM Customers
SELECT 'Branches', COUNT(*) FROM Branches
SELECT 'RelationshipManagers', COUNT(*) FROM RelationshipManagers
SELECT 'Accounts', COUNT(*) FROM Accounts
SELECT 'AccountCustomers', COUNT(*) FROM AccountCustomers;

-- DROP vs TRUNCATE vs DELETE

-- Creating Test Table
CREATE TABLE IdentityTest (
    TestID      INT PRIMARY KEY IDENTITY(1, 1),
    TestValue   NVARCHAR(50) NOT NULL
);
INSERT INTO IdentityTest (TestValue) VALUES
    ('Record A'),
    ('Record B'),
    ('Record C');
SELECT * FROM IdentityTest;


-- DELETE Operation with ROLLBACK
BEGIN TRANSACTION;
DELETE FROM IdentityTest;
SELECT * FROM IdentityTest;
ROLLBACK TRANSACTION;

-- Records are restored
SELECT * FROM IdentityTest;

-- DELETE does not reset IDENTITY
INSERT INTO IdentityTest (TestValue) VALUES
    ('After DELETE Rollback');
SELECT * FROM IdentityTest;


-- DELETE Operation without ROLLBACK
DELETE FROM IdentityTest;
INSERT INTO IdentityTest (TestValue) VALUES
    ('After DELETE Commit');
SELECT * FROM IdentityTest;


-- TRUNCATE Operation with ROLLBACK
BEGIN TRANSACTION;
TRUNCATE TABLE IdentityTest;
SELECT * FROM IdentityTest;
ROLLBACK TRANSACTION;

-- Records and identity state are restored
SELECT * FROM IdentityTest;


-- TRUNCATE Operation without ROLLBACK
TRUNCATE TABLE IdentityTest;
INSERT INTO IdentityTest (TestValue) VALUES
    ('After TRUNCATE');
SELECT * FROM IdentityTest;


-- DROP Operation with ROLLBACK
BEGIN TRANSACTION;
DROP TABLE IdentityTest;
ROLLBACK TRANSACTION;

-- Table is restored after rollback
SELECT * FROM IdentityTest;


-- DROP Operation without ROLLBACK
DROP TABLE IdentityTest;

-- Verify that the table no longer exists
SELECT OBJECT_ID('IdentityTest', 'U') AS TableObjectID;
-- NULL indicates that the table does not exist


-- Recreate Table to Demonstrate Identity Reset
CREATE TABLE IdentityTest (
    TestID      INT PRIMARY KEY IDENTITY(1, 1),
    TestValue   NVARCHAR(50) NOT NULL
);

INSERT INTO IdentityTest (TestValue) VALUES
    ('After DROP and Recreate');
SELECT * FROM IdentityTest;
DROP TABLE IdentityTest;


-- Insert, Update and Delete Operations

-- Insert a New Account
INSERT INTO Accounts (AccountNumber, AccountType, BranchID, ManagerID, Balance, OpenedAt) VALUES
    ('ACC100011', 'Savings', 1, 1, 85000.00, '2026-09-25');

INSERT INTO AccountCustomers (AccountID, CustomerID, RelationshipRole) VALUES
    (11, 1, 'Primary');


-- Update Account Balance
SELECT * FROM Accounts
    WHERE AccountNumber = 'ACC100011';
UPDATE Accounts SET Balance = 95000.00
    WHERE AccountNumber = 'ACC100011';
SELECT * FROM Accounts
    WHERE AccountNumber = 'ACC100011';


-- Delete an Account
SELECT * FROM Accounts
    WHERE AccountNumber = 'ACC100010';
DELETE FROM Accounts
    WHERE AccountNumber = 'ACC100010';
SELECT * FROM Accounts
    WHERE AccountNumber = 'ACC100010';


-- Verify cascading deletion of account-customer relationship
SELECT * FROM AccountCustomers
    WHERE AccountID = 10;


-- WHERE Clause using AND
SELECT * FROM Accounts
    WHERE AccountType = 'Savings'
    AND Balance > 50000;


-- WHERE Clause using OR
SELECT * FROM Accounts
    WHERE AccountType = 'Current'
    OR AccountType = 'Fixed Deposit';


-- WHERE Clause using IN
SELECT * FROM Accounts
    WHERE BranchID IN (1, 2, 3);


-- WHERE Clause using BETWEEN
SELECT * FROM Accounts
    WHERE Balance BETWEEN 25000 AND 100000;


-- Accounts Opened in the Last Quarter

-- With Balance Above 50,000
SELECT a.AccountNumber, c.CustomerName, a.AccountType, b.BranchName, rm.ManagerName, a.Balance, a.OpenedAt FROM Accounts AS a
    INNER JOIN AccountCustomers AS ac ON ac.AccountID = a.AccountID
    INNER JOIN Customers AS c ON c.CustomerID = ac.CustomerID
    INNER JOIN Branches AS b ON b.BranchID = a.BranchID
    INNER JOIN RelationshipManagers AS rm ON rm.ManagerID = a.ManagerID AND rm.BranchID = a.BranchID
    WHERE a.OpenedAt >= DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) - 1, 0)
        AND a.OpenedAt < DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()), 0)
        AND a.Balance > 50000
        AND a.AccountType IN ('Savings', 'Current', 'Fixed Deposit')
    ORDER BY a.OpenedAt;

