<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" >
        <title>Professor Database</title>  

        <style>






        </style>
    </head>



<body>
 
    <h1> Professor's Database  </h1>



<?php

    $ssnProf = $_POST["SSN"];

    $con = new mysqli("mariadb","cs332g16","Pion75VH","cs332g16");
    if($con->connect_error)
    {
        echo "SSN: ", $ssnProf, "<br>";
        echo "Connection Failed: ", $con->connect_error, "<br>";

        die("Connection Failed: ".$con->connect_error);
    }

    else
    {
        echo "Connection successful", "<br>";

        $sql = "SELECT C.COURSE_TITLE,C.COURSE_IDENTIFICATION_NUMBER, CS.COURSE_SECTION_CLASSROOM, CS.COURSE_SECTION_MEETING_DAYS,CS.COURSE_SECTION_START_TIME,CS.COURSE_SECTION_END_TIME, D.DEPARTMENT_UNIQUE_NUMBER 
        FROM COURSE C, COURSE_SECTION CS, PROFESSOR P, DEPARTMENT D WHERE P.PROFESSOR_SOCIAL_SECURITY_NUMBER=$ssnProf 
        AND P.PROFESSOR_SOCIAL_SECURITY_NUMBER=CS.COURSE_SECTION_PROFESSOR_SSN  
        AND CS.COURSE_SECTION_COURSE_UNIQUE_NUMBER=C.COURSE_UNIQUE_NUMBER 
        AND CS.COURSE_SECTION_DEPARTMENT_NUM=D.DEPARTMENT_UNIQUE_NUMBER";

        $result = $con->query($sql);

        $numrows = $result->num_rows;

        echo "Professor's SSN: ", $ssnProf, "<br>";
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
                echo "Class ", ($i + 1), "<br>";
                echo "Department: ", $row["DEPARTMENT_UNIQUE_NUMBER"], "<br>"; 
                echo "Identification Number: ", $row["COURSE_IDENTIFICATION_NUMBER"], "<br>"; 
                echo "Title: ", $row["COURSE_TITLE"], "<br>"; 
                echo "Room: ", $row["COURSE_SECTION_CLASSROOM"], "<br>";
                echo "Meeting Days: ", $row["COURSE_SECTION_MEETING_DAYS"], "<br>";
                echo "Time of class: ", $row["COURSE_SECTION_START_TIME"], " to ",$row["COURSE_SECTION_END_TIME"],"<br>";
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