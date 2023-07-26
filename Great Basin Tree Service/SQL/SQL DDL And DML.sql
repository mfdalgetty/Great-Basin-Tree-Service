-- Creation of database

CREATE DATABASE gbts;

-- Creation of tables.

CREATE TABLE Employee (
    	Employee_ID INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    	Phone_number VARCHAR(20),
    	Address VARCHAR(100),
    	City VARCHAR(50),
    	State_code CHAR(2),
    	Employee_name VARCHAR(100)
);
CREATE TABLE Customer (
    	Customer_ID INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    	Phone_number VARCHAR(20),
    	Customer_name VARCHAR(100)
);
CREATE TABLE Inventory (
    	Product_ID INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY ,
    	Product_cost DECIMAL(10, 2),
    	Quantity DECIMAL (4,1),
    	Units VARCHAR(50),
    	Company_name VARCHAR(100),
    	SKU VARCHAR(50),
    	Product_name VARCHAR(100)
);
CREATE TABLE Appointment (
    	Appointment_ID INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    	Employee_ID INT,
    	Customer_ID INT,
    	Work_performed VARCHAR(200),
    	Date DATE,
    	Sales_price DECIMAL(10, 2),
    	Product_ID INT,
    	Quantity_used DECIMAL (4,1),
    	Distance DECIMAL (4,1),
    	FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
    	FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
   	FOREIGN KEY (Product_ID) REFERENCES Inventory (Product_ID)
);	
CREATE TABLE Property (
    	Address VARCHAR(100) PRIMARY KEY,
    	Customer_ID INT,
    	City VARCHAR(50),
    	State_code CHAR(2),
    	Region_code VARCHAR(10),
    	FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);
CREATE TABLE Tree (
   	Tree_ID INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
Health VARCHAR(50),
   	Estimated_age INT,
Work_performed VARCHAR(200),
   	Date DATE,
   	Tree_species VARCHAR(100),
   	Address VARCHAR(100),
   	FOREIGN KEY (Address) REFERENCES Property(Address)
);
CREATE TABLE Quarterly_sales (
Quarter CHAR(2),
	Year INT,
	Appointment_ID INT,
	FOREIGN KEY (Appointment_ID) REFERENCES Appointment
);
CREATE TABLE Inventory_history (
    	Product_ID INT,
    	Product_cost DECIMAL(10, 2),
	Units VARCHAR(50),
    	Company_name VARCHAR(100),
    	SKU VARCHAR(50),
    	Product_name VARCHAR(100),
	Old_quantity DECIMAL (4,1),
	New_quantity DECIMAL (4,1),
	Change_time timestamp with time zone,
	FOREIGN KEY (Product_ID) REFERENCES Inventory(Product_ID)
);
CREATE TABLE users(
    	Username VARCHAR(50),
    	Password VARCHAR(50)
);


-- Filling the tables with data. Updating and Deleting as necessary

-- Employee

INSERT INTO Employee (Phone_Number, Address, City, State_code, Employee_name)
VALUES 	('1234567890', '123 Main St', 'Reno', 'NV', 'John Doe'),
		('9876543210', '456 Elm St', 'Reno', 'NV', 'Jane Smith'),
		('5551234567', '789 Oak St', 'Sparks', 'NV', 'Mike Johnson'),
		('1112223333', '321 Pine St', 'Sparks', 'NV', 'Sarah Davis'),
		('4445556666', '654 Maple St', 'Reno', 'NV', 'David Wilson'),
		('7778889999', '987 Cedar St', 'Carson City', 'NV', 'Emily Thompson'),
		('2223334444', '741 Birch St', 'Carson City', 'NV', 'Michael Lee'),
		('9998887777', '852 Spruce St', 'Reno', 'NV', 'Jennifer Brown'),
		('6665554444', '369 Oak St', 'Reno', 'NV', 'Christopher Taylor'),
		('3332221111', '963 Elm St', 'Stead', 'NV', 'Jessica Martinez');

