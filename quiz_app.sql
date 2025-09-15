CREATE Database QUIZ;
Use QUIZ;

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,     -- store hashed password
    role ENUM('student','faculty','admin') NOT NULL
);
CREATE TABLE Quizzes (
    quiz_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    created_by INT NOT NULL, 
    created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    duration INT, -- in minutes
    status ENUM('active','closed') DEFAULT 'active',
    FOREIGN KEY (created_by) REFERENCES Users(user_id)
);

CREATE TABLE Questions (
    question_id INT AUTO_INCREMENT PRIMARY KEY,
    quiz_id INT NOT NULL,
    question_text TEXT NOT NULL,
    option_a VARCHAR(200),
    option_b VARCHAR(200),
    option_c VARCHAR(200),
    option_d VARCHAR(200),
    correct_answer VARCHAR(10) NOT NULL, -- e.g. 'A', 'B', 'C', 'D'
    FOREIGN KEY (quiz_id) REFERENCES Quizzes(quiz_id) ON DELETE CASCADE
);

CREATE TABLE Results (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    quiz_id INT NOT NULL,
    user_id INT NOT NULL,
    score INT
);

CREATE TABLE Responses (
    response_id INT AUTO_INCREMENT PRIMARY KEY,
    quiz_id INT NOT NULL,
    user_id INT NOT NULL,
    question_id INT NOT NULL,
    selected_option VARCHAR(10),
    submitted_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (quiz_id) REFERENCES Quizzes(quiz_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (question_id) REFERENCES Questions(question_id)
);


Select * FROM Users;
Select * FROM Quizzes;
Select * FROM Questions;
Select * FROM Results;
SELECT * FROM Responses;

DROP Database QUIZ;

-- user
-- Add a Faculty
INSERT INTO Users (name, email, password, role)
VALUES ('Prof. Sharma', 'sharma@college.com', 'hashed_pass1', 'faculty');
-- Add a Student
INSERT INTO Users (name, email, password, role)
VALUES ('Shivani', 'shivani@college.com', 'hashed_pass2', 'student');

-- INSERT QUIZ
INSERT INTO Quizzes (title, description, created_by, duration, status)
VALUES ('Java Basics Quiz', 'Covers OOP and variables', 1, 30, 'active');


-- INSERT Q
INSERT INTO Questions (quiz_id, question_text, option_a, option_b, option_c, option_d, correct_answer)
VALUES 
(1, 'Which keyword is used to inherit a class in Java?', 'super', 'this', 'extends', 'implements', 'C'),

(1, 'Which of these is not a primitive data type in Java?', 'int', 'float', 'boolean', 'String', 'D');

-- Response
-- Student (user_id = 2) answers Question 1 with option C
INSERT INTO Responses (quiz_id, user_id, question_id, selected_option)
VALUES (1, 2, 1, 'C');

-- Student (user_id = 2) answers Question 2 with option A
INSERT INTO Responses (quiz_id, user_id, question_id, selected_option)
VALUES (1, 2, 2, 'A');

-- RESULT
INSERT INTO Results (quiz_id, user_id, score)
VALUES (1, 2, 1);