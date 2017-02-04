<?php
$c_db="your database name";
$c_server="your server address";
$c_log="your server login name";
$c_pass="your server password";
$conn=mysqli_connect($c_server, $c_log, $c_pass, $c_db) or die("could not connect");
?>
