# Question 3.1 
Create SCHEMA Exam2023Special_Solutionv2;
Use Exam2023Special_Solutionv2;

-- Create Table Dog
Create Table Dog (
DogID INT NOT NULL PRIMARY KEY,
Name VARCHAR (225) NOT NULL,
Colour VARCHAR (225)
);

-- Create Table DogPark
Create Table DogPark (
DogParkID INT NOT NULL PRIMARY KEY,
Name VARCHAR(225) NOT NULL,
Description VARCHAR (225)
);

-- Create Table Visit
Create Table Visit (
VisitID INT NOT NULL PRIMARY KEY,
DogID INT NOT NULL,
DogParkID INT NOT NULL,
Date DATE,
Rating INT,
Foreign Key (DogID) references Dog(DogID),
Foreign Key (DogParkID) references DogPark (DogParkID)
);

# Question 3.2
-- Insert records in Dog Table
INSERT INTO Dog (DogID, Name, Colour) VALUES
(1, 'Tilly', 'Grey with white accents'),
(2, 'Scotty', 'Black');

-- Insert records in DogPark Table
INSERT INTO DogPark (DogParkID, Name, Description) VALUES
(1, 'Wonderful Walkies', 'Off-leash park with lots of water for swimming.'),
(2, 'Bush Babies', 'Plenty of trees providing shade. Off-leash park.');

-- Insert records in Visit table
INSERT INTO Visit (VisitID, DogID, DogParkID, Date, Rating) VALUES
(1, 1, 1, '2023-03-11', 5),
(2, 2, 1, '2023-03-11', 5),
(3, 1, 2, '2023-03-12', 4);

# Question 3.3 
SELECT * FROM DogPark
ORDER BY NAME ASC;

# Question 3.4
SELECT Name, Colour
FROM Dog
WHERE Colour like '%grey%';

# Question 3.5
SELECT DogParkID, COUNT(*) AS NumberOfVisits
FROM Visit
GROUP BY DogParkID;

# Question 3.6
SELECT Dog.Name as DogName, DogPark.Name AS ParkName, Visit.Date, Visit.Rating
FROM Visit 
JOIN Dog ON Visit.DogID = Dog.DogID
JOIN DogPark ON Visit.DogParkID = DogPark.DogParkID;

# Question 3.7 
CREATE or REPLACE VIEW Visits2023 AS
SELECT DogPark.Name AS ParkName, Visit.Date
FROM Visit
JOIN DogPark ON Visit.DogParkID = DogPark.DogParkID
WHERE Visit.Date Between '2023-01-01' AND '2023-12-31';

Select * From Visits2023;

# Question 3.8
DELIMITER //

Create Procedure average_park_rating (IN park_id INT)
BEGIN 
Select AVG (Rating) AS AverageRating
FROM Visit
WHERE DogParkID = park_id;

END //
DELIMITER ;
CALL average_park_rating(1); 