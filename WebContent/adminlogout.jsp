<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
<%
if (session == null || session.getAttribute("User") == null || !session.getAttribute("User").equals("Administrator") || !session.getAttribute("security").equals("/'].;[,lp.;[/']']]")) {
%>
		<script>
			window.open("Home","_top");
		</script>
<%
}
%>
<%
		session.removeAttribute("User");
        session.removeAttribute("security");
		response.setHeader("Cache-control","no-store");
		response.setHeader("Pragma","no-cache");
		response.setDateHeader("Expire",0);
		session.invalidate();
%>
		<script type="text/javascript">
			window.open("AdminLogin","_top");
		</script>