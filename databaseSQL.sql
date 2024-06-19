
create database Farewell;

use Farewell;

-- Table for StudentData:
CREATE TABLE StudentData (
    student_ID VARCHAR(7) PRIMARY KEY,
    Name VARCHAR(50)
);

CREATE TABLE Student (
    student_ID VARCHAR(7) PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(100),
    Password VARCHAR(255),
    DietaryPreference VARCHAR(100),
    TotalFamilyMembers INT NOT NULL CHECK (TotalFamilyMembers >= 0) 
);

CREATE TABLE Volunteer (
    student_ID VARCHAR(7),
    task_ID INT AUTO_INCREMENT,
    PRIMARY KEY (task_ID),
    FOREIGN KEY (student_ID) REFERENCES Student(student_ID)
);

DROP TABLE IF EXISTS Volunteer;

-- modify column 


CREATE TABLE Organizer (
    organizerID VARCHAR(7) PRIMARY KEY,
    student_ID VARCHAR(7) NOT NULL,  -- Assuming student_ID is a VARCHAR(7) in the Student table
    Name VARCHAR(255) NOT NULL,
    Category ENUM('Performance', 'Budget', 'Menu', 'Manager', 'Invitations', 'Decor', 'Security') NOT NULL,
    Email VARCHAR(255),
    Role VARCHAR(100),
    Password VARCHAR(255),
    FOREIGN KEY (student_ID) REFERENCES Student(student_ID)
);

CREATE TABLE MenuItem(
    itemID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20),
    price INT NOT NULL
);

-- ItemSuggest:
CREATE TABLE ItemSuggest (
    itemID INT PRIMARY KEY,
    name VARCHAR(50),
    votes INT NOT NULL,
    FOREIGN KEY (itemID) REFERENCES MenuItem(itemID)
);

-- FinalMenu:
CREATE TABLE FinalMenu (
    itemID INT,
    name VARCHAR(20),
    price INT NOT NULL,
    PRIMARY KEY (itemID),
    FOREIGN KEY (itemID) REFERENCES MenuItem(itemID)
);

-- Teacher Table:
CREATE TABLE Teacher (
    ID VARCHAR(7) PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(100)
);

CREATE TABLE TeacherRegistration (
    TeacherID VARCHAR(7),
    Name VARCHAR(50),
    NumberOfFamilyMembers INT,
    PRIMARY KEY (TeacherID),
    FOREIGN KEY (TeacherID) REFERENCES Teacher(ID)  -- Changed 'Teachers' to 'Teacher'
);

-- PerformanceVoting:
CREATE TABLE PerformanceVoting (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Type VARCHAR(20),
    Duration INT,  -- Duration in minutes
    SpecialRequirements VARCHAR(50),
    Votes INT NOT NULL
);

-- Final Performance:
CREATE TABLE FinalPerformance (
    ID INT,
    PRIMARY KEY (ID),
    FOREIGN KEY (ID) REFERENCES PerformanceVoting(ID)
);

-- Announcement Table:
CREATE TABLE Announcement (
    id INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(100)
);

-- Task's table:
CREATE TABLE Tasks (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(20),
    Status ENUM('Not Started', 'In Progress', 'Completed', 'On Hold', 'Cancelled') NOT NULL,
    Progress INT  -- basically progress as a percentage . . .
);

-- Making a table for allocation:
CREATE TABLE Allocation (
    TaskID INT,
    StudentID VARCHAR(7),
    FOREIGN KEY (TaskID) REFERENCES Tasks(ID),
    FOREIGN KEY (StudentID) REFERENCES Student(student_ID)
);


-- Making Rehearsals table:
CREATE TABLE Rehearsals (
    ID INT,
    Schedule DATETIME,
    PRIMARY KEY (ID),
    FOREIGN KEY (ID) REFERENCES FinalPerformance(ID)
);

-- students who have done suggestion
CREATE TABLE DoneSuggest(
    itemID INT,
    student_ID VARCHAR(7),
    FOREIGN KEY (itemID) REFERENCES MenuItem(itemID),
    FOREIGN KEY (student_ID) REFERENCES Student(student_ID)
);

