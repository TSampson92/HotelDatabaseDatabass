DROP DATABASE HOTEL;
CREATE DATABASE HOTEL;

CREATE TABLE GUEST (
	Email VARCHAR(30) NOT NULL, 
	G_name VARCHAR(30) NOT NULL, 
	Credit_card_num CHAR(16) NOT NULL, 
	Phone_num VARCHAR(13) NOT NULL, 
	Address VARCHAR(40) NOT NULL, 
	CONSTRAINT pk_Guest PRIMARY KEY(Email, G_name),
	CONSTRAINT email_ch CHECK (Email LIKE '%__@__%.__%')
)