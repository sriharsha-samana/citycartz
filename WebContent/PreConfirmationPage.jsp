<%@ page import="java.io.File" %>
<%@ page import="javax.xml.parsers.DocumentBuilder" %>
<%@ page import="javax.xml.parsers.DocumentBuilderFactory" %>
<%@ page import="org.w3c.dom.Document" %>
<%@ page import="org.w3c.dom.NodeList" %>
<%@ page import="org.w3c.dom.Node" %>
<%@ page import="org.w3c.dom.Element" %>
<%@ page import="DatabaseActions.*" %>
<%
String Origin=new String();
String Destination= new String();
String CustName= new String();
String Contact=new String();
String DateTime=new String();
String VehicleType=new String();
String VehicleTypeLabel=new String();
String BookingInfo = new String();
String strBaseFare = new String();
String strFarePerKm = new String();
boolean flag=false;
try
{
 Origin= request.getParameter("pac-input-from");
 Destination= request.getParameter("pac-input-to");
 CustName=request.getParameter("custname");
 Contact= request.getParameter("contactnum");
 DateTime=request.getParameter("DateTime");
 VehicleType= request.getParameter("vehicletype");
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
					if(VehicleType.equalsIgnoreCase(strEachVehicleValue))
						{
							strBaseFare = (String)eElement.getAttribute("basefare");
							strFarePerKm =	(String)eElement.getAttribute("fareperkm");
							VehicleTypeLabel = strEachVehicleHeader;
						}
				}
		}
 flag=true;
}
catch (Exception e)
{
	%>
	<jsp:forward page="/404"></jsp:forward>
	<%
	}
