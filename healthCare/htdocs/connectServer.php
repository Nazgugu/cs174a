<?php
	if (empty($_GET))
	{
		echo '{"success":0,"error_message":"no_user_name_or_password"}';
	}
	else
	{
		$username = $_GET['username'];
		$password = $_GET['password'];
		$webHost  = 'localhost:8888';
		// echo $webHost;
		// echo nl2br("\n");
		// echo $username;
		// echo nl2br("\n");
		// echo $password;
		set_time_limit(1);
		$connection = mysql_connect($webHost, $username, $password);
		if (!$connection)
		{
			echo '{"success":0,"error_message":"invalid_username_or_password"}';
		}
		else
		{
			echo '{"success":1}';
		}

		mysql_close($connection);
	}

?>