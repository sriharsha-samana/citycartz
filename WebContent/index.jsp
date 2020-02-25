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
	<title>CityCartz : India's Best Logistic Services | Packing, House Shifting and Luggage Delivery Services</title>
	<link href="css/style.min.css" rel="stylesheet" type="text/css" media="all" />
	<link href="css/booking.min.css" rel="stylesheet" type="text/css" media="all" />
	<!--fonts-->
		<link href='http://fonts.googleapis.com/css?family=Sintony:700,400' rel='stylesheet' type='text/css'>
		<link href='http://fonts.googleapis.com/css?family=Lato:100,300,400,700,900,100italic,300italic,400italic,700italic,900italic' rel='stylesheet' type='text/css'>
	<!--//fonts-->
		<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" media="all" />
	<!-- for-mobile-apps -->
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="keywords" content="Tension Free,Shifting,Transport,Logistics,City,Carts,Delivery,Luggage,Packers and Movers,Online Shifting">
		<meta name="description" content="Citicartz has now made Logistics simple, easy, convenient and just a click away. CALL US: +91-9406920009">
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
			</script>
			<script src="http://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.2/modernizr.js"></script>
			<script>
					$(window).load(function() {
						// Animate loader off screen
						$(".se-pre-con").fadeOut("slow");
					});
			</script>
		<script src="http://maps.googleapis.com/maps/api/js?sensor=false&amp;libraries=places"></script>
		<script src="js/jquery.geocomplete.js"></script>
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
				hideTrackOderForm();
				hideFeedbackForm();
				hideRegistrationForm();
				hideBookingForm();
				$('.feedback-button').hide();
				$('.track-order-index').show("slow");
				$(".banner .container > :not(.track-order-index)").css("opacity","0.3");
				
				if($(window).width() < 840){
				$( "ul.nav1" ).slideToggle( 300, function() {
					 // Animation complete.
					});
				}
			}
			function hideTrackOderForm()
			{
				$('.track-order-index').hide("slow");
				$(".banner .container > :not(.track-order-index)").css("opacity","1");
				$('.feedback-button').show();
			}
			function showFeedbackForm()
			{
				hideTrackOderForm();
				hideFeedbackForm();
				hideRegistrationForm();
				hideBookingForm();
				$('.feedback-button').hide();
				$('.feedback-form').show("slow");
				$(".banner .container > :not(.feedback-form)").css("opacity","0.3");
			}
			function hideFeedbackForm()
			{
				$('.feedback-form').hide("slow");
				$(".banner .container > :not(.feedback-form)").css("opacity","1");
				$('.feedback-button').show();
			}
			function showBookingForm()
			{
				hideTrackOderForm();
				hideFeedbackForm();
				hideRegistrationForm();
				hideBookingForm();
				$('.feedback-button').hide();
				$('.booking-form-hidden').show("slow");
				$(".banner .container > :not(.booking-form-hidden)").css("opacity","0.3");
				
			}
			function hideBookingForm()
			{
				$('.booking-form-hidden').hide("slow");
				$(".banner .container > :not(.booking-form-hidden)").css("opacity","1");
				$('.feedback-button').show();
			}
			function showRegistrationForm()
			{
				hideTrackOderForm();
				hideFeedbackForm();
				hideRegistrationForm();
				hideBookingForm();
				$('.feedback-button').hide();
				$('.register-form-hidden').show("slow");
				$(".banner .container > :not(.register-form-hidden)").css("opacity","0.3");
			}
			function hideRegistrationForm()
			{
				$('.register-form-hidden').hide("slow");
				$(".banner .container > :not(.register-form-hidden)").css("opacity","1");
				$('.feedback-button').show();
			}
			$(document).ready(function(){$('.track-order-index').hide();});
			$(document).ready(function(){$('.feedback-form').hide();});
</script>
<link rel="icon" type="image/png" href="favicon-32x32.png" sizes="32x32">
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
					<li><a class="active" href="Home">HOME</a></li>
					<li><a href="About">ABOUT US</a></li>
					<li><a href="Fares">ESTIMATE PRICE</a></li>	
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
<!-- //header -->
	<div title="Click here to give feedback" onclick="showFeedbackForm();" class="feedback-button">
		FEEDBACK
	</div>
	<!-- banner -->
