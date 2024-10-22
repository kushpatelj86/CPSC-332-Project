CREATE TABLE PROFESSOR (
    PROFESSOR_SOCIAL_SECURITY_NUMBER numeric(9) NOT NULL,
    PROFESSOR_FIRST_NAME VARCHAR(255),
    PROFESSOR_LAST_NAME VARCHAR(255),
    PROFESSOR_STREET_ADDRESS VARCHAR(255),
    PROFESSOR_CITY VARCHAR(255),
    PROFESSOR_STATE VARCHAR(255),
    PROFESSOR_ZIPCODE numeric(5),
    PROFESSOR_AREA_CODE INTEGER,
    PROFESSOR_TELEPHONE_NUMBER numeric(7),
    PROFESSOR_SEX ENUM('Male', 'Female') NOT NULL,
    PROFESSOR_TITLE VARCHAR(255),
    PROFESSOR_SALARY INTEGER,
    PRIMARY KEY(PROFESSOR_SOCIAL_SECURITY_NUMBER)
);



CREATE TABLE DEPARTMENT(

    DEPARTMENT_UNIQUE_NUMBER char(4) NOT NULL,
    DEPARTMENT_NAME VARCHAR(255),
    DEPARTMENT_AREA_CODE INTEGER,
    DEPARTMENT_TELEPHONE_NUMBER numeric(7),
    DEPARTMENT_OFFICE_LOCATION VARCHAR(255),
    CHAIR_PERSON_SSN numeric(9) NOT NULL
    PRIMARY KEY(DEPARTMENT_UNIQUE_NUMBER),
    FOREIGN KEY (CHAIR_PERSON_SSN) REFERENCES Professor(PROFESSOR_SOCIAL_SECURITY_NUMBER)
);

CREATE TABLE COURSE (
    COURSE_UNIQUE_NUMBER INTEGER NOT NULL,
    COURSE_TITLE VARCHAR(255),
    COURSE_TEXTBOOK VARCHAR(255),
    COURSE_UNITS INTEGER NOT NULL,
    COURSE_DEPARTMENT_NUM char(4) NOT NULL,
    PRIMARY KEY(COURSE_UNIQUE_NUMBER),
    FOREIGN KEY(COURSE_DEPARTMENT_NUM) REFERENCES DEPARTMENT(DEPARTMENT_UNIQUE_NUMBER)
);


CREATE TABLE COURSE_SECTION (
    COURSE_SECTION_UNIQUE_NUMBER INTEGER NOT NULL,
    COURSE_SECTION_CLASSROOM VARCHAR(255),
    COURSE_SECTION_NUMSEATS INTEGER NOT NULL,
    COURSE_SECTION_MEETING_DAYS VARCHAR(255),
    COURSE_SECTION_START_TIME VARCHAR(255),
    COURSE_SECTION_END_TIME VARCHAR(255),
    COURSE_SECTION_COURSE_UNIQUE_NUMBER INTEGER NOT NULL,
    COURSE_SECTION_DEPARTMENT_NUM char(4) NOT NULL,
    COURSE_SECTION_PROFESSOR_SNN numeric(9) NOT NULL,
    PRIMARY KEY(COURSE_SECTION_UNIQUE_NUMBER),
    FOREIGN KEY(COURSE_SECTION_COURSE_UNIQUE_NUMBER) REFERENCES COURSE(COURSE_UNIQUE_NUMBER)
    FOREIGN KEY(COURSE_SECTION_DEPARTMENT_NUM) REFERENCES DEPARTMENT(DEPARTMENT_UNIQUE_NUMBER)

    FOREIGN KEY(COURSE_SECTION_PROFESSOR_SNN) REFERENCES PROFESSOR(PROFESSOR_SOCIAL_SECURITY_NUMBER)


);

CREATE TABLE STUDENT (
    STUDENT_CWID numeric(9) NOT NULL,
    STUDENT_FIRST_NAME VARCHAR(225),
    STUDENT_LAST_NAME VARCHAR(225),
    STUDENT_STREET_ADDRESS VARCHAR(255),
    STUDENT_CITY VARCHAR(255),
    STUDENT_STATE VARCHAR(255),
    STUDENT_ZIPCODE numeric(5),
    STUDENT_AREA_CODE INTEGER,
    STUDENT_TELEPHONE_NUMBER numeric(7),
    STUDENT_SEX ENUM('Male', 'Female') NOT NULL,
    STUDENT_MAJOR char(4) NOT NULL
    PRIMARY KEY(STUDENT_CWID),
    FOREIGN KEY (STUDENT_MAJOR) REFERENCES Department(DEPARTMENT_UNIQUE_NUMBER)
);



CREATE TABLE ENROLLMENT_RECORD(
    ENROLLMENT_RECORD_UNIQUE_NUMBER INTEGER NOT NULL,
    ENROLLMENT_RECORD_STUDENT_CWID numeric(9) NOT NULL,
    ENROLLMENT_RECORD_COURSE_SECTION_NUMBER INTEGER NOT NULL,
    ENROLLMENT_RECORD_GRADE VARCHAR(255),
    PRIMARY KEY(ENROLLMENT_RECORD_UNIQUE_NUMBER),
    FOREIGN KEY (ENROLLMENT_RECORD_STUDENT_CWID) REFERENCES STUDENT(STUDENT_CWID),
    FOREIGN KEY (ENROLLMENT_RECORD_COURSE_SECTION_NUMBER) REFERENCES COURSE_SECTION(COURSE_SECTION_UNIQUE_NUMBER)





);






