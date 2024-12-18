CREATE TABLE PROFESSOR (
    PROFESSOR_SOCIAL_SECURITY_NUMBER NUMERIC(9) NOT NULL,
    PROFESSOR_FIRST_NAME VARCHAR(255),
    PROFESSOR_LAST_NAME VARCHAR(255),
    PROFESSOR_STREET_ADDRESS VARCHAR(255),
    PROFESSOR_CITY VARCHAR(255),
    PROFESSOR_STATE VARCHAR(255),
    PROFESSOR_ZIPCODE NUMERIC(5),
    PROFESSOR_AREA_CODE INTEGER,
    PROFESSOR_TELEPHONE_NUMBER NUMERIC(7),
    PROFESSOR_SEX ENUM('Male', 'Female') NOT NULL,
    PROFESSOR_TITLE VARCHAR(255),
    PROFESSOR_SALARY INTEGER,
    PRIMARY KEY(PROFESSOR_SOCIAL_SECURITY_NUMBER)
);

CREATE TABLE DEPARTMENT(

    DEPARTMENT_UNIQUE_NUMBER char(4) NOT NULL,
    DEPARTMENT_NAME VARCHAR(255),
    DEPARTMENT_AREA_CODE INTEGER,
    DEPARTMENT_TELEPHONE_NUMBER NUMERIC(7),
    DEPARTMENT_OFFICE_LOCATION VARCHAR(255),
    DEPARTMENT_CHAIR_PERSON_SSN NUMERIC(9) NOT NULL,
    PRIMARY KEY(DEPARTMENT_UNIQUE_NUMBER),
    FOREIGN KEY (DEPARTMENT_CHAIR_PERSON_SSN) REFERENCES PROFESSOR(PROFESSOR_SOCIAL_SECURITY_NUMBER)
);

CREATE TABLE COURSE (
    COURSE_UNIQUE_NUMBER INTEGER NOT NULL,
    COURSE_TITLE VARCHAR(255),
    COURSE_TEXTBOOK VARCHAR(255),
    COURSE_UNITS INTEGER NOT NULL,
    COURSE_DEPARTMENT_NUM char(4) NOT NULL,
    COURSE_IDENTIFICATION_NUMBER INTEGER NOT NULL,
    PRIMARY KEY(COURSE_UNIQUE_NUMBER),
    FOREIGN KEY(COURSE_DEPARTMENT_NUM) REFERENCES DEPARTMENT(DEPARTMENT_UNIQUE_NUMBER)
);


CREATE TABLE COURSE_SECTION (
    COURSE_SECTION_UNIQUE_NUMBER INTEGER NOT NULL,
    COURSE_SECTION_COURSE_UNIQUE_NUMBER INTEGER NOT NULL,
    COURSE_SECTION_DEPARTMENT_NUM char(4) NOT NULL,
    COURSE_SECTION_COURSE_IDENTIFICATION_NUMBER INTEGER NOT NULL,
    COURSE_SECTION_CLASSROOM VARCHAR(255),
    COURSE_SECTION_NUMSEATS INTEGER NOT NULL,
    COURSE_SECTION_MEETING_DAYS VARCHAR(255),
    COURSE_SECTION_START_TIME VARCHAR(255),
    COURSE_SECTION_END_TIME VARCHAR(255),
    COURSE_SECTION_PROFESSOR_SSN NUMERIC(9) NOT NULL,
    PRIMARY KEY(COURSE_SECTION_UNIQUE_NUMBER,COURSE_SECTION_COURSE_UNIQUE_NUMBER,COURSE_SECTION_DEPARTMENT_NUM),
    FOREIGN KEY(COURSE_SECTION_COURSE_UNIQUE_NUMBER) REFERENCES COURSE(COURSE_UNIQUE_NUMBER),
    FOREIGN KEY(COURSE_SECTION_DEPARTMENT_NUM) REFERENCES DEPARTMENT(DEPARTMENT_UNIQUE_NUMBER),
    FOREIGN KEY(COURSE_SECTION_PROFESSOR_SSN) REFERENCES PROFESSOR(PROFESSOR_SOCIAL_SECURITY_NUMBER)

);

