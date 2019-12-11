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