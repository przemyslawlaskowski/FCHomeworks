-- 1. Create the database SklepInternetowy

CREATE DATABASE SklepInternetowy;


-- 2. Create tables with appropriate constraints
-- Table: Klienci (Customers)
USE SklepInternetowy;
CREATE TABLE Klienci (
    KlientID INT PRIMARY KEY AUTO_INCREMENT,
    Imie NVARCHAR(50) NOT NULL,
    Nazwisko NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    DataUrodzenia DATE,
    DataRejestracji DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Table: Produkty (Products)
CREATE TABLE Produkty (
    ProduktID INT PRIMARY KEY AUTO_INCREMENT,
    Nazwa NVARCHAR(100) NOT NULL,
    Cena DECIMAL(10, 2) NOT NULL,
    IloscNaStanie INT CHECK (IloscNaStanie >= 0)
);

-- Table: Zamowienia (Orders)
CREATE TABLE Zamowienia (
    ZamowienieID INT PRIMARY KEY AUTO_INCREMENT,
    KlientID INT,
    DataZamowienia DATETIME DEFAULT CURRENT_TIMESTAMP,
    Status NVARCHAR(20) CHECK (Status IN ('Zlozone', 'Wyslane', 'Dostarczone', 'Anulowane')),
    CONSTRAINT FK_KlientZamowienie FOREIGN KEY (KlientID) REFERENCES Klienci(KlientID)
);

-- Table: SzczegolyZamowienia (OrderDetails)
CREATE TABLE SzczegolyZamowienia (
    SzczegolyZamowieniaID INT PRIMARY KEY AUTO_INCREMENT,
    ZamowienieID INT,
    ProduktID INT,
    Ilosc INT CHECK (Ilosc > 0),
    Cena DECIMAL(10, 2),
    CONSTRAINT FK_ZamowienieSzczegoly FOREIGN KEY (ZamowienieID) REFERENCES Zamowienia(ZamowienieID),
    CONSTRAINT FK_ProduktSzczegoly FOREIGN KEY (ProduktID) REFERENCES Produkty(ProduktID)
);


-- 3. Populate tables with sample data

-- Insert into Klienci
INSERT INTO Klienci (Imie, Nazwisko, Email, DataUrodzenia)
VALUES 
('Jan', 'Kowalski', 'jan.kowalski@email.com', '1985-03-15'),
('Anna', 'Nowak', 'anna.nowak@email.com', '1992-07-10'),
('Piotr', 'Zielinski', 'piotr.zielinski@email.com', '2001-12-21');

-- Insert into Produkty
INSERT INTO Produkty (Nazwa, Cena, IloscNaStanie)
VALUES 
('Laptop', 2500.00, 15),
('Smartfon', 3500.00, 30),
('Słuchawki', 200.00, 50);

-- Insert into Zamowienia
INSERT INTO Zamowienia (KlientID, Status)
VALUES 
(1, 'Zlozone'),
(2, 'Wyslane'),
(3, 'Dostarczone');

-- Insert into SzczegolyZamowienia
INSERT INTO SzczegolyZamowienia (ZamowienieID, ProduktID, Ilosc, Cena)
VALUES 
(1, 1, 1, 2500.00),
(2, 2, 2, 3000.00),
(3, 3, 3, 600.00);


-- 4. Analyze price changes of products in orders
SELECT 
    ProduktID, 
    MIN(Cena) AS MinPrice, 
    MAX(Cena) AS MaxPrice, 
    COUNT(*) AS TotalOrders
FROM 
    SzczegolyZamowienia
GROUP BY 
    ProduktID;

   
-- 5. Calculate total product sales over months
SELECT 
    MONTH(Zamowienia.DataZamowienia) AS Month, 
    Produkty.Nazwa, 
    SUM(SzczegolyZamowienia.Cena * SzczegolyZamowienia.Ilosc) AS TotalSales
FROM 
    SzczegolyZamowienia
JOIN 
    Zamowienia ON SzczegolyZamowienia.ZamowienieID = Zamowienia.ZamowienieID
JOIN 
    Produkty ON SzczegolyZamowienia.ProduktID = Produkty.ProduktID
GROUP BY 
    MONTH(Zamowienia.DataZamowienia), Produkty.Nazwa;

   
-- 6. Create a table `DaneJson` with columns `ID` and `Dane` (NVARCHAR(MAX))
CREATE TABLE DaneJson (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Dane NVARCHAR()
);

-- OR

-- In my case, I had to use this version (MariaDB MySQL). 
CREATE TABLE DaneJson (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Dane LONGTEXT
);



-- 7. Insert JSON data into `DaneJson` and query using JSON_VALUE to extract information

-- Sample JSON data insert
INSERT INTO DaneJson (Dane) 
VALUES 
('{"Imie": "Przemek", "Nazwisko": "Laskowski", "Wiek": 33)'),
('{"Imie": "Anna", "Nazwisko": "Nowak", "Wiek": 28}');

-- Query to extract 'Imie' from JSON data
SELECT 
    JSON_VALUE(Dane, '$.Imie') AS FirstName,
    JSON_VALUE(Dane, '$.Nazwisko') AS LastName
FROM 
    DaneJson;

   
-- 8. Optimizing queries, indexes, and joins to improve database performance

-- 8a. Adding indexes on foreign keys to speed up joins
CREATE INDEX idx_KlientID ON Zamowienia (KlientID);
CREATE INDEX idx_ProduktID ON SzczegolyZamowienia (ProduktID);
CREATE INDEX idx_ZamowienieID ON SzczegolyZamowienia (ZamowienieID);

-- 8b. Limit the number of records returned for large tables (example for Zamowienia)
SELECT * 
FROM Zamowienia
LIMIT 100; -- Limits the number of rows returned to 100

-- 8c. Optimize JOIN query performance by ensuring proper indexing and using INNER JOIN where appropriate
SELECT 
    Klienci.Imie, 
    Klienci.Nazwisko, 
    Produkty.Nazwa AS Produkt, 
    SzczegolyZamowienia.Ilosc, 
    SzczegolyZamowienia.Cena
FROM 
    Klienci
INNER JOIN 
    Zamowienia ON Klienci.KlientID = Zamowienia.KlientID
INNER JOIN 
    SzczegolyZamowienia ON Zamowienia.ZamowienieID = SzczegolyZamowienia.ZamowienieID
INNER JOIN 
    Produkty ON SzczegolyZamowienia.ProduktID = Produkty.ProduktID;
