<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<%@page import="login.AdminVerification" %>
<%
	String strUsername = request.getParameter("username");
	String strPassword = request.getParameter("password");
	AdminVerification obj = new AdminVerification();
	boolean check = obj.verifyAdmin(strUsername, strPassword);
	if(check)
		{
			session.setAttribute("User", strUsername);	
			session.setAttribute("security","/'].;[,lp.;[/']']]");
			response.sendRedirect("AdminHome");	
		}
		else
			{
%>
				<script type="text/javascript">
				alert("Wrong Details!!");
				window.open("AdminLogin","_top");
				</script>
<%					
			}
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
</head>
<body>
</body>
</html>