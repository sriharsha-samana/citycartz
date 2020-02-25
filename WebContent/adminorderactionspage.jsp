<!DOCTYPE html>
<html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.sql.rowset.CachedRowSet" %>
<%@ page import="javax.sql.rowset.RowSetProvider" %>
<%@ page import="java.io.*" %>    
<%@ page import="DatabaseActions.*" %> 
<%@ page import="java.io.File" %>
<%@ page import="javax.xml.parsers.DocumentBuilder" %>
<%@ page import="javax.xml.parsers.DocumentBuilderFactory" %>
<%@ page import="org.w3c.dom.Document" %>
<%@ page import="org.w3c.dom.NodeList" %>
<%@ page import="org.w3c.dom.Node" %>
<%@ page import="org.w3c.dom.Element" %>
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
			function updateFieldsIfCancelled()
			{
				var value = $('#STATUS').val();
				if(value == 'Cancelled')
					{
						$('#VEHICLE_NUMBER').val("NA");
						$('#DRIVER_NAME').val("NA");
						$('#ESTIMATED_DATE_TIME_PICKUP').val("NA");
						$('#VEHICLE_NUMBER').prop("readonly",true);
						$('#DRIVER_NAME').prop("readonly",true);
						$('#ESTIMATED_DATE_TIME_PICKUP').prop("readonly",true);
						$('#VEHICLE_NUMBER').hide();
						$('#DRIVER_NAME').hide();
						$('#ESTIMATED_DATE_TIME_PICKUP').hide();
					}
					else
						{
							$('#VEHICLE_NUMBER').val("");
							$('#DRIVER_NAME').val("");
							$('#ESTIMATED_DATE_TIME_PICKUP').val("");
							$('#VEHICLE_NUMBER').prop("readonly",false);
							$('#DRIVER_NAME').prop("readonly",false);
							$('#ESTIMATED_DATE_TIME_PICKUP').prop("readonly",false);
							$('#VEHICLE_NUMBER').show();
							$('#DRIVER_NAME').show();
							$('#ESTIMATED_DATE_TIME_PICKUP').show();
						}
			}
			function calculateCharges()
			{
				var action = $('#action').val();
				if(action == "complete")
					{
						var totalfare = 0;
						var basefare = 0;
						var chargeperkm = 0;
						var actdist = 0;
						var fareforactualdistance = 0;
						var waitingtime = 0;
						var freewaitingmins = 0;
						var waitingchargepermin = 0;
						var waitingcharge = 0;
						var nightholding = "No";
						var nightholdingcharge = 0;
						var discount = 0;
						waitingtime = $('#WAITING_TIME').val();
						waitingtime = parseInt(waitingtime);
						freewaitingmins = $('#FREE_WAITING_HOURS').val();
						freewaitingmins = parseInt(freewaitingmins);
						freewaitingmins = freewaitingmins * 60;
						waitingchargepermin = $('#WAITING_CHARGE_PER_MIN').val();
						waitingchargepermin = parseInt(waitingchargepermin);
						if(waitingtime>freewaitingmins)
							{
								waitingtime = waitingtime - freewaitingmins;
							}
							else
								{
									waitingtime = 0;
								}
						waitingcharge = waitingtime * waitingchargepermin;
						waitingcharge = parseInt(waitingcharge);
						basefare = $('#BASE_FARE').val();
						basefare = parseInt(basefare);
						actdist = $('#ACTUAL_DISTANCE').val();
						actdist = parseInt(actdist);
						chargeperkm = $('#CHARGE_PER_KM').val();
						chargeperkm = parseInt(chargeperkm);
						fareforactualdistance = chargeperkm * actdist;
						fareforactualdistance = basefare + parseInt(fareforactualdistance);
						nightholding = $('#NIGHTHOLDING').val();
						if(nightholding == "yes")
							{
								nightholdingcharge = $('#NIGHT_HOLDING_CHARGE_PER_NIGHT').val();
							}
							else
								{
									nightholdingcharge = 0;
								}
						nightholdingcharge = parseInt(nightholdingcharge);
						discount = $('#DISCOUNT').val();
						discount = parseInt(discount);
						discount = basefare * (discount / 100);
						discount = parseInt(discount);
						totalfare = fareforactualdistance + waitingcharge + nightholdingcharge - discount;
						totalfare = parseInt(totalfare);
						$('#NIGHTHOLDING_CHARGES').val(nightholdingcharge);
						$('#WAITING_CHARGES').val(waitingcharge);
						$('#TOTAL_FARE').val(totalfare);
					}
			}
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
CachedRowSet crs;
CachedRowSet crsnew;
String BookingInfo="";
DatabaseOperations dopt=new DatabaseOperations();
String orderNo= request.getParameter("value");
String strAction = request.getParameter("action");
String strWhere= new String();
String strStatus=new String();
String strSubmitLabel = "Submit";
strWhere="UniqueT_id ='"+orderNo+"'";
crs=dopt.fetchDataFromDB("bookingdetails",null, strWhere);
crsnew=dopt.fetchDataFromDB("bookingdetailsfinal",null, strWhere);
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
	<div class="order-action-page">