-- students who have done performance voting
CREATE TABLE DonePerformSugest(
    ID INT,
    student_ID VARCHAR(7),
    FOREIGN KEY (ID) REFERENCES PerformanceVoting(ID),
    FOREIGN KEY (student_ID) REFERENCES Student(student_ID)
);

CREATE TABLE Performances (
    ID INT,
    Timeslot TIME,
    Venue VARCHAR(30),
    PRIMARY KEY (ID),
    FOREIGN KEY (ID) REFERENCES FinalPerformance(ID)
);

-- Creating a trigger for MenuItem:
DELIMITER $$
CREATE TRIGGER CheckMenuItemPrice BEFORE UPDATE ON MenuItem
-- Ensures that price above 1000 gets capped to 1000 and that we cannot have negative price . . .
FOR EACH ROW
BEGIN
    IF NEW.price < 0 THEN
        SET NEW.price = OLD.price; -- simply prevents from setting a negative price
    ELSEIF NEW.price > 1000 THEN
        SET NEW.price = 1000; -- capping the maximum price
    END IF;
END$$

DELIMITER ;

-- Creating a trigger for TeacherRegistration:
-- Basically, we cannot add negative family member count
DELIMITER $$
CREATE TRIGGER UpdateFamilyCount BEFORE UPDATE ON TeacherRegistration
FOR EACH ROW
BEGIN
    IF NEW.NumberOfFamilyMembers < 0 THEN
        SET NEW.NumberOfFamilyMembers = 0;
    END IF;
END$$

DELIMITER ;

-- Setting the trigger for ItemSuggestion:
DELIMITER $$
CREATE TRIGGER InitializeVotes BEFORE INSERT ON ItemSuggest
FOR EACH ROW
BEGIN
    SET NEW.votes = 0;
END$$

DELIMITER ;

-- Trigger for PerformanceVoting:
-- ensures votes are 0 if not set:
DELIMITER $$
CREATE TRIGGER InitializeVotesBeforeInsert BEFORE INSERT ON PerformanceVoting
FOR EACH ROW
BEGIN
    SET NEW.Votes = 0;
END$$

DELIMITER ;

-- Trigger for tasks
-- sets Progress to 0 by default:
DELIMITER $$
CREATE TRIGGER SetDefaultProgress BEFORE INSERT ON Tasks
FOR EACH ROW
BEGIN
    IF NEW.Progress IS NULL THEN
        SET NEW.Progress = 0;
    END IF;
END$$

DELIMITER ;

-- Inserting into StudentData:
INSERT INTO StudentData (student_ID, Name) VALUES
('BCDE123', 'Usman Malik'),
('BCDE124', 'Nadia Khan'),
('BCDE125', 'Ahmed Raza'),
('BCDE126', 'Amina Ilyas'),
('BCDE127', 'Tariq Jameel'),
('BCDE128', 'Sara Ahmed'),
('BCDE129', 'Asim Hussain'),
('BCDE130', 'Zara Naeem'),
('BCDE131', 'Junaid Khan'),
('BCDE132', 'Laila Ali'),
('BCDE133', 'Omar Siddiqui'),
('BCDE134', 'Farah Khan'),
('BCDE135', 'Ibrahim Ali'),
('BCDE136', 'Maha Arif'),
('BCDE137', 'Sohail Mirza'),
('BCDE138', 'Fatima Zahra'),
('BCDE139', 'Ali Hassan'),
('BCDE140', 'Rabia Basri'),
('BCDE141', 'Zainab Qureshi'),
('BCDE142', 'Yusuf Ahmed'),
('BCDE143', 'Aisha Bhatti'),
('BCDE144', 'Hassan Khalid'),
('BCDE145', 'Imran Qasim'),
('BCDE146', 'Javeria Khan'),
('BCDE147', 'Kamran Ali'),
('BCDE148', 'Lubna Riaz'),
('BCDE149', 'Mohsin Hayat'),
('BCDE150', 'Naila Tariq'),
('BCDE151', 'Owais Majeed'),
('BCDE152', 'Pakeeza Irfan'),
('BCDE153', 'Qasim Jutt'),
('BCDE154', 'Rania Sohail'),
('BCDE155', 'Saadullah Jan'),
('BCDE156', 'Tabinda Rashid'),
('BCDE157', 'Umer Farooq'),
('BCDE158', 'Viqar Ahmed'),
('BCDE159', 'Wahaj Ali'),
('BCDE160', 'Xara Malik'),
('BCDE161', 'Yasmeen Raza'),
('BCDE162', 'Zahid Mehmood');

