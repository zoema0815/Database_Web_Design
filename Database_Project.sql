
CREATE TABLE Customer (
    CustomerID varchar(11),
    BalanceDue REAL CHECK(BalanceDue>0),
    Address varchar(50),
    PRIMARY KEY (CustomerID)
)

CREATE TABLE Contact_Owner ( 
    ContactID varchar(11), 
    FirstName varchar(20), 
    LastName varchar(20),
    Email varchar(20),
    Phone INT,
    CustomerID varchar(11),
    PRIMARY KEY (CustomerID,ContactID),
    FOREIGN KEY (CustomerID) REFERENCES Customer
        ON DELETE CASCADE
)

CREATE TABLE Paint (
    PaintID varchar(11),
    ColorName varchar(20),
    ColorStyle varchar(20),
    PRIMARY KEY (PaintID)
)

CREATE TABLE FavoriteColor (
    CustomerID varchar(11),
    PaintID varchar(11),
    PRIMARY KEY (CustomerID, PaintID),
    FOREIGN KEY (CustomerID) REFERENCES Customer,
    FOREIGN KEY (PaintID) REFERENCES Paint
)


CREATE TABLE ModelType_Colorwork(
    TypeNumber varchar(11),
    TypeName varchar(20),
    SalePercentage REAL,
    CHECK(SalePercentage<1 AND SalePercentage>0),
    PaintID varchar(11) NOT NULL,
    PRIMARY KEY (TypeNumber),
    FOREIGN KEY (PaintID) REFERENCES Paint
        ON DELETE NO ACTION
)

CREATE TABLE Scooter_madeby(
    SerialNumber varchar(11),
    UnitPrice REAL CHECK(UnitPrice>0),
    TypeNumber varchar(11) NOT NULL,
    PRIMARY KEY (SerialNumber),
    FOREIGN KEY (TypeNumber) REFERENCES ModelType_Colorwork
        ON DELETE NO ACTION
)

CREATE TABLE OrderHistory_Buy(
    OrderID varchar(11),
    PricePaid REAL CHECK(PricePaid>0),
    OrderDate INTEGER,
    CustomerID varchar(11) NOT NULL,
    PRIMARY KEY (OrderID),
    FOREIGN KEY (CustomerID) REFERENCES Customer
        ON DELETE NO ACTION
)

CREATE TABLE Orders(
    orderID varchar(11),
    SerialNumber varchar(11),
    PRIMARY KEY (orderID, SerialNumber),
    FOREIGN KEY (orderID) REFERENCES OrderHistory_Buy,
    FOREIGN KEY (SerialNumber) REFERENCES Scooter_madeby
)

CREATE TABLE RetailStore(
    StoreID varchar(11),
    Phone INTEGER,
    Email varchar(20),
    Owner varchar(11),
    PRIMARY KEY (StoreID)
)

CREATE TABLE manages(
    SerialNumber varchar(11),
    StoreID varchar(11),
    PRIMARY KEY (SerialNumber, StoreID),
    FOREIGN KEY (SerialNumber) REFERENCES Scooter_madeby,
    FOREIGN KEY (StoreID) REFERENCES RetailStore
)

CREATE TABLE Locateat_Location(
    LocationID varchar(11),
    Address varchar(55),
    ZipCode varchar(20),
    City varchar(11),
    State varchar(11),
    StoreID varchar(11),
    PRIMARY KEY (StoreID,LocationID),
    FOREIGN KEY (StoreID) REFERENCES RetailStore
        ON DELETE CASCADE
)

-- Adding data into tables
-- customer data
INSERT INTO Customer (CustomerID, BalanceDue, Address)
VALUES ('Customer1', 32.00, '12 Main St');

INSERT INTO Customer (CustomerID, BalanceDue, Address)
VALUES ('Customer2', 750.00, '456 Elm St');

INSERT INTO Customer (CustomerID, BalanceDue, Address)
VALUES ('Customer3', 1000.00, '235 Columbia St');

INSERT INTO Customer (CustomerID, BalanceDue, Address)
VALUES ('Customer4', 10.00, '467 Oak St'); 

INSERT INTO Customer (CustomerID, BalanceDue, Address)
VALUES ('Customer5', 0.01, '3 West St');

INSERT INTO Customer (CustomerID, BalanceDue, Address)
VALUES ('Customer6', 0.21, '400 East St');

INSERT INTO Customer (CustomerID, BalanceDue, Address)
VALUES ('Customer7', 635.00, '890 Irvine Blvd');

INSERT INTO Customer (CustomerID, BalanceDue, Address)
VALUES ('Customer8', 770.00, '6 Old Way');

INSERT INTO Customer (CustomerID, BalanceDue, Address)
VALUES ('Customer9', 92.00, '9009 Tinker');