<div class="container">	
<div class="order-action-page-left">
<div class="order-search-form-header">Order Details</div>
<%
if(crs.next())
{
%>
<table border=1>
<tr><td>Order Number</td><td><input type="text" name="orderno" id="orderno" value="<%=orderNo%>" readonly /></td></tr>
<tr><td>Customer Name</td><td><input type="text" name="custname" id="custname" value="<%=crs.getString("CUST_NAME")%>"  readonly/></td></tr>
<tr><td>From LandMark</td><td><textarea name="from" id="from" readonly><%=crs.getString("ORIGIN")%></textarea></td></tr>
<tr><td>To LandMark</td><td><textarea name="to" id="to" readonly><%=crs.getString("DESTINATION")%></textarea></td></tr>
<tr><td>Date & Time of PickUp</td><td><input type="textarea" name="datetime" id="datetime" value="<%=crs.getString("DATE_TIME_PICKUP")%>" readonly /></td></tr>
<tr><td>Mobile Number</td><td><input type="text" name="mobile" id="mobile" value="<%=crs.getString("MOBILE")%>" readonly /></td></tr>
<tr><td>Vehicle Type</td><td><input type="text" name="vehciletype" id="vehicletype" value="<%=crs.getString("VEHICLE_TYPE_LABEL")%>" readonly/></td></tr>
<%
if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("complete"))
{
	if(crsnew.next())
	{
%>
		<tr><td>Vehicle Number</td><td><input type="text" name="vehiclenumber" id="vehiclenumber" value="<%=crsnew.getString("VEHICLE_NUMBER") %>" readonly /></td></tr>
		<tr><td>Driver Name</td><td><input type="text" name="drivername" id="drivername" value="<%=crsnew.getString("DRIVER_NAME")%>" readonly /></td></tr>
		<tr><td>Estimated Time of PickUp</td><td><input type="text" name="estimateddatetimepickup" id="estimateddatetimepickup" value="<%=crsnew.getString("ESTIMATED_DATE_TIME_PICKUP")%>" readonly /></td></tr>
		<tr><td>Status</td><td><input type="text" name="orderstatus" id="orderstatus" value="<%=crsnew.getString("STATUS")%>" readonly /></td></tr>
<%      
	}
	crsnew.beforeFirst();
}
%>
 </table>
 </div>
 <div class="order-action-page-right">
 <div class="order-search-form-header">Update details</div>
 <form name="confirmdetails" method="post" action="AdminStoreFinalDetails" onsubmit="calculateCharges();">
 <input type="hidden" name="action" id="action" value="<%=strAction%>"/>
 <input type="hidden" value=<%=orderNo%> name="orderno" id="orderno"/>
 <table border=0>
