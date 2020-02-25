<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="SendEMAIL.*" %>
<%@ page import="FileActions.*" %>
<%@ page import="DatabaseActions.*" %>
<%
boolean logfilestatus;
String statusvalue=null;
String appFolder =  getServletContext().getRealPath("/");
File dbFile= new File(appFolder);
String strApplicationPath = dbFile.toURL().toString();
strApplicationPath = strApplicationPath.substring(strApplicationPath.indexOf("file:/")+6, strApplicationPath.length());
String sendername=request.getParameter("username");
String senderemail=request.getParameter("useremail");
String receiveremail="feedback@citycartz.com";
String feedback=request.getParameter("userfeedback");
String subject="Feedback";
DatabaseOperations dbop = new DatabaseOperations();
// STORE INTO FEEDBACK TABLE
String strDatabaseTableName = "feedback";
String[] strDatabaseTableFields = dbop.GetColumnNames(strDatabaseTableName);
int size=strDatabaseTableFields.length;
String[] strDatabaseTableValues = new String[size];
strDatabaseTableValues[0]=sendername;
strDatabaseTableValues[1]=senderemail;
strDatabaseTableValues[2]=feedback;
statusvalue=dbop.AddNewBookingEntry(strDatabaseTableName, strDatabaseTableFields,strDatabaseTableValues);
// SEND EMAIL TO ADMIN
Java_Email jemail=new Java_Email();
boolean status=jemail.sendEmail(sendername, senderemail,receiveremail, subject, feedback);
if(status)
{
%>
<script type="text/javascript">
    alert("Thank You For Writing To CityCartz. We Appreciate Your Feedback.");
	window.open("Home","_self");
	</script>
<% 
}
else
{
	// WRITE TO LOG FILE
    WriteToLogFile wtlf= new WriteToLogFile();
	String formatString = "\n";
	formatString +="FEEDBACK EMAIL NOT SENT\r\nTHE DETAILS ARE:\r\n";
 	formatString +="SenderName:"+sendername+"\r\nSenderEmail:"+senderemail+"\r\nFeedback="+feedback+"";
	logfilestatus=wtlf.writetologfile(appFolder+"/LogFiles/feedback_logFile.txt",formatString);
	if(!logfilestatus)
	{
		%>
		<script type="text/javascript">
		alert("Something went wrong.Please Try Again");
		window.open("Home","_self");
		</script>
		<%
	}
	else
	{
		%>
		<script type="text/javascript">
		alert("Thank You For Writing To CityCartz. We Appreciate Your Feedback.");
		window.open("Home","_self");
		</script>
		<%
	}
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">		
<title>CityCartz - Your Shifting Partner</title>
</head>
<body>
</body>
</html>