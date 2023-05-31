-- These DDL Statements create the tables and define the relationships described in the Relational Database Schema Diagram

CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Phone_number VARCHAR(20),
    Address VARCHAR(100),
    City VARCHAR(50),
    State_code CHAR(2),
    Employee_name VARCHAR(100)
);
CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Phone_number VARCHAR(20),
    Customer_name VARCHAR(100)
);
CREATE TABLE Appointment (
    Appointment_ID INT PRIMARY KEY,
    Employee_ID INT,
    Customer_ID INT,
    Work_performed VARCHAR(200),
    Date DATE,
    Sales_price DECIMAL(10, 2),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);
CREATE TABLE Region (
    Region_code VARCHAR(10) PRIMARY KEY,
    Distance_from_office DECIMAL(10, 2)
);
CREATE TABLE Property (
    Customer_ID INT,
    Address VARCHAR(100),
    City VARCHAR(50),
    State_code CHAR(2),
    Region_code VARCHAR(10),
	FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Region_code) REFERENCES Region(Region_code)
);
CREATE TABLE Tree (
    Tree_ID INT PRIMARY KEY,
    Health VARCHAR(50),
    Estimated_age INT,
    Work_performed VARCHAR(200),
    Date DATE,
    Tree_species VARCHAR(100)
);
CREATE TABLE Inventory (
    Product_ID INT PRIMARY KEY,
    Product_cost DECIMAL(10, 2),
    Quantity INT,
    Company_name VARCHAR(100),
    SKU VARCHAR(50),
    Product_name VARCHAR(100)
);
CREATE TABLE Sales (
    Sales_price DECIMAL(10, 2),
    Customer_ID INT,
    Employee_ID INT,
    Appointment_ID INT,
    Product_ID INT,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
    FOREIGN KEY (Appointment_ID) REFERENCES Appointment(Appointment_ID),
    FOREIGN KEY (Product_ID) REFERENCES Inventory(Product_ID)
);

-- Filling the tables with data

INSERT INTO Employee (Employee_ID, Phone_Number, Address, City, State_code, Employee_name)
VALUES (1, '1234567890', '123 Main St', 'Reno', 'NV', 'John Doe'),
       (2, '9876543210', '456 Elm St', 'Reno', 'NV', 'Jane Smith'),
       (3, '5551234567', '789 Oak St', 'Reno', 'NV', 'Mike Johnson');
	   
INSERT INTO Customer (Customer_ID, Phone_number, Customer_name)
VALUES (1, '1112223333', 'John Customer'),
       (2, '4445556666', 'Jane Customer'),
       (3, '7778889999', 'Mike Customer');
	   
INSERT INTO Appointment (Appointment_ID, Employee_ID, Customer_ID, Work_performed, Date, Sales_price)
VALUES (1, 1, 1, 'Trimming', '2023-05-15', 100.00),
       (2, 2, 2, 'Removal', '2023-05-16', 150.00),
       (3, 3, 3, 'Herbicide treatment', '2023-05-17', 200.00);
	   
INSERT INTO Region (Region_code, Distance_from_office)
VALUES ('SPARKS', 1),
       ('MID', 15.2),
       ('SW', 8.7);
	   
INSERT INTO Property (Customer_ID, Address, City, State_code, Region_code)
VALUES (1, '123 Beech St', 'Sparks', 'NV', 'SPARKS'),
	   (2, '456 Pine St', 'Reno', 'NV', 'MID'),
	   (3, '789 Laurel St', 'Reno', 'NV', 'SW');

INSERT INTO Tree (Tree_ID, Health, Estimated_age, Work_performed, Date, Tree_species)
VALUES (1, 'Healthy', 20, 'Trimming', '2023-05-18', 'Oak'),
       (2, 'Average', 10, 'Pruning', '2023-05-19', 'Maple'),
       (3, 'Poor', 5, 'Fertilization', '2023-05-20', 'Birch');
	   
INSERT INTO Inventory (Product_ID, Product_cost, Quantity, Company_name, SKU, Product_name)
VALUES (1, 10.00, 100, 'Arborcare', 'SKU001', 'Bug Ender'),
       (2, 15.00, 150, 'Arborcare', 'SKU002', 'Bug Ender Max'),
       (3, 20.00, 200, 'Arborcare', 'SKU003', 'Root Care');	 
	   
INSERT INTO Sales (Sales_price, Customer_ID, Employee_ID, Appointment_ID, Product_ID)
VALUES (100.00, 1, 1, 1, 1),
       (150.00, 2, 2, 2, 2),
       (200.00, 3, 3, 3, 3);

-- 2 Views on the data

CREATE VIEW Dying_trees AS
		SELECT Tree_ID, Health 
		FROM Tree
		WHERE Health = 'Poor';

CREATE VIEW Low_inventory AS
		SELECT Product_ID, Quantity
		FROM Inventory
		WHERE Quantity <= 1;
		
-- 2 Functions

-- Stored Procedure

-- 1 Trigger
