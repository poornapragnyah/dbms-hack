CREATE TABLE Author (
    Author_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Affiliation VARCHAR(255)
);

CREATE TABLE Track (
    Track_ID INT PRIMARY KEY AUTO_INCREMENT,
    Track_Name VARCHAR(255) UNIQUE NOT NULL,
    Description TEXT
);

CREATE TABLE Paper (
    Paper_ID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL,
    Abstract TEXT,
    Keywords VARCHAR(255),
    Submission_Date DATE,
    Status VARCHAR(20) DEFAULT NULL,
    Track_ID INT,
    FOREIGN KEY (Track_ID) REFERENCES Track(Track_ID)
);

CREATE TABLE Reviewer (
    Reviewer_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE,
    Expertise_Area VARCHAR(255),
    Max_Papers INT DEFAUlT 5
);

CREATE TABLE Review (
    Review_ID INT PRIMARY KEY AUTO_INCREMENT,
    Paper_ID INT,
    Reviewer_ID INT,
    Score INT CHECK (Score >= 0 AND Score <= 10), 
    Feedback TEXT,
    Review_Date DATE,
    FOREIGN KEY (Paper_ID) REFERENCES Paper(Paper_ID),
    FOREIGN KEY (Reviewer_ID) REFERENCES Reviewer(Reviewer_ID),
    UNIQUE(Paper_ID, Reviewer_ID) 
);

CREATE TABLE Schedule (
    Schedule_ID INT PRIMARY KEY AUTO_INCREMENT,
    Paper_ID INT UNIQUE,
    Presentation_Date DATE,
    Presentation_Time TIME,
    Room VARCHAR(50),
    FOREIGN KEY (Paper_ID) REFERENCES Paper(Paper_ID)
);

CREATE TABLE contains(
    Paper_ID INT PRIMARY KEY,
    Track_ID INT,
    FOREIGN KEY (Paper_ID) REFERENCES Paper(Paper_ID),
    FOREIGN KEY (Track_ID) REFERENCES Track(Track_ID)
);

CREATE TABLE submits (
    Paper_ID INT,
    Author_ID INT,
    PRIMARY KEY (Paper_ID, Author_ID),
    FOREIGN KEY (Paper_ID) REFERENCES Paper(Paper_ID),
    FOREIGN KEY (Author_ID) REFERENCES Author(Author_ID)
);


CREATE TABLE review_by(
    Paper_ID INT,
    Reviewer_ID INT,
    PRIMARY KEY(Paper_ID, Reviewer_ID),
    FOREIGN KEY (Paper_ID) REFERENCES Paper(Paper_ID),
    FOREIGN KEY (Reviewer_ID) REFERENCES Reviewer(Reviewer_ID)
);

CREATE TABLE receives(
    Paper_ID INT,
    Reviewer_ID INT,
    PRIMARY KEY(Paper_ID, Reviewer_ID),
    FOREIGN KEY (Paper_ID) REFERENCES Paper(Paper_ID),
    FOREIGN KEY (Reviewer_ID) REFERENCES Reviewer(Reviewer_ID)
);


CREATE TABLE provides(
    Paper_ID INT,
    Reviewer_ID INT PRIMARY KEY,
    FOREIGN KEY (Paper_ID) REFERENCES Paper(Paper_ID),
    FOREIGN KEY (Reviewer_ID) REFERENCES Reviewer(Reviewer_ID)
);

CREATE TABLE has(
    Schedule_ID INT PRIMARY KEY,
    Paper_ID INT,
    FOREIGN KEY (Paper_ID) REFERENCES Paper(Paper_ID),
    FOREIGN KEY (Schedule_ID) REFERENCES Schedule(Schedule_ID)
);

INSERT INTO Author (Name, Email, Affiliation) VALUES
('Alice Johnson', 'alice@example.com', 'University of Knowledge'),
('Bob Smith', 'bob@example.com', 'Tech Institute'),
('Cathy Brown', 'cathy@example.com', 'Research Labs'),
('David White', 'david@example.com', 'Innovation Center'),
('Emma Green', 'emma@example.com', 'Data Science Corp');

INSERT INTO Track (Track_Name, Description) VALUES
('Machine Learning', 'Track for ML and AI related papers'),
('Data Science', 'Data analytics and big data papers'),
('Cybersecurity', 'Topics on network and information security'),
('Software Engineering', 'Software development and lifecycle topics'),
('Human-Computer Interaction', 'HCI research and usability studies');


