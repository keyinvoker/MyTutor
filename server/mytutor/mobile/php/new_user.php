<?php
if (isset($_POST)) {

    include_once("dbconnect.php");
    session_start();

    $email = $_POST['email'];
    $password = $_POST['password'];
    $password2 = $_POST['password2'];
    $phone = $_POST['phone'];
    $name = addslashes($_POST['name']);
    $address = addslashes($_POST['address']);
    $image = $_FILES['image']['name'];
    $base64image = $_POST['image'];
    $msg;

    if (empty($email) || empty($password) || empty($password2) || empty($phone) || empty($name) || empty($address) || empty($image)) {
        $msg = 'Fill in all the fields!';
    } else if (strlen($password) < 8) {
        $msg = 'Password needs to be 8 characters long!';
    } else if ($password != $password2) {
        $msg = 'Password does not match the confirmation!';
    } else if (is_numeric($phone) < 8) {
        $msg = 'Please enter a valid mobile phone number!';
    } else {

        $password = hash('sha256', $password);
        $sqlinsert = "INSERT INTO `users`(`email`, `password`, `name`, `phone`, `address`) VALUES ('$email','$password','$name','$phone', '$address')";

        if ($conn->query($sqlinsert) === TRUE) {
            $filename = mysqli_insert_id($conn);
            $decoded_string = base64_decode($base64image);
            $path = '../assets/profiles/' . $filename . '.jpg';
            $is_written = file_put_contents($path, $decoded_string);
            echo "<script>alert('Successfully logged in!')</script>";
            header('Location: ../web/login.php');
        } else {
            echo "<script>alert('You're a failure')</script>";
            header('Location: ../web/register.php');
        }
    }
    echo "<script>window.location.replace('../web/register.php?errorMsg=$msg')</script>";
}
