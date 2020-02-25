<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="DatabaseActions.*" %>
<html>
<%
if (session == null || session.getAttribute("User") == null || !session.getAttribute("User").equals("Administrator") || !session.getAttribute("security").equals("/'].;[,lp.;[/']']]")) {
%>
		<script>
			window.open("Home","_top");
		</script>
<%
}
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
<title>DB Creation</title>
</head>
<body>
<%
	CreateDatabase cdb = new CreateDatabase();
	boolean created = cdb.createDatabase(request.getParameter("path"));
	if(created)
	{
%>
		<script>
			alert("Database created succesfully.");
			window.open("AdminHome","_self");
		</script>
<%		
	}
	else
	{
%>
		<script>
			alert("Database creation Failed. Please try again.");
			window.open("AdminHome","_self");
		</script>
<%	
	}
%>
</body>
</html>