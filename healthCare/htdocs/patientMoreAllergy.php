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

	$sql = "SELECT Patient.patientId, Patient.GivenName, Patient.FamilyName, COUNT(*) AS NumberOfAllergies FROM Patient, Allergies WHERE Patient.patientId = Allergies.patientId GROUP BY Patient.patientId HAVING COUNT(*)>1";

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