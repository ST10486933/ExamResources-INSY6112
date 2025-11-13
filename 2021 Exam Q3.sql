# Question 3
-- 3.1
-- Create and Use Schema
Create Schema horseraces_st10486933;
Use horseraces_st10486933;

-- Create Horse Table
Create Table Horse (
HorseID INT NOT NULL Auto_Increment PRIMARY KEY,
Name VARCHAR(50) NOT NULL
);

-- Create Race Table
Create Table Race (
RaceID INT NOT NULL Auto_Increment PRIMARY KEY,
Name VARCHAR(50) NOT NULL,
Date DATE
);

-- Create Entry Table
Create Table Entry (
EntryID INT NOT NULL Auto_Increment PRIMARY KEY,
HorseID INT NOT NULL,
RaceID INT NOT NULL,
Foreign Key (HorseID) references Horse(HorseID),
Foreign Key (RaceID) references Race(RaceID)
); 

-- 3.2
-- Insert Data into Horse
INSERT INTO Horse (HorseID, Name) Values
(1, 'Bold Ruler'),
(2, 'Phantom');

-- Insert Data into Race
INSERT INTO Race (RaceID, Name, Date) Values
(1, 'Most Important Race 2019', '2019-07-05'),
(2, 'Some Other Race 2020', '2020-11-19');

-- Insert Data into Entry
INSERT INTO Entry (EntryID, HorseID, RaceID) Values
(1, 1, 1),
(2, 1, 2),
(3, 2, 2);

-- 3.3
-- Query names from Horse and sort them from Z to A
SELECT Name FROM Horse
Order By Name DESC;

-- 3.4 
-- Query all columns from Race between 01/01/2019 and 31/12/2019
SELECT * FROM Race
WHERE Date 
BETWEEN '2019-01-01' AND '2019-12-31';

-- 3.5
-- Show how many races each horse participated in
SELECT HorseID, COUNT(RaceID) AS NumberOfRaces
FROM Entry
GROUP BY HorseID;

-- 3.6
-- Query Horse Name and Race Name for all entries in the database
SELECT h.Name AS HorseName, r.Name AS RaceName
FROM Entry e
JOIN Horse h ON e.HorseID = h.HorseID
JOIN Race r ON e.RaceID = r.RaceID;

-- 3.7
-- Create View of races this year
CREATE OR REPLACE VIEW getthisyearsraces AS
SELECT Race.Name AS RaceName, Race.Date AS RaceDate
FROM Race
WHERE YEAR(Date) = YEAR(CURDATE()); 

SELECT * FROM getthisyearsraces;

-- 3.8
-- Create procedure to show the number of races Phantom entered
DELIMITER //

Create Procedure count_horse_races (IN HorseName VARCHAR(50))
BEGIN
SELECT COUNT(e.RaceID) AS NumberOfRaces
FROM Entry e
JOIN Horse h ON e.HorseID = h.HorseID
WHERE h.Name = HorseName;
END //

DELIMITER ;

CALL count_horse_races('Phantom');

