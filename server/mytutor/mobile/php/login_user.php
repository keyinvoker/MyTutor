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
        $user['name'] = $row['name'];
        $user['email'] = $row['email'];
        $user['phone'] = $row['phone'];
        $user['address'] = $row['address'];
        // $_SESSION['image'] = $row['image'];
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