INSERT INTO Customer (CustomerID, BalanceDue, Address)
VALUES ('Customer10', 30.00, '86 Broadway');

INSERT INTO Customer (CustomerID, BalanceDue, Address)
VALUES ('Customer11', 500.00, '356 Main St');

INSERT INTO Customer (CustomerID, BalanceDue, Address)
VALUES ('Customer12', 1750.00, '356 Main St');

INSERT INTO Customer (CustomerID, BalanceDue, Address)
VALUES ('Customer13', 120.00, '134 Main St');

INSERT INTO Customer (CustomerID, BalanceDue, Address)
VALUES ('Customer14', 50.00, '765 Elm St');

INSERT INTO Customer (CustomerID, BalanceDue, Address)
VALUES ('Customer15', 250.00, '675 Plm St');

-- Contact_Owner

INSERT INTO Contact_Owner (ContactID, FirstName, LastName, Email, Phone, CustomerID)
VALUES ('201301', 'Alice', 'Brown', 'john.doe@example.com', 555123456, 'Customer1');

INSERT INTO Contact_Owner (ContactID, FirstName, LastName, Email, Phone, CustomerID)
VALUES ('201302', 'Molly', 'Wilson', 'janes@example.com', 555987654, 'Customer2');

INSERT INTO Contact_Owner (ContactID, FirstName, LastName, Email, Phone, CustomerID)
VALUES ('201303', 'Jake', 'Smith', 'micon@example.com', 555867530, 'Customer3');

INSERT INTO Contact_Owner (ContactID, FirstName, LastName, Email, Phone, CustomerID)
VALUES ('201304', 'Ethan', 'Johnson', 'sson@example.com', 555555334,'Customer4');

INSERT INTO Contact_Owner (ContactID, FirstName, LastName, Email, Phone, CustomerID)
VALUES ('201305', 'Olivia', 'Brown', 'davidb@example.com', 555111222, 'Customer5');

INSERT INTO Contact_Owner (ContactID, FirstName, LastName, Email, Phone, CustomerID)
VALUES ('201306', 'Ava', 'Williams', 'emava@example.com', 555314159, 'Customer6');

INSERT INTO Contact_Owner (ContactID, FirstName, LastName, Email, Phone, CustomerID)
VALUES ('201307', 'Noah', 'Davis', 'roverm@example.com', 555246802, 'Customer7');

INSERT INTO Contact_Owner (ContactID, FirstName, LastName, Email, Phone, CustomerID)
VALUES ('201308', 'Isabella', 'Wilson', 'lirris@example.com', 555777888, 'Customer8');

INSERT INTO Contact_Owner (ContactID, FirstName, LastName, Email, Phone, CustomerID)
VALUES ('201309', 'Sophia', 'Miller', 'wdon@example.com', 555456789, 'Customer9');

INSERT INTO Contact_Owner (ContactID, FirstName, LastName, Email, Phone, CustomerID)
VALUES ('201310', 'Emma', 'Jones', 'ssdwm@example.com', 555321765, 'Customer10');

INSERT INTO Contact_Owner (ContactID, FirstName, LastName, Email, Phone, CustomerID)
VALUES ('201311', 'Liam', 'Anderson', 'jsdadt@example.com', 555999123, 'Customer11');

INSERT INTO Contact_Owner (ContactID, FirstName, LastName, Email, Phone, CustomerID)
VALUES ('201312', 'Mason', 'Taylor', 'jsdfs2@example.com', 555543210, 'Customer12');

INSERT INTO Contact_Owner (ContactID, FirstName, LastName, Email, Phone, CustomerID)
VALUES ('201313', 'Isabella', 'Brown', 'IBSN3444@example.com', 555553211, 'Customer13');

INSERT INTO Contact_Owner (ContactID, FirstName, LastName, Email, Phone, CustomerID)
VALUES ('201314', 'Zoe', 'Williams', 'ZOE8999@example.com', 555583211, 'Customer14');

INSERT INTO Contact_Owner (ContactID, FirstName, LastName, Email, Phone, CustomerID)
VALUES ('201315', 'Jade', 'Johnson', 'jj234@example.com', 55544211, 'Customer15');

-- paint

INSERT INTO Paint (PaintID, ColorName, ColorStyle)
VALUES ('Paint1', 'Red', 'Matte');

INSERT INTO Paint (PaintID, ColorName, ColorStyle)
VALUES ('Paint2', 'Blue', 'Glossy');

INSERT INTO Paint (PaintID, ColorName, ColorStyle)
VALUES ('Paint3', 'Green', 'Metallic');

INSERT INTO Paint (PaintID, ColorName, ColorStyle)
VALUES ('Paint4', 'Yellow', 'Satin');

