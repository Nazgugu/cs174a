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

	$patientSql = "SELECT * FROM Patient";

	$patientQuery = mysql_query($patientSql);

	if (!$patientQuery)
	{
		echo json_encode(array('success' => '0', 'error' => 'unknown error'));
	}
	else
	{
		$patientArray = array();
		while ($singlePatient = mysql_fetch_assoc($patientQuery))
		{
			$patientArray[] = $singlePatient;
		}
		echo json_encode(array('success' => '1', 'result' => $patientArray));
	}

	mysql_close($webcon);
?>