<div class="banner">
	<div class="container">
	<div class="track-order-index">
		<span class="track-order-index-close" onclick="hideTrackOderForm();"><img src="images/close.png" alt="Close"/></span>
		<form name="trackorder" method="post" action="TrackOrderDisplay">
	    		<input type="text" name="transactionid" id="transactionid" placeholder=" Enter Unique Transaction Id" required autocomplete="off"></input>
				<input type="submit" value="CHECK">
		 </form>
	</div>
	<div id="feedback-form" class="feedback-form">
		<span class="feedback-form-close" onclick="hideFeedbackForm();"><img src="images/close.png" alt="Close"/></span>
		<form name="feedback" method="post" action="Feedback">
				<input type="text" name="username" id="username" placeholder="Name" required>
	    		<input type="email" name="useremail" id="useremail" placeholder="Email" required>
	    		<textarea name="userfeedback" placeholder="Message"></textarea>
	    		<!-- <textarea placeholder="Message"></textarea>-->
				<input type="submit" value="SUBMIT">
		 </form>
	</div>	
	<div class="register-form-hidden">
		<div class="register-form-hidden-close" onclick="hideRegistrationForm();"><img src="images/close.png" alt="Close"></div>	
			<form name= "register" id ="register" method="post" action="Register">
				<input type="text" name="cust_name" id="cust_name" value="" placeholder=" NAME " required autocomplete="off"/>
				<input type="email" name="cust_email" id="cust_email" value="" placeholder=" EMAIL " required autocomplete="off"/>
				<input type="text" name="cust_mobile" id="cust_mobile" value="" placeholder=" MOBILE (Optional) " pattern="[789][0-9]{9}" autocomplete="off"/>
				<input type="submit" name="cust_register_submit" id="cust_register_submit" value="REGISTER"/>
			</form>
	</div>
				<div class="booking-form-hidden">
				<div class="booking-form-hidden-close" onclick="hideBookingForm();"><img src="images/close.png" alt="Close"></div>	
				<form name= "booking" id ="booking" method="post" action="PreConfirm">
					<input id="custname" name="custname" type="text" placeholder="  Name " pattern="^[a-zA-Z\s]+$" required>
					<input id="contactnum" name="contactnum" type="text" placeholder="  Contact Number" pattern="[789][0-9]{9}" required>
					<input id="DateTime" name="DateTime" type="text" placeholder="  Date and Time" required readonly>
					<select id="vehicletype" name="vehicletype" required>
							<option value="">--Select vehicle--</option>
<%
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
										}
%>
											<option value="<%=strEachVehicleValue%>"><%=strEachVehicleHeader%></option>
<%
								}
%>
						</select>
				    	<input id="pac-input-from" name="pac-input-from" type="text" placeholder="  From landmark" required/>
						<input id="pac-input-to" name="pac-input-to" type="text" placeholder="  To landmark" required>
						<input type="submit" value="BOOK ORDER"/>
					</form>
					</div>
					<div class="booking-form-info">
					
								<h1>SHIFT YOUR WAY <info class="hiddenInfo"><span class="normal">&#9742; Call us : </span><span class="orange">1800 2000 949 </span></info></h1>
								
								<ul class="hiddenInfo">
									<li><h2>Best Domestic Relocation Services</h2></li>
									<li><h2>Low Budget, Secure Shifting and Delivery Services</h2></li>
									<li><h2>Mumbai's best Intracity Packers and Movers</h2></li>
								</ul>
								
					<div class="booking-form-submit-index">
						<input type="button" onclick="showBookingForm();" value="SHIFT NOW"/>
					</div>
					</div>
	</div>
