<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$user_id = (int)$_POST['user_id'];
$subject_id = (int)$_POST['subject_id'];
$subject_name = $_POST['subject_name'];
$subject_price = (double)$_POST['subject_price'];

$sqlcheckcart = "SELECT *
                 FROM `cart`
                 WHERE `user_id` = $user_id AND
                       `subject_id` = $subject_id AND
                       `status` = 'OPEN'
";
$result = $conn->query($sqlcheckcart);

if ($result->num_rows == 0) {
    $sqlinsert = "INSERT INTO `cart`(`user_id`, `subject_id`, `subject_name`, `subject_price`, `status`)
                  VALUES ($user_id, $subject_id, '$subject_name', $subject_price, 'Unpaid')";
    if ($conn->query($sqlinsert) === TRUE) {
        $response = array('status' => 'success', 'data' => null);
        sendJsonResponse($response);
    } else {
        $response = array('status' => 'failed', 'data' => null);
        sendJsonResponse($response);
    }
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
