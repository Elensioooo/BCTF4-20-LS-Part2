--Lecture#2

--მთლიანი ცხრილი გამოვიტანე
SELECT * FROM STUDENTS


--კონკრეტული row-ს/ობიექტის წაშლა.
DELETE FROM STUDENTS
WHERE Email = 'mariam@gmail.com'


--PRIMARY KEY 
--ჩვენს ცხრილს უნდა ქონდეს PRIMARY KEY, რომელიც კარგი იქნება რომ იყოს ID
--ის არის ცხრილში არსებული ობეიქტების იდენთიფიკატორი
--ამისთის მოგვიწვეს ველის დამატება

--ძველ მონაცემებს არ ექნებოდათ აიდი, ამიტომ ჯერ ვშლით ცხრილს
--DROP TABLE STUDENTS

--ცხრილი შევქმნათ და PRIMARY KEY მივცეთ ID
CREATE TABLE STUDENTS
(
	ID INT PRIMARY KEY IDENTITY(1,1),
	FirstName NVARCHAR(50) NOT NULL, 
	Email VARCHAR(255) NOT NULL UNIQUE,
	Age INT NOT NULL CHECK(AGE BETWEEN 18 AND 100), 
	GPA DECIMAL(3,2) CHECK(GPA BETWEEN 0.00 AND 4.00), 
	IsActive BIT DEFAULT(1), --BIT არის ბულეანი
	Registered DATETIME2 DEFAULT(SYSDATETIME())
)
GO

--ცხრილში ჩავამატოთ ობიექტები
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
	'MARIAM@gmail.com',
	20,
	2.50
)


--ცხრილში ველის ჩამატება 
--როცა თეიბლს ვცვლი, ან უნდა იყოს NULL ან უნდა მივანიჭო 
--default მნიშვნელობა
--თუ ცხრილში ჩამატების დროს არ უწერ NULL-ს ან DEFAULT-ს
--მაშინ DEFAULT-ად მიებიჭება NULL
--ყველა ძველ ობიექტს phoneNUmber ექნება NULL
ALTER TABLE STUDENTS 
ADD phoneNumber VARCHAR(20) NULL

--ჩავამატოთ ობიექტი, რომელსაც აქვს ტელ ნომერი
INSERT INTO STUDENTS
(
	FirstName,
	Email,
	Age,
	GPA,
	phoneNumber
)
VALUES
(
	N'თამარი',
	'Tamar@gmail.com',
	22,
	1.75,
	'555777888'
)


--ცხრილში კონკრეტული ROW-ს(ობიექტის) მონაცემის შეცვლა
--UPDATE ბრძანება
UPDATE STUDENTS
SET phoneNumber = '599123777'
WHERE ID = 7

SELECT * FROM STUDENTS

--ფაკულტეტის ცხრილის შემქნა
CREATE TABLE FACULTY
(
	FacutlyID INT PRIMARY KEY IDENTITY(1,1),
	FacultyName NVARCHAR(100) NOT NULL
)

--ფაკულტეტის დამატება
INSERT INTO FACULTY
(
	FacultyName
)
VALUES
(
	'Medical Science'
)

SELECT * FROM FACULTY
--რელაციები / კავშირები
--ერთი სტუდენტი უკავშირდება ბევრ ფაკულტეტს
--სტუდენტს უნდა მივაკავშიროთ ფაკულტეტი, რადგან ამ რელაციაშ იმთვარი არის სტუდენტი
--მთავარი არის სტუდენტი და დამხამრე ცხრილი არის ფაკულტეტი

--FOREIGN KEY
--FOREIGN KEY-ს ვიყენებთ სხვა ცხრილთან დასაკავშირებლად 
--სტუდენტს უნდა დავუმატოთ ფაკულტეტის აიდი, რომელიც იქნება ფაკულტეტის ცხრილის PRIMARY KEY

ALTER TABLE STUDENTS
ADD FacutlyID INT NULL -- დასამატებელი ველის სახელი და ტიპი და შეზღუდვა

-- ვქმნით FOREIGN KEY შეზღუდვას, რომლის მიხედვითაც STUDENTS-ის FacultyID
-- უნდა შეესაბამებოდეს FACULTY ცხრილში არსებულ FacultyID-ს
ALTER TABLE STUDENTS
ADD CONSTRAINT FK_STUDENTS_FACUTLY FOREIGN KEY (FacutlyID) REFERENCES FACULTY(FacutlyID)




--ახალი სტუდენტის ჩამატება(ახლა უკვე ფაკულტეტით)
INSERT INTO STUDENTS
(
	FirstName,
	Email,
	Age,
	phoneNumber,
	FacutlyID
)
VALUES
(
	N'სოფო',
	'sopho@gmail.com',
	22,
	'555888777',
	5
)