CREATE TABLE STUDENT (
    STUDENT_CWID NUMERIC(9) NOT NULL,
    STUDENT_FIRST_NAME VARCHAR(225),
    STUDENT_LAST_NAME VARCHAR(225),
    STUDENT_STREET_ADDRESS VARCHAR(255),
    STUDENT_CITY VARCHAR(255),
    STUDENT_STATE VARCHAR(255),
    STUDENT_ZIPCODE NUMERIC(5),
    STUDENT_AREA_CODE INTEGER,
    STUDENT_TELEPHONE_NUMBER NUMERIC(7),
    STUDENT_SEX ENUM('Male', 'Female') NOT NULL,
    STUDENT_MAJOR char(4) NOT NULL,
    PRIMARY KEY(STUDENT_CWID),
    FOREIGN KEY (STUDENT_MAJOR) REFERENCES DEPARTMENT(DEPARTMENT_UNIQUE_NUMBER)
);



CREATE TABLE ENROLLMENT_RECORD(
    ENROLLMENT_RECORD_UNIQUE_NUMBER INTEGER NOT NULL,
    ENROLLMENT_RECORD_STUDENT_CWID NUMERIC(9) NOT NULL,
    ENROLLMENT_RECORD_COURSE_SECTION_NUMBER INTEGER NOT NULL,
    ENROLLMENT_RECORD_COURSE_SECTION_COURSE_UNIQUE_NUMBER INTEGER NOT NULL,
    ENROLLMENT_RECORD_COURSE_SECTION_DEPARTMENT_NUM char(4) NOT NULL,
    ENROLLMENT_COURSE_SECTION_IDENTIFICATION_NUMBER VARCHAR(255),
    ENROLLMENT_RECORD_GRADE VARCHAR(255),
    PRIMARY KEY(ENROLLMENT_RECORD_UNIQUE_NUMBER),
    FOREIGN KEY (ENROLLMENT_RECORD_STUDENT_CWID) REFERENCES STUDENT(STUDENT_CWID),
    FOREIGN KEY (ENROLLMENT_RECORD_COURSE_SECTION_NUMBER,ENROLLMENT_RECORD_COURSE_SECTION_COURSE_UNIQUE_NUMBER,ENROLLMENT_RECORD_COURSE_SECTION_DEPARTMENT_NUM) 
    REFERENCES COURSE_SECTION(COURSE_SECTION_UNIQUE_NUMBER,COURSE_SECTION_COURSE_UNIQUE_NUMBER,COURSE_SECTION_DEPARTMENT_NUM)





);






CREATE TABLE MINOR (
    MINOR_DEPARTMENT_UNIQUE_NUMBER char(4) NOT NULL,
    MINOR_STUDENTS_CWID NUMERIC(9) NOT NULL,
    PRIMARY KEY(MINOR_DEPARTMENT_UNIQUE_NUMBER),
    FOREIGN KEY(MINOR_DEPARTMENT_UNIQUE_NUMBER) REFERENCES DEPARTMENT(DEPARTMENT_UNIQUE_NUMBER),
    FOREIGN KEY(MINOR_STUDENTS_CWID) REFERENCES STUDENT(STUDENT_CWID)

);


CREATE TABLE PREREQUISITE(
    PREREQUISITE_COURSE_UNIQUE_NUMBER INTEGER NOT NULL,
    PREREQUISITE_COURSE_UNIQUE_DEPARMENT_UNIQUE_NUMBER char(4) NOT NULL,
    PRIMARY KEY (PREREQUISITE_COURSE_UNIQUE_NUMBER),
    FOREIGN KEY (PREREQUISITE_COURSE_UNIQUE_NUMBER) REFERENCES COURSE(COURSE_UNIQUE_NUMBER),
    FOREIGN KEY (PREREQUISITE_COURSE_UNIQUE_DEPARMENT_UNIQUE_NUMBER) REFERENCES DEPARTMENT(DEPARTMENT_UNIQUE_NUMBER)


);


CREATE TABLE PROFESSOR_COLLEGE_DEGREES(
    PROFESSOR_COLLEGE_DEGREE VARCHAR(255),
    DEPARTMENT_PROFESSOR_SSN NUMERIC(9) NOT NULL,
    PROFESSOR_COLLEGE_DATE_AWARDED VARCHAR(255),
    PRIMARY KEY(PROFESSOR_COLLEGE_DEGREE),
    FOREIGN KEY(DEPARTMENT_PROFESSOR_SSN) REFERENCES PROFESSOR(PROFESSOR_SOCIAL_SECURITY_NUMBER)

);



