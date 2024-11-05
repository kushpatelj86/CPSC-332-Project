<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" >
        <title> Student's Database</title>  

        <style>






        </style>
    </head>



<body>
 

<h1> Student's Database  </h1>


<?php

    $courseNum = $_POST["CourseNumber"];
    $departmentNum = $_POST["DepartmentNumber"];


    $con = new mysqli("mariadb","cs332g16","Pion75VH","cs332g16");

    if($con->connect_error)
    {
        echo "Course Number: ", $courseNum, "<br>";
        echo "Course Number: ", $departmentNum, "<br>";
        die("Connection failed: " . $con->connect_error);

        echo "Connection Failed: ", $con->connect_error, "<br>";
    }
    else
    {

        echo  "<br>";

        echo "Connection successful", "<br>";
        echo "Course Number: ", $courseNum, "<br>";
        echo "Course Number: ", $departmentNum, "<br>";
        echo "<br>";



        $sql = "SELECT C.COURSE_TITLE, CS.COURSE_SECTION_CLASSROOM, C.COURSE_UNIQUE_NUMBER, CS.COURSE_SECTION_UNIQUE_NUMBER,
        CS.COURSE_SECTION_CLASSROOM,CS.COURSE_SECTION_MEETING_DAYS, CS.COURSE_SECTION_START_TIME,CS.COURSE_SECTION_END_TIME, D.DEPARTMENT_UNIQUE_NUMBER,
        COUNT(*) AS NUM_STUDENTS
        FROM COURSE C, COURSE_SECTION CS, ENROLLMENT_RECORD ER, DEPARTMENT D
        WHERE C.COURSE_UNIQUE_NUMBER=$courseNum 
        AND D.DEPARTMENT_UNIQUE_NUMBER='$departmentNum' 
        AND C.COURSE_UNIQUE_NUMBER=CS.COURSE_SECTION_COURSE_UNIQUE_NUMBER
        AND D.DEPARTMENT_UNIQUE_NUMBER=CS.COURSE_SECTION_DEPARTMENT_NUM 
        AND CS.COURSE_SECTION_UNIQUE_NUMBER=ER.ENROLLMENT_RECORD_COURSE_SECTION_NUMBER
        AND CS.COURSE_SECTION_COURSE_UNIQUE_NUMBER =ER.ENROLLMENT_RECORD_COURSE_SECTION_COURSE_UNIQUE_NUMBER
        AND CS.COURSE_SECTION_DEPARTMENT_NUM=ER.ENROLLMENT_RECORD_COURSE_SECTION_DEPARTMENT_NUM
        GROUP BY ER.ENROLLMENT_RECORD_COURSE_SECTION_NUMBER";

                
        $result = $con->query($sql);

        $numrows = $result->num_rows;

        echo "Professor's Course Number: ", $courseNum, "<br>";
        echo "Professor's Department Number: ", $departmentNum, "<br>";
        echo "<br>";


        if($numrows <= 0)
        {
            echo "No results", "<br>";

            echo "<br>";

        }

        else
        {
            for($i = 0; $i < $numrows; $i++)
            {
                $row = $result->fetch_assoc();
                echo "Course Section: ", $row["COURSE_SECTION_UNIQUE_NUMBER"], "<br>"; 
                echo "Classroom: ", $row["COURSE_SECTION_CLASSROOM"], "<br>"; 
                echo "Meeting Days: ", $row["COURSE_SECTION_MEETING_DAYS"], "<br>"; 
                echo "Time of class: ", $row["COURSE_SECTION_START_TIME"], " to ",$row["COURSE_SECTION_END_TIME"],"<br>";
                echo "Number of Students Enrolled: ", $row["NUM_STUDENTS"], "<br>";
                echo "<br>";

            }
        }

        $result->free_result();
        $con->close();







    }

    







    ?>


<h4>Return to Homepage by pressing the button</h4>
<form action = "http://ecs.fullerton.edu/~cs332g16/index.html">
        <button type = "submit"> Return to Homepage </button>
</form>



</body>
</html>