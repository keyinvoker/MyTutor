<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}
include_once("dbconnect.php");
$email = $_POST['email'];
$password = $_POST['password'];
$name = addslashes($_POST['name']);
$address = addslashes($_POST['address']);
// $image = $_POST['image'];
$sqlinsert = "INSERT INTO `users`(`email`, `password`, `name`, `address`) VALUES ('$email','$password','$name','$address')";
if ($conn->query($sqlinsert) === TRUE) {
    $response = array('status' => 'success', 'data' => null);
    $filename = mysqli_insert_id($conn);
    // $decoded_string = base64_decode($base64image);
    // $path = '../assets/images/' . $filename . '.jpg';
    // $is_written = file_put_contents($path, $decoded_string);
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
