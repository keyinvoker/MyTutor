<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$email = $_POST['email'];
$password = hash('sha256', $_POST['password']);
$sqllogin = "SELECT * FROM `users` WHERE `email` = '$email' AND `password` = '$password'";
$result = $conn->query($sqllogin);
$numrow = $result->num_rows;

if ($numrow > 0) {
    while ($row = $result->fetch_assoc()) {
        $user['userid'] = $row['id'];
        $user['username'] = $row['name'];
        $user['useremail'] = $row['email'];
        $user['userphone'] = $row['phone'];
        $user['useraddress'] = $row['address'];
    }
    $response = array('status' => 'success', 'data' => $user);
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
