-- PROCEDURE INSERT INTO
CREATE PROCEDURE InsertLearner
(
    @learner_ID  CHAR(10),	-- static allocation of 10 characters
    @username  VARCHAR(20),	-- Dynamic memory allocation of 20 characters
    @password  VARCHAR(12),
    @name  NVARCHAR(40), -- Name of user 
    @sex  VARCHAR(6),	--male, female
    @birth_day  DATE
)
AS
BEGIN
    SET NOCOUNT ON
    DECLARE @type_account  VARCHAR(7)	-- leanrner
    DECLARE @age INT
    SET @age = YEAR(GETDATE()) - YEAR(@birth_day)
    SET @type_account = 'learner'

    -- VALIDATE INPUT
    -- CONSTRAINT CHECK: LEN OF USERNAME AND PASSWORD MUST BE VALID
    IF (LEN(@username) < 8 OR LEN(@password) < 8)
    BEGIN
        RAISERROR ('Username or password invalid. Length of username or password must be greater or equal 8', 0, 0)
        RETURN
    END

    -- CONSTRAINT
    IF NOT (@Sex = 'male' OR @Sex = 'female')
    BEGIN
        RAISERROR ('Sex is invalid. Sex must be male or female', 0, 0)
        RETURN
    END

    -- INSERT DATA INTO TABLE
    INSERT INTO Learner
    VALUES (@learner_ID, @username, @password, @type_account, @name, @sex, @birth_day, @age)
END
GO

EXECUTE InsertLearner '1712240', 'learner1', '123456789', N'Duong Thi Minh Ngoc',  'female', '1999-02-21'
EXECUTE InsertLearner '1712241', 'learner2', '123456789', N'Nguyen Tran Thanh Tam',  'female', '2001-01-22'
EXECUTE InsertLearner '1712242', 'learner3', '123456789', N'Ho Van Loi',  'male', '2003-12-08'
EXECUTE InsertLearner '1712243', 'learner4', '123456789', N'Ngo Van Manh',  'male', '1997-03-16'
EXECUTE InsertLearner '1712244', 'learner5', '123456789', N'Nguyen Van Thanh',  'male', '2005-01-23'
EXECUTE InsertLearner '1712245', 'learner6', '123456789', N'Nguyen Thanh Hoang',  'male', '2000-05-06'
EXECUTE InsertLearner '1712246', 'learner7', '123456789', N'Doan Thi Ngoc Nhi',  'female', '1999-01-13'
EXECUTE InsertLearner '1712247', 'learner8', '123456789', N'Nguyen Thanh Hang',  'female', '2002-12-12'
EXECUTE InsertLearner '1712248', 'learner9', '123456789', N'Doan Van Sang',  'male', '2000-12-08'
GO


-- PROCEDURE SHOW DATA
CREATE PROCEDURE GetLearner
AS
BEGIN
    SELECT Learner_ID, Username, Name, Sex, Birth_day FROM Learner
    ORDER BY Name 
END
GO

EXECUTE GetLearner
GO

SELECT * FROM Learner WHERE Username = 'learner1'