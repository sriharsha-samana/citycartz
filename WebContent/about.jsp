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
<link rel="icon" type="image/png" href="favicon-32x32.png" sizes="32x32">
</head>
<body>
<div class="se-pre-con"></div>
<%
		String appFolder =  getServletContext().getRealPath("/");
		File file = new File(appFolder+"/dynamicData/dynamicData.xml");
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		DocumentBuilder db = dbf.newDocumentBuilder();
		Document doc = db.parse(file);
%>
<!-- header -->
<div class="header">
		<div class="header-left">
		<a href="Home"><span class="blue">City</span><span class="orange">Cartz</span></a>
	</div>
	<div class="header-right">
		<span class="menu"><img src="images/menu.png" alt=""/></span>
				<ul class="nav1">
					<li><a href="Home">HOME</a></li>
					<li><a class="active"href="About">ABOUT US</a></li>
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
	<div class="track-order-index">
		<span class="track-order-index-close" onclick="hideTrackOderForm();"><img src="images/close.png" alt="Close"/></span>
		<form name="trackorder" method="post" action="TrackOrderDisplay">
	    		<input type="text" name="transactionid" id="transactionid" placeholder=" Enter Unique Transaction Id" required autocomplete="off"></input>
				<input type="submit" value="CHECK">
		 </form>
	</div>
	<div class="article">
		<div class="container">	
			<h3>SAY HELLO TO CITYCARTZ</h3>
		</div>
	</div>	
<div class="about-us">
	<div class="container">	
			<br>
 <div class="about-us-top">
        <div class="about-us-left">
<%
				NodeList listOfParas = doc.getElementsByTagName("aboutcompanyleft");
						String strEachPara = "";
						for(int j=0;j<listOfParas.getLength();j++)
							{
								Node nNode1 = listOfParas.item(j);
								if (nNode1.getNodeType() == Node.ELEMENT_NODE) 
									{
										Element eElement = (Element) nNode1;
										strEachPara = (String)eElement.getTextContent();
%>
			  <div class="about-us-left-para">  <p><%=strEachPara%></p></div>
<%
									}
							 }
%>
        </div>
        <div class="about-us-right">
            <img src="images/transport.jpg"></img>
        </div>
    </div>
    <div class="about-us-bottom">
        <div class="about-us-row-2-left">
        <img src="images/loadingunloading.jpg"></img>
        </div>
        <div class="about-us-row-2-right">
        <br><br>
        <%
				NodeList listOfParas1 = doc.getElementsByTagName("aboutcompanybottom1");
						String strEachPara1 = "";
						for(int j=0;j<listOfParas1.getLength();j++)
							{
								Node nNode1 = listOfParas1.item(j);
								if (nNode1.getNodeType() == Node.ELEMENT_NODE) 
									{
										Element eElement = (Element) nNode1;
										strEachPara1 = (String)eElement.getTextContent();
%>
			  <div class="about-us-left-para">  <p><%=strEachPara1%></p></div>
<%
									}
							 }
%>
        </div>
      </div>
        <div class="about-us-bottom1">
                  <div class="about-us-row3-left">
        <%
				NodeList listOfParas2 = doc.getElementsByTagName("aboutcompanybottom2");
						String strEachPara2 = "";
						for(int j=0;j<listOfParas2.getLength();j++)
							{
								Node nNode1 = listOfParas2.item(j);
								if (nNode1.getNodeType() == Node.ELEMENT_NODE) 
									{
										Element eElement = (Element) nNode1;
										strEachPara2 = (String)eElement.getTextContent();
%>
			  <div class="about-us-left-para">  <p><%=strEachPara2%></p></div>
<%
									}
							 }
%>
                  </div>
                 <div class="about-us-row3-right">
              <img src="images/customizedservice.jpg"/>
                 </div>
        </div>
            <div class="about-us-bottom2">
                    <div class="about-us-row4">
<%
				NodeList listOfParas3 = doc.getElementsByTagName("aboutcompanybottom3");
						String strEachPara3 = "";
						for(int j=0;j<listOfParas3.getLength();j++)
							{
								Node nNode1 = listOfParas3.item(j);
								if (nNode1.getNodeType() == Node.ELEMENT_NODE) 
									{
										Element eElement = (Element) nNode1;
										strEachPara3 = (String)eElement.getTextContent();
%>
			  <div class="about-us-left-para">  <p><%=strEachPara3%></p></div>
<%
									}
							 }
%>
                    </div>
                    <br><br>
                    <div class="about-us-row-5">
<%
				NodeList listOfParas4 = doc.getElementsByTagName("aboutcompanybottom4");
						String strEachPara4 = "";
						for(int j=0;j<listOfParas4.getLength();j++)
							{
								Node nNode1 = listOfParas4.item(j);
								if (nNode1.getNodeType() == Node.ELEMENT_NODE) 
									{
										Element eElement = (Element) nNode1;
										strEachPara4 = (String)eElement.getTextContent();
%>
			  <div class="about-us-left-para">  <p><%=strEachPara4%></p></div>
<%
									}
							 }
%>
                    </div>  
            </div>
	</div>	
</div>
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