</div>
<!-- //banner -->
<!-- banner-bottom -->
	<div class="advertise">
		<div class="container">
			<div class="ad-info"><span class="highlight">FLAT 40% DISCOUNT</span> <br><span>VALID FOR ORDERS BEFORE 25-07-2015</span></div>
			<div class="login-info"> <div onclick="showRegistrationForm();" class="register-button"><a>REGISTER</a></div> <div class="register-info"><span>WITH US TODAY FOR <span class="highlight">10%</span> EXTRA DISCOUNT</span></div></div>
			<div class="contact-info"><span>&#9742; CALL US: </span><br><span class="highlight">1800 2000 949 </span></div>
		</div>
	</div>
	<div class="banner-bottom-header">
		<div class="container">
			<h3>OUR SERVICES</h3>
		</div>
	</div>
<div class="banner-bottom">
	<div class="container">
		<!-- responsiveslides -->
					<script src="js/responsiveslides.min.js"></script>
						<script>
							// You can also use "$(window).load(function() {"
							$(function () {
							 // Slideshow 4
							$("#slider3").responsiveSlides({
								auto: true,
								pager: true,
								nav: false,
								speed: 1000,
								namespace: "callbacks",
								before: function () {
							$('.events').append("<li>before event fired.</li>");
							},
							after: function () {
								$('.events').append("<li>after event fired.</li>");
								}
								});
								});
					</script>
		<!-- responsiveslides -->
		<div  id="top" class="callbacks_container">
					<ul class="rslides" id="slider3">
<%
						NodeList listOfServices = doc.getElementsByTagName("service");
						String strEachHeader = "";
						String strEachMessage = "";
						String strEachImageURL = "";
						for(int i=0;i<listOfServices.getLength();)
							{
%>
						<li>
							<div class="bottom-grids">
<%
									for(int j=0;j<4;j++)
										{
											Node nNode = listOfServices.item(i);
											if (nNode.getNodeType() == Node.ELEMENT_NODE) 
												{
													Element eElement = (Element) nNode;
													strEachHeader= (String)eElement.getAttribute("header");
													strEachMessage= (String)eElement.getTextContent();
													strEachImageURL = (String)eElement.getAttribute("imageURL");
%>
											<div class="bottom-grid">
												<img src="<%=strEachImageURL%>" alt=""/>
												<div class="bottom-info">
													<h3><%=strEachHeader%></h3>
													<p><%=strEachMessage%></p>
												</div>
												<div class="bottom-pos a"></div>
											</div>
<%
												}
											i++;
										}
%>										
								<div class="clearfix"></div>
							</div>
						</li>
<%
							}
%>
					</ul>
		</div>
	</div>
	<br><br>
</div>
<div class="article">
	<div class="container">
		<h3>HOW WE WORK?</h3>
	</div>
</div>
<!-- //article -->
<!-- portfolio -->
<div class="article-grids">
<%
				NodeList listOfDomains = doc.getElementsByTagName("flow");
				String strEachDomainHeader = "";
				String strEachDomainImageURL = "";
				for(int b=0;b<listOfDomains.getLength();b++)
					{
						Node nNode1 = listOfDomains.item(b);
						if (nNode1.getNodeType() == Node.ELEMENT_NODE) 
							{
								Element eElement = (Element) nNode1;
								strEachDomainHeader = (String)eElement.getTextContent();
								strEachDomainImageURL = (String)eElement.getAttribute("imageURL");
							}
%>
	<div class="col-md-2 article-grid">
		<img src="<%=strEachDomainImageURL%>" alt=""/>
		<div class="article-info">
			<p><%=strEachDomainHeader%></p>
		</div>
	</div>
<%
					}
%>		
</div>
	<div class="clearfix"></div>
<!-- </div>-->
<!-- //article -->
<!-- //banner-bottom -->
<!-- slider-bottom -->
<div class="slider-bottom">
	<div class="container">
		<div class="slider-grids">
			<div class="col-md-6 slider-grid">
				<span class="col-md-6-header">SAY HELLO TO CITYCARTZ</span>
<%
						NodeList listOfParas = doc.getElementsByTagName("whycitycartzleft");
						String strEachPara = "";
						for(int j=0;j<listOfParas.getLength();j++)
							{
								Node nNode1 = listOfParas.item(j);
								if (nNode1.getNodeType() == Node.ELEMENT_NODE) 
									{
										Element eElement = (Element) nNode1;
										strEachPara = (String)eElement.getTextContent();
%>
					<div class="col-md-6-header-para"><p><%=strEachPara%></p></div>
<%
									}
							}
