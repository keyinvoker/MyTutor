<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$tutorid = (int)$_POST['tutorid'];

$sqlfetchsubjects = "SELECT subject_name
                    FROM tbl_subjects
                    WHERE tutor_id = $tutorid";

$result = $conn->query($sqlfetchsubjects);

if ($result->num_rows > 0) {
    $tutorsubjects["tutorsubjects"] = array();
    while ($row = $result->fetch_assoc()) {
        $tslist = array();
        $tslist['subjectname'] = $row['subject_name'];
        array_push($tutorsubjects["tutorsubjects"], $tslist);
    }
    $response = array('status' => 'success', 'data' => $tutorsubjects);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