UPDATE Employee
SET Address = '345 Maple Ave'
WHERE Employee_name = 'Mike Johnson';

DELETE FROM Employee 
WHERE Employee_name = 'Emily Thompson';

-- Customer

INSERT INTO Customer (Phone_number, Customer_name)
VALUES 	('7021111111', 'Bob Johnson'),
		('7022222222', 'Emily Davis'),
		('7023333333', 'Michael Smith'),
		('7024444444', 'Sarah Wilson'),
		('7025555555', 'David Thompson'),
		('7026666666', 'Jessica Lee'),
		('7027777777', 'John Miller'),
		('7028888888', 'Amy Taylor'),
		('7029999999', 'Daniel Anderson'),
		('7021234567', 'Olivia Martinez');
		
UPDATE Customer 
SET Customer_name = 'Emily Johanssen'
WHERE Customer_ID = 2;

DELETE FROM Customer 
WHERE Customer_name = 'Daniel Anderson';

-- Inventory 

INSERT INTO Inventory (Product_cost, Quantity, Units, Company_name, SKU, Product_name)
VALUES 	(9.99, 10.0, 'Liters', 'TreeCare Products Inc.', 'TC001', 'Rootmax'),
		(9.99, 5.5, 'Liters', 'GreenThumb Tree Care Supplies', 'GT001', 'Tree Fertilizer'),
		(2.99, 100, 'Plugs', 'Evergreen Tree Care Solutions', 'ETC001', 'Arborjet Plugs'),
		(119.99, 15.0, 'Liters', 'ArborPro Tree Services', 'APTS001', 'Bug Destroyer'),
(49.99, 3.5, 'Liters', 'BranchMaster Tree Care', 'BMTC001', 'Tree Growth Hormone'),
		(59.99, 6.0, 'Boxes', 'Nature Tree Care', 'NTC001', 'Tree Insecticide'),
		(39.99, 3, 'Wraps', 'Roots & Shoots Tree Care', 'RSTC001', 'Tree Bark Protector'),
		(19.99, 4.0, 'Bags', 'Canopy Tree Care Products', 'CTCP001', 'Tree Mulch'),
		(9.99, 7, 'Bottles', 'TreeCare Experts', 'TCE001', 'Tree Health Tonic'),
		(99.99, 1.0, 'Kits', 'Forest Guardians Tree Care', 'FGTC001', 'Tree Planting Kit');

UPDATE Inventory 
SET Product_cost = 3.99
WHERE Product_name = 'Arborjet Plugs';

DELETE FROM Inventory
WHERE Product_name = 'Tree Planting Kit';

-- Appointment

INSERT INTO Appointment (Employee_ID, Customer_ID, Work_performed, Date, Sales_price, Product_ID, Quantity_used, Distance)
VALUES 	(1, 1, 'Trimming', '2021-01-01', 500, NULL, NULL, 1.5),
		(2, 2, 'Fertilization', '2021-04-01', 200, 1, 1.0, 5),
		(3, 3, 'Injection', '2021-07-01', 500, 4, 2.0, 10),
		(4, 4, 'Injection', '2021-10-01', NULL, 3, 10, 2),
		(5, 5, 'Fertilization', '2022-01-01', 300, 2, 3.0, 7),
		(7, 6, 'Removal', '2022-04-01', 1000, NULL, NULL, 11),
		(8, 7, 'Injection', '2022-07-01', 600, 4, 1.0, 1),
		(9, 8, 'Injection', '2022-10-01', NULL, 3, 8, 5),
		(10, 10, 'Fertilization', '2023-01-01', 400, 2, 4, 15);
		
UPDATE Appointment
SET Sales_price = 1200
WHERE Appointment_ID = 6;

DELETE FROM Appointment
WHERE Appointment_ID = 8;

--Property
	   
