-- Day 5 (Set 3) --

-- Creating and Switching Database
IF DB_ID('HospitalDB') IS NULL BEGIN
    CREATE DATABASE HospitalDB;
END; GO
USE HospitalDB;

-- Creating Tables
CREATE TABLE Departments (
    DepartmentID       INT PRIMARY KEY IDENTITY(1, 1),
    DepartmentName     NVARCHAR(100) NOT NULL UNIQUE,
    Location           NVARCHAR(100) NOT NULL
);

CREATE TABLE Doctors (
    DoctorID           INT PRIMARY KEY IDENTITY(1, 1),
    DoctorName         NVARCHAR(100) NOT NULL,
    Specialization     NVARCHAR(100) NOT NULL,
    DepartmentID       INT NOT NULL REFERENCES Departments(DepartmentID),
    Email              NVARCHAR(100) NOT NULL UNIQUE,
    Phone              NVARCHAR(20) NOT NULL
);

CREATE TABLE Patients (
    PatientID          INT PRIMARY KEY IDENTITY(1, 1),
    PatientName        NVARCHAR(100) NOT NULL,
    DateOfBirth        DATE NOT NULL,
    Gender             NVARCHAR(10) NOT NULL CHECK (Gender IN ('Male', 'Female', 'Other')),
    Phone              NVARCHAR(20) NOT NULL,
    Address            NVARCHAR(200) NOT NULL
);

CREATE TABLE Visits (
    VisitID            INT PRIMARY KEY IDENTITY(1, 1),
    PatientID          INT NOT NULL REFERENCES Patients(PatientID),
    DoctorID           INT NOT NULL REFERENCES Doctors(DoctorID),
    VisitDate          DATE NOT NULL CHECK (VisitDate BETWEEN '2000-01-01' AND '2099-12-31'),
    Diagnosis          NVARCHAR(200) NOT NULL,
    Prescription       NVARCHAR(500),
    Status             NVARCHAR(20) NOT NULL DEFAULT('Open'),

    CONSTRAINT DF_Visits_Status
        CHECK (Status IN ('Open', 'Completed', 'Cancelled'))
);

CREATE TABLE Billing (
    BillingID       INT PRIMARY KEY IDENTITY(1, 1),
    VisitID         INT NOT NULL UNIQUE REFERENCES Visits(VisitID),
    BillAmount      DECIMAL(10, 2) NOT NULL CHECK(BillAmount >= 0),
    PaymentStatus   NVARCHAR(20) NOT NULL,
    PaymentDate     DATE NULL,

    CONSTRAINT CK_Billing_PaymentStatus
        CHECK(PaymentStatus IN ('Paid', 'Pending', 'Partial'))
);


-- Inserting Data

INSERT INTO Departments (DepartmentName, Location) VALUES
    ('Cardiology', 'Block A - First Floor'),
    ('Neurology', 'Block A - Second Floor'),
    ('Orthopedics', 'Block B - First Floor'),
    ('Pediatrics', 'Block B - Second Floor'),
    ('Dermatology', 'Block C - First Floor');


INSERT INTO Doctors (DoctorName, Specialization, DepartmentID, Email, Phone) VALUES
    ('Dr. Arun Kumar', 'Cardiologist', 1, 'arun@hospital.com', '+91 90000 00001'),
    ('Dr. Priya Sharma', 'Interventional Cardiologist', 1, 'priya@hospital.com', '+91 90000 00002'),
    ('Dr. Rahul Verma', 'Neurologist', 2, 'rahul@hospital.com', '+91 90000 00003'),
    ('Dr. Sneha Reddy', 'Neurosurgeon', 2, 'sneha@hospital.com', '+91 90000 00004'),
    ('Dr. Vikram Singh', 'Orthopedic Surgeon', 3, 'vikram@hospital.com', '+91 90000 00005'),
    ('Dr. Ananya Das', 'Joint Specialist', 3, 'ananya@hospital.com', '+91 90000 00006'),
    ('Dr. Karthik Raj', 'Pediatrician', 4, 'karthik@hospital.com', '+91 90000 00007'),
    ('Dr. Meera Nair', 'Child Specialist', 4, 'meera@hospital.com', '+91 90000 00008'),
    ('Dr. Aditya Rao', 'Dermatologist', 5, 'aditya@hospital.com', '+91 90000 00009'),
    ('Dr. Divya Krishnan', 'Cosmetic Dermatologist', 5, 'divya@hospital.com', '+91 90000 00010');


