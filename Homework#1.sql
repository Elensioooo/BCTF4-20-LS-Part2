--homework#1

SELECT * FROM STUDENTS
SELECT * FROM FACULTY

--1. 1:1(One-to-One) რელაცია
--A. შექმენით ცხრილი STUDENT_DETAILS, სადაც შეინახავთ
--   სტუდენტის დამატებით პერსონალურ ინფორმაციას: Address, PassportNumber , DateOFbIRHT
--B. დააკავშირეთ STUDENT_DETAILS ცხრილი 1 TO 1 კავშირით STUDENTS ცხრილთან
--   StudentID უნდა იყოს STUDENT_DETAILS-ის PRIMARY KEY და ამავდროულად  
--   FOREIGN KEY,რომლიც მიუთითბს  STUDENTS(ID)-ზე
CREATE TABLE STUDENT_DETAILS
(
	StudentID INT PRIMARY KEY NOT NULL,
	Address NVARCHAR(250) NULL,
	PassportNumber VARCHAR(50) UNIQUE NOT NULL,
	DateOfBirth DATE NULL,
	CONSTRAINT FK_STUDENT_DETAILS_STUDENTS FOREIGN KEY (StudentID) REFERENCES STUDENTS(ID)
)

--2. ლექტორები და კურსები
CREATE TABLE INSTRUCTORS
(
	InstructorID INT PRIMARY KEY IDENTITY(1,1),
	FirstName NVARCHAR(250) NOT NULL,
	LastName NVARCHAR(250) NOT NULL,
	EMAIL VARCHAR(255) UNIQUE NOT NULL,
)

--COURSE ცხრილი
CREATE TABLE COURSE
(
	CourseID INT PRIMARY KEY IDENTITY(1,1),
	InstructorID INT NOT NULL,
	CourseTitle NVARCHAR(50) NOT NULL, 
	Credits INT CHECK(Credits between 1 AND 6),
	CONSTRAINT FK_COURSE_INSTRUCTORS FOREIGN KEY (InstructorID) REFERENCES INSTRUCTORS(InstructorID)
)

--3. Many-to-many რელაცია
CREATE TABLE ENROLLMENTS
(
	EnrollmentID INT PRIMARY KEY IDENTITY(1,1),
	StudentID INT NOT NULL,
	CourseID INT NOT NULL,
	EnrollmentDate DATETIME2 DEFAULT(SYSDATETIME()),
	Grade DECIMAL(3,2) CHECK(Grade between 0.00 AND 4.00),
	CONSTRAINT FK_ENROLLMENTS_STUDENTS FOREIGN KEY (StudentID) REFERENCES STUDENTS(ID),
	CONSTRAINT FK_ENROLLMENTS_COURSES FOREIGN KEY (CourseID) REFERENCES COURSE(CourseID),
	CONSTRAINT UQ_ENROLLMENTS_STUDENTS_COURSE UNIQUE(StudentID, CourseID)
)


--PART2 - DML
--ჩაწერეთ 3 ფაკულტეტი, 5 სტუდენტი, 5 სტუდენტის პროფილი
--3ლექტორი, 4 კურსი და მინიმუმ 8 რეგისტრაცია(ENROLLEMTNS)

--3 ფაკულტეტი
INSERT INTO FACULTY
(
	FacultyName

)
VALUES
(
	'Law'
)

--5სტუდენტი
INSERT INTO STUDENTS
(
	FirstName,
	Email,
	Age,
	GPA,
	phoneNumber,
	FacutlyID
)
VALUES
(
	N'გვანცა',
	'gvantsa@gmail.com',
	22,
	4.00,
	'555555777',
	10
)

--5 სტუდენტის პროფილი
INSERT INTO STUDENT_DETAILS
(
	StudentID,
	Address,
	PassportNumber,
	DateOfBirth
)
VALUES
(
	5,
	'Tbilisi',
	'GE24681359',
	'2004-07-20'
)

--3 ლეტორი
INSERT INTO INSTRUCTORS
(
	FirstName,
	LastName,
	EMAIL
)
VALUES
(
	N'გოჩა',
	N'მალანია',
	'gochu@gmail.com'
)

