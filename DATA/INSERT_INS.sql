USE course

INSERT INTO Instructor
(Instructor_ID, Username, Password, Type_account, Name, Sex,  Birth_day, Bio, Field)
VALUES
( '10100021', 'username1', '123456789', 'instructor', 'Tran Thanh A', 'Female', '1990-12-18', 'Bio', 'Economics')
GO

-- -- violate constraint age
-- INSERT INTO Instructor
-- VALUES('10100024', 'username2', '123456789', 'Instructor', 'Tran Thanh C', 'Male', '2000-10-12', 'Bio', 'Biology') 
-- GO

-- validate
INSERT INTO Instructor
VALUES('10100022', 'username2', '123456789', 'Instructor', 'Tran Thanh C', 'Male', '1990-10-12', 'Bio', 'Biology') 
GO

INSERT INTO Instructor
VALUES('10100023', 'username3', '123456789', 'Instructor', 'Tran Thanh M', 'Male', '1994-10-12', 'Bio', 'Biology') 
GO

INSERT INTO Instructor
VALUES('10100024', 'username4', '123456789', 'Instructor', 'Tran Thanh B', 'Male', '1990-10-12', 'Bio', 'Biology') 
GO

INSERT INTO Instructor
VALUES('10100025', 'username5', '123456789', 'Instructor', 'Tran Thanh D', 'Male', '1990-10-12', 'Bio', 'Biology') 
GO

INSERT INTO Instructor
VALUES('10100026', 'username6', '123456789', 'Instructor', 'Tran Thanh H', 'Male', '1990-10-12', 'Bio', 'Chemistry') 
GO  

INSERT INTO Instructor
VALUES('10100027', 'username7', '123456789', 'Instructor', 'Tran Thanh N', 'Female', '1990-10-12', 'Bio', 'Foreign Language', 'N@gmail.com') 
GO  