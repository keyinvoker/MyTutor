<?php
if (!isset($_POST)) {
    echo "ngento";
    die();
} else {

    include_once("dbconnect.php");
    session_start();

    $email = $_POST['email'];
    $password = hash('sha256', $_POST['password']);
    // $password = sha1($_POST['password']);
    $sqllogin = "SELECT * FROM `users` WHERE `email` = '$email' AND `password` = '$password'";
    $result = $conn->query($sqllogin);
    $numrow = $result->num_rows;

    if ($numrow > 0) {
        while ($row = $result->fetch_assoc()) {

            $_SESSION['name'] = $row['name'];
            $_SESSION['email'] = $row['email'];
            $_SESSION['address'] = $row['address'];
            $_SESSION['image'] = $row['image'];
        }

        echo "<script>alert('Logged in succesfully!)</script>";
        header('Location: ../web/account.php');
    } else {
        echo "numrow2";
        echo "<script>alert('Sorry children...)</script>";
        header('Location: ../web/login.php');
    }
}
