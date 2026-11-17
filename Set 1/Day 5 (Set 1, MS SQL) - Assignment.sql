-- Day 5 (Set 1) --

-- Creating and Switching Database
IF DB_ID('RetailDB') IS NULL BEGIN
    CREATE DATABASE RetailDB
END; GO;
USE RetailDB;

-- Creating Tables
CREATE TABLE Suppliers (
    SupplierID      INT PRIMARY KEY IDENTITY(1, 1),
    SupplierName    NVARCHAR(100) NOT NULL,
    Phone           NVARCHAR(100) NOT NULL UNIQUE,
);

CREATE TABLE Categories (
    CategoryID      INT PRIMARY KEY IDENTITY(1, 1),
    CategoryName    NVARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Warehouses (
    WarehouseID     INT PRIMARY KEY IDENTITY(1, 1),
    WarehouseName   NVARCHAR(100) NOT NULL UNIQUE,
    City            NVARCHAR(50) NOT NULL
);

CREATE TABLE Products (
    ProductID       INT PRIMARY KEY IDENTITY(1, 1),
    SKU             NVARCHAR(30) NOT NULL UNIQUE,
    ProductName     NVARCHAR(150) NOT NULL,
    CategoryID      INT NOT NULL REFERENCES Categories(CategoryID),
    SupplierID      INT NOT NULL REFERENCES Suppliers(SupplierID),
    UnitPrice       DECIMAL(12, 2) NOT NULL DEFAULT(0) CHECK (UnitPrice >= 0),
    IsDiscontinued  BIT NOT NULL DEFAULT(0),
    CreatedAt       DATETIME2 NOT NULL DEFAULT CURRENT_TIMESTAMP,
);

CREATE TABLE Inventory (
    ProductID       INT NOT NULL REFERENCES Products(ProductID) ON DELETE CASCADE,
    WarehouseID     INT NOT NULL REFERENCES Warehouses(WarehouseID),
    Quantity        INT NOT NULL DEFAULT(0) CHECK (Quantity >= 0),
    ReorderLevel    INT NOT NULL DEFAULT(10) CHECK (ReorderLevel >= 0),

    CONSTRAINT PK_Inventory PRIMARY KEY (ProductID, WarehouseID)
);

-- Inserting Data
INSERT INTO Suppliers (SupplierName, Phone) VALUES
    ('Acme Electronics', '+91 90000 00001'),
    ('Global Gadgets',   '+91 90000 00002'),
    ('Fresh Foods Ltd',  '+91 90000 00003'),
    ('Office Source',    '+91 90000 00004'),
    ('Home Essentials',  '+91 90000 00005'),
    ('Nova Computing',   '+91 90000 00006'),
    ('Urban Living',     '+91 90000 00007'),
    ('Bright Lighting',  '+91 90000 00008'),
    ('Active Sports',    '+91 90000 00009'),
    ('Green Garden Co',  '+91 90000 00010');

INSERT INTO Categories (CategoryName) VALUES
    ('Electronics'),
    ('Computers'),
    ('Groceries'),
    ('Stationary'),
    ('Furniture'),
    ('Home Appliances'),
    ('Lighting'),
    ('Sports'),
    ('Garden'),
    ('Accessories');

INSERT INTO Warehouses (WarehouseName, City) VALUES
    ('Central Warehouse', 'Chennai'),
    ('North Warehouse',   'Coimbatore'),
    ('South Warehouse',   'Madurai'),
    ('East Warehouse',    'Trichy'),
    ('West Warehouse',    'Salem'),
    ('Airport Warehouse', 'Chennai'),
    ('Harbor Warehouse',  'Tuticorin'),
    ('City Warehouse',    'Erode'),
    ('Rural Warehouse',   'Tirunelveli'),
    ('Express Warehouse', 'Vellore');

INSERT INTO Products (SKU, ProductName, CategoryID, SupplierID, UnitPrice, IsDiscontinued)
    SELECT source.SKU, source.ProductName, category.CategoryID, supplier.SupplierID, source.UnitPrice, source.IsDiscontinued FROM(
        VALUES
        (N'SKU-1001', N'Wireless Mouse', N'Electronics', N'Acme Electronics', 799.00, 0),
        (N'SKU-1002', N'USB-C Keyboard', N'Computers', N'Global Gadgets', 1499.00, 0),
        (N'SKU-1003', N'Organic Rice 5kg', N'Groceries', N'Fresh Foods Ltd', 650.00, 0),
        (N'SKU-1004', N'Notebook Pack', N'Stationery', N'Office Source', 250.00, 0),
        (N'SKU-1005', N'Office Chair', N'Furniture', N'Home Essentials', 5499.00, 0),
        (N'SKU-1006', N'Air Fryer', N'Home Appliances', N'Nova Computing', 6999.00, 0),
        (N'SKU-1007', N'Desk Lamp', N'Lighting', N'Bright Lighting', 1199.00, 0),
        (N'SKU-1008', N'Football', N'Sports', N'Active Sports', 899.00, 0),
        (N'SKU-1009', N'Garden Hose', N'Garden', N'Green Garden Co', 599.00, 1),
        (N'SKU-1010', N'Old Phone Case', N'Accessories', N'Acme Electronics', 199.00, 1)
    ) AS source ( SKU, ProductName, CategoryName, SupplierName, UnitPrice, IsDiscontinued)
    INNER JOIN Categories AS category
        ON category.CategoryName = source.CategoryName
    INNER JOIN Suppliers AS supplier
        ON supplier.SupplierName = source.SupplierName;

INSERT INTO Inventory (productid, warehouseid, quantity, reorderlevel)
    SELECT product.ProductID, warehouse.WarehouseID, source.Quantity, source.ReorderLevel FROM (
        VALUES
        (N'SKU-1001', N'Central Warehouse', 45, 10),
        (N'SKU-1002', N'North Warehouse', 18, 5),
        (N'SKU-1003', N'South Warehouse', 80, 20),
        (N'SKU-1004', N'East Warehouse', 120, 25),
        (N'SKU-1005', N'West Warehouse', 12, 5),
        (N'SKU-1006', N'Airport Warehouse', 9, 3),
        (N'SKU-1007', N'Harbor Warehouse', 30, 8),
        (N'SKU-1008', N'City Warehouse', 25, 8),
        (N'SKU-1009', N'Rural Warehouse', 14, 5),
        (N'SKU-1010', N'Express Warehouse', 0, 5)
    ) AS source (SKU, WarehouseName, Quantity, ReorderLevel)
    INNER JOIN Products AS product
        ON product.SKU = source.SKU
    INNER JOIN Warehouses AS warehouse
        ON warehouse.WarehouseName = source.WarehouseName;

-- Verify id Data is inserted
SELECT 'Suppliers' AS TableName, COUNT(*) AS TotalRecords FROM Suppliers
SELECT 'Categories', COUNT(*) FROM Categories
SELECT 'Warehouses', COUNT(*) FROM Warehouses
SELECT 'Products', COUNT(*) FROM Products
SELECT 'Inventory', COUNT(*) FROM Inventory;

-- Failure 1 (Duplicate Key)
BEGIN TRY
    INSERT INTO Products (SKU, ProductName, CategoryID, SupplierID, UnitPrice) VALUES
        ('SKU-1001', 'Duplicate Mouse', 1, 1, 500);
END TRY BEGIN CATCH
    PRINT 'EXPECTED FAILURE 1: ' + ERROR_MESSAGE()
END CATCH;

-- Failure 2 (Missing Parents)
BEGIN TRY
    INSERT INTO Products (SKU, ProductName, CategoryID, SupplierID, UnitPrice) VALUES
        ('SKU-9999', 'Unknown Product', 99, 99, 100.0);
END TRY BEGIN CATCH
    PRINT 'EXPECTED FAULURE 2: ' + ERROR_MESSAGE()
END CATCH;

-- Failure 3 (Negative Quantity)
BEGIN TRY
    INSERT INTO Inventory (ProductID, WarehouseID, Quantity, ReorderLevel) VALUES
        (1, 2, -5, 5);
END TRY BEGIN CATCH
    PRINT 'EXPECTED FAILURE 3: ' + ERROR_MESSAGE()
END CATCH;

-- Failure 4 (NULL Failure)
BEGIN TRY
    INSERT INTO Suppliers (SupplierName, Phone) VALUES
        (NULL, '+91 90000 00099');
END TRY BEGIN CATCH
    PRINT 'EXPECTED FAILURE 4: ' + ERROR_MESSAGE()
END CATCH;

-- Supplier Phone Number Update
SELECT * FROM Suppliers
    WHERE SupplierName = 'Acme Electronics';

UPDATE Suppliers SET Phone = '+91 98000 00001'
    WHERE SupplierName = 'Acme Electronics';

SELECT * FROM Suppliers
    WHERE SupplierName = 'Acme Electronics';

-- Delete Discontinued Products
SELECT * FROM Inventory;

SELECT * FROM Products
    WHERE IsDiscontinued = 1;

DELETE FROM Products
    WHERE IsDiscontinued = 1;

SELECT * FROM Products
    WHERE IsDiscontinued = 1;

SELECT * FROM Inventory;