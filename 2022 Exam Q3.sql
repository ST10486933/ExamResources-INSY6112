# Question 3
-- 3.1
Create Schema restaurantgroup_st10486933;
USE restaurantgroup_st10486933;

Create Table Restaurant (
RestaurantID INT NOT NULL PRIMARY KEY,
Name VARCHAR(100) NOT NULL,
Occupancy INT NOT NULL
);

Create Table City (
CityID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
Name VARCHAR(100) NOT NULL
);

Create Table RestaurantCity (
RestaurantCityID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
RestaurantID INT NOT NULL,
CityID INT NOT NULL,
OpenDate DATE NOT NULL,
CloseDate DATE,
Foreign Key (RestaurantID) references Restaurant(RestaurantID),
Foreign Key (CityID) references City(CityID)
);

-- 3.2
INSERT INTO Restaurant (RestaurantID, Name, Occupancy) VALUES
(1, 'Bears of Brooklyn', 100),
(2, 'Cats of Cape Town', 500);

INSERT INTO City (CityID, Name) VALUES
(1, 'Pretoria'),
(2, 'Cape Town');

INSERT INTO RestaurantCity (RestaurantCityID, RestaurantID, CityID, OpenDate, CloseDate) VALUES
(1, 1, 1, '2020-01-01', NULL),
(2, 2, 2, '2022-01-01', '2022-02-03');

-- 3.3
SELECT * FROM Restaurant
ORDER BY Occupancy DESC;

-- 3.4
SELECT RestaurantID, CityID, OpenDate, CloseDate
FROM RestaurantCity
WHERE CloseDate BETWEEN '2022-01-01' AND '2022-12-31';

-- 3.5
SELECT CityID, COUNT(RestaurantID) as NumberOfRestaurants
FROM RestaurantCity
Group BY CityID;

-- 3.6
SELECT r.Name AS RestaurantName, r.Occupancy,
c.Name AS CityName
FROM Restaurant r
JOIN RestaurantCity rc ON r.RestaurantID = rc.RestaurantID
JOIN City c ON rc.CityID = c.CityID;

-- 3.7
CREATE OR REPLACE VIEW OpenedRestaurants AS
SELECT r.Name AS RestaurantName
FROM Restaurant r
JOIN RestaurantCity rc ON r.RestaurantID = rc.RestaurantID
WHERE rc.CloseDate IS NULL AND rc.OpenDate <= CURDATE();

SELECT * FROM OpenedRestaurants;

-- 3.8
DELIMITER //

Create Procedure count_restaurants_in_city (IN input_CityID INT)
BEGIN
SELECT COUNT(RestaurantID) AS NumberOfRestaurants
FROM RestaurantCity
WHERE CityID = input_CityID;
END //

DELIMITER ;

CALL count_restaurants_in_city(2);
