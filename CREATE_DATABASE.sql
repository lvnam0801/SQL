CREATE DATABASE course
GO -- execute the above command block

USE course
GO

-------------------------------------LEARNER-----------------------------------------------
CREATE TABLE Learner 
(
    Learner_ID CHAR(10) PRIMARY KEY,	-- static allocation of 10 characters
    Username VARCHAR(20) NOT NULL UNIQUE,	-- Dynamic memory allocation of 20 characters
    Password VARCHAR(12) NOT NULL ,
    Type_account VARCHAR(7) DEFAULT 'Learner',	-- leanrner
    Name NVARCHAR(40), -- Name of user 
    Sex VARCHAR(6),	--male, female
    Birth_day DATE,	
    Age INT, -- age of learner
	CONSTRAINT CH_AccLeaLen CHECK ((LEN(Username) > 6) AND (LEN(Password) > 8)), -- constraint: length of password
    CONSTRAINT CH_SexLearner CHECK (Sex = 'male' OR Sex = 'female')
)
GO

-- INDEX FOR TABLE LEARANER
CREATE INDEX Idx_Learner
ON Learner(Name)
GO


--------------------------------------INSTRUCTOR----------------------------------------------
CREATE TABLE Instructor
(
	Instructor_ID CHAR(10) PRIMARY KEY, -- static allocation of 10 characters
	Username VARCHAR(20) NOT NULL UNIQUE,
    Password VARCHAR(12) NOT NULL,
	Type_account VARCHAR(10) DEFAULT 'Instructor',   -- Instructor(lectures)
	Name NVARCHAR(40),
	Sex VARCHAR(6), -- male or female
	Birth_day DATE NOT NULL,
    Age INT, -- age of instructor
	Bio TEXT,   --Curriculum Vitae
	Field VARCHAR(50),  -- Field of teaching
    Email VARCHAR(50),
    CONSTRAINT CH_AccInsLen CHECK ((LEN(Username) > 6) AND (LEN(Password) > 8)), -- Constraint: length of username and password
    CONSTRAINT CH_AgeIns CHECK (YEAR(GETDATE()) - YEAR(Birth_day) > 22)  -- Constraint: Age > 22
)
GO

CREATE INDEX Idx_Instructor
ON Instructor(Name)
GO

-- DROP INDEX Idx_Instructor ON Instructor
-- GO

---------------------------------------------INSTRUCTOR RANK-----------------------------------------
CREATE TABLE Instructor_Rank
(
    Instructor_ID CHAR(10),
    Rank VARCHAR(20), -- M.S., Ph.D, Assoc. Prof., Prof.
    CONSTRAINT PK_InsRank PRIMARY KEY (Instructor_ID, Rank),
    CONSTRAINT FK_InsRankID FOREIGN KEY (Instructor_ID) REFERENCES Instructor(Instructor_ID) -- reference to instructor relation
    ON DELETE CASCADE   -- if the parent date is deleted(updated), the child data will be deleted(updated) 
    ON UPDATE CASCADE   --NO ACTION | SET NULL | SET DEFAULT
)
GO



-----------------------------------------------SUBJECT------------------------------------------------
CREATE TABLE Subject
(
    Subject_ID CHAR(10) PRIMARY KEY,    
    Title VARCHAR(100) NOT NULL UNIQUE, -- title of courses
    Description TEXT DEFAULT 'Description'
)
GO

