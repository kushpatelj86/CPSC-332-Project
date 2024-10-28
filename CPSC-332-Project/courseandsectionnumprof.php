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

    $con = new mysqli("localhost","root","","universitydb");
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

        $sql = "SELECT ER.ENROLLMENT_RECORD_GRADE, ER.ENROLLMENT_RECORD_STUDENT_CWID, COUNT(*) AS NUM_GRADES 
        FROM ENROLLMENT_RECORD ER, COURSE C, COURSE_SECTION CS, STUDENT S, DEPARTMENT D 
        WHERE $sectionNum=CS.COURSE_SECTION_UNIQUE_NUMBER
        AND $courseNum=CS.COURSE_SECTION_COURSE_UNIQUE_NUMBER 
        AND  '$departmentNum'=CS.COURSE_SECTION_DEPARTMENT_NUM 
        AND CS.COURSE_SECTION_COURSE_UNIQUE_NUMBER=C.COURSE_UNIQUE_NUMBER   
        AND CS.COURSE_SECTION_DEPARTMENT_NUM=D.DEPARTMENT_UNIQUE_NUMBER 
        AND ER.ENROLLMENT_RECORD_STUDENT_CWID = S.STUDENT_CWID 
        AND ER.ENROLLMENT_RECORD_COURSE_SECTION_NUMBER=CS.COURSE_SECTION_UNIQUE_NUMBER 
        GROUP BY ER.ENROLLMENT_RECORD_GRADE
        ORDER BY ER.ENROLLMENT_RECORD_GRADE ASC";

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
<form action="http://localhost:8000/index.html">
    <button type = "submit"> Return to Homepage </button>

</form>



</body>
</html>