<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" >
        <title> Professor's Database</title>  

        <style>






        </style>
    </head>



<body>
 

<h1> Professor's Database  </h1>


<?php

    $courseNum = $_POST["CourseNumber"];
    $sectionNum = $_POST["SectionNumber"];
    $departmentNum = $_POST["DepartmentNumber"];

    $con = new mysqli("mariadb","cs332g16","Pion75VH","cs332g16");
    if($con->connect_error)
    {
        echo "Course Number: ", $courseNum, "<br>";
        echo "Section Number: ", $sectionNum, "<br>";
        echo "Department Number: ", $departmentNum, "<br>";

        echo "Connection Failed: ", $con->connect_error, "<br>";

        die("Connection Failed: ".$con->connect_error);
    }

    else
    {
        echo "Connection successful", "<br>";
        echo "Course Number: ", $courseNum, "<br>";
        echo "Section Number: ", $sectionNum, "<br>";
        echo "Department Number: ", $departmentNum, "<br>";

        $sql = "SELECT ER.ENROLLMENT_RECORD_STUDENT_CWID, ER.ENROLLMENT_RECORD_GRADE, COUNT(*) AS NUM_GRADES 
        FROM ENROLLMENT_RECORD ER, COURSE_SECTION CS
        WHERE $sectionNum=CS.COURSE_SECTION_UNIQUE_NUMBER
        AND $courseNum=CS.COURSE_SECTION_COURSE_UNIQUE_NUMBER 
        AND  '$departmentNum'=CS.COURSE_SECTION_DEPARTMENT_NUM 
        AND ER.ENROLLMENT_RECORD_COURSE_SECTION_DEPARTMENT_NUM=CS.COURSE_SECTION_DEPARTMENT_NUM 
        AND ER.ENROLLMENT_RECORD_COURSE_SECTION_COURSE_UNIQUE_NUMBER=CS.COURSE_SECTION_COURSE_UNIQUE_NUMBER 
        AND ER.ENROLLMENT_RECORD_COURSE_SECTION_NUMBER=CS.COURSE_SECTION_UNIQUE_NUMBER 
        GROUP BY ER.ENROLLMENT_RECORD_GRADE";

        $result = $con->query($sql);

        $numrows = $result->num_rows;

        echo "Professor's Course Number: ", $courseNum, "<br>";
        echo "Professor's Section Number: ", $sectionNum, "<br>";
        echo "Professor's Department Number: ", $departmentNum, "<br>";


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
                echo "Grade: ", $row["ENROLLMENT_RECORD_GRADE"], "<br>"; 
                echo "Number of Students: ", $row["NUM_GRADES"], "<br>"; 
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