INSERT INTO Property (Customer_ID, Address, City, State_code, Region_code)
VALUES 	(1, '123 Beech St', 'Sparks', 'NV', 'SPARKS'),
		(2, '456 Pine St', 'Reno', 'NV', 'MID'),
		(3, '789 Laurel St', 'Reno', 'NV', 'SW'),
		(4, '987 Elm St', 'Sparks', 'NV', 'SPARKS'),
		(5, '654 Oak St', 'Reno', 'NV', 'MID'),
		(6, '321 Maple St', 'Reno', 'NV', 'SW'),
		(7, '111 Cedar St', 'Sparks', 'NV', 'SPARKS'),
		(8, '222 Walnut St', 'Reno', 'NV', 'MID'),
		(10, '333 Birch St', 'Reno', 'NV', 'SW');

UPDATE Property
SET Address = '333 Birch Ave'
WHERE Address = '333 Birch St';

DELETE FROM property
WHERE Customer_ID = 10;

--Tree

INSERT INTO Tree (Health, Estimated_age, Work_performed, Date, Tree_species, Address)
VALUES 	('Healthy', 20, 'Trimming', '2021-01-01', 'Oak', '123 Beech St'),
		('Average', 15, 'Fertilization', '2021-04-01', 'Maple', '456 Pine St'),
		('Poor', 10, 'Injection', '2021-07-01', 'Pine', '789 Laurel St'),
		('Healthy', 30, 'Injection', '2021-10-01', 'Spruce', '987 Elm St'),
		('Average', 25, 'Fertilization', '2022-01-01', 'Birch', '654 Oak St'),
		('Poor', 10, 'Removal', '2022-04-01', 'Oak', '321 Maple St'),
		('Healthy', 35, 'Injection', '2022-07-01', 'Maple', '111 Cedar St'),
		('Average', 20, 'Injection', '2022-10-01', 'Pine', '222 Walnut St'),
		('Poor', 20, 'Removal', '2023-01-01', 'Maple', '222 Walnut St');

UPDATE Tree
SET Tree_species = 'Oak'
WHERE Tree_ID = 9;

DELETE FROM Tree
WHERE Tree_ID = 9;	
	   
-- Quarterly Sales

INSERT INTO Quarterly_sales (Quarter, Year, Appointment_ID)
VALUES 	('Q1', 2021, 1),
		('Q2', 2021, 2),
		('Q3', 2021, 3),
		('Q4', 2021, 4),
		('Q1', 2022, 5),
		('Q2', 2022, 6),
		('Q3', 2022, 7),
		('Q4', 2022, NULL),
		('Q1', 2023, 9);
		
UPDATE Quarterly_sales
SET Appointment_ID = 8
WHERE Appointment_ID = NULL;

DELETE FROM Quarterly_sales
WHERE Quarter = 'Q4' AND Year = 2022;

-- Inventory History. This table is only to be modified by trigger.

INSERT INTO Inventory_history (Product_ID, Product_cost, Units, Company_name, SKU, Product_name, Old_quantity, New_quantity, Change_time)
VALUES 	(1, 9.99, 'Liters', 'TreeCare Products Inc.', 'TC001', 'Rootmax', 8, NULL, NULL),
(2, 9.99, 'Liters', 'GreenThumb Tree Care Supplies', 'GT001', 'Tree Fertilizer', 5.5, NULL, NULL),
(3, 2.99, 'Plugs', 'Evergreen Tree Care Solutions', 'ETC001', 'Arborjet Plugs', 100, NULL, NULL),
(4, 119.99, 'Liters', 'ArborPro Tree Services', 'APTS001', 'Bug Destroyer', 15, NULL, NULL),
(5, 49.99, 'Liters', 'BranchMaster Tree Care', 'BMTC001', 'Tree Growth Hormone', 3.5, NULL, NULL),
(6, 59.99, 'Boxes', 'Nature Tree Care', 'NTC001', 'Tree Insecticide', 6.0, NULL, NULL),
(7, 39.99, 'Wraps', 'Roots & Shoots Tree Care', 'RSTC001', 'Tree Bark Protector', 3, NULL, NULL),
(8, 19.99, 'Bags', 'Canopy Tree Care Products', 'CTCP001', 'Tree Mulch', 4.0, NULL, NULL),
(9, 9.99, 'Bottles', 'TreeCare Experts', 'TCE001', 'Tree Health Tonic', 7, NULL, NULL);
		
