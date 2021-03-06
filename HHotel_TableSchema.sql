
DROP DATABASE IF EXISTS HOTEL;
CREATE DATABASE HOTEL;
USE HOTEL;

CREATE TABLE IF NOT EXISTS GUEST 
(Email VARCHAR(50) NOT NULL, 
G_name VARCHAR(50) NOT NULL, 
Credit_card_num CHAR(16) NOT NULL, 
Phone_num VARCHAR(13) NOT NULL, 
Address VARCHAR(80) NOT NULL, 
CONSTRAINT pk_Guest PRIMARY KEY(Email, G_name),
CONSTRAINT email_ch CHECK (Email LIKE '%__@__%.__%'));

CREATE TABLE IF NOT EXISTS EMPLOYEE 
(FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
E_ID CHAR(5) NOT NULL,
Manager_ID CHAR(5),
Address VARCHAR(80),
E_Position VARCHAR(50) NOT NULL,
Salary DECIMAL (18,2),
primary key(E_ID),
FOREIGN KEY(Manager_ID) REFERENCES EMPLOYEE(E_ID));

CREATE TABLE IF NOT EXISTS DEPARTMENT 
(Dep_Name VARCHAR(50) NOT NULL,
Dep_ID INT NOT NULL,
Num_employees INT NOT NULL,
Dep_Head CHAR(5) NOT NULL,
primary key(Dep_ID),
FOREIGN KEY(Dep_Head) REFERENCES EMPLOYEE(E_ID));

ALTER TABlE EMPLOYEE ADD Dep_ID INT;
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(Dep_ID) REFERENCES DEPARTMENT(Dep_ID);

CREATE TABLE IF NOT EXISTS GUEST_ROOM
(Room_Num INT NOT NULL,
Num_beds INT NOT NULL,
Bed_type VARCHAR(20),
Smoking_status TINYINT DEFAULT 0,
primary key(Room_num),
CONSTRAINT roomNo_range CHECK (Room_Num BETWEEN 1 and 999),
CONSTRAINT bedType CHECK (Bed_type IN('King','Queen','Twin','Full')),
CONSTRAINT Smoking_status CHECK (Smoking_status = 0 OR Smoking_status = 1));

CREATE TABLE IF NOT EXISTS CONFERENCE_ROOM 
(CR_Number VARCHAR(3) NOT NULL,
Is_Booked CHAR(1) DEFAULT 'n', 
primary key(CR_Number),
CONSTRAINT booked_status CHECK (Is_Booked IN('y','n')));

CREATE TABLE IF NOT EXISTS DEPARTMENT_SERVICES_GUEST_ROOM
(Dep_ID INT NOT NULL,
G_Room_Num INT NOT NULL,
primary key(Dep_ID,G_Room_Num),
FOREIGN KEY(Dep_ID) REFERENCES DEPARTMENT(DEP_ID),
FOREIGN KEY(G_Room_Num) REFERENCES GUEST_ROOM(Room_num));

CREATE TABLE IF NOT EXISTS DEPARTMENT_SERVICES_CONFERENCE_ROOM
(Dep_ID INT NOT NULL,
C_Room_Num VARCHAR(3) NOT NULL,
PRIMARY KEY(Dep_ID,C_Room_Num),
FOREIGN KEY(Dep_ID) REFERENCES DEPARTMENT(Dep_ID),
FOREIGN KEY(C_Room_Num) REFERENCES CONFERENCE_ROOM(CR_Number));

CREATE TABLE IF NOT EXISTS GUEST_RESERVATION 
(G_Reservation_ID VARCHAR(10) NOT NULL,
G_Name VARCHAR(30) NOT NULL,
Room_Number INT NOT NULL,
Number_Of_Guests INT DEFAULT 1,
Start_Date DATE NOT NULL,
End_Date DATE NOT NULL,
G_Email VARCHAR(50) NOT NULL,
primary key(G_Reservation_ID,G_Name,Room_Number,G_email),
CONSTRAINT email_ch CHECK (G_email LIKE '%__@__%.__%'),
FOREIGN KEY(G_Email,G_Name) REFERENCES GUEST(Email,G_Name) ON DELETE CASCADE,
FOREIGN KEY(Room_Number) REFERENCES GUEST_ROOM(Room_Num),
CONSTRAINT date_order CHECK (Start_date < End_Date));

CREATE TABLE IF NOT EXISTS CONFERENCE_RESERVATION
(C_Reservation_ID VARCHAR(10) NOT NULL,
G_Name VARCHAR(30) NOT NULL,
Room_Number VARCHAR(3) NOT NULL,
Number_Of_Guests INT DEFAULT 1,
Start_Date DATE NOT NULL,
End_Date DATE NOT NULL,
G_Email VARCHAR(50) NOT NULL,
primary key(C_Reservation_ID,G_Name,Room_Number,G_email),
CONSTRAINT email_ch CHECK (G_email LIKE '%__@__%.__%'),
FOREIGN KEY(G_Email,G_Name) REFERENCES GUEST(Email,G_Name) ON DELETE CASCADE,
FOREIGN KEY(Room_Number) REFERENCES CONFERENCE_ROOM(CR_Number),
CONSTRAINT date_order CHECK (Start_date < End_Date));


CREATE TABLE IF NOT EXISTS MEMBERSHIP 
(G_email VARCHAR(50) NOT NULL,
G_name VARCHAR(50) NOT NULL,
Member_ID VARCHAR(9) NOT NULL,
Member_status VARCHAR(10) DEFAULT 'Bronze',
Member_since DATE,
primary key (member_ID),
FOREIGN KEY(G_email,G_name) REFERENCES GUEST(Email,G_name),
CONSTRAINT member_status CHECK (member_status IN('Gold', 'Silver', 'Bronze'))); 

CREATE TRIGGER Incr_empl_count
AFTER INSERT ON EMPLOYEE
FOR EACH ROW
UPDATE DEPARTMENT
SET Num_employees = 1 + Num_employees
WHERE NEW.Dep_ID = DEPARTMENT.Dep_ID;

CREATE TRIGGER Decr_empl_count
BEFORE DELETE ON EMPLOYEE
FOR EACH ROW
UPDATE DEPARTMENT
SET Num_employees = Num_employees - 1
WHERE OLD.Dep_ID = DEPARTMENT.Dep_ID;