------------------------------------------------COURSE-------------------------------------------------
CREATE TABLE Course
(
    Course_ID CHAR(10) NOT NULL UNIQUE,
    Title VARCHAR(100), -- Topic of course(
    Description TEXT DEFAULT 'Description',
    Time_to_finish INT, -- UNIT IS WEEK
    Cost MONEY DEFAULT 'Free',
    Ins_ID CHAR(10), -- Course Instructor
    Create_date DATE DEFAULT GETDATE(), -- The date the course was created
    Subject_ID CHAR(10),    -- field of course
    Number_Learner INT, -- number of learner enroll into the course
    CONSTRAINT FK_CourInsID FOREIGN KEY (Ins_ID) REFERENCES Instructor(Instructor_ID) -- reference to Instructor(responding for the course)
    ON DELETE SET NULL
    ON UPDATE CASCADE,

    CONSTRAINT FK_CourSubID FOREIGN KEY (Subject_ID) REFERENCES Subject(Subject_ID) -- reference to subject of the course
    ON DELETE SET NULL
    ON UPDATE CASCADE,

    CONSTRAINT PK_Course PRIMARY KEY (Course_ID),
    
    CONSTRAINT CH_TimeToFinish CHECK (Time_to_finish <= 3)
)
GO

CREATE INDEX Idx_Course
ON Course(Title) -- find according to title of course
GO

-----------------------------------------------ENROLL--------------------------------------------------
CREATE TABLE Enroll
(
    Learner_ID CHAR(10) NOT NULL UNIQUE,
    Course_ID CHAR(10) NOT NULL UNIQUE,
    Enroll_date DATE DEFAULT GETDATE(),
    State INT DEFAULT 0, -- complete: %(progress of learner)
    CONSTRAINT FK_EnrLearID FOREIGN KEY (Learner_ID) REFERENCES Learner(Learner_ID) -- course registrants
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    
    CONSTRAINT FK_EnrCourID FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID) -- the course is registered
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT PK_Enroll PRIMARY KEY (Learner_ID, Course_ID),
    CONSTRAINT CH_State CHECK (State >= 0 AND State <= 100) -- the progress of the learner
)
GO

CREATE INDEX Idx_Enroll
ON Enroll(Enroll_date)
GO

-------------------------------------------LESSON----------------------------------------------
CREATE TABLE Lesson
(
    Course_ID CHAR(10) NOT NULL,
    L_number INT NOT NULL,
    Content TEXT,
    CONSTRAINT FK_LessCour FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT PK_Lesson PRIMARY KEY(Course_ID, L_number)
)
GO

-----------------------------------------LESSON MATERIAL-----------------------------------------
CREATE TABLE Lesson_Material
(
    Course_ID CHAR(10) NOT NULL,
    L_number INT NOT NULL,
    Material_ID CHAR(10) NOT NULL UNIQUE,
    Type VARCHAR(50),
    Format VARCHAR(50),
    Title VARCHAR(50),
    URL VARCHAR(2083),
    CONSTRAINT FK_MaterLess FOREIGN KEY (Course_ID, L_number) REFERENCES Lesson(Course_ID, L_number)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT PK_Material PRIMARY KEY (Course_ID, L_number, Material_ID)
)
GO

