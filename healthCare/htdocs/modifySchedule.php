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

	if (isset($_POST['PlanId']))
	{
		$PlanId = mysql_real_escape_string($_POST['PlanId']);
		$Activity = mysql_real_escape_string($_POST['Activity']);
		$ScheduledDate = mysql_real_escape_string($_POST['ScheduledDate']);

		$sql = "UPDATE Schedule_Plan SET Schedule_Plan.Activity = '".$Activity."', Schedule_Plan.ScheduledDate = '".$ScheduledDate."' WHERE Schedule_Plan.PlanId = '".$PlanId."'";
		// print ($sql);
		// print "\r\n";

		$query = mysql_query($sql);
		if (!$query)
		{
			echo json_encode(array('success' => '0', 'error' => 'Update failed'));
		}
		else
		{	
			// print (mysql_affected_rows());
			// print "\r\n";
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
		echo json_encode(array('success' => '0', 'error' => 'No allergy Id'));
	}

?>