INSERT INTO PROFESSOR VALUES
(123456789, 'Adam', 'Jones','6473 Burch St','Placerville','CA',22546,567,2948301,'Male', 'Dr. ',200000),
(765626466, 'Lisa', 'Smith','463 Arid St','Maricopa','AZ',93526,653,7338321,'Female', 'Professor. ',342000),
(543565396, 'Ron', 'Navarro','5646 Newbury St','Plains','GA',42316,543,5938321,'Male', 'Assistant Professor. ',262000);



INSERT INTO DEPARTMENT VALUES

('CPSC', 'Computer Science',714,2136637,'CS-429',123456789),
('ISDS', 'Information Systems',657,7535679,'SGMH-245',123456789);





INSERT INTO COURSE VALUES
(18495, 'File Structures and Databases', 'Databases for Begginers',3,'CPSC',332),
(17981, 'Operating Systems', 'Operating Systems for Begginers',3,'CPSC',351),
(18262,'Artificial Intelligence','Artificial Intelligence : A Modern Approach 4th Edition',3,'CPSC',488),
(17874, 'Introduction to Prgramming', 'Basic Prgramming Concepts 12th Edition',3,'ISDS',309),
(19453, 'Privacy and Security', 'Cyber Security for Begginers: Security is Key 6th Edition',3,'ISDS',418);






INSERT INTO COURSE_SECTION VALUES
(01, 18262, 'CPSC', 488, 'CS 101', 45, 'M/W', '7:00 PM', '9:45 PM', 765626466),
(02, 17981, 'CPSC',351, 'CS 110A', 35, 'T/TH', '1:00 PM', '2:15 PM', 543565396),
(03, 17981, 'CPSC', 351,'CS 110A', 35, 'T/TH', '7:00 PM', '8:15 PM', 543565396),
(03, 18495, 'CPSC',332, 'CS 208', 35, 'T', '1:00 PM', '3:15 PM', 123456789),
(04, 18495, 'CPSC',332, 'CS 101', 45, 'M/W', '11:00 AM', '12:50 PM', 765626466),
(05, 19453, 'ISDS',418, 'CS 300', 35, 'T/TH', '4:00 PM', '5:15 PM', 543565396),
(06, 17874, 'ISDS',309, 'CS 208', 35, 'T', '4:00 PM', '6:15 PM', 123456789);


INSERT INTO STUDENT VALUES
(111222333, 'John', 'Doe', '123 Main St', 'Irvine', 'CA', 92618, 949, 5551234, 'Male', 'CPSC'),
(222333444, 'Jane', 'Smith', '456 Oak St', 'Fullerton', 'CA', 92831, 714, 5555678, 'Female', 'CPSC'),
(333444555, 'Emily', 'Johnson', '789 Pine St', 'Tustin', 'CA', 92780, 714, 5559876, 'Female', 'ISDS'),
(444555666, 'Michael', 'Brown', '321 Maple St', 'Anaheim', 'CA', 92805, 657, 5554321, 'Male', 'ISDS'),
(555666777, 'Jessica', 'Davis', '654 Cedar St', 'Brea', 'CA', 92821, 714, 5557654, 'Female', 'CPSC'),
(666777888, 'Chris', 'Martinez', '987 Elm St', 'Orange', 'CA', 92866, 714, 5553456, 'Male', 'ISDS'),
(777888999, 'Laura', 'Garcia', '246 Birch St', 'Santa Ana', 'CA', 92701, 657, 5556789, 'Female', 'CPSC'),
(888000999, 'David', 'Wilson', '369 Palm St', 'Garden Grove', 'CA', 92840, 714, 5559876, 'Male', 'ISDS'),
(999111000, 'Sophia', 'Miller', '135 Willow St', 'Costa Mesa', 'CA', 92626, 949, 5551122, 'Female', 'CPSC'),
(000222111, 'Daniel', 'Lopez', '789 Spruce St', 'Huntington Beach', 'CA', 92646, 714, 5552233, 'Male', 'ISDS'),
(111333444, 'Olivia', 'Anderson', '159 Oak St', 'Irvine', 'CA', 92618, 949, 5551357, 'Female', 'CPSC'),
(222444555, 'James', 'Taylor', '753 Birch St', 'Tustin', 'CA', 92780, 714, 5552468, 'Male', 'ISDS'),
(333555666, 'Isabella', 'Thomas', '852 Maple St', 'Anaheim', 'CA', 92805, 657, 5553697, 'Female', 'CPSC'),
(444666777, 'Liam', 'Jackson', '654 Pine St', 'Brea', 'CA', 92821, 714, 5554567, 'Male', 'ISDS'),
(555777888, 'Mia', 'White', '159 Cedar St', 'Orange', 'CA', 92866, 714, 5555678, 'Female', 'CPSC'),
(666888999, 'Noah', 'Harris', '963 Elm St', 'Garden Grove', 'CA', 92840, 714, 5556789, 'Male', 'ISDS'),
(777999000, 'Ava', 'Clark', '753 Birch St', 'Santa Ana', 'CA', 92701, 657, 5557890, 'Female', 'CPSC'),
(888111222, 'Lucas', 'Lewis', '258 Palm St', 'Costa Mesa', 'CA', 92626, 949, 5558901, 'Male', 'ISDS'),
(999222333, 'Zoe', 'Robinson', '369 Willow St', 'Huntington Beach', 'CA', 92646, 714, 5559012, 'Female', 'CPSC'),
(000333444, 'Ethan', 'Hall', '147 Cedar St', 'Fullerton', 'CA', 92831, 714, 5550123, 'Male', 'ISDS'),
(111444555, 'Emma', 'Young', '258 Elm St', 'Irvine', 'CA', 92618, 949, 5551234, 'Female', 'CPSC');





