<!DOCTYPE html>
<html>
<%@ page import="java.io.File" %>
<%@ page import="javax.xml.parsers.DocumentBuilder" %>
<%@ page import="javax.xml.parsers.DocumentBuilderFactory" %>
<%@ page import="org.w3c.dom.Document" %>
<%@ page import="org.w3c.dom.NodeList" %>
<%@ page import="org.w3c.dom.Node" %>
<%@ page import="org.w3c.dom.Element" %>
<head>
	<title>CityCartz - Your Shifting Partner</title>
	<link href="css/style.min.css" rel="stylesheet" type="text/css" media="all" />
	<link href="css/booking.min.css" rel="stylesheet" type="text/css" media="all" />
	<link href="css/fares.min.css" rel="stylesheet" type="text/css" media="all" />
	<!--fonts-->
		<link href='http://fonts.googleapis.com/css?family=Sintony:700,400' rel='stylesheet' type='text/css'>
		<link href='http://fonts.googleapis.com/css?family=Lato:100,300,400,700,900,100italic,300italic,400italic,700italic,900italic' rel='stylesheet' type='text/css'>
	<!--//fonts-->
		<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" media="all" />
	<!-- for-mobile-apps -->
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
	<!-- start-smooth-scrolling -->
<link rel="icon" type="image/png" href="favicon-32x32.png" sizes="32x32">
	<script>
		function updateVehicleFares(id)
			{
				hideAllDivs();
				showDiv(id);
			}
	</script>
	<script src="http://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.2/modernizr.js"></script>
			<script>
					$(window).load(function() {
						// Animate loader off screen
						$(".se-pre-con").fadeOut("slow");
					});
			</script>
</head>
<!-- header -->
<body>
<div class="se-pre-con"></div>
<%
		String appFolder =  getServletContext().getRealPath("/");
		File file = new File(appFolder+"/dynamicData/dynamicData.xml");
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		DocumentBuilder db = dbf.newDocumentBuilder();
		Document doc = db.parse(file);
%>
<div class="header">
		<div class="header-left">
		<a href="Home"><span class="blue">City</span><span class="orange">Cartz</span></a>
	</div>
	<div class="header-right">
		<span class="menu"><img src="images/menu.png" alt=""/></span>
				<ul class="nav1">
					<li><a href="Home">HOME</a></li>
					<li><a href="About">ABOUT US</a></li>
					<li><a class="active" href="Fares">ESTIMATE PRICE</a></li>	
					<li><a href="Book">SHIFT NOW</a></li>
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
	<div class="track-order-index">
		<span class="track-order-index-close" onclick="hideTrackOderForm();"><img src="images/close.png" alt="Close"/></span>
		<form name="trackorder" method="post" action="TrackOrderDisplay">
	    		<input type="text" name="transactionid" id="transactionid" placeholder=" Enter Unique Transaction Id" required autocomplete="off"></input>
				<input type="submit" value="CHECK">
		 </form>
	</div>
		<div class="fares-header">
			<br><h3><span>PRICING</span></h3>
		</div><br>
	<div class="container">
			<div id="fares-left" class="fares-left">
					<ul>
<%
							NodeList listOfVehicles = doc.getElementsByTagName("vehicle");
							String strHiddenDivs = "";
							String strEachVehicleValue = "";
							String strEachVehicleHeader = "";
							String strActiveDiv = "";
							for(int a=0;a<listOfVehicles.getLength();a++)
								{
									Node nNode1 = listOfVehicles.item(a);
									if (nNode1.getNodeType() == Node.ELEMENT_NODE) 
										{
											Element eElement = (Element) nNode1;
											strEachVehicleHeader = (String)eElement.getTextContent();
											strEachVehicleValue = (String)eElement.getAttribute("value");
										}
									strHiddenDivs += strEachVehicleValue + ",";	
									if(a==0)
										{
											strActiveDiv = strEachVehicleValue;
										}																				
%>
									<li id="<%=strEachVehicleValue%>" onclick="updateVehicleFares(id);">
										<span><%=strEachVehicleHeader%></span>
									</li>
<%
								}
%>
					</ul>
			</div>
	<script>
		$(document).ready(function (){	
			hideAllDivs();
			showDiv("<%=strActiveDiv%>");
		});
		function hideAllDivs()
			{
				var hiddenDivs = "<%=strHiddenDivs%>";
				var arr = hiddenDivs.split(",");
				for(var i=0;i<arr.length;i++)
					{
						if(arr[i] != '')
							{
								$("."+arr[i]).hide();
								$("#"+arr[i]).removeClass("active");
							}
					}
			}
		function showDiv(val)
			{
				$("."+val).show();
				$("#"+val).addClass("active");
			}
	</script>
			<div id="fares-right" class="fares-right">
<%
							String strEachVehicleBaseFare = "";
							String strEachVehicleFarePerKM = "";
							String strEachVehicleWaitingCharge = "";
							String strEachVehicleFreeWaitingHours = "";
							String strEachVehicleNightHoldingCharges = "";
							for(int a=0;a<listOfVehicles.getLength();a++)
								{
									Node nNode1 = listOfVehicles.item(a);
									if (nNode1.getNodeType() == Node.ELEMENT_NODE) 
										{
											Element eElement = (Element) nNode1;
											strEachVehicleValue = (String)eElement.getAttribute("value");
											strEachVehicleBaseFare = (String)eElement.getAttribute("basefare");
											strEachVehicleFarePerKM = (String)eElement.getAttribute("fareperkm");
											strEachVehicleWaitingCharge = (String)eElement.getAttribute("waitingfare");
											strEachVehicleFreeWaitingHours = (String)eElement.getAttribute("freewaitinghours");
											strEachVehicleNightHoldingCharges = (String)eElement.getAttribute("nightholdingfare");
										}
%>
									<div class="<%=strEachVehicleValue%>" id="<%=strEachVehicleValue%>">
										<table border=1>
											<tr>
												<td>Base Price</td>
												<td class="value"><b>Rs. <%=strEachVehicleBaseFare%></b></td>
											</tr>
											<tr>
												<td>Price Per Kilometer</td>
												<td class="value"><b>Rs. <%=strEachVehicleFarePerKM%></b></td>
											</tr>
											<tr>
												<td>Waiting Charges per minute(If it exceeds <span style="color:#fff"><b><%=strEachVehicleFreeWaitingHours%></b></span> Hrs)</td>
												<td class="value"><b>Rs. <%=strEachVehicleWaitingCharge%></b></td>
											</tr>
											<tr>
												<td>Night Holding Charges</td>
												<td class="value"><b>Rs. <%=strEachVehicleNightHoldingCharges%></b></td>
											</tr>
										</table>
									</div>	
<%										
								}			
%>				
			</div>
	</div>
<br><br><br><br><br>	
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
</body>
</html>