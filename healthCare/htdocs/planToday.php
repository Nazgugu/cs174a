<?php
	$webhost        = 'localhost:8888';
	$webusername    = 'root';
	$webpassword    = 'root';
	$oridbname      = 'healthCareSystem';
	$webcon         = mysql_connect($webhost, $webusername, $webpassword);

	$patientId;

	if (!$webcon)
	{
		print("error".mysql_error());
		//print "error!";
	}
	// print("connection success");
	// echo nl2br("\n");
	// //print "succeed";

	@mysql_select_db($oridbname) or die("Unable to find database");

	date_default_timezone_set('America/Los_Angeles');
    $date = date('n/j/Y', time());
    $date="'".$date."%'";

	$sql = "SELECT Patient.patientId, Patient.GivenName, Patient.FamilyName, Schedule_Plan.ScheduledDate FROM Patient, Schedule_Plan WHERE Patient.patientId=Schedule_Plan.patientId AND Schedule_Plan.Activity='Surgery' AND Schedule_Plan.ScheduledDate LIKE".$date;

	$query = mysql_query($sql);

	if (!$query)
	{
		echo json_encode(array('success' => '0', 'error' => 'unknown error'));
	}
	else
	{
		$resultArray = array();
		while ($row = mysql_fetch_assoc($query))
		{
			$resultArray[] = $row;
		}

		echo json_encode(array('success' => '1','result' => $resultArray));
	}

	mysql_close($webcon);
?>