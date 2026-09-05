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
DROP TABLE STUDENTS

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
	'mariami@gmail.com',
	22,
	2.75
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
	N'ლანა',
	'lana@gmail.com',
	22,
	2.75,
	'555777888'
)


--ცხრილში კონკრეტული ROW-ს(ობიექტის) მონაცემის შეცვლა
--UPDATE ბრძანება
UPDATE STUDENTS
SET phoneNumber = '599123456'
WHERE ID = 2

SELECT * FROM STUDENTS

--ფაკულტეტის ცხრილის შემქნა
CREATE TABLE FACULTY
(
	FacutlyID INT PRIMARY KEY IDENTITY(1,1),
	FacultyName NVARCHAR(100) NOT NULL
)

--რელაციები / კავშირები
--ერთი სტუდენტი უკავშირდება ბევრ ფაკულტეტს
--სტუდენტს უნდა მივაკავშიროთ ფაკულტეტი, რადგან ამ რელაციაშ იმთვარი არის სტუდენტი
--მთავარი არის სტუდენტი და დამხამრე ცხრილი არის ფაკულტეტი

--FOREIGN KEY
--FOREIGN KEY-ს ვიყენებთ სხვა ცხრილთან დასაკავშირებლად 
--სტუდენტს უნდა დავუმატოთ ფაკულტეტის აიდი, რომელიც იქნება ფაკულტეტის ცხრილის PRIMARY KEY

ALTER TABLE STUDETNS
ADD FacutlyID INT NULL -- დასამატებელი ველის სახელი და ტიპი და შეზღუდვა

-- ვქმნით FOREIGN KEY შეზღუდვას, რომლის მიხედვითაც STUDENTS-ის FacultyID
-- უნდა შეესაბამებოდეს FACULTY ცხრილში არსებულ FacultyID-ს
ALTER TABLE STUDETNS
ADD CONSTRAINT FK_STUDENTS_FACUTLY FOREIGN KEY (FacutlyID) REFERENCES FACULTY(FacutlyID)

SELECT * FROM FACULTY