INSERT INTO Paint (PaintID, ColorName, ColorStyle)
VALUES ('Paint5', 'Purple', 'Purple');

INSERT INTO Paint (PaintID, ColorName, ColorStyle)
VALUES ('Paint6', 'Orange', 'Shiny');

INSERT INTO Paint (PaintID, ColorName, ColorStyle)
VALUES ('Paint7', 'Pink', 'Textured');

INSERT INTO Paint (PaintID, ColorName, ColorStyle)
VALUES ('Paint8', 'Brown', 'Sparkling');

INSERT INTO Paint (PaintID, ColorName, ColorStyle)
VALUES ('Paint9', 'White', 'Matte');

INSERT INTO Paint (PaintID, ColorName, ColorStyle)
VALUES ('Paint10', 'Black', 'Glossy');


-- FavoriteColor

INSERT INTO FavoriteColor (CustomerID, PaintID)
VALUES ((select CustomerID from Customer where CustomerID = 'Customer1'), (select PaintID from Paint where PaintID = 'Paint3'));

INSERT INTO FavoriteColor (CustomerID, PaintID)
VALUES ((select CustomerID from Customer where CustomerID = 'Customer2'), (select PaintID from Paint where PaintID = 'Paint2'));

INSERT INTO FavoriteColor (CustomerID, PaintID)
VALUES ((select CustomerID from Customer where CustomerID = 'Customer3'), (select PaintID from Paint where PaintID = 'Paint8'));

INSERT INTO FavoriteColor (CustomerID, PaintID)
VALUES ('Customer4', 'Paint6');

INSERT INTO FavoriteColor (CustomerID, PaintID)
VALUES ((select CustomerID from Customer where CustomerID = 'Customer5'), (select PaintID from Paint where PaintID = 'Paint10'));

INSERT INTO FavoriteColor (CustomerID, PaintID)
VALUES ((select CustomerID from Customer where CustomerID = 'Customer6'), (select PaintID from Paint where PaintID = 'Paint6'));

INSERT INTO FavoriteColor (CustomerID, PaintID)
VALUES ((select CustomerID from Customer where CustomerID = 'Customer7'), (select PaintID from Paint where PaintID = 'Paint9'));

INSERT INTO FavoriteColor (CustomerID, PaintID)
VALUES ((select CustomerID from Customer where CustomerID = 'Customer8'), (select PaintID from Paint where PaintID = 'Paint5'));

INSERT INTO FavoriteColor (CustomerID, PaintID)
VALUES ((select CustomerID from Customer where CustomerID = 'Customer9'), (select PaintID from Paint where PaintID = 'Paint4'));

INSERT INTO FavoriteColor (CustomerID, PaintID)
VALUES ((select CustomerID from Customer where CustomerID = 'Customer10'), (select PaintID from Paint where PaintID = 'Paint7'));

INSERT INTO FavoriteColor (CustomerID, PaintID)
VALUES ((select CustomerID from Customer where CustomerID = 'Customer11'), (select PaintID from Paint where PaintID = 'Paint1'));

INSERT INTO FavoriteColor (CustomerID, PaintID)
VALUES ((select CustomerID from Customer where CustomerID = 'Customer12'), (select PaintID from Paint where PaintID = 'Paint2'));

INSERT INTO FavoriteColor (CustomerID, PaintID)
VALUES ((select CustomerID from Customer where CustomerID = 'Customer13'), (select PaintID from Paint where PaintID = 'Paint8'));

INSERT INTO FavoriteColor (CustomerID, PaintID)
VALUES ((select CustomerID from Customer where CustomerID = 'Customer14'), (select PaintID from Paint where PaintID = 'Paint4'));

INSERT INTO FavoriteColor (CustomerID, PaintID)
VALUES ((select CustomerID from Customer where CustomerID = 'Customer15'), (select PaintID from Paint where PaintID = 'Paint8'));


-- ModelType_Colorwork

INSERT INTO ModelType_Colorwork (TypeNumber, TypeName, SalePercentage, PaintID)
VALUES ('Type1', 'Sporty', 0.042, (select PaintID from Paint where PaintID = 'Paint8'));

INSERT INTO ModelType_Colorwork (TypeNumber, TypeName, SalePercentage, PaintID)
VALUES ('Type2', 'Eco', 0.103, (select PaintID from Paint where PaintID = 'Paint4'));

INSERT INTO ModelType_Colorwork (TypeNumber, TypeName, SalePercentage, PaintID)
VALUES ('Type3', 'Basic', 0.13, (select PaintID from Paint where PaintID = 'Paint3'));

INSERT INTO ModelType_Colorwork (TypeNumber, TypeName, SalePercentage, PaintID)
VALUES ('Type4', 'Deluxe', 0.057, (select PaintID from Paint where PaintID = 'Paint2'));