<%
String[] strFields = null;
if(strAction.equalsIgnoreCase("confirm"))
{
	strFields = new String[5];
	strFields[0] = "VEHICLE_NUMBER";
	strFields[1] = "DRIVER_NAME";
	strFields[2] = "ESTIMATED_DATE_TIME_PICKUP";
	strFields[3] = "STATUS";
	strFields[4] = "UNIQUET_ID";
	session.setAttribute("strFields",strFields);
	strSubmitLabel = "Update";
%>
   <tr>
       <td class="action-label">Vehicle Number</td>
       <td><input type="text" name="VEHICLE_NUMBER" id="VEHICLE_NUMBER" pattern="^[A-Z]{2}[0-9]{2}[A-Z]{2}[0-9]{4}$"required/></td>
   </tr>
   <tr>
        <td class="action-label">Driver Name</td>
        <td><input type="text" name="DRIVER_NAME" id="DRIVER_NAME" required/></td>
  </tr>
   <tr>
        <td class="action-label">Estimated PickUp</td>
        <td><input id="ESTIMATED_DATE_TIME_PICKUP" name="ESTIMATED_DATE_TIME_PICKUP" type="text" placeholder=" Date and Time" required readonly/></td>
  </tr>
  <tr>
        <td class="action-label">Status</td>
        <td>
        <select id="STATUS" name="STATUS" required onchange="updateFieldsIfCancelled();" required>
            <option value="Confirmed">Confirmed</option>
            <option value="Cancelled">Cancelled</option>
       </select>
       </td>
  </tr>
<input type="hidden" name="UNIQUET_ID" id="UNIQUET_ID" value="<%=orderNo%>" readonly />
<%
}
else if(strAction.equalsIgnoreCase("update"))
{
	strFields = new String[1];
	strFields[0] = "STATUS";
	session.setAttribute("strFields",strFields);
	strStatus = "";
	if(crsnew.next())
	{
		strStatus=crsnew.getString("STATUS");
	}
	crsnew.beforeFirst();
	strSubmitLabel = "Update";
	String[] strStatusOptions = new String[10];
	strStatusOptions[0] = "Confirmed";
	strStatusOptions[1] = "Driver Details Sent";
	strStatusOptions[2] = "Driver Reached Location";
	strStatusOptions[3] = "Packing in Progress";
	strStatusOptions[4] = "Loading in Progress";
	strStatusOptions[5] = "Security Pass Key Generated";
	strStatusOptions[6] = "Shifting in Progress";
	strStatusOptions[7] = "Pass Key Verification Completed";
	strStatusOptions[8] = "Unloading in Progress";
	strStatusOptions[9] = "Shifting Completed";
%>
 <tr>
 	<td class="action-label">Status</td>
 	<td>
 		<select id="STATUS" name="STATUS" required>
 <%
 			for(int a=0;a<strStatusOptions.length;a++)
 			{
 				if(strStatusOptions[a].equalsIgnoreCase(strStatus))
	 				{
%>
						<option value="<%=strStatusOptions[a]%>" selected><%=strStatusOptions[a]%></option>
<%	 					
	 				}
	 				else
	 					{
%>
	 						<option value="<%=strStatusOptions[a]%>"><%=strStatusOptions[a]%></option>	 					
<%	
	 					}
 			}
 %>
 		</select>  
 	</td>
 </tr>
<% 
}
else if(strAction.equalsIgnoreCase("complete"))
{
	strFields = new String[8];
	strFields[0] = "ACTUAL_DISTANCE";
	strFields[1] = "WAITING_TIME";
	strFields[2] = "WAITING_CHARGES";
	strFields[3] = "NIGHTHOLDING";
	strFields[4] = "NIGHTHOLDING_CHARGES";
	strFields[5] = "DISCOUNT";
	strFields[6] = "TOTAL_FARE";
	strFields[7] = "STATUS";
	session.setAttribute("strFields",strFields);
	String strActualDist = "0";
	String strWaitingTime = "0";
	String strNightHolding = "No";
	String strDiscount = "0";
	if(crsnew.next())
	{
		strStatus = crsnew.getString("STATUS");
		strActualDist = crsnew.getString("ACTUAL_DISTANCE");
		strWaitingTime = crsnew.getString("WAITING_TIME");
		strNightHolding = crsnew.getString("NIGHTHOLDING");
		strDiscount = crsnew.getString("DISCOUNT");
	}
	crsnew.beforeFirst();
	strSubmitLabel = "Complete";
%>
   <tr>
      <td class="action-label">Actual Distance (Km)</td>
      <td><input type="text" name="ACTUAL_DISTANCE" id="ACTUAL_DISTANCE" value="<%=strActualDist %>" pattern="[0-9]{1,9}" required/></td>
   </tr>
  <tr>
      <td class="action-label">Waiting Time (Mins)</td>
      <td><input type="text" name="WAITING_TIME" id="WAITING_TIME" value="<%=strWaitingTime %>" pattern="[0-9]{1,9}" required/></td>
  </tr>
  <tr>
      <td class="action-label">Night Holding</td>
      <td><select id="NIGHTHOLDING" name="NIGHTHOLDING" required>
      		   <option value="<%=strNightHolding%>" selected><%=strNightHolding%></option>
               <option value="yes">yes</option>
               <option value="no">no</option>
          </select>
          </td></tr>
  <tr>
     <td class="action-label">Discount (%)</td>
     <td><input type="text" name="DISCOUNT" id="DISCOUNT" value="<%=strDiscount%>" pattern="(100)|(0*\d{1,2})" required/></td>
  </tr>
  <tr>
     <td class="action-label">Status</td>
     <td>
        <select id="STATUS" name="STATUS" required>
            <option value="Total Fare Details Sent">Total Fare Details Sent</option>
       	    <option value="Payment Pending">Payment Pending</option>
            <option value="Payment Received">Payment Received</option> 
        </select>
      </td>
   </tr>
   <input type="hidden" name="WAITING_CHARGES" id="WAITING_CHARGES" value="0" readonly/> 
   <input type="hidden" name="NIGHTHOLDING_CHARGES" id="NIGHTHOLDING_CHARGES" value="0" readonly/> 
   <input type="hidden" name="TOTAL_FARE" id="TOTAL_FARE" value="0" readonly/> 
 <%
 		String strBaseFare = "0";
 		String strChargePerKM = "0";
 		String strWaitingChargePerMin = "0";
 		String strFreeWaitingHours = "0";
 		String strNightHoldingChargePerNight = "0";
 		String appFolder =  getServletContext().getRealPath("/");
		File file = new File(appFolder+"/dynamicData/dynamicData.xml");
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		DocumentBuilder db = dbf.newDocumentBuilder();
		Document doc = db.parse(file);
		NodeList listOfVehicles = doc.getElementsByTagName("vehicle");
		String strEachVehicleValue = "";
		String strEachVehicleHeader = "";
		for(int a=0;a<listOfVehicles.getLength();a++)
			{
				Node nNode1 = listOfVehicles.item(a);
				if (nNode1.getNodeType() == Node.ELEMENT_NODE) 
					{
						Element eElement = (Element) nNode1;
						strEachVehicleHeader = (String)eElement.getTextContent();
						strEachVehicleValue = (String)eElement.getAttribute("value");
						if(strEachVehicleValue.equalsIgnoreCase(crs.getString("VEHICLE_TYPE"))){
							strBaseFare = (String)eElement.getAttribute("basefare");
							strChargePerKM = (String)eElement.getAttribute("fareperkm");
							strWaitingChargePerMin = (String)eElement.getAttribute("waitingfare");
							strFreeWaitingHours = (String)eElement.getAttribute("freewaitinghours");
							strNightHoldingChargePerNight = (String)eElement.getAttribute("nightholdingfare");		
						}
					}
			}
 %>
 	<input type="hidden" name="BASE_FARE" id="BASE_FARE" value="<%=strBaseFare %>" readonly/> 
	<input type="hidden" name="CHARGE_PER_KM" id="CHARGE_PER_KM" value="<%=strChargePerKM %>" readonly/> 
	<input type="hidden" name="WAITING_CHARGE_PER_MIN" id="WAITING_CHARGE_PER_MIN" value="<%=strWaitingChargePerMin %>" readonly/> 
	<input type="hidden" name="FREE_WAITING_HOURS" id="FREE_WAITING_HOURS" value="<%=strFreeWaitingHours %>" readonly/>
	<input type="hidden" name="NIGHT_HOLDING_CHARGE_PER_NIGHT" id="NIGHT_HOLDING_CHARGE_PER_NIGHT" value="<%=strNightHoldingChargePerNight %>" readonly/> 
<% 
}
else if(strAction.equalsIgnoreCase("close"))
{
	strFields = new String[1];
	strFields[0] = "STATUS";
	session.setAttribute("strFields",strFields);
	strSubmitLabel = "Close Order";
	if(crsnew.next())
	{
%>
	<input type="hidden" name="STATUS" id="STATUS" value="Closed" readonly/> 
	<tr>
      <td class="action-label">Actual Distance (Km)</td>
      <td><input type="text" name="ACTUAL_DISTANCE" id="ACTUAL_DISTANCE" value="<%=crsnew.getString("ACTUAL_DISTANCE")%>" required readonly/></td>
   </tr>
   	<tr>
      <td class="action-label">Waiting Time (Mins)</td>
      <td><input type="text" name="WAITING_TIME" id="WAITING_TIME" value="<%=crsnew.getString("WAITING_TIME")%>" required readonly/></td>
   </tr>
   	<tr>
      <td class="action-label">Waiting Charges (Rs)</td>
      <td><input type="text" name="WAITING_CHARGES" id="WAITING_CHARGES" value="<%=crsnew.getString("WAITING_CHARGES")%>" required readonly/></td>
   </tr>
   <tr>
      <td class="action-label">Night Holding Charges (Rs)</td>
      <td><input type="text" name="NIGHTHOLDING_CHARGES" id="NIGHTHOLDING_CHARGES" value="<%=crsnew.getString("NIGHTHOLDING_CHARGES")%>" required readonly/></td>
   </tr>
   <tr>
      <td class="action-label">Discount (%)</td>
      <td><input type="text" name="DISCOUNT" id="DISCOUNT" value="<%=crsnew.getString("DISCOUNT")%>" required readonly/></td>
   </tr>
   <tr>
      <td class="action-label">Total Fare (Rs)</td>
      <td><input type="text" name="TOTAL_FARE" id="TOTAL_FARE" value="<%=crsnew.getString("TOTAL_FARE")%>" required readonly/></td>
   </tr>
<%
	}
}
%>
<tr><td></td><td><input type="submit" value="<%=strSubmitLabel %>"></td></tr>
</table>
</form>
<%
}
else
{
%>
	<h3>Order not found.</h3>
<%
}
%>
</div>
</div>
</div>
</body>
<link rel="stylesheet" type="text/css" href="css/jquery.datetimepicker.css"/>
<script src="js/jquery.datetimepicker.js"></script>
<script>
var dateToday = new Date();   
$('#ESTIMATED_DATE_TIME_PICKUP').datetimepicker({
	step: 15,
	closeOnWithoutClick :true,
	validateOnBlur:true,
	theme:'dark',
	defaultDate:0,
	todayButton:true,
	timepickerScrollbar:true
});
</script>
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
</html>