USE  NTESLE
BEGIN TRAN
CREATE TABLE Customer(
CustomerId VARCHAR(10) PRIMARY KEY CHECK(CustomerId LIKE 'CS[0-9][0-9][0-9]'),
CustomerName VARCHAR(50),
CustomerPhone VARCHAR(15)CHECK(CustomerPhone LIKE '+62%'),
CustomerAdsress VARCHAR(50)
)
GO
COMMIT

BEGIN TRAN
CREATE TABLE Staff(
StaffId VARCHAR(10) PRIMARY KEY CHECK(StaffId LIKE 'ST[0-9][0-9][0-9]'),
StaffName VARCHAR(25),
StaffGender VARCHAR(10)CHECK(StaffGender LIKE 'Female' OR StaffGender LIKE 'Male'),
StaffPhone VARCHAR(15),
StaffDOB DATE,
Salary NUMERIC(11,2)CHECK(Salary BETWEEN 1000000 AND 10000000)
)
GO
COMMIT

BEGIN TRAN
CREATE TABLE ProductType(
ProductTypeId VARCHAR(5) PRIMARY KEY CHECK(ProductTypeId LIKE 'PT[0-9][0-9][0-9]'),
ProductTypeName VARCHAR(25)
)
GO

BEGIN TRAN
CREATE TABLE Product(
ProductId VARCHAR (10) PRIMARY KEY CHECK(ProductId LIKE 'PD[0-9][0-9][0-9]'),
ProductName VARCHAR (15)CHECK(LEN(ProductName) >=5),
Price NUMERIC (11,2) CHECK(Price >= 5000),
ExpiredDate DATE CHECK(YEAR(ExpiredDate) > '2020'),
ProductTypeId VARCHAR(5)REFERENCES ProductType(ProductTypeId) ON UPDATE CASCADE ON DELETE CASCADE
)
GO

BEGIN TRAN
CREATE TABLE SalesTransaction(
SalesTransactionId VARCHAR(5) PRIMARY KEY CHECK(SalesTransactionId LIKE 'SL[0-9][0-9][0-9]'),
StaffId VARCHAR(10) REFERENCES Staff(StaffId)ON UPDATE CASCADE ON DELETE CASCADE,
CustomerId VARCHAR(10) REFERENCES Customer(CustomerId)ON UPDATE CASCADE ON DELETE CASCADE,
SalesDate DATE,
)

BEGIN TRAN
CREATE TABLE DetailSalesTransaction(
SalesTransactionId VARCHAR(5) REFERENCES SalesTransaction(SalesTransactionId)ON UPDATE CASCADE ON DELETE CASCADE,
ProductId VARCHAR (10) REFERENCES Product(ProductId) ON UPDATE CASCADE ON DELETE CASCADE,
ProductQtty INT,
PRIMARY KEY(SalesTransactionId,ProductId)
)

------------------------------------------------------------------------------
BEGIN TRAN
CREATE TABLE Supplier(
SupplierId VARCHAR(5) PRIMARY KEY CHECK(SupplierId LIKE 'SU[0-9][0-9][0-9]'),
SupplierName VARCHAR(25),
SupplierPhone VARCHAR(15),
SuppplierAddress VARCHAR(30)
)
BEGIN TRAN
CREATE TABLE Ingredients(
IngredientsId VARCHAR(5) PRIMARY KEY CHECK(IngredientsId LIKE 'IG[0-9][0-9][0-9]'),
IngredientsName VARCHAR (25),
IngredientsPrice NUMERIC(11,2),
IngredientsExpiredDate DATE CHECK (YEAR(IngredientsExpiredDate) > '2020')
)
 BEGIN TRAN
CREATE TABLE PurchaseTransaction(
PurchaseId varchar(5) PRIMARY KEY CHECK(PurchaseId LIKE 'PU[0-9][0-9][0-9]'),
StaffId VARCHAR(10) REFERENCES Staff(StaffId)ON UPDATE CASCADE ON DELETE CASCADE,
SupplierId VARCHAR(5)REFERENCES Supplier(SupplierId)ON UPDATE CASCADE ON DELETE CASCADE,
DatePurchase DATE
)

BEGIN TRAN
CREATE TABLE DetailPurchaseTransaction(
PurchaseId varchar(5) REFERENCES PurchaseTransaction(PurchaseId)ON UPDATE CASCADE ON DELETE CASCADE,
IngredientsId VARCHAR(5) REFERENCES Ingredients(IngredientsId)ON UPDATE CASCADE ON DELETE CASCADE,
IngredientsQtty INT,
PRIMARY KEY(PurchaseId,IngredientsId)
)

COMMIT