INSERT INTO ModelType_Colorwork (TypeNumber, TypeName, SalePercentage, PaintID)
VALUES ('Type5', 'Off-Road', 0.13, (select PaintID from Paint where PaintID = 'Paint4'));

INSERT INTO ModelType_Colorwork (TypeNumber, TypeName, SalePercentage, PaintID)
VALUES ('Type6', 'Lightweight', 0.103, (select PaintID from Paint where PaintID = 'Paint6'));

INSERT INTO ModelType_Colorwork (TypeNumber, TypeName, SalePercentage, PaintID)
VALUES ('Type7', 'Speedy', 0.076, (select PaintID from Paint where PaintID = 'Paint9'));

INSERT INTO ModelType_Colorwork (TypeNumber, TypeName, SalePercentage, PaintID)
VALUES ('Type8', 'Folding', 0.069, (select PaintID from Paint where PaintID = 'Paint7'));

INSERT INTO ModelType_Colorwork (TypeNumber, TypeName, SalePercentage, PaintID)
VALUES ('Type9', 'Compact', 0.048, (select PaintID from Paint where PaintID = 'Paint1'));

INSERT INTO ModelType_Colorwork (TypeNumber, TypeName, SalePercentage, PaintID)
VALUES ('Type10', 'Performance', 0.107, (select PaintID from Paint where PaintID = 'Paint10'));

INSERT INTO ModelType_Colorwork (TypeNumber, TypeName, SalePercentage, PaintID)
VALUES ('Type11', 'Retro', 0.046, (select PaintID from Paint where PaintID = 'Paint5'));

INSERT INTO ModelType_Colorwork (TypeNumber, TypeName, SalePercentage, PaintID)
VALUES ('Type12', 'Street', 0.088, (select PaintID from Paint where PaintID = 'Paint2'));


-- Scooter_madeby

INSERT INTO Scooter_madeby (SerialNumber, UnitPrice, TypeNumber)
VALUES ('S11123', 460, (select TypeNumber from ModelType_Colorwork where TypeNumber = 'Type12'));

INSERT INTO Scooter_madeby (SerialNumber, UnitPrice, TypeNumber)
VALUES ('S222123', 250, (select TypeNumber from ModelType_Colorwork where TypeNumber = 'Type9'));

INSERT INTO Scooter_madeby (SerialNumber, UnitPrice, TypeNumber)
VALUES ('S33312', 340, (select TypeNumber from ModelType_Colorwork where TypeNumber = 'Type5'));

INSERT INTO Scooter_madeby (SerialNumber, UnitPrice, TypeNumber)
VALUES ('S444512', 540, (select TypeNumber from ModelType_Colorwork where TypeNumber = 'Type6'));

INSERT INTO Scooter_madeby (SerialNumber, UnitPrice, TypeNumber)
VALUES ('S55598', 340, (select TypeNumber from ModelType_Colorwork where TypeNumber = 'Type3'));

INSERT INTO Scooter_madeby (SerialNumber, UnitPrice, TypeNumber)
VALUES ('S66639', 340, (select TypeNumber from ModelType_Colorwork where TypeNumber = 'Type3'));

INSERT INTO Scooter_madeby (SerialNumber, UnitPrice, TypeNumber)
VALUES ('S777543', 560, (select TypeNumber from ModelType_Colorwork where TypeNumber = 'Type10'));

INSERT INTO Scooter_madeby (SerialNumber, UnitPrice, TypeNumber)
VALUES ('S888914', 220, (select TypeNumber from ModelType_Colorwork where TypeNumber = 'Type1'));

INSERT INTO Scooter_madeby (SerialNumber, UnitPrice, TypeNumber)
VALUES ('S999001', 270, (select TypeNumber from ModelType_Colorwork where TypeNumber = 'Type2'));

INSERT INTO Scooter_madeby (SerialNumber, UnitPrice, TypeNumber)
VALUES ('S1010456', 300, (select TypeNumber from ModelType_Colorwork where TypeNumber = 'Type4'));

INSERT INTO Scooter_madeby (SerialNumber, UnitPrice, TypeNumber)
VALUES ('S1111099', 340, (select TypeNumber from ModelType_Colorwork where TypeNumber = 'Type5'));

INSERT INTO Scooter_madeby (SerialNumber, UnitPrice, TypeNumber)
VALUES ('S121256', 400, (select TypeNumber from ModelType_Colorwork where TypeNumber = 'Type7'));

INSERT INTO Scooter_madeby (SerialNumber, UnitPrice, TypeNumber)
VALUES ('S1313588', 360, (select TypeNumber from ModelType_Colorwork where TypeNumber = 'Type8'));

