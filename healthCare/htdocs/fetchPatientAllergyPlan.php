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

	if (isset($_POST['patientId']))
	{
		$patientId = mysql_real_escape_string($_POST['patientId']);
		$allergySql = "SELECT * FROM Allergies WHERE Allergies.patientId = '".$patientId."'";
		$planSql = "SELECT * FROM Schedule_Plan WHERE Schedule_Plan.patientId = '".$patientId."'";
		
		$planQuery = mysql_query($planSql);
		$allergyQuery = mysql_query($allergySql);
		$allergyArray = array();
		$planArray = array();
		while ($singlePlan = mysql_fetch_assoc($planQuery))
		{
			$planArray[] = $singlePlan;
		}
		while ($singleAllergy = mysql_fetch_assoc($allergyQuery))
		{
			$allergyArray[] = $singleAllergy;
		}
		echo json_encode(array('success' => '1', 'allergy' => $allergyArray, 'plan' => $planArray));
	}
	else
	{
		echo json_encode(array('success' => '0', 'error' => 'No input patientID'));
	}

	mysql_close($webcon);
?>