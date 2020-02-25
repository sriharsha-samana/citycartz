<!DOCTYPE html>
<html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.sql.rowset.CachedRowSet" %>
<%@ page import="javax.sql.rowset.RowSetProvider" %>
<%@ page import="java.io.*" %>    
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
		<script type="text/javascript">
		</script>
		<script src="http://maps.googleapis.com/maps/api/js?sensor=false&amp;libraries=places"></script>
		<script src="js/jquery.geocomplete.js"></script>
	<!-- start-smooth-scrolling -->
	<script type="text/javascript">
		function initialize() {
			 var options = {
			  componentRestrictions: {country: "IN"}
			 };
			 var input1 = document.getElementById('pac-input-from');
			 var input2 = document.getElementById('pac-input-to');
			 var autocomplete = new google.maps.places.Autocomplete(input1, options);
			 var autocomplete = new google.maps.places.Autocomplete(input2, options);
			}
			google.maps.event.addDomListener(window, 'load', initialize);
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
<%
String orderNumber []=new String[0];
String customerName[]= new String[0];
String mobileNumber[]= new String[0];
String datetime[]= new String[0];
String orderStatus[]=new String[0];
String sqlquery=new String();
String strUpdateButton = "Update Order";
DatabaseOperations dopt=new DatabaseOperations();
String strDatabaseTableName="bookingdetails";
int count=0;
CachedRowSet crs;
CachedRowSet crsnew;
String form1=request.getParameter("ordersearchform1");
String form2=request.getParameter("ordersearchform2");
if(form2==null)
{
	if(form1.equals("dateform"))
	{
	// SEARCH USING DATE
	String strWhere= new String();
	String schedule=request.getParameter("radio");
	String date=request.getParameter("DateTime");
	if(schedule.equals("any"))
	{
		 sqlquery="SELECT * FROM bookingdetails";
	}
	else if(schedule.equals("afterdate"))
	{
	 strWhere="CAST(DATE_TIME_PICKUP as DATE) >'"+date+"'";
	 sqlquery="SELECT * FROM bookingdetails WHERE "+strWhere+"";
	}
	else if(schedule.equals("beforedate"))
	{
		 strWhere="CAST(DATE_TIME_PICKUP as DATE) <'"+date+"'";
		 sqlquery="SELECT * FROM bookingdetails WHERE "+strWhere+"";
	}
	else if(schedule.equals("ondate"))
	{
		 strWhere="CAST(DATE_TIME_PICKUP as DATE)='"+date+"'";
		 sqlquery="SELECT * FROM bookingdetails WHERE "+strWhere+"";
	}
	
    int i=0;
	strWhere=strWhere.replace('/','-');
     crs = dopt.fetchDataFromDB(strDatabaseTableName, null, strWhere);
     count=crs.size();
      i=0;
     orderNumber  = new String[count];
     customerName = new String[count];
     mobileNumber = new String[count];
     datetime     = new String[count];
     orderStatus  = new String[count];
     if(crs.next())
     {
     	do{
     	   customerName[i]=crs.getString("CUST_NAME");
    	   orderNumber[i]=crs.getString("UNIQUET_ID");
    	   datetime[i]=crs.getString("DATE_TIME_PICKUP");
   	       mobileNumber[i]=crs.getString("MOBILE");
   	       orderStatus[i]=crs.getString("STATUS");
   	       if(orderStatus[i].equalsIgnoreCase("Confirmed"))
   	       {
   	    	   strWhere="UNIQUET_ID='"+orderNumber[i]+"'";
   	    	   crsnew=dopt.fetchDataFromDB("bookingdetailsfinal",null,strWhere);
   	    	   if(crsnew.next())
   	    	   {
   	    		   orderStatus[i]=crsnew.getString("STATUS");
   	    	   }   
   	       }
    	   i++;
     	}while(crs.next());
     }
     else
     {
%>
     	<script>
     	alert("No Orders Present in the Selected Dates");
     	</script>
 <%
     }
	}
}
else 
{
    if(form1==null)
    {
    	if(form2.equals("ordernoform"))
    	{
        // SEARCH USING ORDER NO
    	String strWhere= new String();
        String orderNo= request.getParameter("orderno");
    	strWhere="UniqueT_id ='"+orderNo+"'";
    	sqlquery="SELECT * FROM bookingdetails WHERE "+strWhere+"";
    	crs = dopt.fetchDataFromDB(strDatabaseTableName, null, strWhere);
    	count=crs.size();
    	int i=0;
    	 orderNumber  = new String[count];
	     customerName = new String[count];
	     mobileNumber = new String[count];
	     datetime     = new String[count];
	     orderStatus  = new String[count];
        if(crs.next())
        {
        	do{
        	   customerName[i]=crs.getString("CUST_NAME");
       	       orderNumber[i]=crs.getString("UNIQUET_ID");
       	       datetime[i]=crs.getString("DATE_TIME_PICKUP");
       	       mobileNumber[i]=crs.getString("MOBILE");
       	       orderStatus[i]=crs.getString("STATUS");
    	       if(orderStatus[i].equalsIgnoreCase("Confirmed"))
    	       {
    	    	   strWhere="UNIQUET_ID='"+orderNumber[i]+"'";
    	    	   crsnew=dopt.fetchDataFromDB("bookingdetailsfinal",null,strWhere);
    	    	   if(crsnew.next())
    	    	   {
    	    		   orderStatus[i]=crsnew.getString("STATUS");
    	    	   }   
    	       }
       	       i++;
        	}while(crs.next());
        }
        else
        {
        	%>
        	<script type="text/javascript">
        	alert("No Such Order Number Exists");
        	</script>
        	<%
        }
        }
     }
}
%>    
<body>
<div class="se-pre-con"></div>
<!-- header -->
<div class="header">
	<div class="header-left">
		<a href="AdminHome"><span class="blue">City</span><span class="orange">Cartz</span></a>
	</div>
	<div class="header-right">
		<span class="menu"><img src="images/menu.png" alt=""/></span>
				<ul class="nav1">
					<li><a href="AdminHome">HOME</a></li>
					<li><a class="active" href="AdminOrderSearch">UPDATE ORDER STATUS</a></li>	
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
	<div class="order-search-results">