UPDATE INSTRUCTORS
SET LastName = N'არჩუქაძე'
where InstructorID = 5

--4 კურსი
INSERT INTO COURSE
(
    InstructorID,
    CourseTitle,
    Credits
)
VALUES
(
    6,
    'Economic Basics',
    5
)

--8 რეგისტრაცია
INSERT INTO ENROLLMENTS
(
	StudentID,
	CourseID,
	Grade

)
VALUES
(
	10,
	1,
	3.30
)


--PART3 - SELECT
--1. გმოიტანეთ ყველა სტუდენტის FirstName, Email და ფაკულტეტის დასახელება
--STUDENTS - FirstName, Email Facutly - FacutlyName
SELECT
	S.FirstName,
	S.Email,
	F.FacultyName
FROM STUDENTS AS S
JOIN FACULTY AS F ON S.FacutlyID = F.FacutlyID

--2. გამოიტანეთ კურსების სია მათ პასუხისმგებელ ლექტორებთან ერთად(FirstName, LastName)
-- COURSES - COUURSETITLE, ID INSTRUCTORS- FIRSTNAME LASTNAME
SELECT 
	C.*,
	I.FirstName + '-' + I.LastName AS Instructure
FROM COURSE as C
join INSTRUCTORS AS I ON C.InstructorID = I.InstructorID

--3. გამოიტანეთ იმ სტუდენტების სია (FirstName, PassportNumber), რომელთა GPA
--   აღემატება 3.00-ს
SELECT 
	S.FirstName,
	S.GPA,
	SD.PassportNumber
FROM STUDENTS AS S
JOIN STUDENT_DETAILS AS SD ON S.ID = SD.StudentID
WHERE S.GPA > 3.00

--4. გამოიტანეთ სტუდეტნის სახელი, კურსის დასახელება 
--   და მიღებული ქულა ყველა რეგისტრაციისთის

SELECT
	E.*,
	S.FirstName,
	C.CourseTitle
FROM ENROLLMENTS AS E
JOIN STUDENTS AS S ON E.StudentID = S.ID
JOIN COURSE AS C ON E.CourseID = C.CourseID


--5. იპოვეთ თითოეული სტუდენტის საშუალო ქოლა (AVG(GRADE)),
-- რომელიც მიიღო კურსებში. გამოიტანეთ სტუდენტის სახელი და საშუალო ქულა
SELECT
	S.FirstName,
	AVG(E.Grade)
FROM STUDENTS AS S
JOIN ENROLLMENTS AS E ON S.ID = E.StudentID
GROUP BY S.FirstName

--6. დაითავლეთ რამდენი სტუდენიტა დარეგისტრირებული თითოეულ კურსზე
SELECT
	E.CourseID,
	COUNT(E.StudentID) AS StudentCount
FROM COURSE AS C
JOIN ENROLLMENTS AS E ON C.CourseID = E.CourseID
GROUP BY E.CourseID

--7. გამოიტანე იმსტუდენტების სია,რომელსაც ჯერ არცერთ კურსზე არ გაუვლით
--რეგისტრაცია LEFT JOIN/IS NULL
SELECT
	S.*,
	E.*
FROM STUDENTS AS S
LEFT JOIN ENROLLMENTS AS E ON S.ID = E.StudentID
WHERE E.EnrollmentID IS NULL


--8. იპოვეთ ყველაზე მაღალი GPA-ის მქონე სტუდენტის მიერ არჩეული კურსების დასახელებეი
SELECT
	S.FirstName,
	C.CourseTitle
FROM STUDENTS AS S
JOIN ENROLLMENTS AS E ON S.ID = E.StudentID
JOIN COURSE AS C ON E.CourseID = C.CourseID
WHERE S.GPA = 
(
	SELECT 
		MAX(S.GPA)
	FROM STUDENTS AS S

)

SELECT * FROM FACULTY
SELECT * FROM STUDENTS
SELECT * FROM STUDENT_DETAILS
SELECT * FROM INSTRUCTORS 
SELECT * FROM STUDENTS
SELECT * FROM COURSE
SELECT* FROM ENROLLMENTS   