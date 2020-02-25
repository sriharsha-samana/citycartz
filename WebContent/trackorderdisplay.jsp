<!DOCTYPE html>
<%@ page import="java.io.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DatabaseActions.*" %>
<%@ page import="javax.sql.rowset.CachedRowSet" %>
<%@ page import="javax.sql.rowset.RowSetProvider" %>
<%@ page import="javax.xml.parsers.DocumentBuilder" %>
<%@ page import="javax.xml.parsers.DocumentBuilderFactory" %>
<%@ page import="org.w3c.dom.Document" %>
<%@ page import="org.w3c.dom.NodeList" %>
<%@ page import="org.w3c.dom.Node" %>
<%@ page import="org.w3c.dom.Element" %>
<html>
<%
    String strOrderNumber = request.getParameter("transactionid");
    DatabaseOperations dopt=new DatabaseOperations();
    String strWhere= "UNIQUET_ID='"+strOrderNumber+"'";
    String vehicletype="";
    String waitingcharge="";
    String fareperkm="";
    CachedRowSet crs=dopt.fetchDataFromDB("bookingdetails",null,strWhere );
    CachedRowSet crsnew = dopt.fetchDataFromDB("bookingdetailsfinal",null,strWhere);
   if(crs.next())
   {
	   crs.beforeFirst();
    if(crs.next())
    {
     vehicletype = crs.getString("VEHICLE_TYPE");
    }
	String appFolder =  getServletContext().getRealPath("/");
	File file = new File(appFolder+"/dynamicData/dynamicData.xml");
	DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
	DocumentBuilder db = dbf.newDocumentBuilder();
	Document doc = db.parse(file);
	NodeList nList = doc.getElementsByTagName("vehicle");
	for (int temp = 0; temp < nList.getLength(); temp++) {
        Node nNode = nList.item(temp);
        if (nNode.getNodeType() == Node.ELEMENT_NODE) {
        	Element eElement = (Element) nNode; 
        	if(eElement.getAttribute("value").equals(vehicletype))
        	{
        	      waitingcharge = eElement.getAttribute("waitingfare");
        	      fareperkm= eElement.getAttribute("fareperkm");
        	}
        }
	}
	crs.beforeFirst();
	String strCustName = "Not Updated";
	String strMobile =  "Not Updated";
	String strFrom = "Not Updated";
	String strTo = "Not Updated";
	String strDateTime = "Not Updated";
	String strVehicle = "Not Updated";
	String strChargepPerKm = "Not Updated";
	String strEstimatedDist = "Not Updated";
	String strActualDist = "Not Updated";
	String strTotalWaitingMins = "Not Updated";
	String strWaitingChargePerMin = "Not Updated";
	String strTotalWaitingCharge = "Not Updated";
	String strNightHoldingCharge = "Not Updated";
	String strCouponCode = "Not Updated";
	String strDiscount = "Not Updated";
	String strTotalFare = "Not Updated";
	String strStatus = "Not Updated";
	if(crs.next())
	{
		strCustName = crs.getString("CUST_NAME");
		strMobile =  crs.getString("MOBILE");
		strFrom = crs.getString("ORIGIN");
		strTo = crs.getString("DESTINATION");
		strDateTime = crs.getString("DATE_TIME_PICKUP");
		strVehicle = crs.getString("VEHICLE_TYPE_LABEL");
		strChargepPerKm = fareperkm;
		strEstimatedDist = crs.getString("ESTIMATED_DISTANCE");
		strStatus  = crs.getString("STATUS");
	}
	if(crsnew.next())
		{
				strActualDist = crsnew.getString("ACTUAL_DISTANCE");
				strTotalWaitingMins = crsnew.getString("WAITING_TIME");
				strWaitingChargePerMin = waitingcharge;
				strTotalWaitingCharge = crsnew.getString("WAITING_CHARGES");
				strNightHoldingCharge = crsnew.getString("NIGHTHOLDING_CHARGES");
				strCouponCode = "-";
				strDiscount = crsnew.getString("DISCOUNT");
				strTotalFare = crsnew.getString("TOTAL_FARE");
				strStatus = crsnew.getString("STATUS");
		}
				List<String> strShiftingInProgressList = new ArrayList<String>();
				strShiftingInProgressList.add("Driver Details Sent");
				strShiftingInProgressList.add("Driver Reached Location");
				strShiftingInProgressList.add("Packing in Progress");
				strShiftingInProgressList.add("Loading in Progress");
				strShiftingInProgressList.add("Security Pass Key Generated");
				strShiftingInProgressList.add("Shifting in Progress");
				strShiftingInProgressList.add("Pass Key Verification Completed");
				strShiftingInProgressList.add("Unloading in Progress");
				List<String> strShiftingCompletedList = new ArrayList<String>();
				strShiftingCompletedList.add("Shifting Completed");
				strShiftingCompletedList.add("Total Fare Details Sent");
				strShiftingCompletedList.add("Payment Pending");
				strShiftingCompletedList.add("Payment Received");
				String strFlowStatus = "";
				if(strStatus.equalsIgnoreCase("Received"))
				{
					strFlowStatus = "Received";
				}
				else if(strStatus.equalsIgnoreCase("Confirmed"))
				{
					strFlowStatus = "Confirmed";
				}
				else if(strShiftingInProgressList.contains(strStatus))
				{
					strFlowStatus = "ShiftingStarted";
				}
				else if(strShiftingCompletedList.contains(strStatus))
				{
					strFlowStatus="ShiftingCompleted";
				}
				else if(strStatus.equalsIgnoreCase("Closed"))
				{
					strFlowStatus = "Closed";
				}
				else if(strStatus.equalsIgnoreCase("Cancelled"))
				{
					strFlowStatus = "Cancelled";
				}
				else
				{
					strFlowStatus = "Received";
				}
%>
<head>
	<title>CityCartz - Your Shifting Partner</title>
	<link href="css/style.min.css" rel="stylesheet" type="text/css" media="all" />
	<link href="css/booking.min.css" rel="stylesheet" type="text/css" media="all" />
	<link href="css/invoice.min.css" rel="stylesheet" type="text/css" media="all"/>
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
			function showInvoiceLink()
			{
				$('.invoice-link').show("slow");
			}
			$('.banner').click(function(){$('.track-order-index').hide();});
			$(document).ready(function()
			{
				$('.track-order-index').hide();
				var status = "<%=strFlowStatus%>";
				$('#'+status).addClass("active");	
			});
		</script>
		<script src="http://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.2/modernizr.js"></script>
			<script>
					$(window).load(function() {
						// Animate loader off screen
						$(".se-pre-con").fadeOut("slow");
					});
			</script>
	<!-- start-smooth-scrolling -->
<link rel="icon" type="image/png" href="favicon-32x32.png" sizes="32x32">
</head>
<body>
<div class="se-pre-con"></div>
<!-- header -->
<div class="header">
		<div class="header-left">
		<a href="Home"><span class="blue">City</span><span class="orange">Cartz</span></a>
	</div>
	<div class="header-right">
		<span class="menu"><img src="images/menu.png" alt=""/></span>
				<ul class="nav1">
					<li><a href="Home">HOME</a></li>
					<li><a href="About">ABOUT US</a></li>
					<li><a href="Fares">ESTIMATE PRICE</a></li>	
					<li><a href="Book">SHIFT NOW</a></li>
					<li><a class="active" style="cursor:pointer" onclick="showTrackOderForm();">TRACK ORDER</a></li>
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
<div class="track-order-display">
	<div class="container">
		<div class="track-order-display-left">
			<div class="track-order-display-left-header">
				Order Summary
			</div>
			<table>
				<tr>
					<td class="form-label">
						Confirmation Id:
					</td>
					<td>
						<%=strOrderNumber%>
					</td>
				</tr>
				<tr>
					<td class="form-label">
						Name:
					</td>
					<td>
						<%=strCustName %>
					</td>
				</tr>
				<tr>
					<td class="form-label">
						Mobile:
					</td>
					<td>
						<%=strMobile %>
					</td>
				</tr>
				<tr>
					<td class="form-label">
						From Landmark:
					</td>
					<td>
						<%=strFrom %>
					</td>
				</tr>
				<tr>
					<td class="form-label">
						To Landmark:
					</td>
					<td>
						<%=strTo %>
					</td>
				</tr>
				<tr>
					<td class="form-label">
						Date & Time:
					</td>
					<td>
						<%=strDateTime %>
					</td>
				</tr>
				<tr>
					<td class="form-label">
						Vehicle:
					</td>
					<td>
						<%=strVehicle %>
					</td>
				</tr>
				<tr>
					<td class="form-label">
						Charge per km:
					</td>
					<td>
						Rs.  <%=strChargepPerKm %>
					</td>
				</tr>
				<tr>
					<td class="form-label">
						Estimated Distance:
					</td>
					<td>
						<%=strEstimatedDist %> 
					</td>
				</tr>
				<tr>
					<td class="form-label">
						Actual Distance:
					</td>
					<td>
						<%=strActualDist %> km
					</td>
				</tr>
				<tr>
					<td class="form-label">
						Waiting time:
					</td>
					<td>
						<%=strTotalWaitingMins %> mins
					</td>
				</tr>
				<tr>
					<td class="form-label">
						Waiting charge(per min charge Rs.<%=strWaitingChargePerMin %>):
					</td>
					<td>
						Rs. <%=strTotalWaitingCharge %>
					</td>
				</tr>
				<tr>
					<td class="form-label">
						Night holding charges:
					</td>
					<td>
						Rs. <%=strNightHoldingCharge %>
					</td>
				</tr>
				<tr>
					<td class="form-label">
						Discount:
					</td>
					<td>
						Coupon:<%=strCouponCode%>
						Rs. <%=strDiscount %>
					</td>
				</tr>
				<tr>
					<td class="form-label">
						Total Fare:
					</td>
					<td>
						Rs. <%=strTotalFare %>
					</td>
				</tr>
			</table>
		</div>
		<div class="track-order-display-right">
			<div class="track-order-display-right-header">
				Order Status
			</div>
			<div class="track-order-display-right-status">
			  <span>Status:</span><input readonly="readonly" type="text" value="<%=strStatus%>"></input>
			</div>
			<div class="track-order-display-right-status-flow">
<%
			if(!strFlowStatus.equalsIgnoreCase("Cancelled"))
				{
%>
					<ul>
						<li>
							<input id="Received" type="text" value="Received" readonly/>
						</li>
						<li>
							<img src="images/down.png" alt="">
						</li>
						<li>
							<input id="Confirmed" type="text" value="Confirmed" readonly/>
						</li>
						<li>
							<img src="images/down.png" alt="">
						</li>		
						<li>
							<input id="ShiftingStarted" type="text" value="Shifting Started" readonly/>
						</li>
						<li>
							<img src="images/down.png" alt="">
						</li>
						<li>
							<input id="ShiftingCompleted" type="text" value="Shifting Completed" readonly/>
						</li>
						<li>
							<img src="images/down.png" alt="">
						</li>
						<li>
							<input id="Closed" type="text" value="Closed" readonly/>
						</li>
					</ul>
<%
				}
				else
				{
%>
					<ul>
						<li>
							<input id="Cancelled" type="text" value="Cancelled" readonly/>
						</li>
					</ul>		
<%					
				}
%>
			</div>
		</div>
		<%
		if(strStatus.equalsIgnoreCase("Payment Received")|| strStatus.equalsIgnoreCase("Closed"))
		{
%>
    <div class="invoice-link">
		<a href="invoice.jsp?value=<%=strOrderNumber%>">Click Here To View Invoice</a>
	</div>
<%
		}
		%>
	</div>
	<br><br><br><br>
</div>
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
<%
}
	else
	{
%>
     <script>
		window.open("TrackOrder","_self");
		</script>
<%		
	}
%>
</html>