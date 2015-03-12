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
		// print($patientId);
		// print "\r\n";
		//we got the patientID
		$findpatientSql = "SELECT * FROM Patient, GuardianBy, Guardians WHERE Patient.patientID = '".$patientId."' AND GuardianBy.patientId = '".$patientId."' AND Guardians.GuardianNo = GuardianBy.GuardianNo";
		// print($findpatientSql);
		// print "\r\n";
		$queryPatient = mysql_query($findpatientSql);
		if (!$queryPatient)
		{
			echo json_encode(array('success' => '0', 'error' => 'No such Patient'));
		}
		else
		{	
			if ($row = mysql_fetch_assoc($queryPatient))
			{	
				$array['success'] = '1';
				$array['result'] = $row;
				echo json_encode($array);
			}
			else
			{	
				// print("not good");
				echo json_encode(array('success' => '0', 'error' => 'No Such Patient'));
			}
		}
	}
	else
	{	
		// print("no input");
		echo json_encode(array('success' => '0', 'error' => 'No input patientID'));
	}
	mysql_close($webcon);
?>