CREATE TABLE MINOR (
    MINOR_DEPARTMENT_UNIQUE_NUMBER char(4) NOT NULL,
    MINOR_STUDENTS_CWID numeric(9) NOT NULL,
    PRIMARY KEY(MINOR_DEPARTMENT_UNIQUE_NUMBER),
    FOREIGN KEY(MINOR_DEPARTMENT_UNIQUE_NUMBER) REFERENCES Department(DEPARTMENT_UNIQUE_NUMBER),
    FOREIGN KEY(MINOR_STUDENTS_CWID) REFERENCES STUDENT(STUDENT_CWID)

);


CREATE TABLE PREREQUISITE(
    PREREQUISITE_COURSE_UNIQUE_NUMBER char(4) NOT NULL,
    PRIMARY KEY (PREREQUISITE_COURSE_UNIQUE_NUMBER),
    FOREIGN KEY (PREREQUISITE_COURSE_UNIQUE_NUMBER) REFERENCES Course(COURSE_UNIQUE_NUMBER)

);


CREATE TABLE PROFESSOR_COLLEGE_DEGREES(
    PROFESSOR_COLLEGE_DEGREE VARCHAR(255),
    DEPARTMENT_PROFESSOR_SSN numeric(9) NOT NULL,
    PROFESSOR_COLLEGE_DATE_AWARDED VARCHAR(255),
    PRIMARY KEY(PROFESSOR_COLLEGE_DEGREE),
    FOREIGN KEY(DEPARTMENT_PROFESSOR_SSN) REFERENCES Professor(PROFESSOR_SOCIAL_SECURITY_NUMBER)

);



INSERT INTO PROFESSOR VALUES

(123456789, 'Adam', 'Jones','6473 Burch St','Placerville','CA',22546,567,2948301,'Male', 'Dr. ',200000),
(765626466, 'Lisa', 'Smith','463 Arid St','Maricopa','AZ',93526,653,7338321,'Female', 'Professor. ',342000),
(543565396, 'Ron', 'Navarro','5646 Newbury St','Plains','GA',42316,543,5938321,'Male', 'Assistant Professor. ',262000);



INSERT INTO DEPARTMENT VALUES

('CPSC', 'Computer Science',714,2136637,"CS-429",987654321),
("ISDS", 'Information Systems',657,7535679,"SGMH-245",234756821);



INSERT INTO ENROLLMENT_RECORD VALUES
(30016, 666777888, 02, 'A-'),
(30017, 777888999, 03, 'B+'),
(30018, 888000999, 04, 'A'),
(30019, 999111000, 05, 'B'),
(30020, 000222111, 06, 'C+'),
(30021, 111222333, 01, 'A'),
(30022, 222333444, 02, 'B-'),
(30023, 333444555, 03, 'C'),
(30024, 444555666, 04, 'A'),
(30025, 555666777, 05, 'B+'),
(30026, 666777888, 06, 'F'),
(30027, 777888999, 01, 'A-'),
(30028, 888000999, 02, 'D+'),
(30029, 999111000, 03, 'A'),
(30030, 000222111, 04, 'C'),
(30031, 111222333, 05, 'B'),
(30032, 222333444, 06, 'A-'),
(30033, 333444555, 01, 'B+'),
(30034, 444555666, 02, 'A'),
(30035, 555666777, 03, 'C+');



INSERT INTO COURSE VALUES
(332, "File Structures and Databases", "Databases for Begginers",3,'CPSC'),
(351, "Operating Systems", "Operating Systems for Begginers",3,'CPSC'),
(488,'Artificial Intelligence','Artificial Intelligence : A Modern Approach 4th Edition',3,'CPSC'),
(309, "Introduction to Prgramming", "Basic Prgramming Concepts 12th Edition",3,'ISDS'),
(418, "Privacy and Security", "Cyber Security for Begginers: Security is Key 6th Edition",3,'ISDS');





INSERT INTO COURSE_SECTION VALUES
(01,'CS 101',45,'M/W','7:00 PM','9:45 PM',488, 'CPSC',765626466),
(02,'CS 110A',35,'T/TH','1:00 PM','2:15 PM',351, 'CPSC',543565396),
(03,'CS 208',35,'T','1:00 PM','3:15 PM',332, 'CPSC',123456789),
(04,'CS 101',45,'M/W','11:00 AM','12:50 PM',332, 'CPSC',765626466),
(05,'CS 300',35,'T/TH','4:00 PM','5:15 PM',418, 'ISDS',543565396),
(06,'CS 208',35,'T','4:00 PM','6:15 PM',309, 'ISDS',123456789);


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
(000222111, 'Daniel', 'Lopez', '789 Spruce St', 'Huntington Beach', 'CA', 92646, 714, 5552233, 'Male', 'ISDS');