INSERT INTO Paper (Title, Abstract, Keywords, Submission_Date, Track_ID) VALUES
('AI for Health', 'Exploring AI applications in healthcare', 'AI, Health', '2024-10-01', 1),
('Big Data Trends', 'Analyzing data at scale', 'Big Data, Analytics', '2024-10-10', 2),
('Security Challenges', 'Current trends in cybersecurity', 'Cybersecurity, Networks', '2024-09-20', 3),
('Agile Methods', 'Exploring agile methodologies', 'Agile, Software', '2024-09-25', 4),
('Usability Testing', 'Methods for usability improvement', 'Usability, HCI', '2024-11-01', 5);


INSERT INTO Reviewer (Name, Email, Expertise_Area, Max_Papers) VALUES
('Frank Harris', 'frank@example.com', 'Machine Learning', 5),
('Grace Lee', 'grace@example.com', 'Data Science', 5),
('Henry Brown', 'henry@example.com', 'Cybersecurity', 5),
('Ivy Thomas', 'ivy@example.com', 'Software Engineering', 5),
('Jack Black', 'jack@example.com', 'Human-Computer Interaction', 5);


INSERT INTO Review (Paper_ID, Reviewer_ID, Score, Feedback, Review_Date) VALUES
(1, 1, 8, 'Well-written and thorough', '2024-10-15'),
(2, 2, 7, 'Good analysis but lacks detail', '2024-10-18'),
(3, 3, 9, 'Excellent insights on cybersecurity', '2024-10-20'),
(4, 4, 6, 'Needs more empirical data', '2024-10-25'),
(5, 5, 7, 'Interesting approach to usability', '2024-11-05');


INSERT INTO Schedule (Paper_ID, Presentation_Date, Presentation_Time, Room) VALUES
(1, '2024-12-01', '10:00:00', 'Room A'),
(2, '2024-12-01', '11:00:00', 'Room B'),
(3, '2024-12-02', '10:00:00', 'Room C'),
(4, '2024-12-02', '11:00:00', 'Room D'),
(5, '2024-12-03', '10:00:00', 'Room E');


INSERT INTO contains (Paper_ID, Track_ID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO submits (Paper_ID, Author_ID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);


INSERT INTO review_by (Paper_ID, Reviewer_ID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);



INSERT INTO receives (Paper_ID, Reviewer_ID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);


INSERT INTO provides (Paper_ID, Reviewer_ID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO has (Schedule_ID, Paper_ID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO Author (Name, Email, Affiliation) VALUES
('John Doe', 'john.doe@example.com', 'Health Tech Innovations');

INSERT INTO submits (Paper_ID, Author_ID) VALUES
(1, 6);



-- WITH RECURSIVE CollaborationNetwork AS (
--     -- Base case: Find all direct co-authors of the given author
--     SELECT
--         s1.Author_ID AS Base_Author,
--         s2.Author_ID AS Co_Author
--     FROM
--         submits s1
--         JOIN submits s2 ON s1.Paper_ID = s2.Paper_ID
--     WHERE
--         s1.Author_ID != s2.Author_ID
--         AND s1.Author_ID = (
--             SELECT Author_ID FROM Author WHERE Name = 'Alice Johnson'
--         )

--     UNION ALL

--     -- Recursive case: Find co-authors of co-authors
--     SELECT
--         cn.Base_Author,
--         s2.Author_ID AS Co_Author
--     FROM
--         CollaborationNetwork cn
--         JOIN submits s1 ON cn.Co_Author = s1.Author_ID
--         JOIN submits s2 ON s1.Paper_ID = s2.Paper_ID
--     WHERE
--         s2.Author_ID != cn.Base_Author
--         AND s2.Author_ID != cn.Co_Author  -- Preventing cycles
-- )
-- -- Select all co-authors excluding the base author and join with Author table to get the name
-- SELECT a.Name AS Co_Author_Name
-- FROM CollaborationNetwork cn
-- JOIN Author a ON cn.Co_Author = a.Author_ID
-- WHERE cn.Co_Author != (
--     SELECT Author_ID FROM Author WHERE Name = 'Alice Johnson'
-- )
-- GROUP BY cn.Co_Author;