INSERT INTO Patients (PatientName, DateOfBirth, Gender, Phone, Address) VALUES
    ('Arun Kumar', '1990-05-15', 'Male', '+91 91000 00001', '12 Anna Nagar, Chennai'),
    ('Priya Sharma', '1985-08-20', 'Female', '+91 91000 00002', '24 Gandhipuram, Coimbatore'),
    ('Rahul Verma', '1978-03-10', 'Male', '+91 91000 00003', '15 KK Nagar, Madurai'),
    ('Sneha Reddy', '1995-11-25', 'Female', '+91 91000 00004', '32 Thillai Nagar, Trichy'),
    ('Vikram Singh', '1965-02-14', 'Male', '+91 91000 00005', '18 Fairlands, Salem'),
    ('Ananya Das', '2000-07-08', 'Female', '+91 91000 00006', '45 Velachery, Chennai'),
    ('Karthik Raj', '2010-09-12', 'Male', '+91 91000 00007', '21 Peelamedu, Coimbatore'),
    ('Meera Nair', '1988-12-30', 'Female', '+91 91000 00008', '10 Palayamkottai, Tirunelveli'),
    ('Aditya Rao', '1972-06-18', 'Male', '+91 91000 00009', '17 KK Nagar, Madurai'),
    ('Divya Krishnan', '1992-04-22', 'Female', '+91 91000 00010', '29 RS Puram, Coimbatore');


INSERT INTO Visits (PatientID, DoctorID, VisitDate, Diagnosis, Prescription, Status) VALUES
    (1, 1, '2026-09-05', 'Hypertension', 'Amlodipine 5mg daily', 'Completed'),
    (2, 3, '2026-09-12', 'Migraine', 'Paracetamol 500mg as needed', 'Completed'),
    (3, 5, '2026-09-20', 'Knee Pain', 'Physiotherapy and pain medication', 'Completed'),
    (4, 7, '2026-10-02', 'Common Cold', 'Cetirizine 10mg daily', 'Open'),
    (5, 1, '2026-10-05', 'Coronary Artery Disease', 'Aspirin 75mg daily', 'Completed'),
    (6, 9, '2026-10-08', 'Skin Allergy', 'Antihistamine cream', 'Open'),
    (7, 8, '2026-10-12', 'Viral Fever', 'Paracetamol 250mg', 'Completed'),
    (8, 2, '2026-10-15', 'Chest Pain', 'ECG and further evaluation', 'Open'),
    (9, 4, '2026-10-20', 'Chronic Headache', 'Neurological evaluation', 'Completed'),
    (10, 10, '2026-10-25', 'Acne', 'Topical retinoid cream', 'Open');


INSERT INTO Billing (VisitID, BillAmount, PaymentStatus, PaymentDate) VALUES
    (1, 1500.00, 'Paid', '2026-09-05'),
    (2, 1200.00, 'Paid', '2026-09-12'),
    (3, 2500.00, 'Partial', '2026-09-20'),
    (4, 800.00, 'Pending', NULL),
    (5, 5000.00, 'Paid', '2026-10-05'),
    (6, 1000.00, 'Pending', NULL),
    (7, 900.00, 'Paid', '2026-10-12'),
    (8, 3500.00, 'Partial', '2026-10-15'),
    (9, 2200.00, 'Paid', '2026-10-20'),
    (10, 1800.00, 'Pending', NULL);


-- Verify Inserted Data
SELECT * FROM Departments;
SELECT * FROM Doctors;
SELECT * FROM Patients;
SELECT * FROM Visits;
SELECT * FROM Billing;

SELECT 'Departments' AS TableName, COUNT(*) AS TotalRecords FROM Departments
SELECT 'Doctors', COUNT(*) FROM Doctors
SELECT 'Patients', COUNT(*) FROM Patients
SELECT 'Visits', COUNT(*) FROM Visits
SELECT 'Billing', COUNT(*) FROM Billing;


-- ALTER TABLE Operations

