<?php
// $servername = "localhost";
// $username   = "root";
// $password   = "";
// $dbname     = "mytutor";

// [1] [ NiagaHosting - https://legion-commander.xyz ]
// $servername = "localhost";
// $username   = "u1593062_joerio";
// $password   = "Joerio123!";
// $dbname     = "u1593062_mytutor";
// [2]
$servername = "localhost";
$username   = "u1593062_joemama";
$password   = "JoeMama";
$dbname     = "u1593062_mytutor";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>