INSERT INTO Student (student_ID, Name, Email, Password, DietaryPreference, TotalFamilyMembers) VALUES
('BCDE123', 'Usman Malik', 'usman.malik@example.com', 'pass123', 'Vegetarian', 2),
('BCDE124', 'Nadia Khan', 'nadia.khan@example.com', 'pass124', 'Vegan', 0),
('BCDE125', 'Ahmed Raza', 'ahmed.raza@example.com', 'pass125', 'Gluten-Free', 3),
('BCDE126', 'Amina Ilyas', 'amina.ilyas@example.com', 'pass126', 'Halal', 1),
('BCDE127', 'Tariq Jameel', 'tariq.jameel@example.com', 'pass127', 'Kosher', 0),
('BCDE128', 'Sara Ahmed', 'sara.ahmed@example.com', 'pass128', 'No Dairy', 1),
('BCDE129', 'Asim Hussain', 'asim.hussain@example.com', 'pass129', 'No Nuts', 2),
('BCDE130', 'Zara Naeem', 'zara.naeem@example.com', 'pass130', 'Halal', 4),
('BCDE131', 'Junaid Khan', 'junaid.khan@example.com', 'pass131', 'Vegetarian', 1),
('BCDE132', 'Laila Ali', 'laila.ali@example.com', 'pass132', 'Vegan', 3),
('BCDE133', 'Omar Siddiqui', 'omar.siddiqui@example.com', 'pass133', 'Gluten-Free', 2),
('BCDE134', 'Farah Khan', 'farah.khan@example.com', 'pass134', 'Halal', 0),
('BCDE135', 'Ibrahim Ali', 'ibrahim.ali@example.com', 'pass135', 'Kosher', 1),
('BCDE136', 'Maha Arif', 'maha.arif@example.com', 'pass136', 'Vegetarian', 2),
('BCDE137', 'Sohail Mirza', 'sohail.mirza@example.com', 'pass137', 'Vegan', 0),
('BCDE138', 'Fatima Zahra', 'fatima.zahra@example.com', 'pass138', 'No Dairy', 1),
('BCDE139', 'Ali Hassan', 'ali.hassan@example.com', 'pass139', 'No Nuts', 3),
('BCDE140', 'Rabia Basri', 'rabia.basri@example.com', 'pass140', 'Halal', 4),
('BCDE141', 'Zainab Qureshi', 'zainab.qureshi@example.com', 'pass141', 'Gluten-Free', 2),
('BCDE142', 'Yusuf Ahmed', 'yusuf.ahmed@example.com', 'pass142', 'Vegetarian', 1);


