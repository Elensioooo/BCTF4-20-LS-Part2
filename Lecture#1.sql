--Lecture#1

--Creating database
CREATE DATABASE UNIVERSITY
GO

USE UNIVERSITY
GO -- GO ყოფას ბეჩებად, ჯერ ერთი ნაწილი რომ გაეშვება, მერე გაუშვებს მეორეს


--ცხრილის შექმნა
--შესაძლო ცხრილები უნივერსისტეტის მონაცემთა ბაზაში:
--ლექტორები, სტუდენტები, საგნები,აუდიტორირები...

CREATE TABLE STUDENTS
(
	--ცხრილში აუცილებლად უნდა ვუთხრა რა სვეტები მექნება
	--ანუ ყველა Column წინასწარ განისაზღვრება
	FirstName NVARCHAR(50) NOT NULL, -- ფრჩხილებში უთითებ ზომას
	Email VARCHAR(255) NOT NULL UNIQUE,
	Age INT NOT NULL CHECK(AGE BETWEEN 18 AND 100), 
	GPA DECIMAL(3,2) CHECK(GPA BETWEEN 0.00 AND 4.00), --3 - ანუ ჯამში რამდენ ციფრიანია, 2 -  წერტილის მერე რამდენი ციფრი მექნება; მაგ2.25
	IsActive BIT DEFAULT(1), --BIT არის ბულეანი
	Registered DATETIME2 DEFAULT(SYSDATETIME())
	--ფაკულტეტი აქ არ იქნება(ამისთვის ცალკე ცხრილი იქნება)
)
GO

SELECT* FROM STUDENTS

--ცხრილში ობიექტი ჩამატება
INSERT INTO STUDENTS
(
	FirstName,
	Email,
	Age,
	GPA
)
VALUES
(
	N'მარიამი',
	'mariam@gmail.com',
	24,
	4.00

)

