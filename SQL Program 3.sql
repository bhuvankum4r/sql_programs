## Lab Program 3
## Puppy pet shop wants to keep track of dogs and their owners. The person can buy maximum three pet dogs.
## We store person’s name, SSN and address and dog’s name, date of purchase and sex. 
## The owner of the pet dogs will be identified by SSN since the dog’s names are not distinct.
## a) Establish the database by normalizing up to 3NF and considering all schema level constraints.
## b) Write SQL insertion query to insert few tuples to all the relations.
## c) List all pets owned by a person ‘Abhiman’. 
## d) List all persons who are not owned a single pet 
## e) Write a trigger to check the constraint that the person can buy maximum three pet dogs 
## f) Write a procedure to list all dogs and owner details purchased on the specific date.

CREATE SCHEMA PETSHOP;
USE PETSHOP;

-- Query 1
## Establish the database by normalizing up to 3NF and considering all schema level constraints.
### Owner table: Owner SSN (primary key), Owner name, Owner address
### Dog table: Dog ID (primary key), Dog name, Sex
### Purchase table: Owner SSN (foreign key), Dog ID (foreign key), Date of purchase
CREATE TABLE Petstore (
StoreName VARCHAR(50) PRIMARY KEY,
StoreLocation VARCHAR(50)
);
CREATE TABLE Owner (
SSN VARCHAR(11),
Name VARCHAR(50),
Address VARCHAR(100),
PRIMARY KEY (SSN)
);
CREATE TABLE Dog (
DogID INT,
Name VARCHAR(50),
Sex CHAR(1),
PRIMARY KEY (DogID)
);
CREATE TABLE Purchase (
SSN VARCHAR(11),
DogID INT,
DateOfPurchase DATE,
PRIMARY KEY (SSN, DogID),
FOREIGN KEY (SSN) REFERENCES Owner(SSN),
FOREIGN KEY (DogID) REFERENCES Dog(DogID)
);

-- Query 2
## Write SQL insertion query to insert few tuples to all the relations.
INSERT INTO Petstore (StoreName, StoreLocation) VALUES
('Puppy Pet Shop', '123 Main Street'),
('Bark Avenue', '456 Oak Avenue'),
('Furry Friends', '789 Maple Road'),
('Happy Tails', '234 Pine Street'),
('Paws & Claws', '567 Elm Street');
INSERT INTO Owner (SSN, Name, Address) VALUES
('123-45-6789', 'Abhiman', '100 Main Street'),
('234-56-7890', 'Bob', '200 Oak Avenue'),
('345-67-8901', 'Cathy', '300 Maple Road'),
('456-78-9012', 'David', '400 Pine Street'),
('567-89-0123', 'Emma', '500 Elm Street'),
('222-22-2222', 'Brenda', '456 Oak Ave'),
('333-33-3333', 'Charlie', '789 Elm Blvd');
INSERT INTO Dog (DogID, Name, Sex) VALUES
(1, 'Buddy', 'M'),
(2, 'Charlie', 'M'),
(3, 'Lucy', 'F'),
(4, 'Molly', 'F'),
(5, 'Max', 'M');
INSERT INTO Purchase (SSN, DogID, DateOfPurchase) VALUES
('123-45-6789', 1, '2022-01-01'),
('123-45-6789', 2, '2022-02-01'),
('123-45-6789', 3, '2022-03-01'),
('234-56-7890', 4, '2022-04-01'),
('345-67-8901', 5, '2022-05-01'),
('456-78-9012', 1, '2022-06-01'),
('567-89-0123', 2, '2022-07-01'),
('567-89-0123', 3, '2022-08-01'),
('567-89-0123', 4, '2022-09-01'),
('567-89-0123', 5, '2022-10-01');

-- Query 3
## List all pets owned by a person ‘Abhiman’. 
SELECT D.Name AS DogName, P.DateOfPurchase
FROM Purchase P
INNER JOIN Dog D ON P.DogID = D.DogID
INNER JOIN Owner O ON P.SSN = O.SSN
WHERE O.Name = 'Abhiman';

-- Query 4
## List all persons who are not owned a single pet
SELECT O.Name
FROM Owner O
LEFT JOIN Purchase P ON O.SSN = P.SSN
WHERE P.SSN IS NULL;

-- Query 5
## Write a trigger to check the constraint that the person can buy maximum three pet dogs
DELIMITER $$
CREATE TRIGGER MaxThreePets
BEFORE INSERT ON Purchase
FOR EACH ROW
BEGIN
DECLARE v_PetCount INT;
 SELECT COUNT(*) INTO v_PetCount
 FROM Purchase
 WHERE SSN = NEW.SSN;
 IF v_PetCount >= 3 THEN
 SIGNAL SQLSTATE '45000' 
 SET MESSAGE_TEXT = 'A person cannot purchase more than three pets';
 END IF;
END$$
DELIMITER ;

INSERT INTO Purchase (SSN, DogID, DateOfPurchase) VALUES
('123-45-6789', 4, '2022-01-01');

-- Query 6
## Write a procedure to list all dogs and owner details purchased on the specific date.
DELIMITER $$
CREATE PROCEDURE ListDogsAndOwnersByDate (p_Date DATE)
BEGIN
SELECT O.Name AS OwnerName, O.SSN, D.Name AS DogName, P.DateOfPurchase
FROM Purchase P
INNER JOIN Dog D ON P.DogID = D.DogID
INNER JOIN Owner O ON P.SSN = O.SSN
WHERE P.DateOfPurchase = p_Date;
END$$
DELIMITER ;

CALL ListDogsAndOwnersByDate('2022-09-01');