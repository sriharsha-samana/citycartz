<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import="DatabaseActions.*" %>
<html>
<head>
<%
if (session == null || session.getAttribute("User") == null || !session.getAttribute("User").equals("Administrator") || !session.getAttribute("security").equals("/'].;[,lp.;[/']']]")) {
%>
		<script>
			window.open("Home","_top");
		</script>
<%
}
%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
</head>
<body>
<%
	String strPrimaryKey  = request.getParameter("value");
	String[] strStatusField = new String[1];
	strStatusField[0] = "STATUS";
	String[] strStatusFieldValue = new String[1];
	strStatusFieldValue[0] = "Confirmed";
	DatabaseOperations dopt=new DatabaseOperations();
	String status = dopt.UpdateExistingEntry("bookingdetailsfinal", strPrimaryKey, strStatusField, strStatusFieldValue);
	if(status.equalsIgnoreCase("true"))
	{
%>
		<script>
			alert("Order reopened Successfully.");
			window.open("AdminOrderSearch","_self");
		</script>
<%		
	}
	else
	{
%>
		<script>
			alert("Reopening order failed. Please try again.");
			window.open("AdminOrderSearch","_self");
		</script>
<%		
	}
%>
</body>
</html>