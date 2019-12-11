USE course
-- INSERT LEARNER

INSERT INTO Learner
VALUES ( '1712243', 'learner4', '0123456789', 'learner', N'Nguyen Van D',  'male', '2012-12-12')
GO

INSERT INTO Learner
VALUES ( '1712242', 'learner3', '0123456789', 'learner', N'Nguyen Van C',  'male', '2012-12-12')
GO

INSERT INTO Learner
VALUES ( '1712241', 'learner2', '0123456789', 'learner', N'Nguyen Van B',  'male', '2012-12-12')
GO

INSERT INTO Learner
VALUES ( '1712240', 'learner1', '0123456789', 'learner', N'Nguyen Van A',  'male', '2012-12-12')
GO

INSERT INTO Learner
VALUES ( '1712244', 'learner5', '0123456789', 'learner', N'Nguyen Van M',  'male', '2012-12-12')
GO

INSERT INTO Learner
VALUES ( '1712245', 'learner6', '0123456789', 'learner', N'Nguyen Van G',  'male', '2012-12-12')
GO

INSERT INTO Learner
VALUES ( '1712246', 'learner7', '0123456789', 'learner', N'Nguyen Van E',  'male', '2012-12-12')
GO

INSERT INTO Learner
VALUES ( '1712260', 'learner10', '0123456789', 'learner', N'Anh Van E',  'male', '2012-12-12')
GO


-- INSERT INSTRUCTORS

INSERT INTO Instructor
(Instructor_ID, Username, Password, Type_account, Name, Sex,  Birth_day, Bio, Field, Email)
VALUES
( '10100021', 'username1', '123456789', 'instructor', 'Tran Thanh A', 'Female', '1990-12-18', 'Bio', 'Economics', '***@gmail.com')
GO

-- violate constraint age
INSERT INTO Instructor
VALUES('10100040', 'user', '123456789', 'Instructor', 'Tran Thanh C', 'Male', '2000-10-12', 'Bio', 'Biology', '***@gmail.com') 
GO

-- validate
INSERT INTO Instructor
VALUES('10100022', 'username2', '123456789', 'Instructor', 'Tran Thanh C', 'Male', '1990-10-12', 'Bio', 'Biology', '***@gmail.com') 
GO

INSERT INTO Instructor
VALUES('10100023', 'username3', '123456789', 'Instructor', 'Tran Thanh M', 'Male', '1994-10-12', 'Bio', 'Biology', '***@gmail.com') 
GO

INSERT INTO Instructor
VALUES('10100024', 'username4', '123456789', 'Instructor', 'Tran Thanh B', 'Male', '1990-10-12', 'Bio', 'Biology', '***@gmail.com') 
GO

INSERT INTO Instructor
VALUES('10100025', 'username5', '123456789', 'Instructor', 'Tran Thanh D', 'Male', '1990-10-12', 'Bio', 'Biology', '***@gmail.com') 
GO

INSERT INTO Instructor
VALUES('10100026', 'username6', '123456789', 'Instructor', 'Tran Thanh H', 'Male', '1990-10-12', 'Bio', 'Chemistry', '***@gmail.com') 
GO  

INSERT INTO Instructor
VALUES('10100027', 'username7', '123456789', 'Instructor', 'Tran Thanh N', 'Female', '1990-10-12', 'Bio', 'Foreign Language', 'N@gmail.com') 
GO  

--------------------INSERT RANK---------------------
INSERT INTO Instructor_Rank
(
    Instructor_ID,
    Rank -- M.S., Ph.D, Assoc. Prof., Prof.
)
VALUES('10100021', 'M.S.')
GO

-- -- violate
-- INSERT INTO Instructor_Rank
-- VALUES('1010002', 'Ph.D')
-- GO

INSERT INTO Instructor_Rank
VALUES('10100022', 'Assoc. Prof')
GO

USE course1

INSERT INTO Instructor_Rank
VALUES('10100023', 'Ph.D')
GO

INSERT INTO Instructor_Rank
VALUES('10100024', 'Ph.D')
GO

INSERT INTO Instructor_Rank
VALUES('10100025', 'Assoc. Prof')
GO

INSERT INTO Instructor_Rank
VALUES('10100026', 'Prof.')
GO

-- INSERT SUBJECT
INSERT INTO Subject ( Subject_ID, Title, Description)
VALUES('001', 'Title1', 'Des')

-- INSERT COURSE
INSERT INTO Course(Course_ID, Title, Description, Time_to_finish, Cost, Ins_ID, Create_date, Subject_ID)
VALUES ('1000', 'English', 'Des', 3, 50, '10100027', '2019-12-01', '001')
GO

-- INSERT ENROLL
INSERT INTO Enroll(Learner_ID, Course_ID, Enroll_date, State)
VALUES('1712243', '1000', GETDATE(), 0)
GO