INSERT INTO Scooter_madeby (SerialNumber, UnitPrice, TypeNumber)
VALUES ('S145234', 240, (select TypeNumber from ModelType_Colorwork where TypeNumber = 'Type11'));

INSERT INTO Scooter_madeby (SerialNumber, UnitPrice, TypeNumber)
VALUES ('S158890', 270, (select TypeNumber from ModelType_Colorwork where TypeNumber = 'Type2'));

-- OrderHistory_Buy

INSERT INTO OrderHistory_Buy (OrderID, PricePaid, OrderDate, CustomerID)
VALUES ('O1xxp098', 200, 130101, (select CustomerID from Customer where CustomerID = 'Customer1'));

INSERT INTO OrderHistory_Buy (OrderID, PricePaid, OrderDate, CustomerID)
VALUES ('O289345r', 300, 130102, (select CustomerID from Customer where CustomerID = 'Customer2'));

INSERT INTO OrderHistory_Buy (OrderID, PricePaid, OrderDate, CustomerID)
VALUES ('O3zz890m2', 400, 130103, (select CustomerID from Customer where CustomerID = 'Customer3'));

INSERT INTO OrderHistory_Buy (OrderID, PricePaid, OrderDate, CustomerID)
VALUES ('O400234po', 400, 130103, (select CustomerID from Customer where CustomerID = 'Customer4'));

INSERT INTO OrderHistory_Buy (OrderID, PricePaid, OrderDate, CustomerID)
VALUES ('O5123ert', 450, 130104, (select CustomerID from Customer where CustomerID = 'Customer5'));

INSERT INTO OrderHistory_Buy (OrderID, PricePaid, OrderDate, CustomerID)
VALUES ('O6o6734z', 250, 130105, (select CustomerID from Customer where CustomerID = 'Customer6'));

INSERT INTO OrderHistory_Buy (OrderID, PricePaid, OrderDate, CustomerID)
VALUES ('O778er091', 300, 130106, (select CustomerID from Customer where CustomerID = 'Customer7'));

INSERT INTO OrderHistory_Buy (OrderID, PricePaid, OrderDate, CustomerID)
VALUES ('O818iez', 450, 130108, (select CustomerID from Customer where CustomerID = 'Customer8'));

INSERT INTO OrderHistory_Buy (OrderID, PricePaid, OrderDate, CustomerID)
VALUES ('O9tasbsb', 150, 130109, (select CustomerID from Customer where CustomerID = 'Customer9'));

INSERT INTO OrderHistory_Buy (OrderID, PricePaid, OrderDate, CustomerID)
VALUES ('O10zz286', 300, 130111, (select CustomerID from Customer where CustomerID = 'Customer10'));

INSERT INTO OrderHistory_Buy (OrderID, PricePaid, OrderDate, CustomerID)
VALUES ('O11110oo', 200, 130113, (select CustomerID from Customer where CustomerID = 'Customer11'));

INSERT INTO OrderHistory_Buy (OrderID, PricePaid, OrderDate, CustomerID)
VALUES ('O120zbf2', 100, 130115, (select CustomerID from Customer where CustomerID = 'Customer12'));

INSERT INTO OrderHistory_Buy (OrderID, PricePaid, OrderDate, CustomerID)
VALUES ('O13pasl5', 100, 130117, (select CustomerID from Customer where CustomerID = 'Customer13'));

INSERT INTO OrderHistory_Buy (OrderID, PricePaid, OrderDate, CustomerID)
VALUES ('O14ghm01', 150, 130118, (select CustomerID from Customer where CustomerID = 'Customer14'));

INSERT INTO OrderHistory_Buy (OrderID, PricePaid, OrderDate, CustomerID)
VALUES ('O15po0xd', 150, 130118, (select CustomerID from Customer where CustomerID = 'Customer15'));

-- Orders

INSERT INTO Orders (orderID, SerialNumber)
VALUES ((select OrderID from OrderHistory_Buy where OrderID = 'O1xxp098'), (select SerialNumber from Scooter_madeby where SerialNumber = 'S11123'));

INSERT INTO Orders (orderID, SerialNumber)
VALUES ((select OrderID from OrderHistory_Buy where OrderID = 'O289345r'), (select SerialNumber from Scooter_madeby where SerialNumber = 'S222123'));

INSERT INTO Orders (orderID, SerialNumber)
VALUES ('O3zz890m2', 'S33312');

INSERT INTO Orders (orderID, SerialNumber)
VALUES ('O400234po', 'S444512');

INSERT INTO Orders (orderID, SerialNumber)
VALUES ('O5123ert', 'S55598');

INSERT INTO Orders (orderID, SerialNumber)
VALUES ('O6o6734z', 'S66639');

