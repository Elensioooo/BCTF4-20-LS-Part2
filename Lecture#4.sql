USE UNIVERSITY

SELECT* FROM STUDENTS

--სტუდენიტს ჩამატებისთის
INSERT INTO dbo.STUDENTS(FirstName,Email,Age,GPA,IsActive,Registered,phoneNumber,FacutlyID)
VALUES(@FirstName,@LastName,@Age,@GPA,@IsActive,@Registered,@phoneNumber,@FacutlyID)

--creating procedure(პროცედურაში გავიტანოთ სტუდენტის ჩამატების ლოგიკა)
CREATE PROCEDURE sp_AddStudent
	@FirstName NVARCHAR(50),
	@Age INT,
    @Email VARCHAR(255),
    @GPA DECIMAL(3,2),
	@IsActive BIT,
	@Registered DATETIME2,
	@phoneNumber VARCHAR(20),
	@FacutlyID INT
	AS
	BEGIN
		INSERT INTO STUDENTS
		(
			FirstName,
			Email,
			Age,
			GPA,
			IsActive,
			Registered,
			phoneNumber,
			FacutlyID
		)
		VALUES
		(
			@FirstName,
			@Email, 
			@Age,
			@GPA,
			@IsActive,
			@Registered,
			@phoneNumber,
			@FacutlyID
		)

	END


--სინტაქსის გასახსენებლად 
--CREATE PROCEDURE sp_GetTopSt
--	@topSTAmount int -- პარამეტრი
--	AS -- პროცედურებში ეს მჭირდება უეჭ
--	begin
--		select TOP(@topSTAmount) 
--			FirstName,
--			ID,
--			GPA
--		FROM STUDENTS
--		ORDER BY GPA ASC
--	end