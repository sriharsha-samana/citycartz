<%@ page import="java.io.*" %>
<%@ page import="SendSMS.Java_Sms"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="DatabaseActions.*" %>
<%@ page import="FileActions.*" %>
<%@ page import="SendEMAIL.*"%>
<%
boolean finalsmsstatus=false;
boolean logfilestatus=false;
boolean databasestatus=false;
String strPrimaryKey=null;
String senderemail="shadowagent@citycartz.com";
String receiveremail="support@citycartz.com";
String adminsmsdetails;
String clientsmsdetails;
String adminmobile="9406920009";
String status="Received";
String statusvalue=null;
String strDatabaseTableName = "bookingdetails";
String appFolder =  getServletContext().getRealPath("/");
File dbFile= new File(appFolder);
String strApplicationPath = dbFile.toURL().toString();
strApplicationPath = strApplicationPath.substring(strApplicationPath.indexOf("file:/")+6, strApplicationPath.length());
DatabaseOperations dbop = new DatabaseOperations();
UniqueIDgeneration uid= new UniqueIDgeneration();
String UniqueT_id= uid.getUniqueId();
String[] DatabaseTableFields = dbop.GetColumnNames(strDatabaseTableName);
int size=DatabaseTableFields.length;
String[] DatabaseTableValues = new String[size];
String clientmobile=null;
for(int i=0;i<size;i++)
{
	if(DatabaseTableFields[i].equalsIgnoreCase("UNIQUET_ID"))
	{
		DatabaseTableValues[i] = UniqueT_id;
		strPrimaryKey=UniqueT_id;
	}
	else
	{
		DatabaseTableValues[i] = request.getParameter(DatabaseTableFields[i]);
		if(DatabaseTableFields[i].equalsIgnoreCase("MOBILE"))
		{
			clientmobile = request.getParameter(DatabaseTableFields[i]);
		}
	}
}
// STORE BOOKINGDETAILS IN DATABASE
statusvalue=dbop.AddNewBookingEntry(strDatabaseTableName, DatabaseTableFields,DatabaseTableValues);
if(statusvalue.equals("true"))
{
	 databasestatus = true;
}
else
{
	// WRITE INTO A LOG FILE 	
	WriteToLogFile wtlf= new WriteToLogFile();
	String formatString = "\n";
	formatString +="BOOKING DETAILS ARE NOT STORED IN THE DATABASE.\r\nTHE DETAILS ARE:\r\n";
 	for(int j=0;j<DatabaseTableFields.length;j++)
	{
		formatString += DatabaseTableFields[j] + " : " +  DatabaseTableValues[j] + "\r\n";
	}
	logfilestatus=wtlf.writetologfile(appFolder+"/LogFiles/confirm_order_logFile.txt",formatString);
	if(logfilestatus)
    {
 	   databasestatus=true;
    }
	else
	{
		databasestatus=false;
	}
}
      if(databasestatus)
      {    	  
    	  // SEND EMAIL TO ADMIN SAYING BOOKING CONFIRMED	  
    	  String subject="NEW BOOKING RECEIVED";
		  String data="New Booking has been received. The Details are:\r\n";
		  for(int j=0;j<DatabaseTableFields.length;j++)
			{
				data += DatabaseTableFields[j] + " : " +  DatabaseTableValues[j] + "\r\n";
			}
		  Java_Email jmail= new Java_Email();
		  boolean emailstatus=jmail.sendEmail("Admin", senderemail,receiveremail, subject, data);   	  
         // SEND SMS TO CLIENT AND ADMIN SAYING BOOKING CONFIRMED
   Java_Sms sms= new Java_Sms();
   adminsmsdetails=sms.formatsms("admin",DatabaseTableFields,DatabaseTableValues);
   boolean smsstatusadmin = false;
   if(!adminsmsdetails.equalsIgnoreCase("NoFormatAvailable"))
   {
	 smsstatusadmin = sms.sendsms(adminmobile,adminsmsdetails);
   }
   clientsmsdetails=sms.formatsms("client",DatabaseTableFields,DatabaseTableValues);
   boolean smsstatusclient = false;
   if(!clientsmsdetails.equalsIgnoreCase("NoFormatAvailable"))
		   {
	 			smsstatusclient = sms.sendsms(clientmobile,clientsmsdetails);
		   }
   if(!smsstatusclient)
  {
	  // SECOND TRY
	  boolean smsstatusclient1= false;
	  smsstatusclient1= sms.sendsms(clientmobile,clientsmsdetails);
	  if(!smsstatusclient1)
	  { 
		  //SEND EMAIL TO ADMIN SAYING SMS TO CLIENT FAILED
		   subject="SMS FAILED TO CLIENT";
		   data="SMS to client"+clientmobile+"has been failed. Details are Stored in Log File.Details are\r\n";
		  data+=clientsmsdetails;
		  emailstatus=jmail.sendEmail("Admin", senderemail,receiveremail, subject, data);
			// WRITE INTO A LOG FILE 	
			WriteToLogFile wtlf= new WriteToLogFile();
			String formatString = "\n";
			formatString +="SMS NOT SENT TO CLIENT.\r\nTHE DETAILS ARE:\r\n";
			for(int j=0;j<DatabaseTableFields.length;j++)
			{
				formatString += DatabaseTableFields[j] + " : " +  DatabaseTableValues[j] + "\r\n";
			}
			logfilestatus=wtlf.writetologfile(appFolder+"/LogFiles/client_sms_maindetails_logFile.txt",formatString);
		                                     	if(!logfilestatus)
			                                         {
		                                     		// DELETE STORED VALUE FROM DATABASE 
		                                     	String dbstatus = dbop.DeleteExistingEntry("bookingdetails", strPrimaryKey);
%>
		<script>
		  alert("Sorry. Something Went Wrong, Please Try Again");
		  window.open("Home","_self");
		</script>
<%
		                                             }
			                                         else       
			                                         {
                                                      smsstatusclient = true;
			                                         }
	                                }
                             }
	                    if(!smsstatusadmin)
	                            {
		                           //SEND EMAIL TO ADMIN SAYING SMS TO ADMIN FAILED
                                    subject="SMS FAILED TO ADMIN";
		                            data="SMS to admin"+adminmobile+"has been failed. Details are\r\n";
		                           data+=adminsmsdetails;
		                           emailstatus=jmail.sendEmail("Admin", senderemail,receiveremail, subject, data);
		                                  if(emailstatus)
		                                         {
		                                         	 smsstatusadmin=true;
		                                         }
		                                       else
		                                         {
			                                         smsstatusadmin=true;
		                                         }
	                           }
	                  if(smsstatusclient && smsstatusadmin)
	                             {
		                         finalsmsstatus=true;
	                             }
      }
      else
      {    
%>    	 
                                                         <script>
		                                     			  alert("Sorry. Something Went Wrong, Please Try Again");
		                                     			  window.open("Home","_self");
		                                     			</script>     
<%
      }
      if(finalsmsstatus&&databasestatus)
      {
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
	<!-- start-smooth-scrolling -->
<link rel="icon" type="image/png" href="favicon-32x32.png" sizes="32x32">
</head>
<body onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">
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
					<li><a href="fares.html">ESTIMATE PRICE</a></li>	
					<li><a class="active"  href="Book">SHIFT NOW</a></li>
					<li><a href="TrackOrder">TRACK ORDER</a></li>
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
<!-- 404 -->
<div class="confirmation-page">
	<div class="container">
		<div class="confirmation-info">
			<h4> BOOKING HAS BEEN RECORDED.</h4>
			<p> Transaction Id : <%=UniqueT_id%></p>
			<p> YOU WILL RECEIVE A CONFIRMATION SMS WITH VEHICLE NUMBER, DRIVER DETAILS AND PICK UP TIME IN FEW MOMENTS</p>
			<div class="home-page"><a href="Home">HOME PAGE</a></div>
		</div>
	</div>
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
</html>	
<%
}
else{
%>
	<script>
	alert("Sorry. Something Went Wrong, Please Try Again");
		window.open("Home","_self");
	</script>
<%		  
}
%>