INSERT INTO Orders (orderID, SerialNumber)
VALUES ('O778er091', 'S777543');

INSERT INTO Orders (orderID, SerialNumber)
VALUES ('O818iez', 'S888914');

INSERT INTO Orders (orderID, SerialNumber)
VALUES ('O9tasbsb', 'S999001');

INSERT INTO Orders (orderID, SerialNumber)
VALUES ('O10zz286', 'S1010456');

INSERT INTO Orders (orderID, SerialNumber)
VALUES ('O11110oo', 'S1111099');

INSERT INTO Orders (orderID, SerialNumber)
VALUES ('O120zbf2', 'S121256');

INSERT INTO Orders (orderID, SerialNumber)
VALUES ('O13pasl5', 'S1313588');

INSERT INTO Orders (orderID, SerialNumber)
VALUES ('O14ghm01', 'S145234');

INSERT INTO Orders (orderID, SerialNumber)
VALUES ('O15po0xd', 'S158890');

-- RetailStore

INSERT INTO RetailStore (StoreID, Phone, Email, Owner)
VALUES ('1', 555767999, 'yxj@example.com', 'Owner1');

INSERT INTO RetailStore (StoreID, Phone, Email, Owner)
VALUES ('2', 567888000, 'dfg322@example.com', 'Owner2');

INSERT INTO RetailStore (StoreID, Phone, Email, Owner)
VALUES ('3', 555878999, 'cd690j@example.com', 'Owner3');

INSERT INTO RetailStore (StoreID, Phone, Email, Owner)
VALUES ('4', 555787666, 'xj123@example.com', 'Owner4');

INSERT INTO RetailStore (StoreID, Phone, Email, Owner)
VALUES ('5',555456321 , 'ly34@example.com', 'Owner5');

INSERT INTO RetailStore (StoreID, Phone, Email, Owner)
VALUES ('6', 555451340, 'erxj@example.com', 'Owner6');

INSERT INTO RetailStore (StoreID, Phone, Email, Owner)
VALUES ('7', 555640380, 'asyxj@example.com', 'Owner7');

INSERT INTO RetailStore (StoreID, Phone, Email, Owner)
VALUES ('8', 555567899, 'sdj@example.com', 'Owner8');

INSERT INTO RetailStore (StoreID, Phone, Email, Owner)
VALUES ('9', 555345678, 'j56j@example.com', 'Owner9');

INSERT INTO RetailStore (StoreID, Phone, Email, Owner)
VALUES ('10', 555342989, 'kk2j@example.com', 'Owner10');

INSERT INTO RetailStore (StoreID, Phone, Email, Owner)
VALUES ('11', 555678432, 'tyu789@example.com', 'Owner11');


-- manages

INSERT INTO manages (SerialNumber, StoreID)
VALUES ((select SerialNumber from Scooter_madeby where SerialNumber = 'S11123'), (select StoreID from RetailStore where StoreID = '3'));

INSERT INTO manages (SerialNumber, StoreID)
VALUES ('S222123', '7');

INSERT INTO manages (SerialNumber, StoreID)
VALUES ('S33312', '5');

INSERT INTO manages (SerialNumber, StoreID)
VALUES ('S444512', '1');

INSERT INTO manages (SerialNumber, StoreID)
VALUES ('S55598', '2');

INSERT INTO manages (SerialNumber, StoreID)
VALUES ('S66639', '10');

INSERT INTO manages (SerialNumber, StoreID)
VALUES ('S777543', '8');

INSERT INTO manages (SerialNumber, StoreID)
VALUES ('S888914', '4');

INSERT INTO manages (SerialNumber, StoreID)
VALUES ('S999001', '10');

INSERT INTO manages (SerialNumber, StoreID)
VALUES ('S1010456', '5');

INSERT INTO manages (SerialNumber, StoreID)
VALUES ('S1111099', '8');

INSERT INTO manages (SerialNumber, StoreID)
VALUES ('S121256', '6');

INSERT INTO manages (SerialNumber, StoreID)
VALUES ('S1313588', '4');

INSERT INTO manages (SerialNumber, StoreID)
VALUES ('S145234', '2');

INSERT INTO manages (SerialNumber, StoreID)
VALUES ('S158890', '11');

-- Locateat_Location

INSERT INTO Locateat_Location (LocationID, Address, ZipCode, City, State, StoreID)
VALUES ('location1', '789 Oak St', '15213','Pittsburgh', 'PA',  (select StoreID from RetailStore where StoreID = '1'));

INSERT INTO Locateat_Location (LocationID, Address, ZipCode, City, State, StoreID)
VALUES ('location2', '130 Main Street', '94577','Oakville', 'CA', '2');

