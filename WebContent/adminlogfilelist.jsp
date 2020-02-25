<!DOCTYPE html>
<html>
<%@ page import="java.io.File" %>
<%@ page import="javax.xml.parsers.DocumentBuilder" %>
<%@ page import="javax.xml.parsers.DocumentBuilderFactory" %>
<%@ page import="org.w3c.dom.Document" %>
<%@ page import="org.w3c.dom.NodeList" %>
<%@ page import="org.w3c.dom.Node" %>
<%@ page import="org.w3c.dom.Element" %>
<%@ page import="DatabaseActions.*" %>
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
	<title>CityCartz - Your Shifting Partner</title>
	<link href="css/style.min.css" rel="stylesheet" type="text/css" media="all" />
	<link href="css/booking.min.css" rel="stylesheet" type="text/css" media="all" />
	<!--fonts-->
		<link href='http://fonts.googleapis.com/css?family=Sintony:700,400' rel='stylesheet' type='text/css'>
		<link href='http://fonts.googleapis.com/css?family=Lato:100,300,400,700,900,100italic,300italic,400italic,700italic,900italic' rel='stylesheet' type='text/css'>
	<!--//fonts-->
		<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" media="all" />
	<!-- for-mobile-apps -->
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
		<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
	<!-- //for-mobile-apps -->
	<!-- js -->
		<script type="text/javascript" src="js/jquery.min.js"></script>
	<!-- js -->
	<!-- start-smooth-scrolling -->
		<script type="text/javascript" src="js/move-top.js"></script>
		<script type="text/javascript" src="js/easing.js"></script>
		<script src="http://maps.googleapis.com/maps/api/js?sensor=false&amp;libraries=places"></script>
		<script src="js/jquery.geocomplete.js"></script>
	<!-- start-smooth-scrolling -->
	<script type="text/javascript">
			function showTrackOderForm()
			{
				$('.track-order-index').show("slow");
			}
			function hideTrackOderForm()
			{
				$('.track-order-index').hide("slow");
			}
			function logout()
			{
				window.open("AdminLogout","_self");
			}
			$('.banner').click(function(){$('.track-order-index').hide();});
			$(document).ready(function(){$('.track-order-index').hide();});
</script>
				<script src="http://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.2/modernizr.js"></script>
			<script>
					$(window).load(function() {
						// Animate loader off screen
						$(".se-pre-con").fadeOut("slow");
					});
			</script>
<link rel="icon" type="image/png" href="favicon-32x32.png" sizes="32x32">
</head>
<body>
<div class="se-pre-con"></div>
<div class="header">
	<div class="header-left">
		<a href="AdminHome"><span class="blue">City</span><span class="orange">Cartz</span></a>
	</div>
	<div class="header-right">
		<span class="menu"><img src="images/menu.png" alt=""/></span>
				<ul class="nav1">
					<li><a class="active" href="AdminHome">HOME</a></li>
					<li><a href="AdminOrderSearch">UPDATE ORDER STATUS</a></li>
					<li><a style="cursor:pointer" onclick="showTrackOderForm();">TRACK ORDER</a></li>
					<li><a href="AdminLogFileList">LOG FILES</a>
					<li><a style="cursor:pointer" onclick="logout();">LOGOUT</a></li>
				</ul>
				<!-- script for menu -->
					<script> 
						$( "span.menu" ).click(function() {
						$( "ul.nav1" ).slideToggle( 300, function() {
						 // Animation complete.
						});
						});
					</script>
				<!-- //script for menu -->
	</div>
	<div class="clearfix"></div>
</div>
<!-- //header -->
<div class="track-order-index">
		<span class="track-order-index-close" onclick="hideTrackOderForm();"><img src="images/close.png" alt="Close"/></span>
		<form name="trackorder" method="post" action="AdminTrackOrderDisplay">
	    		<input type="text" name="transactionid" id="transactionid" placeholder=" Enter Unique Transaction Id" required autocomplete="off"></input>
				<input type="submit" value="CHECK">
		 </form>
	</div>
	<div class="container">
	<div class="log-file-list">
			<div class="log-file-list-header">LOG FILES</div>
