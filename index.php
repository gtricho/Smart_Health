<!doctype html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" type="text/css" href="fall.css">
<title>Εξομοίωση πτώσης</title>
</head>
<body>

<?php
    $url1=$_SERVER['REQUEST_URI'];
    header("Refresh: 5; URL=$url1");
?>
<?php
include_once('config.php');
?>
	
<div id="title">
Προσομοίωση πτώσης και ειδοποίησης
</div>
<div id="subtitle">
Τριχόπουλος Γεώργιος
<img src="img/SmartHealth.png" alt="Logo">
</div>
<div id="Warning1">
Όλα καλά
<?php
if (!empty($_POST['message'])) {
	$query="INSERT INTO FallDect (xronos) VALUES(NOW())";
	$result=mysqli_query($conn, $query) or die('could not insert due to '.mysqli_error($conn));
	
	$message=$_POST["message"]; 
	$filename="submitted-msg.html";
	file_put_contents($filename,$message." Health Security Issue - Possible Fall ",FILE_APPEND);
	$androidmessages=file_get_contents($filename);
    //   echo $androidmessages;
	}
?>
<?php
	$q1="SELECT * FROM FallDect";
	$r1=mysqli_query($conn, $q1) or die('could not select due to '.mysqli_error($conn));
	$howMany=mysqli_num_rows($r1);
		if($howMany>0) {
			header("Location: warning.php");
			exit;
		}

?>
	
</div>
<div id="footer">
Εργασία - παρουσίαση στα πλαίσια του μαθήματος "Διάχυτη Υπολογιστική" - Διδάσκων: Καρυδάκης Γεώργιος - Πανεπιστήμιο Αιγαίου - 2017
</div>
</body>
</html>

