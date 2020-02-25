<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
		<link rel="stylesheet" href="css/login.min.css" type="text/css">
		<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
		<script type = "text/javascript" >
			function preventBack(){window.history.forward();}
			setTimeout("preventBack()", 0);
			window.onunload=function(){null};
		</script>
		<script type = "text/javascript" >
		          function validation()
		          {
		        	  var username= document.getElementById("username").value;
		        	  var password= document.getElementById("password").value;
		        	  if ( username.trim() == "" || password.trim() == "")
		        	  {
		        		  alert("Please enter Username and Password!"); 
		        		  return false;
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
		<title>CityCartz - Your Shifting Partner</title>
    <link rel="icon" type="image/png" href="favicon-32x32.png" sizes="32x32">
	</head>
	<body>
	<div class="se-pre-con"></div>
						 <!-----start-main---->
				<div class="login-form">
			 	<div class="head">
						<!-- <img src="images/logo.png" alt=""/>-->
					</div>
				<form name="LoginForm" method="post" onsubmit="return validation();" action="AdminVerification">
					<p>Admin Login</p>
					<br>
					<br>
					<li>
						<input type="text" class="text" name="username" id="username" placeholder="Username" required><a href="#" class=" icon user" ></a>
					</li>
					<li>
						<input type="password"  name="password" id="password" placeholder="Password" required><a href="#" class=" icon lock" ></a>
					</li>
					<div class="p-container">
								<input type="submit" value="SIGN IN" ">
							<div class="clear"> </div>
					</div>
				</form>
			</div>
			<!--//End-login-form-->
		  <!-----start-copyright---->
   					<div class="copy-right">
						<p><a href="#"></a></p> 
					</div>
				<!-----//end-copyright---->
	</body>
</html>