<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$email = addslashes($_POST['email']);
$password = $_POST['password'];
$password2 = $_POST['password2'];
$name = addslashes($_POST['name']);
$phone = $_POST['phone'];
$address = addslashes($_POST['address']);
// $image = $_FILES['image']['name'];
// $base64image = $_POST['image'];

$password = hash('sha256', $password);
$sqlinsert = "INSERT INTO `users`(`email`, `password`, `name`, `phone`, `address`) VALUES ('$email','$password','$name','$phone', '$address')";

if ($conn->query($sqlinsert) === TRUE) {
    // $filename = mysqli_insert_id($conn);
    // $decoded_string = base64_decode($base64image);
    // $path = '../assets/profiles/' . $filename . '.jpg';
    // $is_written = file_put_contents($path, $decoded_string);
    $response = array('status' => 'success', 'data' => null);
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
