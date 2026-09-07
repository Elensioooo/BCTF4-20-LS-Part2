--Lecture#3(SQL ფუნქციები, პროცედურები და პრაქტიკული მუშაობა)

--SELECT * FROM STUDENTS


--ცვლადის შექმნა
DECLARE @GPA DECIMAL(3,2)
--გამოცხადებულ ცვლადში ჩავწერეთ მნიშნელობა
SELECT @GPA = GPA FROM STUDENTS WHERE ID = 1

--if statment
IF @GPA > 3.00
BEGIN 
	PRINT 'EXCELENT'
END
ELSE
BEGIN
	PRINT 'NOT EXCELENT'
END

--ELSE IF
IF @GPA > 3.75
BEGIN
	PRINT 'THE BEST'
END
ELSE IF @GPA > 3.00 AND @GPA < 3.75
BEGIN
	PRINT 'AVERAGE'
END
ELSE
BEGIN 
	PRINT 'BAD'
END

--SWITCH CASE 
SELECT 
	GPA,
	CASE 
		WHEN GPA > 3.50 THEN 'AVERAGE'
		ELSE 'BAD'
		END AS RESULT
FROM STUDENTS 
WHERE ID = 1

--WHILE LOOP
DECLARE @i INT = 1
WHILE @i <= 5
BEGIN
	PRINT @i
	set @i = @i + 1
END

--break
DECLARE @it INT = 0
WHILE @it < 10
BEGIN
	IF @it = 7
		break
	PRINT @it
	set @it = @it + 1
END

--continue
DECLARE @iteration INT = 0
WHILE @iteration < 5
BEGIN
	IF @iteration = 3
	BEGIN
		SET @iteration = @iteration + 1
		CONTINUE
	END
	PRINT @iteration
	SET @iteration = @iteration + 1
END

--loop-ს ვიყენებ მაშინ როცა ობიექტებზე მიდნა რაღაც ოპერაციის ჩატარება
--მაგრამ არა SELECT. დროებითი დასატესტი ქეისებისთვის ძირითადად.


--ფუნქციები / პროცედურები
--ფუნქციები - მათ არ აქვთ უფლება რომ ცხრილებში ცვლილებები შეიტანონ
--ფუნქციები გამოიყენება მარტივი რაღაცეებისთვის(გამოთვლებისთის)

--პროცედურევი - მრავალჯერ გამოყენებადი კოდი, რომლის დახმარებითაც მინდა
--რაღაც შევცვალო ცხრილში

--ფუნქციები
CREATE FUNCTION Fn_GetStudentGPA(@id int)
returns decimal(3,2)
as
begin 
	DECLARE @STGPA DECIMAL(3,2)
	SET @STGPA = (
		SELECT 
			GPA
		FROM STUDENTS
		WHERE ID = @id
	)
	RETURN @STGPA
end

--ფუნქციებს ყოველთვის უწერ წინ სქმეას
SELECT dbo.Fn_GetStudentGPA(2)


SELECT 
	FirstName
FROM STUDENTS 
where dbo.Fn_GetStudentGPA(ID) > 3.00

--ფუნქცია, რომელიც გამოითვლის ყველა სტუდენტბის GPA-ის საშუალოს
CREATE FUNCTION Fn_GetAllStudentsAVGGPA()
returns decimal(3,2)
begin
	declare @gpaAvg decimal(3,2)
	set @gpaAVG = (
		SELECT 
			AVG(GPA)
		FROM STUDENTS
	)
	return @gpaAVG
end

SELECT dbo.Fn_GetAllStudentsAVGGPA() as studentsAVGGPA


--პროცედურები
-- სასურველი რაოდენობის ტოპ სტუდენი
CREATE PROCEDURE sp_GetTopSt
	@topSTAmount int -- პარამეტრი
	AS -- პროცედურებში ეს მჭირდება უეჭ
	begin
		select TOP(@topSTAmount) 
			FirstName,
			ID,
			GPA
		FROM STUDENTS
		ORDER BY GPA ASC
	end


--პროცედურის გამოძახება
EXEC dbo.Cp_GetTopSt @topSTAmount = 5

--4 აიდის მქონდე ობიექტს მინდა შევუცვალო gpa
CREATE PROCEDURE sp_UpdateGpaOnSingleStudent
	@StudentID INT,
	@NewGPA Decimal(3,2)
as 
begin
	UPDATE STUDENTS
	SET GPA = @NewGPA
	WHERE ID = @StudentID
end

EXEC dbo.sp_UpdateGpaOnSingleStudent  @StudentID = 4, @NewGPA = 1.1