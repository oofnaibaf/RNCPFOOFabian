DROP database IF EXISTS globalsuperstore;
CREATE DATABASE globalsuperstore;
USE globalsuperstore;
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'secure_file_priv';

select * from customers;

SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_SCHEMA = 'globalsuperstore'
ORDER BY 
    TABLE_NAME, ORDINAL_POSITION;


-- Database schema creation
CREATE DATABASE GlobalSuperStore;
USE GlobalSuperStore;

-- table alerations
ALTER TABLE Orders MODIFY COLUMN Profit DECIMAL(15,2);

-- test cases
SELECT * FROM Orders;
select * FROM products;


-- Table for Customers
CREATE TABLE Customers (
    CustomerID VARCHAR(20) PRIMARY KEY,
    CustomerName VARCHAR(100),
    Segment VARCHAR(50)
);

-- Table for CustomerLocations
CREATE TABLE CustomerLocations (
    LocationID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID VARCHAR(20),
    City VARCHAR(50),
    State VARCHAR(50),
    Country VARCHAR(50),
    PostalCode VARCHAR(10),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Table for Orders
CREATE TABLE Orders (
    OrderID VARCHAR(20) PRIMARY KEY,
    OrderDate DATE,
    ShippingDate DATE,
    ShippingMode VARCHAR(50),
    CustomerID VARCHAR(20),
    Sales FLOAT,
    Profit FLOAT,
    Discount FLOAT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Table for Products
CREATE TABLE Products (
    ProductID VARCHAR(20) PRIMARY KEY,
    Category VARCHAR(50),
    SubCategory VARCHAR(50),
    ProductName VARCHAR(255),
    Price FLOAT
);

-- Table for OrderDetails
CREATE TABLE OrderDetails (
    RowID INT PRIMARY KEY,
    OrderID VARCHAR(20),
    ProductID VARCHAR(20),
    Quantity INT,
    ShippingCost FLOAT,
    OrderPriority VARCHAR(20),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Force load data to some tables bypass GUI
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/unique_products.csv'
INTO TABLE Products
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ProductID, Category, SubCategory, ProductName, Price);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/unique_orders_cleaned_V2.csv'
INTO TABLE Orders
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(OrderID, OrderDate, ShippingDate, ShippingMode, CustomerID, Sales, Profit, Discount);