%>
<!DOCTYPE html>
<html>
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
		<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
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
			jQuery(document).ready(function($) {
				$(".scroll").click(function(event){		
					event.preventDefault();
					$('html,body').animate({scrollTop:$(this.hash).offset().top},1000);
				});
			});
			function showTrackOderForm()
			{
				$('.track-order-index').show("slow");
			}
			function hideTrackOderForm()
			{
				$('.track-order-index').hide("slow");
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
	<!-- start-smooth-scrolling -->
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <style>
    </style>
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=false"></script>
    <script>
var directionsDisplay;
var directionsService = new google.maps.DirectionsService();
var map;
var geocoder;
var markersArray = [];
var origin1 ="<%=Origin%>";
var destinationA = "<%=Destination%>";
var destinationIcon = 'https://chart.googleapis.com/chart?chst=d_map_pin_letter&chld=D|FF0000|000000';
var originIcon = 'https://chart.googleapis.com/chart?chst=d_map_pin_letter&chld=O|FFFF00|000000';
function initialize() {
  directionsDisplay = new google.maps.DirectionsRenderer();
  var mumbai = new google.maps.LatLng(18.9600, 72.8200);
  var mapOptions = {
    zoom:10,
    center: mumbai
  };
  map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  directionsDisplay.setMap(map);
  geocoder = new google.maps.Geocoder();
}
<%
if(flag==true)
{
%>
function calculateDistances() {
	  var service = new google.maps.DistanceMatrixService();
	  service.getDistanceMatrix(
	    {
	      origins: [origin1],
	      destinations: [destinationA],
	      travelMode: google.maps.TravelMode.DRIVING,
	      unitSystem: google.maps.UnitSystem.METRIC,
	      avoidHighways: false,
	      avoidTolls: false
	    }, callback);
	}
function callback(response, status) {
	  if (status != google.maps.DistanceMatrixStatus.OK) {
	    alert('Error was: ' + status);
	  } else {
		  var results=response.rows[0].elements;
		  var duration=results[0].duration.text;
		  var distance=results[0].distance.value;
		  distance = parseInt(distance/1000);
		  var baseFare = "<%=strBaseFare%>";
		  var farePerKm = "<%=strFarePerKm%>";
		  var baseFareInt = parseInt(baseFare);
		  var farePerKmInt = parseInt(farePerKm);
		  var totalFare = baseFareInt + (distance*farePerKmInt);
		  totalFare=Math.round(totalFare);
		  document.getElementById("ESTIMATED_DISTANCE").value = distance + " km";
		  document.getElementById("estimatedDistanceHidden").value = distance;
		  document.getElementById("ESTIMATED_DURATION").value = duration;
		  document.getElementById("ESTIMATED_FARE").value="Rs. "+totalFare;
	  }
}
function calcRoute() 
{
	var start="<%=Origin%>";
	var end= "<%=Destination%>";
  var request ={
      origin:start,
      destination:end,
      travelMode: google.maps.TravelMode.DRIVING
  };
  directionsService.route(request, function(response, status) {
    if (status == google.maps.DirectionsStatus.OK) {
      directionsDisplay.setDirections(response);
    }
  });
}
google.maps.event.addDomListener(window, 'load', initialize);
<%
}
%>
	window.history.forward();
	function noBack() { window.history.forward(); }
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
  <!-- header -->
<div class="header">
		<div class="header-left">
		<a href="Home"><span class="blue">City</span><span class="orange">Cartz</span></a>
	</div>
	<div class="header-right">
		<span class="menu"><img src="images/menu.png" alt=""/></span>
				<ul class="nav1">
					<li><a class="active" href="Home">HOME</a></li>
					<li><a href="About">ABOUT US</a></li>
					<li><a href="Fares">ESTIMATE PRICE</a></li>	
					<li><a class="active" href="Book">SHIFT NOW</a></li>
					<li><a style="cursor:pointer" onclick="showTrackOderForm();">TRACK ORDER</a></li>
					<li><a href="Contact">CONTACT US</a></li>
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
		<form name="trackorder" method="post" action="TrackOrderDisplay">
	    		<input type="text" name="transactionid" id="transactionid" placeholder=" Enter Unique Transaction Id" required autocomplete="off"></input>
				<input type="submit" value="CHECK">
		 </form>
	</div>
<div class="booking-page">
<div class="container">
  		<div class="booking-info">
		<h1><b>Confirm Booking</b></h1>
		</div>	
		<br>
		<br>
		<form name="preconfirmationpage" method="post" action="Confirm" onsubmit="return confirmation();">
	<input type="hidden" name="estimatedDistanceHidden" id="estimatedDistanceHidden" value=""/>		
    <div class="booking-details-top" > 
	    <label for="Mobile Number">
	   	 	<span>Mobile Number</span>
	    		<input readonly="readonly" type="text" name="MOBILE" id="MOBILE" value="<%=Contact %>"></input>
	    </label>
	    <label for="Date & Time">
	   	 	<span>Date and Time</span>
	    		<input readonly="readonly" type="text" name="DATE_TIME_PICKUP" id="DATE_TIME_PICKUP" value="<%=DateTime %>"></input>
	    </label>
	    <label for="Vehicle">
	   	 	<span>Vehicle</span>
	    		<input readonly="readonly" type="text" name="VEHICLE_TYPE_LABEL" id="VEHICLE_TYPE_LABEL" value="<%=VehicleTypeLabel %>"></input>
	    		<input readonly="readonly" type="hidden" name="VEHICLE_TYPE" id="VEHICLE_TYPE" value="<%=VehicleType %>"></input>
	    </label>
	    <label for="CustName">
	   	 	<span>Customer Name</span>
	    		<input readonly="readonly" type="text" name="CUST_NAME" id="CUST_NAME" value="<%=CustName%>"></input>
	    </label>
        <label for="Origin">
        <span>Origin</span>
         <input readonly="readonly" type="text" name="ORIGIN" id="ORIGIN" value="<%=Origin%>"></input>
        </label>
        <label for="Destination">
        <span>Destination</span>
         <input readonly="readonly" type="text" name="DESTINATION" id="DESTINATION" value="<%=Destination%>"></input>
        </label>
    </div>
    <br>
    <br>
    <div class="map-canvas" id="map-canvas"></div>
    <div class="booking-details-bottom">
    <label for="Estimated Fare">
    <span>Estimated Fare</span>
    <input type=text id="ESTIMATED_FARE" name="ESTIMATED_FARE" readonly="readonly" />
    </label>
    <label for="Estimated Distance">
    <span>Estimated Distance</span>
    <input type=text id="ESTIMATED_DISTANCE" name="ESTIMATED_DISTANCE" readonly="readonly" />
    </label>
    <label for="Estimated Duration">
    <span>Estimated Duration</span>
    <input type=text id="ESTIMATED_DURATION" name="ESTIMATED_DURATION" readonly="readonly" />
    </label>
  	</div>
  	<input type="hidden" name="STATUS" id="STATUS" value="Received" />
    <div class="booking-buttons">
    <div class="booking-confirm-button">
    <input type="submit" value="CONFIRM"></input> 
    <input type="button" value="CANCEL" onclick="cancel();"></input> 
    </div>
    </div>
    </form>
   <script type="text/javascript">
    function confirmation()
    {
    	var estDist = document.getElementById("estimatedDistanceHidden").value;
    	estDist = parseInt(estDist);
    	if(estDist < 1 )
    		{
    			alert("Estimated distance between two destinations is less than 1 km. Order cannot be confirmed.");
    			return false;
    		}
    	else
    		{
		    	var sure = window.confirm("Are You Sure, You want to Confirm?");
		    	if(sure)
		    		{
		    			return true;
		    		}
			    	else
			    		{
			    			return false;
			    		}
    		}
    	return false;
    }
    function cancel()
    {
    	var sure = confirm("Are You Sure, You want to Cancel?");
    	if(sure)
		{
			window.open("Home","_self");
		}
		else
			{
				return false;
			}
    }
   </script>
    </div>
  <br>
  <br>
  <br>
  </div>  
<!-- //404 -->
<!-- footer -->
<div class="footer">
	<div class="container">
		<div class="footer-grids">
			<div class="col-md-2 footer-grid logobtm">
				<a href="Home">CityCartz</a>
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
					<li><a href="Home">HOME</a></li>
					<li><a href="About">ABOUT US</a></li>
					<li><a href="Fares">ESTIMATE PRICE</a></li>	
					<li><a href="Book">SHIFT NOW</a></li>
					<li><a href="TrackOrder">TRACK ORDER</a></li>
					<li><a href="Contact">CONTACT US</a></li>
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
  <body onload="calculateDistances(); calcRoute(); noBack();" onpageshow="if (event.persisted) noBack();" onunload="">
  <div class="se-pre-con"></div>
  </body>
</html>