INSERT INTO Locateat_Location (LocationID, Address, ZipCode, City, State, StoreID)
VALUES ('location3', '321 Pine Road', '29601','Greenville', 'SC', '3');

INSERT INTO Locateat_Location (LocationID, Address, ZipCode, City, State, StoreID)
VALUES ('location4', '567 Summer Drive', '98101','Seattle', 'WA', '4');

INSERT INTO Locateat_Location (LocationID, Address, ZipCode, City, State, StoreID)
VALUES ('location5', '590 Maple Drive', '85001','Phoenix', 'AZ', '5');

INSERT INTO Locateat_Location (LocationID, Address, ZipCode, City, State, StoreID)
VALUES ('location6', '890 Cedar Street', '78701','Austin', 'TX', '6');

INSERT INTO Locateat_Location (LocationID, Address, ZipCode, City, State, StoreID)
VALUES ('location7', '234 Birch Lane', '80201','Denver', 'CO', '7');

INSERT INTO Locateat_Location (LocationID, Address, ZipCode, City, State, StoreID)
VALUES ('location8', '876 Walnut Avenue', '33101','Miami', 'FL', '8');

INSERT INTO Locateat_Location (LocationID, Address, ZipCode, City, State, StoreID)
VALUES ('location9', '543 Cherry Road', '10001','New York', 'NY', '9');

INSERT INTO Locateat_Location (LocationID, Address, ZipCode, City, State, StoreID)
VALUES ('location10', '987 Peach Boulevard', '90001','Los Angeles', 'CA', '10');

INSERT INTO Locateat_Location (LocationID, Address, ZipCode, City, State, StoreID)
VALUES ('location11', '790 Oak Lane', '67890','Springfield', 'IL', '11');


-- Query examples
-- 1.calculate total sales revenue
SELECT c.CustomerID, SUM(oh.PricePaid) AS TotalRevenue
FROM Customer c
LEFT JOIN OrderHistory_Buy oh ON c.CustomerID = oh.CustomerID
GROUP BY c.CustomerID;


-- 2. list stores and number of scooters they manage
SELECT r.StoreID, COUNT(m.SerialNumber) AS NumberOfScootersManaged
FROM RetailStore r
LEFT JOIN manages m ON r.StoreID = m.StoreID
GROUP BY r.StoreID;

-- 3. list name of customers and their preferred color
SELECT c.CustomerID, c.FirstName, c.LastName, p.ColorName
FROM Contact_Owner c
JOIN FavoriteColor fc ON c.CustomerID = fc.CustomerID
JOIN Paint p ON fc.PaintID = p.PaintID;

-- Updating database 
-- Active: 1699041193421@@34.74.171.121@5432@proj1part2@rm4069

-- Add one arrary attribute into Table customer
ALTER TABLE Customer
ADD COLUMN PurchasedProducts varchar(11)[]; 

-- Add one text attribute into Table 
ALTER TABLE ModelType_Colorwork
ADD COLUMN Description text;

-- Define a new composite type using CREATE TYPE and create a new table of that type
CREATE TYPE paint_producer AS (
    brand varchar(20),
    origincity varchar(11),
    expiredate INTEGER
);

CREATE TABLE Producers (
    producerID SERIAL PRIMARY KEY,
    details paint_producer,
    paintID varchar(11) REFERENCES Paint(PaintID)
);



-- Insert data  
INSERT INTO Producers (details, paintID)
VALUES
  (ROW('Rust-Oleum', 'Riverford', 20290811), 'Paint1'),
  (ROW('Valspar', 'Mapleview', 20211231), 'Paint2'),
  (ROW('Montana Cans', 'Suncrest', 20300201), 'Paint3'),
  (ROW('Krylon', 'Greenfiled', 20230731), 'Paint4'),
  (ROW('Valspar', 'Mapleview', 20191001), 'Paint5'),
  (ROW('Dupli-Color', 'New York', 20270527), 'Paint6'),
  (ROW('Montana Cans', 'Suncrest', 20291130), 'Paint7'),
  (ROW('ColorSplash', 'Irvine', 20250703), 'Paint8'),
  (ROW('Valspar', 'Mapleview', 20270318), 'Paint9'),
  (ROW('UrbanCanvas', 'Orange', 20240711), 'Paint10');

UPDATE Customer
SET PurchasedProducts = ARRAY['S11123']
WHERE CustomerID = 'Customer2';

UPDATE Customer
SET PurchasedProducts = ARRAY['S777543']
WHERE CustomerID = 'Customer1';

UPDATE Customer
SET PurchasedProducts = ARRAY['S66639','S1111099']
WHERE CustomerID = 'Customer3';

UPDATE Customer
SET PurchasedProducts = ARRAY['S222123','S33312']
WHERE CustomerID = 'Customer4';