CREATE OR REPLACE FUNCTION Record_inventory_changes()
RETURNS TRIGGER AS
$$
BEGIN
	IF NEW.Quantity <> OLD.Quantity THEN
	INSERT INTO Inventory_history (
		Product_ID,
		Product_Cost,
		Units,
		Company_name,
		SKU,
		Product_name,
		Old_quantity,
		New_quantity,
		Change_time
		)
	VALUES
		(
		OLD.Product_ID,
		OLD.Product_Cost,
		OLD.Units,
		OLD.Company_name,
		OLD.SKU,
		OLD.Product_name,
		OLD.quantity,
		NEW.quantity,
		now()
		);
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER inventory_history
AFTER UPDATE 
ON Inventory
FOR EACH ROW
EXECUTE PROCEDURE Record_inventory_changes();

-- Users

INSERT INTO Users (Username, Password)
VALUES 	('eastern1', 'eastern1');


-- Create 2 Views on the data

CREATE VIEW Dying_trees AS
		SELECT Tree_ID, Health 
		FROM Tree
		WHERE Health = 'Poor';

CREATE VIEW Low_inventory AS
		SELECT Product_ID, Quantity
		FROM Inventory
		WHERE Quantity <= 1;
		
-- Creation of tree() function. 
		
	-- This allows a user to easily research the attributes of a tree using only its ID.

CREATE OR REPLACE FUNCTION tree(ID INT) 
	RETURNS TABLE (
	tree_health VARCHAR(50),
    tree_age INT,
    tree_work VARCHAR(200),
    work_date DATE,
    species VARCHAR(100)
	)
AS $$
BEGIN
	RETURN QUERY SELECT
		Health,
		Estimated_Age,
		Work_performed,
		Date,
		Tree_species
	FROM
		public.tree
	WHERE
		Tree_ID = ID;
END;	
$$
LANGUAGE 'plpgsql';

-- Creation of sales() function. 

	-- This allows a manager to easily observe the value created by each individual employee.

CREATE OR REPLACE FUNCTION sales(person INT) 
	RETURNS TABLE (
	name VARCHAR(50),
    sales DECIMAL(10,2)
	)
AS $$
BEGIN
	RETURN QUERY SELECT
		Employee_name,
		CAST(AVG(Sales_price) AS DECIMAL(10,2))
	FROM
		public.employee,
		public.appointment
	WHERE
		employee.Employee_ID = person 
		AND appointment.Employee_ID = person
	GROUP BY
		employee.Employee_name;
END;	
$$
LANGUAGE 'plpgsql';

-- Creation of Stored Procedure update_inventory()

	-- Updates quantity of inventory based on appointment quantity and product used

CREATE OR REPLACE FUNCTION update_inventory()
RETURNS TRIGGER
AS $$
BEGIN
	IF NEW.Quantity_used <> OLD.Quantity_used THEN
		UPDATE Inventory
		SET Quantity = Quantity - (NEW.Quantity_used - OLD.Quantity_used)
		WHERE Product_ID = NEW.Product_ID;
	END IF;
	RETURN NEW;
END;
$$
LANGUAGE plpgsql;

-- Creation of Trigger

	-- Triggers Stored procedure after appointment quantity has been updated

CREATE OR REPLACE TRIGGER inventory_update
	BEFORE UPDATE OF quantity_used ON appointment
	FOR EACH ROW
	EXECUTE FUNCTION update_inventory();