<div class="container">	
<div class="order-search-results-header">Orders Summary</div>
<table border=1>
 	<th>Customer Name</th>
    <th>Order Number</th>
    <th>Mobile Number</th>
    <th>Date & Time of PickUp</th>
    <th>Status</th>
    <th>Action</th>
<% 
 for(int j=0;j<count;j++)
     {
	 	strUpdateButton = "Update Order";
	 %>
    	 <tr><td><% out.println(customerName[j]);%></td>
    	 <td><a href="AdminOrderSummary?order=<%=orderNumber[j]%>"><%out.println(orderNumber[j]); %></a></td>
    	 <td><%out.println(mobileNumber[j]); %></td>
    	 <td><%out.println(datetime[j]); %></td>
    	 <td><%out.println(orderStatus[j]); %>
    	<%
    	 String href="";
    	if(orderStatus[j].equalsIgnoreCase("Received") || orderStatus[j].equalsIgnoreCase("Cancelled"))
    	{
    		href="AdminOrderActions?action=confirm";
    		strUpdateButton = "Confirm Order";
    	}
    	else if(orderStatus[j].equalsIgnoreCase("Shifting Completed") || orderStatus[j].equalsIgnoreCase("Payment Pending") || orderStatus[j].equalsIgnoreCase("Payment Received") || orderStatus[j].equalsIgnoreCase("Total Fare Details Sent"))
    	{
    		href="AdminOrderActions?action=complete";
    		strUpdateButton = "Complete Order";
    		if(orderStatus[j].equalsIgnoreCase("Payment Received"))
    		{
    			strUpdateButton = "Close Order";
    			href="AdminOrderActions?action=close";
    		}
    	}
    	else if(orderStatus[j].equalsIgnoreCase("Closed"))
    	{
    		strUpdateButton = "Reopen Order";
    		href="AdminReopenOrder?action=reopen";
    	}
    	else
    	{
    		href="AdminOrderActions?action=update";
    		strUpdateButton = "Update Order";
    	}
    	%>
    	 <td><a href="<%=href%>&value=<%=(orderNumber[j])%>"><input type="button" value="<%=strUpdateButton %>" ></input></a></td>
    	 </tr>
    <%
     }
%>
</table>
</div>
<br><br><br><br><br><br><br><br>
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
</body>
</html>