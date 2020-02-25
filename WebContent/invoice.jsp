<!DOCTYPE html>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
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
<%
boolean flag=false;
String strUniqueId= "";
String strCustName="";
String strMobile="";
String strBookingDate="";
String strOrigin="";
String strDestination="";
String strVehicleTypeLabel="";
String strBaseFare="";
String strChargePerKm= "";
String strActualDistance="";
String strChargeforActualDistance="";
String strWaitingTime="";
String strWaitingChargePerMin="";
String strFreeWaitingHours="";
String strTotalWaitingCharges="";
String strNightHoldingCharges="";
String strCouponCode = "-";
String strDiscount="";
String strTotalFare="";
String strOrderNumber = request.getParameter("value");
String strVehicleType="";
String strWaitingCharge="";
String strFarePerKm="";
DatabaseOperations dopt=new DatabaseOperations();
String strWhere= "UNIQUET_ID='"+strOrderNumber+"'";
CachedRowSet crs=dopt.fetchDataFromDB("bookingdetails",null,strWhere );
CachedRowSet crsnew = dopt.fetchDataFromDB("bookingdetailsfinal",null,strWhere);
 if(crs.next())
 {
  strVehicleType = crs.getString("VEHICLE_TYPE");
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
    	if(eElement.getAttribute("value").equals(strVehicleType))
    	{
    		strWaitingCharge = eElement.getAttribute("waitingfare");
    	      strFarePerKm= eElement.getAttribute("fareperkm");
    	      strBaseFare=eElement.getAttribute("basefare");
    	      strFreeWaitingHours=eElement.getAttribute("freewaitinghours");
    	}
    }
}
crs.beforeFirst();
if(crs.next()&&crsnew.next())
{
	 strUniqueId= strOrderNumber;
	 strCustName=crs.getString("CUST_NAME");
     strMobile=crs.getString("MOBILE");
     strBookingDate=crs.getString("DATE_TIME_PICKUP");
	 strOrigin=crs.getString("ORIGIN");
	 strDestination=crs.getString("DESTINATION");
	 strVehicleTypeLabel=crs.getString("VEHICLE_TYPE_LABEL");
	 strChargePerKm= strFarePerKm;
	 strActualDistance=crsnew.getString("ACTUAL_DISTANCE");
	 int intChargePerKm = Integer.parseInt(strChargePerKm);
	 int intActualDistance = Integer.parseInt(strActualDistance);
	 int intChargeforActualDistance= intChargePerKm*intActualDistance;
	 strChargeforActualDistance= Integer.toString(intChargeforActualDistance);
	 strFreeWaitingHours=strFreeWaitingHours;
	 strWaitingTime=crsnew.getString("WAITING_TIME");
	 strWaitingChargePerMin=strWaitingCharge;
	 strTotalWaitingCharges=crsnew.getString("WAITING_CHARGES");
	 strNightHoldingCharges=crsnew.getString("NIGHTHOLDING_CHARGES");
	 strDiscount=crsnew.getString("DISCOUNT");
	 strTotalFare=crsnew.getString("TOTAL_FARE");
}
%>
<html>
<head>
<title>CityCartz - Your Shifting Partner</title>
<link href="css/booking.min.css" rel="stylesheet" type="text/css" media="all"/>
<link href="css/invoice.min.css" rel="stylesheet" type="text/css" media="all" />
<!--fonts-->
		<link href='http://fonts.googleapis.com/css?family=Sintony:700,400' rel='stylesheet' type='text/css'>
		<link href='http://fonts.googleapis.com/css?family=Lato:100,300,400,700,900,100italic,300italic,400italic,700italic,900italic' rel='stylesheet' type='text/css'>
	<!--//fonts-->
   <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" media="all" />
   <!-- for-mobile-apps -->
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="Econimical Logistic Services">
		<meta name="keywords" content="Shifting,Transport,Logistics,City,Cart,Logistic,Shift,Delivery,Luggage">
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
			</script>
			<script src="http://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.2/modernizr.js"></script>
			<script>
			function printpage()
			{
				window.print();
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
 <body>
 <div class="se-pre-con"></div>
    <div class="invoice-page">
        <div class="subpage">
        <div class="invoice-top">
             <div class="invoice-logo">
                  <img src="images/logo-min.png"></img>
             </div>
              <div class="invoice-number">
                     <table>
                     <tr>
                         <td class="invoice-label">Invoice No.</td><td class="dot">:</td><td><b><%=strOrderNumber%></b></td>
                     </tr>
                     <tr>
                         <td class="invoice-label">Date</td><td class="dot">:</td> <td class="date" id="date"><%= new java.util.Date() %></td>
                     </tr>
                     </table>
              </div>
            </div>
              <div class="invoice-middle">
               <div class="invoice-header">
                      <h3>CITYCARTZ</h3>
               </div>
                 <div class="invoice-header-bottom">
                     <h5><%=strCustName%></h5>
                 </div>
              </div>
                 <div class="invoice-total-fare">
                         <h4>Total Fare</h4>
                         <h3>&#8377&nbsp;<%=strTotalFare%></h3>
                         <h5>Total Distance: <%=strActualDistance %> Km</h5>
                         <h5>Total Waiting Time: <%=strWaitingTime %> Mins</h5>
                 </div>
                <div class="breakups">
                <div class="fare-breakup">
                <table border=2> 
                    <th colspan=2>FARE BREAKUP</th>
                   <tr>
                     <td align="left">Base Price:</td>
                     <td align="center" >&#8377&nbsp;<%=strBaseFare%></td>
                   </tr>
                   <tr>
                     <td align="left">Price for <%=strActualDistance%> Km:</td>
                     <td align="center">&#8377&nbsp;<%=strChargeforActualDistance %></td>
                   </tr>
                  <!--   <tr>
                      <td align="left">Free Wait Time(<%=strFreeWaitingHours %> hrs) </td>
                      <td align="center">&#8377&nbsp;0.0</td>
                      </tr>-->
                   <tr>
                      <td align="left">Wait Time Charge for <%=strWaitingTime%>min:</td>
                      <td align="center">&#8377&nbsp;<%=strTotalWaitingCharges %></td>
                   </tr>
                   <tr> 
                      <td align="left">NightHolding Charges:</td>
                      <td align="center">&#8377&nbsp;<%=strNightHoldingCharges %> </td>
                   </tr> 
                </table>
              </div> 
              <div class="booking-breakup">
                 <table border=2> 
                    <th colspan=2>BOOKING DETAILS</th>
                   <tr>
                     <td align="left">Vehicle Type:</td>
                     <td align="center" ><%=strVehicleTypeLabel%></td>
                   </tr>
                   <tr>
                     <td align="left">Date Of PickUp:</td>
                     <td align="center"><%=strBookingDate%></td>
                   </tr>
                   <tr>
                      <td align="left">Origin:</td>
                      <td align="center"><%=strOrigin %></td>
                   </tr>
                   <tr>
                      <td align="left">Destination:</td>
                      <td align="center"><%=strDestination%></td>
                   </tr>
                </table>
              </div>  
        </div>    
         <div class="invoice-bottom1">
             <div class="invoice-company-data">
             <br> <p><br>Minimum bill of &#8377&nbsp;<%=strBaseFare%> for booking <%=strVehicleTypeLabel %>. Wait time charges at &#8377&nbsp;<%=strWaitingCharge%> per min after first <%=strFreeWaitingHours %> hrs, includes waiting time during the trip.</p>
              <p>Total fare is inclusive of all taxes. Toll and parking charges are extra.</p>
              <p>For further queries, please write to <a>support@citycartz.com</a></p>
              <p>This is an electronically generated invoice and does not require signature. All terms and conditions are as given on www.citycartz.com.</p>
             </div>     
    </div> 
        <div class="invoice-footer">
         <p>606-2B, HDIL Dreams, Bhandup, Mumbai, Maharashtra.Tel:+91-9406920009.</p>
        </div>
        <div class="invoice-footer-bottom">
              <p>Thank You For Choosing CityCartz</p>
              </div>
               <div class="invoice-download-button">
             <input type="button" value="Print Invoice" onclick="printpage();"></input>
           </div>
</div>
 </div>    
</body>
</html>