-- Inserting into Teacher table:
INSERT INTO Teacher (ID, Name, Email) VALUES
('ABCD123', 'Ayesha Khan', 'ayesha.khan@example.com'),
('EFGH124', 'Ali Ahmed', 'ali.ahmed@example.com'),
('IJKL125', 'Sara Ali', 'sara.ali@example.com'),
('MNOP126', 'Omar Farooq', 'omar.farooq@example.com'),
('QRST127', 'Fatima Iqbal', 'fatima.iqbal@example.com'),
('UVWX128', 'Hassan Raza', 'hassan.raza@example.com'),
('YZAB129', 'Maria Mahmood', 'maria.mahmood@example.com'),
('CDEF130', 'Zainab Asif', 'zainab.asif@example.com'),
('GHIJ131', 'Kamran Malik', 'kamran.malik@example.com'),
('KLMN132', 'Noor Fatima', 'noor.fatima@example.com'),
('OPQR133', 'Bilal Khan', 'bilal.khan@example.com'),
('STUV134', 'Hina Altaf', 'hina.altaf@example.com'),
('WXYZ135', 'Jawad Ahmed', 'jawad.ahmed@example.com'),
('ABEF136', 'Sana Mir', 'sana.mir@example.com'),
('GHIL137', 'Faisal Qureshi', 'faisal.qureshi@example.com'),
('MNPR138', 'Mahira Khan', 'mahira.khan@example.com'),
('STWX139', 'Imran Abbas', 'imran.abbas@example.com'),
('YZCD140', 'Nadia Hussain', 'nadia.hussain@example.com'),
('EFGK141', 'Asim Azhar', 'asim.azhar@example.com'),
('JKLM142', 'Hareem Farooq', 'hareem.farooq@example.com');

INSERT INTO TeacherRegistration (TeacherID, Name, NumberOfFamilyMembers) VALUES
('ABCD123', 'Ayesha Khan', 3),
('EFGH124', 'Ali Ahmad', 2),
('IJKL125', 'Sara Ali', 4),
('MNOP126', 'Omar Farooq', 1);

INSERT INTO MenuItem (name, price) VALUES
('Biryani', 150),
('Nihari', 200),
('Samosa', 30),
('Chapli Kebab', 120),
('Chicken Tikka', 180),
('Seekh Kebab', 100),
('Aloo Paratha', 50),
('Fish Curry', 220),
('Beef Burger', 250),
('Chicken Burger', 230),
('Cheese Burger', 260),
('Veggie Burger', 200),
('Pizza', 500),
('French Fries', 100),
('Club Sandwich', 150),
('Dal Fry', 130),
('Butter Chicken', 300),
('Chana Chaat', 70),
('Gol Gappay', 40),
('Falooda', 120);

-- Inserting into ItemSuggest:
INSERT INTO ItemSuggest (itemID, name) VALUES
(1, 'Biryani'),
(2, 'Nihari'),
(3, 'Samosa'),
(4, 'Chapli Kebab'),
(5, 'Chicken Tikka'),
(6, 'Seekh Kebab'),
(7, 'Aloo Paratha'),
(8, 'Fish Curry'),
(9, 'Beef Burger'),
(10, 'Chicken Burger');


-- Inserting into FinalMenu:
INSERT INTO FinalMenu (itemID, name, price) VALUES
(11, 'Cheese Burger', 260),
(12, 'Veggie Burger', 200),
(13, 'Pizza', 500),
(14, 'French Fries', 100),
(15, 'Club Sandwich', 150),
(16, 'Dal Fry', 130),
(17, 'Butter Chicken', 300),
(18, 'Chana Chaat', 70),
(19, 'Gol Gappay', 40),
(20, 'Falooda', 120);

-- students who have done voting
INSERT INTO DoneSuggest (itemID, student_ID) VALUES
(1, 'BCDE123'),
(2, 'BCDE124'),
(3, 'BCDE125'),
(4, 'BCDE126'),
(5, 'BCDE127'),
(6, 'BCDE128');


-- Inserting into Allocation:
INSERT INTO Allocation (TaskID, StudentID) VALUES
(1, 'BCDE123'),  -- Task 1 assigned to Usman Malik
(2, 'BCDE124'),  -- Task 2 assigned to Nadia Khan
(3, 'BCDE125'),  -- Task 3 assigned to Ahmed Raza
(4, 'BCDE126'),  -- Task 4 assigned to Amina Ilyas
(5, 'BCDE127'),  -- Task 5 assigned to Tariq Jameel
(6, 'BCDE128');  -- Task 6 assigned to Sara Ahmed


-- Inserting values into Tasks:
INSERT INTO Tasks (Name, Status) VALUES
('Budget Report', 'Not Started'),
('Venue Booking', 'Completed'),
('Decor Planning', 'In Progress'),
('Invite Design', 'On Hold'),
('Catering Confirm', 'In Progress'),
('Music Setup', 'Cancelled');