--სტუდენტებს მივცეთ ფაკულტეტები
UPDATE STUDENTS
SET FacutlyID = 6
WHERE ID = 4

SELECT * FROM STUDENTS
SELECT * FROM FACULTY


--joins
--გვინდა რომ სტუდენტებიდან ყველაფერი წამოვიღოთ
--და ფაკულტეტების ცხრილში ჩავსვათ
--ანუ მთლიანი ინფორმაცია მქონდეს 
SELECT 
	S.*,
	F.FacultyName
FROM STUDENTS AS S
LEFT JOIN FACULTY AS F ON S.FacutlyID = F.FacutlyID -- აქ on ის შმედეგ იწერება ის პირობა, თუ რომელი ველები ემთხვევა ერთანეთს

--სტუდენტის მხოლოდ სახელი და ფაკულტეტი 
--LEFT JOIN ნიშნავს, რომ მარცხენა ცხრილიდან უეჭ გამომიტანე
--ყველა ROW(ობიექტი), მიუხედავად იმისა, რომ მას შეიძლება
--არ ქონდეს მნიშნელობა მარჯვენა ცხრილში
SELECT
	S.FirstName,
	F.FacultyName
FROM STUDENTS AS S
LEFT JOIN FACULTY AS F ON S.FacutlyID = F.FacutlyID


--აგრეგატული ფუნქციები
--MIN, MAX, COUNT,

--რამდენი სტუდენტი გვყავს ცხრილშ
SELECT COUNT(*)
FROM STUDENTS

--რამდენი უნიკალური სახხელი მაქვს სიაში
SELECT COUNT(DISTINCT(FirstName))
FROM STUDENTS

--სტუდენტების ასაკთა ჯამი
SELECT
	SUM(Age)
FROM STUDENTS

--საშუალო ასაკი
SELECT 
	AVG(Age)
FROM STUDENTS

--MAX ასაკი
SELECT
	MAX(Age)
FROM STUDENTS


--გადაბმა სტრინგების(კონკატენაციის თემაა)
-- + გვეხმარება რო გადავაბათ
SELECT FirstName + ' - ' + Email  as fullInfo 
FROM STUDENTS



--დაასორტირეთ 0.01-ზე მეტი GPA-ის მქონდე სტუდენტები ასაკის მიხედვით 
SELECT *
FROM STUDENTS
WHERE GPA > 0.01
ORDER BY AGE ASC


--სტინგის ფუნქციები 
--სიგრძე
SELECT 
	FirstName,
	LEN(FirstName)
FROM STUDENTS

--TRIM - სფეისების მოსაშორებელი
SELECT TRIM(' aaa')
SELECT TRIM('AAA   ')

--REPLACE - 
SELECT REPLACE('DEMETRE' , 'E', 'A')

--SUBSTRING - სტრინგის რაღაც ნაწილს მოჭრის
SELECT SUBSTRING('HEELLO', 2, 3)
SELECT LEFT('HELLO', 2)
SELECT RIGHT('HELLO', 2)
SELECT UPPER('niko')
SELECT LOWER('NIKO')


--CLASSWORK
--დაასელექთეთ ისეთი სტუდენტების სია, რომელთა ფაკულტეტის
--სახელი არის 5 სიმბოლოზზე მეტი
SELECT
	S.*,
	LEN(F.FacultyName)
FROM STUDENTS AS S
JOIN FACULTY AS F ON S.FacutlyID = F.FacutlyID
WHERE LEN(F.FacultyName) > 5

--ისეთი სტუდენტების სია მინდა , რომელიც 
--შეიცავს science-ს
SELECT 
	S.*,
	F.FacultyName
FROM STUDENTS AS S
JOIN FACULTY AS F ON S.FacutlyID = F.FacutlyID
WHERE F.FacultyName LIKE '%science%'

--სისტეიდან აღებული დეითი
SELECT SYSDATETIME();
SELECT GETDATE();

SELECT DATEPART(YEAR, '2025-01-01')
SELECT DATEPART(MONTH, '2025-01-01')
SELECT DATEPART(WEEK, '2025-01-01')
SELECT DATEPART(DAY, '2025-01-01')

SELECT YEAR('2025-01-20')
SELECT MONTH('2025-01-20')
SELECT DAY('2025-01-20')


SELECT DATEDIFF(MONTH, '2025-01-20', '2026-06-20')
SELECT DATEDIFF(YEAR, '2025-01-20', '2026-06-20')
SELECT DATEDIFF(WEEK, '2025-01-20', '2026-06-20')


SELECT DATEADD(YEAR, 5, '2025-04-01')
SELECT DATEADD(MONTH, 5, '2025-04-01')
SELECT DATEADD(DAY, 5, '2025-04-01')

--გადაქასთვა
SELECT CAST('1987' AS INT)