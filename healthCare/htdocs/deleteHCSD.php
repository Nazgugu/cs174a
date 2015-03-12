<?php
	$webhost = 'localhost:8888';
	$webusername    = 'root';
	$webpassword    = 'root';
	$oridbname      = 'healthCareSystem';
	$webcon         = mysql_connect($webhost, $webusername, $webpassword);
	if (!$webcon)
	{
		die("connection failed: ".mysql_connect_error());
		//print "error!";
	}
	echo "connection success";
	echo nl2br("\n");
	@mysql_select_db($oridbname) or die("Unable to find database");

	$deleteAllergies = mysql_query("DELETE FROM Allergies");
	if (!$deleteAllergies)
	{
		echo "error".mysql_error();
	}
	echo "deleted Allergies";
	echo nl2br("\n");

	$deleteAssigned = mysql_query("DELETE FROM Assigned");
	if (!$deleteAssigned)
	{
		echo "error".mysql_error();
	}
	echo "deleted assigned";
	echo nl2br("\n");

	$deleteAuthors = mysql_query("DELETE FROM Author");
	if (!$deleteAuthors)
	{
		echo "error".mysql_error();
	}
	echo "deleted authors";
	echo nl2br("\n");

	$deleteGuardianBy = mysql_query("DELETE FROM GuardianBy");
	if (!$deleteGuardianBy)
	{
		echo "error".mysql_error();
	}
	echo "deleted GuardianBy";
	echo nl2br("\n");

	$deleteGuardians = mysql_query("DELETE FROM Guardians");
	if (!$deleteGuardians)
	{
		echo "error".mysql_error();
	}
	echo "deleted Guardians";
	echo nl2br("\n");

	$deleteIB = mysql_query("DELETE FROM InsuredBy");
	if (!$deleteIB)
	{
		echo "error".mysql_error();
	}
	echo "deleted InsuredBy";
	echo nl2br("\n");

	$deleteIC = mysql_query("DELETE FROM InsuranceCompany");
	if (!$deleteIC)
	{
		echo "error".mysql_error();
	}
	echo "deleted InsuranceCompany";
	echo nl2br("\n");

	$deleteFH = mysql_query("DELETE FROM FamilyHistory");
	if (!$deleteFH)
	{
		echo "error".mysql_error();
	}
	echo "deleted FamilyHistory";
	echo nl2br("\n");

	$deleteLTR = mysql_query("DELETE FROM LabTestReport");
	if (!$deleteLTR)
	{
		echo "error".mysql_error();
	}
	echo "deleted LabTestReport";
	echo nl2br("\n");

	$deleteSP = mysql_query("DELETE FROM Schedule_Plan");
	if (!$deleteSP)
	{
		echo "error".mysql_error();
	}
	echo "deleted Schedule_Plan";
	echo nl2br("\n");

	$deletePatient = mysql_query("DELETE FROM Patient");
	if (!$deletePatient)
	{
		echo "error".mysql_error();
	}
	echo "deleted Patient";
	echo nl2br("\n");


?>