<table border=1>
<th> Log File Name </th>
<th> Action </th>
    <tr>
     <td>Booking Confirmation Log File</td>
     <td><a href="AdminLogFileDetails?value=confirm_order_logFile.txt"><input type="button" value="Open Log File"/></a></td>
    </tr>
    <tr>
     <td>Booking Details To Client SMS Log File</td>
     <td><a href="AdminLogFileDetails?value=client_sms_maindetails_logFile.txt"><input type="button" value="Open Log File"/></a></td>
    </tr>
    <tr>
    <td>Driver Details To Client SMS Log File</td>
     <td><a href="AdminLogFileDetails?value=client_sms_driver_details_logFile.txt"><input type="button" value="Open Log File"/></a></td>
    </tr>
     <tr>
     <td>Driver Reached Client SMS Log File</td>
     <td><a href="AdminLogFileDetails?value=client_sms_driver_reached_logFile.txt"><input type="button" value="Open Log File"/></a></td>
    </tr>
     <tr>
     <td>Shifting Started SMS Log File </td>
     <td><a href="AdminLogFileDetails?value=client_sms_shifting_started_logFile.txt"><input type="button" value="Open Log File"/></a></td>
    </tr>
     <tr>
     <td>Shifting Completed SMS Log File</td>
     <td><a href="AdminLogFileDetails?value=client_sms_shifting_completed_logFile.txt"><input type="button" value="Open Log File"/></a></td>
    </tr>
    <tr>
     <td>Total Fare Details To Client SMS Log File</td>
     <td><a href="AdminLogFileDetails?value=client_sms_total_fare_logFile.txt"><input type="button" value="Open Log File"/></a></td>
    </tr>
     <tr>
     <td>Support Email Log File</td>
     <td><a href="AdminLogFileDetails?value=support_logFile.txt"><input type="button" value="Open Log File"/></a></td>
    </tr>
     <tr>
     <td>FeedBack Email Log File</td>
     <td><a href="AdminLogFileDetails?value=feedback_logFile.txt"><input type="button" value="Open Log File"/></a></td>
    </tr>
    <tr>
     <td>User Registration Log File</td>
     <td><a href="AdminLogFileDetails?value=user_registration_logFile.txt"><input type="button" value="Open Log File"/></a></td>
    </tr>
    </table>
</div>
</div>
<!-- footer -->
<div class="footer">
	<div class="container">
		<div class="footer-grids">
			<div class="col-md-2 footer-grid logobtm">
				<a href="AdminHome">CityCartz</a>
			</div>
			<div class="col-md-5 footer-grid">
				<p><b>HEAD OFFICE</b><br><br>606-2B, HDIL Dreams, Bhandup, Mumbai, Maharashtra.<br><br></p>
					  <p>&#8986; 24*7</p>
					  <p>&#9742; 1800 2000 949</p>
					  <p>&#9742; +91-9406920009</p>
					  <p><a href="Contact">&#9993; support@citycartz.com</a></p>
			</div>
			<div class="col-md-3 footer-grid">
				<p>
					Connect socially with CityCartz
				</p><br>
				<p>
					<a href="https://www.facebook.com/pages/CityCartz-Your-Shifting-Partner/1626543447631457?fref=ts"><img src="images/facebook-icon.png"></img></a>
					<a href="https://twitter.com/CityCartz"><img src="images/twitter-icon.png"></img></a>
					<a href="https://plus.google.com/u/2/112945110905269939920/posts"><img src="images/googleplus-icon.png"></img></a>
					<a href="http://www.citycartz.blogspot.in"><img src="images/blog-icon.png"></img></a>
				</p>
			</div>
			<div class="col-md-2 footer-grid">
				<ul>
					<li><a href="AdminHome">HOME</a></li>
					<li><a href="AdminOrderSearch">UPDATE ORDER</a></li>	
					<li><a href="AdminTrackOrder">TRACK ORDER</a></li>
					<li><a href="AdminLogFileList">LOG FILES</a></li>
				</ul>
			</div>
			<div class="clearfix"> </div>
		</div>
		<div class="copy-right">
			<p>Copyright &copy; 2015 www.citycartz.com</p>
		</div>
	</div>
</div>
<!-- //footer -->
<!-- smooth scrolling -->
	<script type="text/javascript">
		$(document).ready(function() {								
		$().UItoTop({ easingType: 'easeOutQuart' });
		});
	</script>
	<a href="#" id="toTop" style="display: block;"> <span id="toTopHover" style="opacity: 1;"> </span></a>
<!-- //smooth scrolling -->
</body>
</html>