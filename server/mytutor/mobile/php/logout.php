<?php
session_start();
session_destroy();
echo "<script>You have been logged out</script";
header('location:../web/login.php');
