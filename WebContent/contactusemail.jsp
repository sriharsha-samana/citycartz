<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="SendEMAIL.*" %>
<%@ page import="FileActions.*" %>
<%
boolean logfilestatus;
String appFolder =  getServletContext().getRealPath("/");
File dbFile= new File(appFolder);
String strApplicationPath = dbFile.toURL().toString();
strApplicationPath = strApplicationPath.substring(strApplicationPath.indexOf("file:/")+6, strApplicationPath.length());
String sendername=request.getParameter("custname");
String senderemail=request.getParameter("email");
String receiveremail="support@citycartz.com";
String subject=request.getParameter("subject");
String data=request.getParameter("data");
Java_Email jemail=new Java_Email();
boolean status=jemail.sendEmail(sendername, senderemail,receiveremail, subject, data);
if(status)
{
%>
<script type="text/javascript">
	alert("Thank You For Writing to CityCartz.We will Update You Soon.");
	window.open("Home","_self");
</script>
<% 
}
else
{
     // WRITE INTO LOG FILE
     WriteToLogFile wtlf= new WriteToLogFile();
	String formatString = "\n";
	formatString +="SUPPORT EMAIL NOT SENT\r\nTHE DETAILS ARE:\r\n";
 	formatString +="SenderName:"+sendername+"\r\nSenderSubject:"+subject+"\r\nSenderEmail:"+senderemail+"\r\nFeedback="+data+"";
	logfilestatus=wtlf.writetologfile(appFolder+"/LogFiles/support_logFile.txt",formatString);
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
		alert("Thank You For Writing to CityCartz.We will Update You Soon.");
		window.open("Home","_self");
		</script>
		<%
	}
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
<title>CityCartz - Your Shifting Partner</title>
</head>
<body>
</body>
</html>