<?php

/**
 * Connect to database
 */
$webhost        = 'localhost:8888';
$webusername    = 'root';
$webpassword    = 'root';
$webdbname      = 'healthmessagesexchange2';
$oridbname      = 'healthCareSystem';
$webcon         = mysql_connect($webhost, $webusername, $webpassword);
if (!$webcon)
{
	die("connection failed: ".mysql_connect_error());
	//print "error!";
}
echo "connection success";
echo nl2br("\n");
// //print "succeed";

@mysql_select_db($webdbname) or die("Unable to find database");

$guardian = mysql_query("SELECT GuardianNo, FirstName, LastName, phone, address, city, state, zip FROM messages");
if (!$guardian)
{
	echo "error". mysql_error();
}
echo "found it guardian";
echo nl2br("\n");
$guardianArray = array();
while ($rowG = mysql_fetch_array($guardian))
{
	array_push($guardianArray, $rowG);
}

$insuranceCompany = mysql_query("SELECT PayerId, Name, Purpose, PolicyType, PolicyHolder FROM messages");
if (!$insuranceCompany)
{
	echo "error". mysql_error();
}
echo "found it insuranceCompany";
echo nl2br("\n");
$insuranceCompanyArray = array();
while ($rowI = mysql_fetch_array($insuranceCompany))
{
	array_push($insuranceCompanyArray, $rowI);
}

//query for reading
$patient = mysql_query("SELECT patientId, GivenName, FamilyName, BirthTime, providerId FROM messages");
if (!$patient)
{
	echo "error".mysql_error();
}
echo "found it patient";
echo nl2br("\n");
$patientArray = array();
while($rowP = mysql_fetch_array($patient)) {
	array_push($patientArray,$rowP);
}

$author = mysql_query("SELECT AuthorId, AuthorTitle, AuthorFirstName, AuthorLastName, ParticipatingRole FROM messages");
if (!$author)
{
	echo "error".mysql_error();
}
echo "found it author";
echo nl2br("\n");
$authorArray = array();
while($rowA = mysql_fetch_array($author)) {
	array_push($authorArray,$rowA);
}

$familyHistory = mysql_query("SELECT patientId, RelativeId, Relation, age, Diagnosis FROM messages");
if (!$familyHistory)
{
	echo "error".mysql_error();
}
echo "found it familyHistory";
echo nl2br("\n");
$familyHistoryArray = array();
while($rowF = mysql_fetch_array($familyHistory))
{
	array_push($familyHistoryArray, $rowF);
}

$Allergy = mysql_query("SELECT Id, Substance, Reaction, Status, patientId FROM messages");
if (!$Allergy)
{
	echo "error".mysql_error();
}
echo "found it allergy";
echo nl2br("\n");
$AllergyArray = array();
while($rowAA = mysql_fetch_array($Allergy))
{
	array_push($AllergyArray, $rowAA);
}

$labTestReport = mysql_query("SELECT patientId, LabTestResultId, PatientVisitId, LabTestPerformedDate, LabTestType, TestResultValue, ReferenceRangeHigh, ReferenceRangeLow FROM messages");
if (!$labTestReport)
{
	echo "error".mysql_error();
}
echo "found it lebtest";
echo nl2br("\n");
$labTestArray = array();
while ($rowl = mysql_fetch_array($labTestReport))
{
	array_push($labTestArray, $rowl);
}

$plan = mysql_query("SELECT PlanId, patientId, Activity, ScheduledDate FROM messages WHERE PlanId IS NOT NULL");
if (!$plan)
{
	echo "error".mysql_error();
}
echo "found it plan";
echo nl2br("\n");
$planArray = array();
while ($rowp = mysql_fetch_array($plan))
{
	array_push($planArray, $rowp);
}

$assignAuthor = mysql_query("SELECT patientId, AuthorId FROM messages");
if (!$assignAuthor)
{
	echo "error".mysql_error();
}
echo "found it assigned author";
echo nl2br("\n");
$assignArray = array();
while ($assign = mysql_fetch_array($assignAuthor))
{
	array_push($assignArray, $assign);
}

