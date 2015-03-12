<?php
	$webhost        = 'localhost:8888';
	$webusername    = 'root';
	$webpassword    = 'root';
	$oridbname      = 'healthCareSystem';
	$webcon         = mysql_connect($webhost, $webusername, $webpassword);

	if (!$webcon)
	{
		print("error".mysql_error());
		//print "error!";
	}
	// else
	// {
	// 	print("success");
	// }
	// print "\r\n";

	@mysql_select_db($oridbname) or die("Unable to find database");

	if (isset($_POST['patientId']))
	{	
		// print($_POST['patientId']);
		// print "\r\n";
		//patient info
		$patientId = mysql_real_escape_string($_POST['patientId']);
		$GivenName = mysql_real_escape_string($_POST['GivenName']);
		$FamilyName = mysql_real_escape_string($_POST['FamilyName']);
		$Suffix = mysql_real_escape_string($_POST['Suffix']);
		$Gender = mysql_real_escape_string($_POST['Gender']);
		$BirthTime = mysql_real_escape_string($_POST['BirthTime']);
		$providerId = mysql_real_escape_string($_POST['providerId']);

		//guaridian info
		$guardianNo = mysql_real_escape_string($_POST['guardianNo']);
		$Relationship = mysql_real_escape_string($_POST['Relationship']);
		$FirstName = mysql_real_escape_string($_POST['FirstName']);
		$LastName = mysql_real_escape_string($_POST['LastName']);
		$phone = mysql_real_escape_string($_POST['phone']);
		$address = mysql_real_escape_string($_POST['address']);
		$city = mysql_real_escape_string($_POST['city']);
		$state = mysql_real_escape_string($_POST['state']);
		$zip = mysql_real_escape_string($_POST['zip']);

		$sql = "UPDATE Patient, GuardianBy, Guardians SET Patient.GivenName = '".$GivenName."', Patient.FamilyName = '".$FamilyName."', Patient.Suffix = '".$Suffix."', Patient.Gender = '".$Gender."', Patient.BirthTime = '".$BirthTime."', Patient.providerId = '".$providerId."', GuardianBy.Relationship = '".$Relationship."', Guardians.FirstName = '".$FirstName."', Guardians.LastName = '".$LastName."', Guardians.phone = '".$phone."', Guardians.address = '".$address."', Guardians.city = '".$city."', Guardians.state = '".$state."', Guardians.zip = '".$zip."' WHERE Patient.patientId = '".$patientId."' AND GuardianBy.patientId = '".$patientId."' AND Guardians.guardianNo = GuardianBy.guardianNo";
		// print($sql);
		// print "\r\n";
		$query = mysql_query($sql);
		if (!$query)
		{
			echo json_encode(array('success' => '0', 'error' => 'Update failed'));
		}
		else
		{
			if (mysql_affected_rows() >= '0')
			{
				echo json_encode(array('success' => '1', 'error' => 'No error'));
			}
			else
			{
				echo json_encode(array('success' => '0', 'error' => 'Update failed'));
			}
		}
	}
	else
	{
		echo json_encode(array('success' => '0', 'error' => 'No patientId'));
	}

	mysql_close($webcon);
?>