INSERT INTO ENROLLMENT_RECORD VALUES
(1, 111222333, 01, 18262, 'CPSC', 488, 'A'),  -- John Doe enrolled in CS 101 for course section 488
(2, 222333444, 02, 17981, 'CPSC', 351, 'B'),  -- Jane Smith enrolled in CS 110A for course section 351
(3, 333444555, 03, 17981, 'CPSC', 351, 'A'),  -- Emily Johnson enrolled in CS 110A for course section 351
(4, 333444555, 04, 18495, 'CPSC', 332, 'C'),  -- Michael Brown enrolled in CS 101 for course section 332
(5, 555666777, 05, 19453, 'ISDS', 418, 'B'),  -- Jessica Davis enrolled in CS 300 for course section 418
(6, 555666777, 06, 17874, 'ISDS', 309, 'B'),  -- Chris Martinez enrolled in CS 208 for course section 309
(7, 777888999, 01, 18262, 'CPSC', 488, 'A'),  -- Laura Garcia enrolled in CS 101 for course section 488
(8, 777888999, 02, 17981, 'CPSC', 351, 'C'),  -- David Wilson enrolled in CS 110A for course section 351
(9, 999111000, 03, 17981, 'CPSC', 351, 'D'),  -- Sophia Miller enrolled in CS 110A for course section 351
(10, 000222111, 04, 18495, 'CPSC', 332, 'C'), -- Daniel Lopez enrolled in CS 101 for course section 332
(11, 111333444, 05, 19453, 'ISDS', 418, 'B'), -- Olivia Anderson enrolled in CS 300 for course section 418
(12, 111333444, 06, 17874, 'ISDS', 309, 'B'), -- James Taylor enrolled in CS 208 for course section 309
(13, 111333444, 01, 18262, 'CPSC', 488, 'A'), -- Isabella Thomas enrolled in CS 101 for course section 488
(14, 444666777, 02, 17981, 'CPSC', 351, 'B'), -- Liam Jackson enrolled in CS 110A for course section 351
(15, 555777888, 03, 17981, 'CPSC', 351, 'B'), -- Mia White enrolled in CS 110A for course section 351
(16, 666888999, 03, 18495, 'CPSC', 332, 'C'), -- Noah Harris enrolled in CS 101 for course section 332
(17, 777999000, 05, 19453, 'ISDS', 418, 'B'), -- Ava Clark enrolled in CS 300 for course section 418
(18, 888111222, 06, 17874, 'ISDS', 309, 'B'), -- Lucas Lewis enrolled in CS 208 for course section 309
(19, 999222333, 01, 18262, 'CPSC', 488, 'A'), -- Zoe Robinson enrolled in CS 101 for course section 488
(20, 000333444, 02, 17981, 'CPSC', 351, 'B'), -- Ethan Hall enrolled in CS 110A for course section 351
(21, 111444555, 04, 18495, 'CPSC', 332, 'C'); -- Emma Young enrolled in CS 101 for course section 332

