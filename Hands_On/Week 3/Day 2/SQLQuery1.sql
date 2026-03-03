/* =========================================
   DROP DATABASE IF EXISTS
========================================= */

USE master;
GO

IF DB_ID('EventDb') IS NOT NULL
BEGIN
    ALTER DATABASE EventDb SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE EventDb;
END
GO


/* =========================================
   CREATE DATABASE
========================================= */

CREATE DATABASE EventDb;
GO

USE EventDb;
GO


/* =========================================
   1. USERINFO TABLE
========================================= */

CREATE TABLE UserInfo
(
    EmailId VARCHAR(100) PRIMARY KEY,

    UserName VARCHAR(50) NOT NULL
        CHECK (LEN(UserName) BETWEEN 1 AND 50),

    Role VARCHAR(20) NOT NULL
        CHECK (Role IN ('Admin','Participant')),

    Password VARCHAR(20) NOT NULL
        CHECK (LEN(Password) BETWEEN 6 AND 20)
);
GO


/* =========================================
   2. EVENTDETAILS TABLE
========================================= */

CREATE TABLE EventDetails
(
    EventId INT PRIMARY KEY,

    EventName VARCHAR(50) NOT NULL
        CHECK (LEN(EventName) BETWEEN 1 AND 50),

    EventCategory VARCHAR(50) NOT NULL
        CHECK (LEN(EventCategory) BETWEEN 1 AND 50),

    EventDate DATETIME NOT NULL,

    Description VARCHAR(255) NULL,

    Status VARCHAR(20) NOT NULL
        CHECK (Status IN ('Active','In-Active'))
);
GO


/* =========================================
   3. SPEAKERSDETAILS TABLE
========================================= */

CREATE TABLE SpeakersDetails
(
    SpeakerId INT PRIMARY KEY,

    SpeakerName VARCHAR(50) NOT NULL
        CHECK (LEN(SpeakerName) BETWEEN 1 AND 50)
);
GO


/* =========================================
   4. SESSIONINFO TABLE
========================================= */

CREATE TABLE SessionInfo
(
    SessionId INT PRIMARY KEY,

    EventId INT NOT NULL,

    SessionTitle VARCHAR(50) NOT NULL
        CHECK (LEN(SessionTitle) BETWEEN 1 AND 50),

    SpeakerId INT NOT NULL,

    Description VARCHAR(255) NULL,

    SessionStart DATETIME NOT NULL,

    SessionEnd DATETIME NOT NULL,

    SessionUrl VARCHAR(200) NULL,

    CONSTRAINT FK_Session_Event
        FOREIGN KEY (EventId)
        REFERENCES EventDetails(EventId),

    CONSTRAINT FK_Session_Speaker
        FOREIGN KEY (SpeakerId)
        REFERENCES SpeakersDetails(SpeakerId)
);
GO


/* =========================================
   5. PARTICIPANTEVENTDETAILS TABLE
========================================= */

CREATE TABLE ParticipantEventDetails
(
    Id INT PRIMARY KEY,

    ParticipantEmailId VARCHAR(100) NOT NULL,

    EventId INT NOT NULL,

    SessionId INT NOT NULL,

    IsAttended BIT NOT NULL
        CHECK (IsAttended IN (0,1)),

    CONSTRAINT FK_Participant_User
        FOREIGN KEY (ParticipantEmailId)
        REFERENCES UserInfo(EmailId),

    CONSTRAINT FK_Participant_Event
        FOREIGN KEY (EventId)
        REFERENCES EventDetails(EventId),

    CONSTRAINT FK_Participant_Session
        FOREIGN KEY (SessionId)
        REFERENCES SessionInfo(SessionId)
);
GO


/* =========================================
   INSERT SAMPLE DATA
========================================= */

INSERT INTO UserInfo VALUES
('admin@gmail.com','AdminUser','Admin','admin123'),
('user1@gmail.com','Rama','Participant','user123');

INSERT INTO EventDetails VALUES
(1,'AI Conference','Technology','2026-03-10 09:00:00','AI Event','Active');

INSERT INTO SpeakersDetails VALUES
(101,'John Smith');

INSERT INTO SessionInfo VALUES
(1001,1,'Intro to AI',101,'Basics of AI',
 '2026-03-10 10:00:00',
 '2026-03-10 11:00:00',
 'http://sessionlink.com');

INSERT INTO ParticipantEventDetails VALUES
(1,'user1@gmail.com',1,1001,1);
GO


/* =========================================
   RETRIEVE DATA
========================================= */

SELECT * FROM UserInfo;
SELECT * FROM EventDetails;
SELECT * FROM SpeakersDetails;
SELECT * FROM SessionInfo;
SELECT * FROM ParticipantEventDetails;
GO