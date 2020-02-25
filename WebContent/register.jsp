<!DOCTYPE>
<%@ page import="java.io.File" %>
<%@ page import="DatabaseActions.*" %>
<%@ page import="FileActions.*" %>
<%@ page import="SendEMAIL.*"%>
<%
boolean logfilestatus=false;
String strcust_name=request.getParameter("cust_name");
String strcust_email=request.getParameter("cust_email");
String strcust_mobile=request.getParameter("cust_mobile");
String senderemail="shadowagent@citycartz.com";
String receiveremail="support@citycartz.com";
String appFolder =  getServletContext().getRealPath("/");
File dbFile= new File(appFolder);
String strApplicationPath = dbFile.toURL().toString();
strApplicationPath = strApplicationPath.substring(strApplicationPath.indexOf("file:/")+6, strApplicationPath.length());
DatabaseOperations dopt = new DatabaseOperations();
String strDatabaseTableFields[] = dopt.GetColumnNames("users");
int length=strDatabaseTableFields.length;
String strDatabaseTableValues[]= new String[length];
strDatabaseTableValues[0]=strcust_name;
strDatabaseTableValues[1]=strcust_email;
strDatabaseTableValues[2]=strcust_mobile;
String dbstatus= dopt.AddNewBookingEntry("users", strDatabaseTableFields,strDatabaseTableValues);
if(dbstatus.equalsIgnoreCase("true"))
{
%>
       <script>
              alert("Registration Successful. Thanks for Registering with CityCartz");
              window.open("Home","_self");
       </script>
<%
                                  //SEND EMAIL TO ADMIN 
                                   String subject="NEW USER REGISTRATION";
		                           String data="New User has Registered. Details are:\r\n";
		                           data+= "Name: "+strcust_name+"\r\n";
		                           data+= "Email: "+strcust_email+"\r\n";
		                           data+= "Mobile: "+strcust_mobile+"\r\n";
		                           Java_Email jmail= new Java_Email();                                      
		                           boolean emailstatus=jmail.sendEmail("Admin", senderemail,receiveremail, subject, data);
		                           // SEND EMAIL TO CLIENT
		                            subject="CityCartz Response";
		                            data="Thank You For Registering with CityCartz.Your Registered Details are:\r\n";
		                            data+= "Name: "+strcust_name+"\r\n";
			                        data+= "Email: "+strcust_email+"\r\n";
			                        data+= "Mobile: "+strcust_mobile+"\r\n";
                                    emailstatus=jmail.sendEmail("Client", "support@citycartz.com",strcust_email, subject, data);
}
else if(dbstatus.contains("Duplicate entry"))
{
%>
      <script>
               alert("Sorry...!! Email Already Registered With Us. Please Use a new Email ID");
               window.open("Home","_self");
      </script>
<%		
}
else
{
	// WRITE INTO LOG FILE
	WriteToLogFile wtlf= new WriteToLogFile();
	String formatString = "\n";
	formatString +="REGISTRATION DETAILS ARE NOT STORED IN THE DATABASE.\r\nTHE DETAILS ARE:\r\n";
 	for(int j=0;j<strDatabaseTableFields.length;j++)
	{
		formatString += strDatabaseTableFields[j] + " : " +  strDatabaseTableValues[j] + "\r\n";
	}
	logfilestatus=wtlf.writetologfile(appFolder+"/LogFiles/user_registration_logFile.txt",formatString);	
       // SEND EMAIL TO ADMIN 
        String subject="NEW USER REGISTRATION";
	    String data="New User has Registered. Details are:\r\n";
		data+= "Name: "+strcust_name+"\r\n";
		data+= "Email: "+strcust_email+"\r\n";
		data+= "Mobile: "+strcust_mobile+"\r\n";
        Java_Email jmail= new Java_Email();                                      
		boolean emailstatus=jmail.sendEmail("Admin", senderemail,receiveremail, subject, data);
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