$GuardianBy = mysql_query("SELECT GuardianNo, patientId, Relationship FROM messages");
if (!$GuardianBy)
{
	echo "error".mysql_error();
}
echo "found it GB";
echo nl2br("\n");
$guardianByArray = array();
while ($gba = mysql_fetch_array($GuardianBy))
{
	array_push($guardianByArray,$gba);
}

$InsureBy = mysql_query("SELECT patientId, PayerId FROM messages");
if (!$InsureBy)
{
	echo "error".mysql_error();
}
echo "found it IB";
echo nl2br("\n");
$insureByArray = array();
while ($isb = mysql_fetch_array($InsureBy))
{
	array_push($insureByArray,$isb);
}

mysql_close($webcon);


//connect to previously created data base
$webcon2  = mysql_connect($webhost, $webusername, $webpassword);
if (!$webcon2)
{
	die("connection failed: ".mysql_connect_error());
	//print "error!";
}
echo nl2br("\n");
echo "connection success 2";
echo nl2br("\n");
@mysql_select_db($oridbname) or die(mysql_error());
echo "success";
echo nl2br("\n");

date_default_timezone_set('America/Los_Angeles');
$date = date('j/n/Y h:i:s a',time());

foreach ($guardianArray as $row)
{
	$guardianSql = ("INSERT INTO Guardians VALUES ('".$row{'GuardianNo'}."', '".
     $row{'FirstName'}."', '".$row{'LastName'}."', '".$row{'phone'}."', '".$row{'address'}."', '".$row{'city'}."', '".$row{'state'}."', '".$row{'zip'}."' )" );;
	 // echo $guardianSql;
	 // echo nl2br("\n");
	$import = mysql_query($guardianSql);
	if (!$import)
	{
		 die('Could not enter data: ' . mysql_error());
	}
}
echo "imported Guardians";
echo nl2br("\n");

foreach ($insuranceCompanyArray as $Insure)
{	
	$holder = addslashes($Insure{'PolicyHolder'});
	$insuranceSql = ("INSERT INTO InsuranceCompany VALUES ('".$Insure{'PayerId'}."', '".$Insure{'Name'}."', '".
     $Insure{'Purpose'}."', '".$Insure{'PolicyType'}."', '".$holder."' )" );;
	 // echo $insuranceSql;
	 // echo nl2br("\n");
	$import = mysql_query($insuranceSql);
	if (!$import)
	{
		 die('Could not enter data: ' . mysql_error());
	}
}
echo "imported insuranceCompany";
echo nl2br("\n");

foreach ($patientArray as $pRow)
{
	$patientSql = ("INSERT INTO Patient (patientId, GivenName, FamilyName, BirthTime, providerId, xmlHealthCreationTime) VALUES ('".$pRow{'patientId'}."', '".$pRow{'GivenName'}."', '".
     $pRow{'FamilyName'}."', '".$pRow{'BirthTime'}."', '".$pRow{'providerId'}."', '".$date."' )" );;
	 // echo $patientSql;
	 // echo nl2br("\n");
	$import = mysql_query($patientSql);
	if (!$import)
	{
		 die('Could not enter data: ' . mysql_error());
	}
}
echo "imported Patients";
echo nl2br("\n");

foreach ($guardianByArray as $gbaRow)
{
	$guardianBySql = ("INSERT INTO GuardianBy VALUES ('".$gbaRow{'GuardianNo'}."', '".$gbaRow{'patientId'}."', '".$gbaRow{'Relationship'}."' )" );;
	 // echo $assignSql;
	 // echo nl2br("\n");
	$import = mysql_query($guardianBySql);
	if (!$import)
	{
		 die('Could not enter data: ' . mysql_error());
	}
}
echo "imported guardianBy";
echo nl2br("\n");