%>
			</div>
			<div class="col-md-6 slider-grid">
<%
						listOfParas = doc.getElementsByTagName("whycitycartzright");
						strEachPara = "";
						for(int k=0;k<listOfParas.getLength();k++)
							{
								Node nNode2 = listOfParas.item(k);
								if (nNode2.getNodeType() == Node.ELEMENT_NODE) 
									{
										Element eElement = (Element) nNode2;
										strEachPara = (String)eElement.getTextContent();
%>
				<div class="col-md-6-header-para"><p>
					<%=strEachPara%>
				</p></div>
<%
									}
							}
%>
			</div>
			<div class="clearfix"></div>
				<div class="col-md-6-read-more-button"><a href="About">READ MORE</a></div>
		</div>
	</div>
</div>
<!-- //slider-bottom -->
<div class="article">
		<div class="container">
			<a href="#"><h3>WHAT OUR CLIENTS SAY?</h3></a>
		</div>
</div>
<!-- slider -->
<div class="second-slider">
	<div class="container">
<!-- Thoughts -->
		<!-- responsiveslides -->
					<script src="js/responsiveslides.min.js"></script>
						<script>
							// You can also use "$(window).load(function() {"
							$(function () {
							 // Slideshow 4
							$("#slider4").responsiveSlides({
								auto: true,
								pager: false,
								nav: true,
								speed: 500,
								namespace: "callbacks",
								before: function () {
							$('.events').append("<li>before event fired.</li>");
							},
							after: function () {
								$('.events').append("<li>after event fired.</li>");
								}
								});
								});
					</script>
				<!-- responsiveslides -->
		<div  id="top" class="callbacks_container">
					<ul class="rslides" id="slider4">
<%
						NodeList listOfReviews = doc.getElementsByTagName("review");
						String strEachReview = "";
						String strEachUser= "";
						String strEachDate= "";
						for(int i=0;i<listOfReviews.getLength();i++)
							{
								Node nNode = listOfReviews.item(i);
								if (nNode.getNodeType() == Node.ELEMENT_NODE) 
									{
										Element eElement = (Element) nNode;
										strEachReview = (String)eElement.getTextContent();
										strEachUser = (String)eElement.getAttribute("user");
										strEachDate = (String)eElement.getAttribute("date");
%>
								<li>
									<div class="sec-slid-info">
										<h3 style="font-family:'Gill Sans MT Condensed';">"<%=strEachReview%>"</h3>
										<p><%=strEachUser%> - <span style="font-size:12px;color:#63c6ae;"><%=strEachDate%></span></p>
									</div>
								</li>
<%
									}
							}
%>
					</ul>
		</div>
	</div>
</div>	
<!-- //slider -->
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
<link rel="stylesheet" type="text/css" href="css/jquery.datetimepicker.css"/>
<script src="js/jquery.datetimepicker.js"></script>
<script>
var dateToday = new Date();    
var date=dateToday.getDate();
var day= dateToday.getDay();
var month= dateToday.getMonth() +1;
var fullYear = dateToday.getFullYear();
var hours= dateToday.getHours();
var minutes=dateToday.getMinutes();
var newdate = fullYear+"/0"+month+"/"+date+" "+hours+":"+minutes;
$('#DateTime').datetimepicker({
	step: 15,
	closeOnWithoutClick :true,
	validateOnBlur:false,
	theme:'dark',
	minDate:dateToday,
	minTime:dateToday,
	defaultDate:0,
	todayButton:true,
	timepickerScrollbar:true,
	todayButton:true,
	onChangeDateTime:
		function(dp,$input)
		{
	    if($input.val()!=newdate)
	    	{
	    	this.setOptions({
	    	      minTime:'00:00'
	    	    });
	    	}
	    else
	    	{
	    	this.setOptions({
	    	      minTime:dateToday
	    	    });
	    	}
	    },
});
</script>
</html>								
