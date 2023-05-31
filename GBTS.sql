CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Phone_number VARCHAR(20),
    Address VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
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
    State VARCHAR(50),
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