UPDATE Customer
SET PurchasedProducts = ARRAY['S158890']
WHERE CustomerID = 'Customer5';

UPDATE Customer
SET PurchasedProducts = ARRAY['S999001']
WHERE CustomerID = 'Customer6';

UPDATE Customer
SET PurchasedProducts = ARRAY['S121256']
WHERE CustomerID = 'Customer7';

UPDATE Customer
SET PurchasedProducts = ARRAY['S145234', 'S55598']
WHERE CustomerID = 'Customer9';

UPDATE Customer
SET PurchasedProducts = ARRAY['S444512']
WHERE CustomerID = 'Customer10';

UPDATE Customer
SET PurchasedProducts = ARRAY['S888914']
WHERE CustomerID = 'Customer14';


UPDATE ModelType_Colorwork
SET Description = 'Customer review of type#1: Sporty Paint8 delivers on its promise of vibrancy and endurance. I used it for my mountain bike, and the color still looks fresh after months of rough trails. Highly recommended for outdoor gear!'
WHERE TypeNumber = 'Type1';

UPDATE ModelType_Colorwork
SET Description = 'Customer review of type#2: I appreciate the Eco for its eco-friendly formulation. The application was smooth, and the coverage was excellent. It’s great to see a product thats kind to the environment without sacrificing quality.'
WHERE TypeNumber = 'Type2';

UPDATE ModelType_Colorwork
SET Description = 'Customer review of type#3: This scooter is my go-to for all my crafting projects. It provides good coverage and a decent color selection for a very affordable price. Its a solid choice for anyone on a budget'
WHERE TypeNumber = 'Type3';

UPDATE ModelType_Colorwork
SET Description = 'Customer review of type#4: Deluxe Paint2 truly lives up to its name. The finish is superior and has a luxurious sheen that I have not found in other brands. Its perfect for pieces that need that extra touch of elegance.'
WHERE TypeNumber = 'Type4';

UPDATE ModelType_Colorwork
SET Description = 'Customer review of type#5: Off-Road is tough as nails. I have used it on my off-road vehicle, and it has resisted scratches and weathering like a champ. If durability is what you need, this is the paint for you.'
WHERE TypeNumber = 'Type5';

UPDATE ModelType_Colorwork
SET Description = 'Customer review of type#6: The Lightweight Paint6 is surprisingly effective given how light it feels. I used it on a model airplane, and it added almost no weight, which was critical for flight.'
WHERE TypeNumber = 'Type6';

UPDATE ModelType_Colorwork
SET Description = 'Customer review of type#7: Speedy Paint9 dries incredibly fast, which is a huge plus for quick projects. The color did not run and maintained its intensity even after drying. Perfect for last-minute touch-ups.'
WHERE TypeNumber = 'Type7';

UPDATE ModelType_Colorwork
SET Description = 'Customer review of type#8: I was skeptical about how well Folding Paint7 would work on a folding table, but it flexed without cracking. Its an ideal paint for surfaces that need to bend or move.'
WHERE TypeNumber = 'Type8';

UPDATE ModelType_Colorwork
SET Description = 'Customer review of type#9: Compact Paint7 comes in a small can but goes a long way. The coverage is impressive, and the paint quality is top-notch.'
WHERE TypeNumber = 'Type9';

UPDATE ModelType_Colorwork
SET Description = 'Customer review of type#10: Performance Paint1 is a game-changer for automotive enthusiasts. It applies smoothly and withstands high temperatures without losing its finish. I recommend it for engine parts and exhausts.'
WHERE TypeNumber = 'Type10';

UPDATE ModelType_Colorwork
SET Description = 'Customer review of type#11: Retro Paint5 gave my vintage furniture a much-needed facelift. The classic colors are spot on, and the paint adheres well to all surfaces. It’s like a trip back in time!'
WHERE TypeNumber = 'Type11';

UPDATE ModelType_Colorwork
SET Description = 'Customer review of type#12: Street Paint2 is vibrant and has a gritty edge that is perfect for urban art. The pigmentation is rich, and it holds up well against the elements. For street artists, this paint is a staple.'
WHERE TypeNumber = 'Type12';

-- Queries
SELECT CustomerID, PurchasedProducts[1] AS FirstPurchase
FROM Customer
WHERE PurchasedProducts IS NOT NULL;

SELECT TypeNumber, TypeName, SalePercentage, PaintID, Description
FROM ModelType_Colorwork
WHERE to_tsvector('english', Description) @@ to_tsquery('english', 'quality');

SELECT 
    producerID,
    (details).brand AS Brand,
    (details).origincity AS OriginCity,
    (details).expiredate AS ExpireDate,
    paintID
FROM Producers
WHERE (details).origincity = 'New York';