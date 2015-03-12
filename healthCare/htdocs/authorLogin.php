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

	if (isset($_POST['AuthorId']))
	{
		//first check if the author exist
		$AuthorId = mysql_real_escape_string($_POST['AuthorId']);

		$checkAuthorSql = "SELECT * FROM Author WHERE Author.AuthorId = '".$AuthorId."' ";
		// print($checkAuthorSql);
		// print "\r\n";
		$checkAuthorQuery = mysql_query($checkAuthorSql);
		if (!$checkAuthorQuery)
		{
			echo json_encode(array('success' => '0', 'error' => 'No such Author'));
		}
		else
		{
			if ($row = mysql_fetch_assoc($checkAuthorQuery))
			{
				//now we have the author, we grant him/her to view and edit details for the patient
				echo json_encode(array('success' => '1', 'error' => 'No error'));
			}
			else
			{
				echo json_encode(array('success' => '0', 'error' => 'No such Author'));
			}
		}
	}
	else
	{
		echo json_encode(array('success' => '0', 'error' => 'No input AuthorId'));
	}

?>