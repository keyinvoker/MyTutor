<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$results_per_page = 6;
$pageno = (int)$_POST['pageno'];
$page_first_result = ($pageno - 1) * $results_per_page;

$search = $_POST['search'];
if (!empty($search)) {
    $sqlfetchsubjects = "SELECT *
                         FROM tbl_subjects ts
                         JOIN tbl_tutors tt
                         ON ts.tutor_id = tt.tutor_id
                         WHERE ts.subject_name LIKE '%$search%'";
} else {
    $sqlfetchsubjects = "SELECT *
                         FROM tbl_subjects ts
                         JOIN tbl_tutors tt
                         ON ts.tutor_id = tt.tutor_id";
}

$result = $conn->query($sqlfetchsubjects);
$number_of_result = $result->num_rows;
$number_of_page = ceil($number_of_result / $results_per_page);
$sqlfetchsubjects = $sqlfetchsubjects . " LIMIT $page_first_result , $results_per_page";

$result = $conn->query($sqlfetchsubjects);

if ($result->num_rows > 0) {
    $subjects["subjects"] = array();
    while ($row = $result->fetch_assoc()) {
        $sblist = array();
        $sblist['subjectid'] = $row['subject_id'];
        $sblist['subjectname'] = $row['subject_name'];
        $sblist['subjectdescription'] = $row['subject_description'];
        $sblist['subjectprice'] = $row['subject_price'];
        $sblist['subjecttutorid'] = $row['tutor_id'];
        $sblist['subjectsessions'] = $row['subject_sessions'];
        $sblist['subjectrating'] = $row['subject_rating'];
        $sblist['subjecttutor'] = $row['tutor_name'];
        array_push($subjects["subjects"], $sblist);
    }
    $response = array('status' => 'success', 'pageno' => "$pageno", 'numofpage' => "$number_of_page", 'data' => $subjects);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'pageno' => "$pageno", 'numofpage' => "$number_of_page", 'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