foreach ($insureByArray as $isbRow)
{
	$insureBySql = ("INSERT INTO InsuredBy VALUES ('".$isbRow{'patientId'}."', '".$isbRow{'PayerId'}."' )" );;
	 // echo $assignSql;
	 // echo nl2br("\n");
	$import = mysql_query($insureBySql);
	if (!$import)
	{
		 die('Could not enter data: ' . mysql_error());
	}
}
echo "imported insuredBy";
echo nl2br("\n");

foreach ($authorArray as $ARow)
{
	$authorSql = ("INSERT INTO Author VALUES ('".$ARow{'AuthorId'}."', '".$ARow{'AuthorTitle'}."', '".
     $ARow{'AuthorFirstName'}."', '".$ARow{'AuthorLastName'}."', '".$ARow{'ParticipatingRole'}."' )" );;
	 // echo $authorSql;
	 // echo nl2br("\n");
	$import = mysql_query($authorSql);
	if (!$import)
	{
		 die('Could not enter data: ' . mysql_error());
	}
}
echo "imported authors";
echo nl2br("\n");

foreach ($familyHistoryArray as $fRow)
{
	$familyHistorySql = ("INSERT INTO FamilyHistory VALUES ('".$fRow{'patientId'}."', '".$fRow{'RelativeId'}."', '".
     $fRow{'Relation'}."', '".$fRow{'age'}."', '".$fRow{'Diagnosis'}."' )" );;
	 // echo $familyHistorySql;
	 // echo nl2br("\n");
	$import = mysql_query($familyHistorySql);
	if (!$import)
	{
		 die('Could not enter data: ' . mysql_error());
	}
}
echo "imported familyHistory";
echo nl2br("\n");

foreach ($AllergyArray as $aRow)
{
	$allergySql = ("INSERT INTO Allergies VALUES ('".$aRow{'Id'}."', '".$aRow{'Substance'}."', '".
     $aRow{'Reaction'}."', '".$aRow{'Status'}."', '".$aRow{'patientId'}."' )" );;
	 // echo $allergySql;
	 // echo nl2br("\n");
	$import = mysql_query($allergySql);
	if (!$import)
	{
		 die('Could not enter data: ' . mysql_error());
	}
}
echo "imported Allergies";
echo nl2br("\n");

foreach ($labTestArray as $lRow)
{
	$labTestSql = ("INSERT INTO LabTestReport VALUES ('".$lRow{'LabTestResultId'}."', '".$lRow{'patientId'}."', '".
     $lRow{'PatientVisitId'}."', '".$lRow{'LabTestPerformedDate'}."', '".$lRow{'LabTestType'}."', '".$lRow{'TestResultValue'}."', '".$lRow{'ReferenceRangeHigh'}."', '".$lRow{'ReferenceRangeLow'}."' )" );;
	 // echo $labTestSql;
	 // echo nl2br("\n");
	$import = mysql_query($labTestSql);
	if (!$import)
	{
		 die('Could not enter data: ' . mysql_error());
	}
}
echo "imported LabTestReport";
echo nl2br("\n");

foreach ($planArray as $planRow)
{
	$planSql = ("INSERT INTO Schedule_Plan VALUES ('".$planRow{'patientId'}."', '".$planRow{'PlanId'}."', '".
     $planRow{'Activity'}."', '".$planRow{'ScheduledDate'}."' )" );;
	 // echo $planSql;
	 // echo nl2br("\n");
	$import = mysql_query($planSql);
	if (!$import)
	{
		 die('Could not enter data: ' . mysql_error());
	}
}
echo "imported plans";
echo nl2br("\n");

foreach ($assignArray as $asRow)
{
	$assignSql = ("INSERT INTO Assigned VALUES ('".$asRow{'AuthorId'}."', '".$asRow{'patientId'}."' )" );;
	 // echo $assignSql;
	 // echo nl2br("\n");
	$import = mysql_query($assignSql);
	if (!$import)
	{
		 die('Could not enter data: ' . mysql_error());
	}
}
echo "imported assign authors";
echo nl2br("\n");


mysql_close($webcon2);


?>