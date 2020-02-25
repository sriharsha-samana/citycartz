<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.sql.rowset.CachedRowSet" %>
<%@ page import="javax.sql.rowset.RowSetProvider" %>
<%@ page import="java.io.*" %>    
<%@ page import="DatabaseActions.*" %>
<%@ page import="SendEMAIL.*"%>
<%@ page import="SendSMS.Java_Sms"%>
<%@ page import="FileActions.*" %>
<%
if (session == null || session.getAttribute("User") == null || !session.getAttribute("User").equals("Administrator") || !session.getAttribute("security").equals("/'].;[,lp.;[/']']]")) {
%>
		<script>
			window.open("Home","_top");
		</script>
<%
}
%>
<%
boolean logfilestatus=false;
String appFolder =  getServletContext().getRealPath("/");
File dbFile= new File(appFolder);
String strApplicationPath = dbFile.toURL().toString();
strApplicationPath = strApplicationPath.substring(strApplicationPath.indexOf("file:/")+6, strApplicationPath.length());
String clientsmsdetails;
String senderemail="shadowagent@citycartz.com";
String receiveremail="support@citycartz.com";
DatabaseOperations dopt=new DatabaseOperations();
String strDatabaseTable = "bookingdetailsfinal";
String[] DatabaseTableFields = new String[8];
DatabaseTableFields[0]="UNIQUET_ID";
DatabaseTableFields[1]="CUST_NAME";
DatabaseTableFields[2]="ORIGIN";
DatabaseTableFields[3]="DESTINATION";
DatabaseTableFields[4]="ESTIMATED_DATE_TIME_PICKUP";
DatabaseTableFields[5]="DRIVER_NAME";
DatabaseTableFields[6]="VEHICLE_NUMBER";
DatabaseTableFields[7]="SECURITY_KEY";
String[] DatabaseTableValues = new String[8];
String fareField[]=new String[1];
String fareValue[]=new String[1];
fareField[0]="TOTAL_FARE";
String orderNo = request.getParameter("orderno");
String strAction = request.getParameter("action");
String clientmobile=null;
String strPrimaryKey=orderNo;
String[] strFields = (String[])session.getAttribute("strFields");
int size=strFields.length;
String[] strValues = new String[size];
for(int i=0;i<size;i++)
{
	strValues[i] = request.getParameter(strFields[i]);
}
String strWhere= "UniqueT_id ='"+orderNo+"'";
CachedRowSet crs;
CachedRowSet crsnew;
crs=dopt.fetchDataFromDB("bookingdetails",null,strWhere);
if(crs.next())
{
	DatabaseTableValues[0]=crs.getString("UNIQUET_ID");
	DatabaseTableValues[1]=crs.getString("CUST_NAME");
	DatabaseTableValues[2]=crs.getString("ORIGIN");
	DatabaseTableValues[3]=crs.getString("DESTINATION");
	clientmobile=crs.getString("MOBILE");
}
crsnew=dopt.fetchDataFromDB(strDatabaseTable,null,strWhere);
if(crsnew.next())
{
	DatabaseTableValues[4]=crsnew.getString("ESTIMATED_DATE_TIME_PICKUP");
	DatabaseTableValues[5]=crsnew.getString("DRIVER_NAME");
	DatabaseTableValues[6]=crsnew.getString("VEHICLE_NUMBER");
	DatabaseTableValues[7]=crsnew.getString("SECURITY_KEY");
	System.out.println(DatabaseTableValues[7]);
}
String dbstatus = "false";
if(!strAction.equalsIgnoreCase("confirm"))
{
	dbstatus=dopt.UpdateExistingEntry(strDatabaseTable, strPrimaryKey, strFields, strValues);
	String[] statusField = new String[1];
	statusField[0] = "STATUS";
	String[] statusValue = new String[1];
	statusValue[0] = request.getParameter(statusField[0]);
	if(statusValue[0].equalsIgnoreCase("Driver Reached Location"))
	{
		crsnew=dopt.fetchDataFromDB(strDatabaseTable, null, strWhere);
		if(crsnew.next())
		{
			DatabaseTableValues[7]=crsnew.getString("SECURITY_KEY");
		}	
		// SEND EMAIL TO ADMIN SAYING "DRIVER REACHED CUSTOMER LOCATION"
		  String subject="DRIVER REACHED CUSTOMER LOCATION";
		  String data="Driver Reached Customer Location.The Details are:\r\n";
		  for(int j=0;j<DatabaseTableFields.length;j++)
			{
				data += DatabaseTableFields[j] + " : " +  DatabaseTableValues[j] + "\r\n";
			}
		  System.out.println(data);
		  Java_Email jmail= new Java_Email();
		  boolean emailstatus=jmail.sendEmail("Admin", senderemail,receiveremail, subject, data);  		
		//send sms to client when status is set as driver reached 
		 Java_Sms sms= new Java_Sms();
		 clientsmsdetails= sms.formatsms("driverreachedclient", DatabaseTableFields, DatabaseTableValues);
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
        	 DatabaseTableValues[7]="NA";
               //SEND EMAIL TO ADMIN
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
                               	formatString += DatabaseTableFields[j] + " : " + DatabaseTableValues[j] + "\r\n";
                              }
                         logfilestatus=wtlf.writetologfile(appFolder+"/LogFiles/client_sms_driver_reached_logFile.txt",formatString);
            }
         if(logfilestatus)
         {
         	smsstatusclient=true;
         } 
      }
    }
	else if(statusValue[0].equalsIgnoreCase("Security Pass Key Generated"))
	{
		UniqueIDgeneration uid = new UniqueIDgeneration();
		String strSecurityKey=uid.getSecurityKey();
		String SecurityTableFields[]= new String[1];
		String SecurityTableValues[]= new String[1];
		SecurityTableFields[0]="SECURITY_KEY";
		SecurityTableValues[0]=strSecurityKey;
		DatabaseTableValues[7]=strSecurityKey;
		dbstatus=dopt.UpdateExistingEntry("bookingdetailsfinal", strPrimaryKey, SecurityTableFields, SecurityTableValues);
		// SEND EMAIL TO ADMIN SAYING "SECURITY PASS KEY GENERATED"
				 String subject="SECURITY PASS KEY GENERATED";
				  String data="Security Pass key generated.The Details are:\r\n";
				  for(int j=0;j<DatabaseTableFields.length;j++)
					{
						data += DatabaseTableFields[j] + " : " +  DatabaseTableValues[j] + "\r\n";
					}
				  System.out.println(data);
				  Java_Email jmail= new Java_Email();
				  boolean emailstatus=jmail.sendEmail("Admin", senderemail,receiveremail, subject, data);  	
		// SEND SMS TO CLIENT SAYING "SHIFTING STARTED" 
		Java_Sms sms= new Java_Sms();
		 clientsmsdetails= sms.formatsms("shiftingstarted",DatabaseTableFields,DatabaseTableValues);
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
               //SEND EMAIL TO ADMIN
                subject="SMS FAILED TO CLIENT";
                data="SMS to client"+clientmobile+"has been failed. Details are Stored in Log File.Details are\r\n";
               data+=clientsmsdetails;
               emailstatus=jmail.sendEmail("Admin", senderemail,receiveremail,subject, data);
               // WRITE INTO A LOG FILE 	
               WriteToLogFile wtlf= new WriteToLogFile();
               String formatString = "\n";
               formatString +="SMS NOT SENT TO CLIENT.\r\nTHE DETAILS ARE:\r\n";
               for(int j=0;j<DatabaseTableFields.length;j++)
               {
                	formatString += DatabaseTableFields[j] + " : " + DatabaseTableValues[j] + "\r\n";
               }
                         logfilestatus=wtlf.writetologfile(appFolder+"/LogFiles/client_sms_shifting_started_logFile.txt",formatString);
            }
         if(logfilestatus)
         {
         	smsstatusclient=true;
         }
      }
	}
	else if(statusValue[0].equalsIgnoreCase("Shifting Completed"))
	{
		crsnew=dopt.fetchDataFromDB(strDatabaseTable,null,strWhere);
		if(crsnew.next())
		{
		DatabaseTableValues[7]=crsnew.getString("SECURITY_KEY");
		}
		// SEND EMAIL TO ADMIN SAYING "SHIFTING COMPLETED"
		  String subject="SHIFTING COMPLETED";
		  String data="Shifting Completed.The Details are:\r\n";
		  for(int j=0;j<DatabaseTableFields.length;j++)
			{
				data += DatabaseTableFields[j] + " : " +  DatabaseTableValues[j] + "\r\n";
			}
		  System.out.println(data);
		  Java_Email jmail= new Java_Email();
		  boolean emailstatus=jmail.sendEmail("Admin", senderemail,receiveremail, subject, data);  	
		
		// SEND SMS TO CLIENT SAYING "SHIFTING COMPLETED"
		 Java_Sms sms= new Java_Sms();
		 clientsmsdetails= sms.formatsms("shiftingcompleted", DatabaseTableFields, DatabaseTableValues);
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
               //SEND EMAIL TO ADMIN
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
                	formatString += DatabaseTableFields[j] + " : " + DatabaseTableValues[j] + "\r\n";
                	
               }
                         logfilestatus=wtlf.writetologfile(appFolder+"/LogFiles/client_sms_shifting_completed_logFile.txt",formatString);
            }
         if(logfilestatus)
         {
         	smsstatusclient=true;
         }
      }
	}
	else if(statusValue[0].equalsIgnoreCase("Total Fare Details Sent"))
	{
		crsnew=dopt.fetchDataFromDB(strDatabaseTable, null, strWhere);
		if(crsnew.next())
		{
			DatabaseTableValues[7]=crsnew.getString("SECURITY_KEY");
			fareValue[0]=crsnew.getString("TOTAL_FARE");
		}
		// SEND EMAIL TO ADMIN SAYING "TOTAL FARE DETAILS SEND"
		 String subject="TOTAL FARE DETAILS SENT";
		  String data="Total Fare Details Sent.The Details are:\r\n";
		  for(int j=0;j<DatabaseTableFields.length;j++)
			{
			  data += DatabaseTableFields[j] + " : " + DatabaseTableValues[j] + "\r\n";
			}
		  data+=fareField[0] + " : " + fareValue[0];
		  System.out.println(data);
		  Java_Email jmail= new Java_Email();
		  boolean emailstatus=jmail.sendEmail("Admin", senderemail,receiveremail, subject, data); 
		
		
		
		// SEND TOTAL FARE DETAILS TO CLIENT AND ADMIN
		Java_Sms sms= new Java_Sms();
		 clientsmsdetails= sms.formatsms("totalfare", fareField, fareValue);
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
              //SEND EMAIL TO ADMIN
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
               	formatString += DatabaseTableFields[j] + " : " + DatabaseTableValues[j] +  "\r\n";
              }
              formatString+=fareField[0] + " : " + fareValue[0]+"\r\n";
                        logfilestatus=wtlf.writetologfile(appFolder+"/LogFiles/client_sms_total_fare_logFile.txt",formatString);
           }
        if(logfilestatus)
        {
        	smsstatusclient=true;
        }
     }
	}
}
else{
	String[] statusField = new String[1];
	statusField[0] = "STATUS";
	String[] statusValue = new String[1];
	statusValue[0] = request.getParameter(statusField[0]);
	dbstatus=dopt.UpdateExistingEntry("bookingdetails", strPrimaryKey, statusField, statusValue);
	if(statusValue[0].equalsIgnoreCase("Confirmed"))
	{
		    dbstatus=dopt.AddNewBookingEntry(strDatabaseTable, strFields, strValues);
		   String dbstatus1=dopt.UpdateExistingEntry(strDatabaseTable, strPrimaryKey, strFields, strValues);
		   crs=dopt.fetchDataFromDB("bookingdetails",null,strWhere);
		   if(crs.next())
		   {
		   	DatabaseTableValues[0]=crs.getString("UNIQUET_ID");
		   	DatabaseTableValues[1]=crs.getString("CUST_NAME");
		   	DatabaseTableValues[2]=crs.getString("ORIGIN");
		   	DatabaseTableValues[3]=crs.getString("DESTINATION");
		   	clientmobile=crs.getString("MOBILE");
		   }
		   crsnew=dopt.fetchDataFromDB(strDatabaseTable,null,strWhere);
		   if(crsnew.next())
		   {
		   	DatabaseTableValues[4]=crsnew.getString("ESTIMATED_DATE_TIME_PICKUP");
		   	DatabaseTableValues[5]=crsnew.getString("DRIVER_NAME");
		   	DatabaseTableValues[6]=crsnew.getString("VEHICLE_NUMBER");
		   	DatabaseTableValues[7]=crsnew.getString("SECURITY_KEY");
		   }
		 //send mail to admin 
	         String subject="SMS DETAILS SENT TO CLIENT";
	         String data="SMS with Driver Name and Vehicle Details has been sent to client "+clientmobile+".\r\n";
	         for(int j=0;j<DatabaseTableFields.length;j++)
	         {
	         data += DatabaseTableFields[j] + " : " +  DatabaseTableValues[j] + "\r\n";
	         }
	         System.out.println(data);
	         Java_Email jmail= new Java_Email();
	         boolean emailstatus=jmail.sendEmail("Admin", senderemail,receiveremail, subject, data);
		// set status to sms sent to client 
	    	statusValue[0]="Driver Details Sent";
	    	dbstatus=dopt.UpdateExistingEntry("bookingdetailsfinal", strPrimaryKey, statusField, statusValue);
		    //send sms to client with driver details
	     crsnew=dopt.fetchDataFromDB(strDatabaseTable,null,strWhere);
	     if(crsnew.next())
	     {
	     	DatabaseTableValues[4]=crsnew.getString("ESTIMATED_DATE_TIME_PICKUP");
	     	DatabaseTableValues[5]=crsnew.getString("DRIVER_NAME");
	     	DatabaseTableValues[6]=crsnew.getString("VEHICLE_NUMBER");
	     }
	   	 Java_Sms sms= new Java_Sms();
		 clientsmsdetails= sms.formatsms("driverdetailstoclient", DatabaseTableFields, DatabaseTableValues);
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
                  //SEND EMAIL TO ADMIN
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
                   	formatString += DatabaseTableFields[j] + " : " + DatabaseTableValues[j] + "\r\n";
                  }
                            logfilestatus=wtlf.writetologfile(appFolder+"/LogFiles/client_sms_driver_details_logFile.txt",formatString);
               }
            if(logfilestatus)
            {
            	smsstatusclient=true;
            }
         }
    	
	}
}
    if(dbstatus.equals("true"))
    {
%>
		  <script type="text/javascript">
		  alert("Order updated Successfully");
		  window.open("AdminOrderSearch","_self");
		  </script>
<%
    }
    else
    {
%>
	  <script type="text/javascript">
	  alert("Exception::<%=dbstatus%>");
	  window.open("AdminOrderSearch","_self");
	  </script>
<%
    }
%>