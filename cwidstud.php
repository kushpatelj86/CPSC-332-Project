<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" >
        <title>Student Database</title>  

        <style>






        </style>
    </head>



<body>
 
    <h1> Student's Database  </h1>



<?php

    $cwidStud = $_POST["CWID"];

    $con = new mysqli("mariadb","cs332g16","Pion75VH","cs332g16");
    if($con->connect_error)
    {
        echo "CWID: ", $cwidStud, "<br>";
        echo "Connection Failed: ", $con->connect_error, "<br>";

        die("Connection Failed: ".$con->connect_error);
    }

    else
    {
        echo "Connection successful", "<br>";

        $sql = "SELECT ER.ENROLLMENT_RECORD_GRADE, ER.ENROLLMENT_RECORD_COURSE_SECTION_COURSE_UNIQUE_NUMBER, ER.ENROLLMENT_RECORD_COURSE_SECTION_DEPARTMENT_NUM,C.COURSE_TITLE
        FROM COURSE C, ENROLLMENT_RECORD ER, COURSE_SECTION CS, STUDENT S, DEPARTMENT D 
        WHERE $cwidStud = S.STUDENT_CWID  
        AND S.STUDENT_CWID = ER.ENROLLMENT_RECORD_STUDENT_CWID 
        AND ER.ENROLLMENT_RECORD_COURSE_SECTION_NUMBER=CS.COURSE_SECTION_UNIQUE_NUMBER 
        AND ER.ENROLLMENT_RECORD_COURSE_SECTION_COURSE_UNIQUE_NUMBER=CS.COURSE_SECTION_COURSE_UNIQUE_NUMBER
        AND ER.ENROLLMENT_RECORD_COURSE_SECTION_DEPARTMENT_NUM=CS.COURSE_SECTION_DEPARTMENT_NUM
        AND CS.COURSE_SECTION_DEPARTMENT_NUM=D.DEPARTMENT_UNIQUE_NUMBER
        AND CS.COURSE_SECTION_COURSE_UNIQUE_NUMBER=C.COURSE_UNIQUE_NUMBER
        GROUP BY C.COURSE_TITLE";

        $result = $con->query($sql);

        $numrows = $result->num_rows;

        echo "Students's CWID  : ", $cwidStud, "<br>";
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
                echo "Title: ", $row["COURSE_TITLE"], "<br>"; 
                echo "Department: ", $row["ENROLLMENT_RECORD_COURSE_SECTION_DEPARTMENT_NUM"], "<br>";
                echo "Course Number: ", $row["ENROLLMENT_RECORD_COURSE_SECTION_COURSE_UNIQUE_NUMBER"], "<br>";
                echo "Grade: ", $row["ENROLLMENT_RECORD_GRADE"],"<br>";
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