-------------------------------------------LEARN--------------------------------------------------
CREATE TABLE Learn
(
    Learner_ID CHAR(10) NOT NULL,
    Course_ID CHAR(10) NOT NULL,
    L_number INT NOT NULL,
    Learn_date DATE DEFAULT GETDATE(),
    Progress INT, -- PROGRESS OF LEARNER(%)
    CONSTRAINT FK_OfLearner FOREIGN KEY (Learner_ID) REFERENCES Learner(Learner_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT FK_OfLess FOREIGN KEY (Course_ID, L_number) REFERENCES Lesson(Course_ID, L_number)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT PK_Learn PRIMARY KEY (Learner_ID, Course_ID, L_number)
)
GO

--------------------------------------------LESSON QUIZ---------------------------------------------
CREATE TABLE Lesson_quiz
(
    Course_ID CHAR(10) NOT NULL,
    L_number INT NOT NULL,
    Lquiz_ID CHAR(10) NOT NULL UNIQUE,
    Form VARCHAR(50),   -- Multiple-choice | Essay
    Question TEXT,
    Answer TEXT,
    CONSTRAINT FK_Lquiz FOREIGN KEY (Course_ID, L_number) REFERENCES Lesson(Course_ID, L_number)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT PK_Lquiz PRIMARY KEY (Course_ID, L_number, Lquiz_ID)
)
GO

-----------------------------------------------TAKE QUIZ----------------------------------------------
CREATE TABLE Take_quiz
(
    Learner_ID CHAR(10) NOT NULL,
    Course_ID CHAR(10) NOT NULL,
    L_number INT NOT NULL,
    Lquiz_ID CHAR(10) NOT NULL,
    Take_date DATE DEFAULT GETDATE(),
    Scoure INT, -- SCORE OF LEARNER(/100)
    CONSTRAINT FK_OfLear FOREIGN KEY (Learner_ID) REFERENCES Learner(Learner_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT FK_OfLessQuiz FOREIGN KEY (Course_ID, L_number, Lquiz_ID) REFERENCES Lesson_quiz(Course_ID, L_number, Lquiz_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT PK_TakeQuiz PRIMARY KEY (Learner_ID, Course_ID, L_number, Lquiz_ID),
    CONSTRAINT CH_ScoreQuiz CHECK (Scoure >= 0 AND Scoure <= 100)
)
GO

-------------------------------------------CERTIFICATE-------------------------------------------------
CREATE TABLE Certificate
(
    Certificate_ID CHAR(10) NOT NULL UNIQUE, -- primary key column
    Rank VARCHAR(50),   -- Rank of certificate
    Description TEXT DEFAULT 'Description',
    Certification_bodies NVARCHAR(500), -- Certification organizations that issue certificates
    Learner_ID CHAR(10) NOT NULL, -- Recipient of the certificate
    Received_date DATE DEFAULT GETDATE(), -- The date the certificate was received
    Course_ID CHAR(10) NOT NULL, -- Certificate of course
    CONSTRAINT FK_CertLear FOREIGN KEY (Learner_ID) REFERENCES Learner(Learner_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT FK_CerCour FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT PK_Certificate PRIMARY KEY (Certificate_ID)
)
GO

---------------------------------------------COURSE EXAM------------------------------------------------
CREATE TABLE Course_exam
(
    Exam_ID CHAR(10) NOT NULL UNIQUE,
    Course_ID CHAR(10) NOT NULL,
    Form VARCHAR(50) DEFAULT 'Multiple choice', -- Multiple-choice | Essay
    Title VARCHAR(100), -- Topic of the exam
    Question TEXT,
    Answer TEXT,

    CONSTRAINT FK_OfCour FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT PK_CourExam PRIMARY KEY (Exam_ID)
)
GO


----------------------------------------------TAKE EXAM-------------------------------------------------
CREATE TABLE Take_Exam
(
    Learner_ID CHAR(10) NOT NULL, -- The examiner
    Exam_ID CHAR(10) NOT NULL, -- The Test
    Take_date DATE DEFAULT GETDATE(),
    Scoure INT, -- Exam result
    State INT, -- Test progress

    CONSTRAINT FK_ExamOfLear FOREIGN KEY (Learner_ID) REFERENCES Learner(Learner_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT FK_OfCourseExam FOREIGN KEY (Exam_ID) REFERENCES Course_exam(Exam_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT PK_TakeExam PRIMARY KEY (Learner_ID, Exam_ID) 
)
GO

-----------------------------------------------FEED BACK-------------------------------------------------
CREATE TABLE Feedback
(
    Exam_ID CHAR(10) NOT NULL,
    Fb_ID CHAR(10) NOT NULL UNIQUE,
    Title VARCHAR(100),
    Content TEXT,
    Learner_ID CHAR(10) NOT NULL,
    Fb_date DATE DEFAULT GETDATE(),
    Instructor_ID CHAR(10) NOT NULL,
    Reply_date DATE,
    
    CONSTRAINT FK_FbLearner FOREIGN KEY (Learner_ID) REFERENCES Learner(Learner_ID),
    CONSTRAINT FK_FBInstructor FOREIGN KEY (Instructor_ID) REFERENCES Instructor(Instructor_ID),

    CONSTRAINT PK_Feedback PRIMARY KEY (Exam_ID, Fb_ID)
)
GO

ALTER TABLE Feedback
ADD CONSTRAINT FK_FbofExam FOREIGN KEY (Exam_ID) REFERENCES Course_Exam(Exam_ID)
    ON DELETE NO ACTION
    On UPDATE CASCADE
GO