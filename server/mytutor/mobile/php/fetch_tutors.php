<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$limit = 3;
$pageno = (int)$_POST['pageno'];
$page_first_result = ($pageno - 1) * $limit;

// $sqlfetchtutors = "SELECT tt.tutor_id,
//                           tt.tutor_email,
//                           tt.tutor_phone,
//                           tt.tutor_name,
//                           tt.tutor_description,
//                           ts.subject_name
//                    FROM tbl_tutors tt
//                    JOIN tbl_subjects ts
//                    ON ts.tutor_id = tt.tutor_id
//                    ORDER BY tt.tutor_id";

$sqlfetchtutors = "SELECT * FROM tbl_tutors";

$result = $conn->query($sqlfetchtutors);
$number_of_result = $result->num_rows;
$totalPages = ceil($number_of_result / $limit);
$sqlfetchtutors = $sqlfetchtutors . " LIMIT $page_first_result, $limit";
$result = $conn->query($sqlfetchtutors);

if ($result->num_rows > 0) {
    $tutors["tutors"] = array();
    while ($row = $result->fetch_assoc()) {
        $tlist = array();
        $tlist['tutorid'] = $row['tutor_id'];
        $tlist['tutorname'] = $row['tutor_name'];
        $tlist['tutordescription'] = $row['tutor_description'];
        $tlist['tutoremail'] = $row['tutor_email'];
        $tlist['tutorphone'] = $row['tutor_phone'];
        array_push($tutors["tutors"], $tlist);
    }
    $response = array('status' => 'success', 'pageno' => "$pageno", 'totalpage' => "$totalPages", 'data' => $tutors);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'pageno' => "$pageno", 'totalpage' => "$totalPages", 'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
