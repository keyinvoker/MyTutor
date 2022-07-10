<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$user_email = $_POST['user_email'];

$sqlfetchcart = "SELECT c.cart_id,
                        s.subject_id,
                        s.subject_name,
                        s.subject_price
                 FROM cart c
                 JOIN tbl_subjects s
                 ON c.subject_id = s.subject_id
                 JOIN users u
                 ON u.id = c.user_id
                 WHERE u.email = '$user_email'
";

$result = $conn->query($sqlfetchcart);
$number_of_result = $result->num_rows;

if ($result->num_rows > 0) {
    $cart["cart"] = array();
    while ($row = $result->fetch_assoc()) {
        $clist = array();
        $clist['cartid'] = $row['cart_id'];
        $clist['subjectid'] = $row['subject_id'];
        $clist['subjectname'] = $row['subject_name'];
        $clist['price'] = $row['subject_price'];
        array_push($cart["cart"], $clist);
    }
    $response = array('status' => 'success', 'data' => $cart);
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