-- Adding InsuranceID Column to Patients
ALTER TABLE Patients
    ADD InsuranceID NVARCHAR(30);

-- Updating Insurance Details
UPDATE Patients SET InsuranceID = 'INS-1001' WHERE PatientID = 1;
UPDATE Patients SET InsuranceID = 'INS-1002' WHERE PatientID = 2;
UPDATE Patients SET InsuranceID = 'INS-1003' WHERE PatientID = 3;
UPDATE Patients SET InsuranceID = 'INS-1004' WHERE PatientID = 4;
UPDATE Patients SET InsuranceID = 'INS-1005' WHERE PatientID = 5;
UPDATE Patients SET InsuranceID = 'INS-1006' WHERE PatientID = 6;
UPDATE Patients SET InsuranceID = 'INS-1007' WHERE PatientID = 7;
UPDATE Patients SET InsuranceID = 'INS-1008' WHERE PatientID = 8;
UPDATE Patients SET InsuranceID = 'INS-1009' WHERE PatientID = 9;
UPDATE Patients SET InsuranceID = 'INS-1010' WHERE PatientID = 10;

-- Verify Added Column
SELECT PatientID, PatientName, InsuranceID FROM Patients;


-- Renaming Visits Table to PatientVisits
EXEC sp_rename 'Visits', 'PatientVisits';

-- Verify Renamed Table
SELECT * FROM PatientVisits;


-- Dropping a Constraint

-- Checking Existing Constraints
SELECT name, type_desc FROM sys.objects
    WHERE parent_object_id = OBJECT_ID('Billing');

-- Dropping PaymentStatus CHECK Constraint
ALTER TABLE Billing
    DROP CONSTRAINT CK_Billing_PaymentStatus;

-- Verify Constraint Removal
SELECT name, type_desc FROM sys.objects
    WHERE parent_object_id = OBJECT_ID('Billing');

-- The PaymentStatus CHECK Constraint is now removed.
-- Other Billing constraints remain unaffected.


-- Insert, Update and Delete Operations

-- Insert a New Patient
INSERT INTO Patients (PatientName, DateOfBirth, Gender, Phone, Address, InsuranceID) VALUES
    ('Naveen Kumar', '1998-06-15', 'Male', '+91 92000 00001', '15 T Nagar, Chennai', 'INS-1011');


-- Insert a New Visit
INSERT INTO PatientVisits (PatientID, DoctorID, VisitDate, Diagnosis, Prescription) VALUES
    (11, 1, '2026-10-28', 'High Blood Pressure', 'Regular BP monitoring');

-- Default Status will be Open
SELECT * FROM PatientVisits
    WHERE PatientID = 11;


-- Update Patient Phone Number
SELECT * FROM Patients
    WHERE PatientID = 11;
UPDATE Patients SET Phone = '+91 92000 00099'
    WHERE PatientID = 11;
SELECT * FROM Patients
    WHERE PatientID = 11;


-- Update Billing Payment Status
SELECT * FROM Billing
    WHERE VisitID = 4;
UPDATE Billing SET PaymentStatus = 'Paid', PaymentDate = '2026-10-30'
    WHERE VisitID = 4;
SELECT * FROM Billing
    WHERE VisitID = 4;


-- Delete a Billing Record
SELECT * FROM Billing
    WHERE VisitID = 10;
DELETE FROM Billing
    WHERE VisitID = 10;
SELECT * FROM Billing
    WHERE VisitID = 10;


-- Retrieving Patients Visited in October 2026

SELECT p.PatientID, p.PatientName, p.Phone, v.VisitDate, v.Diagnosis, v.Status FROM Patients AS p
    INNER JOIN PatientVisits AS v ON v.PatientID = p.PatientID
    WHERE v.VisitDate >= '2026-10-01'
        AND v.VisitDate < '2026-11-01'
    ORDER BY v.VisitDate;


-- Retrieving Doctors of Cardiology Department using WHERE and LIKE

SELECT d.DoctorID, d.DoctorName, d.Specialization, dep.DepartmentName, dep.Location FROM Doctors AS d
    INNER JOIN Departments AS dep ON dep.DepartmentID = d.DepartmentID
    WHERE dep.DepartmentName LIKE '%Cardiology%'
    ORDER BY d.DoctorName;