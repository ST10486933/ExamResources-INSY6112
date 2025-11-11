Create Schema Exam2024;
Use Exam2024;

-- 3.1
Create Table Patient (
PatientID INT PRIMARY KEY,
PatientName VARCHAR(50),
PatientSurname VARCHAR(50),
DateOfBirth DATE
);

-- 3.2
Create Table Doctor (
DoctorID INT PRIMARY KEY,
DoctorName VARCHAR(50),
DoctorSurname VARCHAR(50)
);

-- 3.3
Create Table Appointments (
AppointmentID INT Primary Key,
AppointmentDate DATE,
AppointmentTime TIME,
DurationMinutes INT,
DoctorID INT,
PatientID INT,
Foreign Key (DoctorID) references Doctor(DoctorID),
Foreign Key (PatientID) references Patient(PatientID)
);

-- 3.4
INSERT INTO Patient (PatientID, PatientName, PatientSurname, DateOfBirth) VALUES
(1, 'Debbie', 'Theart', '1980-03-17'),
(2, 'Thomas', 'Duncan', '1976-08-12');

INSERT INTO Doctor (DoctorID, DoctorName, DoctorSurname) VALUES
(1, 'Zintle', 'Nukani'),
(2, 'Ravi', 'Maharaj');

INSERT INTO Appointments (AppointmentID, AppointmentDate, AppointmentTime, DurationMinutes, DoctorID, PatientID) VALUES
(1, '2024-01-15', '9:00', 15, 2, 1),
(2, '2024-01-18', '15:00', 30, 2, 2),
(3, '2024-01-20', '10:00', 15, 1, 1),
(4, '2024-01-21', '11:00', 15, 2, 1);

-- 3.5 
SELECT * FROM Appointments
WHERE AppointmentDate BETWEEN '2024-01-16' AND '2024-01-20';

-- 3.6
SELECT p.PatientName, p.PatientSurname,
COUNT(a.AppointmentID) as TotalAppointments
FROM Patient p
JOIN Appointments a ON p.PatientID = a.PatientID
GROUP BY p.PatientID, p.PatientName, p.PatientSurname
ORDER BY TotalAppointments DESC;

-- 3.7
SELECT a.AppointmentDate, a.AppointmentTime,
d.DoctorName, d.DoctorSurname,
p.PatientName, p.PatientSurname
FROM Appointments a
JOIN Doctor d ON d.DoctorID = a.DoctorID
JOIN Patient p ON p.PatientID = a.PatientID
ORDER BY a.AppointmentDate DESC;

-- 3.8
CREATE or REPLACE VIEW Doctor2Patients AS
SELECT p.PatientName, p.PatientSurname
FROM Patient p
JOIN Appointments a ON p.PatientID = a.PatientID
WHERE a.DoctorID = 2
ORDER BY p.PatientSurname ASC;

SELECT * FROM Doctor2Patients;

-- 3.9
DELIMITER //

CREATE PROCEDURE get_appointments(IN input_date DATE)
BEGIN
SELECT a.AppointmentTime, a.DurationMinutes,
d.DoctorName, d.DoctorSurname,
p.PatientName, p.PatientSurname
FROM Appointments a
JOIN Doctor d ON a.DoctorID = d.DoctorID
JOIN Patient p ON a.PatientID = p.PatientID
WHERE a.AppointmentDate = input_date
ORDER BY a.AppointmentTime ASC;
END //

DELIMITER ;
CALL get_appointments('2024-01-21');