-- Inserting into Announcements:
INSERT INTO Announcement (description) VALUES
('Performance of the jazz band has been delayed by 30 minutes.'),
('The menu item Biryani has been replaced with Pulao.'),
('Reminder: Collect event passes from the front desk before 5 PM.'),
('Location change: The poetry session will now be held in Room 204.');


-- Inserting into FinalPerformance:
INSERT INTO FinalPerformance (ID) VALUES
(1),
(2),
(3),
(4),
(5);

-- Inserting in PerformanceVoting:
INSERT INTO PerformanceVoting (Type, Duration, SpecialRequirements) VALUES
('Dance', 60, 'Large stage'),
('Comedy', 30, 'Microphone'),
('Drama', 90, 'Props for set'),
('Poetry', 20, 'Quiet room'),
('Jazz Band', 45, 'Sound system'),
('Magic Show', 30, 'No special requirements'),
('Lecture', 60, 'Projector and screen'),
('Film Screening', 120, 'Dark room, chairs'),
('Live Painting', 40, 'Natural light'),
('Folk Music', 50, 'Outdoor setting');

CREATE TABLE Budget (
    organizerID VARCHAR(7),
    category ENUM('Performance', 'Budget', 'Menu', 'Manager', 'Invitations', 'Decor', 'Security'),
    allocated_amount INT,  
    spent_amount INT,  
    PRIMARY KEY (organizerID, category),
    FOREIGN KEY (organizerID) REFERENCES Organizer(organizerID)
);


INSERT INTO Budget (organizerID, category, allocated_amount, spent_amount)
VALUES
('ORG001', 'Performance', 100000, 25000),  -- Example values in cents
('ORG002', 'Budget', 150000, 50000),
('ORG003', 'Menu', 80000, 20000),
('ORG004', 'Manager', 50000, 10000),
('ORG005', 'Invitations', 30000, 5000),
('ORG006', 'Decor', 120000, 30000),
('ORG007', 'Security', 40000, 10000);

CREATE VIEW BudgetView AS
SELECT organizerID, 
       category, 
       allocated_amount, 
       spent_amount,
       (allocated_amount - spent_amount) AS remaining_amount
FROM Budget;

DELIMITER //
CREATE TRIGGER EnsureSpendingLimit
BEFORE UPDATE ON Budget
FOR EACH ROW
BEGIN
    IF NEW.spent_amount > NEW.allocated_amount THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Spent amount cannot exceed allocated amount';
    END IF;
END;
//
DELIMITER ;

INSERT INTO Organizer (organizerID, student_ID, Name, Category, Email, Role, Password) VALUES
('ORG001', 'BCDE123', 'Usman Malik', 'Menu', 'usman.malik@example.com', 'Manager', 'pass123'),
('ORG002', 'BCDE124', 'Nadia Khan', 'Decor', 'nadia.khan@example.com', 'Coordinator', 'pass124'),
('ORG003', 'BCDE125', 'Ahmed Raza', 'Performance', 'ahmed.raza@example.com', 'Event Planner', 'pass125'),
('ORG004', 'BCDE126', 'Amina Ilyas', 'Invitations', 'amina.ilyas@example.com', 'Manager', 'pass126'),
('ORG005', 'BCDE127', 'Tariq Jameel', 'Budget', 'tariq.jameel@example.com', 'Manager', 'pass127'),
('ORG006', 'BCDE128', 'Sara Ahmed', 'Security', 'sara.ahmed@example.com', 'Coordinator', 'pass128'),
('ORG007', 'BCDE129', 'Asim Hussain', 'Performance', 'asim.hussain@example.com', 'Event Planner', 'pass129'),
('ORG008', 'BCDE130', 'Zara Naeem', 'Decor', 'zara.naeem@example.com', 'Coordinator', 'pass130'),
('ORG009', 'BCDE131', 'Junaid Khan', 'Invitations', 'junaid.khan@example.com', 'Manager', 'pass131');


-- ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '123456';