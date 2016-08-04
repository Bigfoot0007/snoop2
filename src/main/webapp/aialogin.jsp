
<%
	response.setHeader("Cache-Control", " no-cache");
	response.setHeader("Pragma", "no-cache");
	if (request.getMethod() == "POST") {
		response.setHeader("am-eai-xattrs", "tagvalue_hostedsystemname,tagvalue_currentuid,tagvalue_currentlang");
		response.setHeader("tagvalue_hostedsystemname", request.getParameter("submit"));
		response.setHeader("tagvalue_currentuid", request.getParameter("username"));
		response.setHeader("tagvalue_currentlang", request.getParameter("language"));

	    response.setHeader("am-eai-redir-url","/snoop2/aialogin.jsp");

		if ("true".equalsIgnoreCase(request.getParameter("ISSSOID"))) {
			response.setHeader("am-eai-user-id", request.getParameter("username"));
		} else {
			response.setHeader("am-eai-user-id", "#novalue#");
		}
	}
%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AIA Login demo</title>
</head>
<body>


	<div>

		<%
			out.print(request.getHeader("iv-user") + "(" + request.getHeader("sso-currentuid ") + ")");
		%>
		<a href="../pkmslogout">logout</a> 
		<%
			java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			java.util.Date currentTime = new java.util.Date();//得到当前系统时间 
			String str_date1 = formatter.format(currentTime); //将日期时间格式化 
			out.println(currentTime);
		%>
		<a href="">Get</a> &nbsp; <a href="../sso/common/clp.jsp"> CLP </a>
		<!-- for SSOID -->
		<form action="" method="post">

			<label for="username" isrequired="false">SSOUID</label> <input type="input" name="username" value="042940605" /> <input type="hidden" name="ISSSOID" value="true" />
			<!--  zh_CN, zh_TW,and en_HK  -->
			<select name="language">
				<option value="zh_CN">zh_CN</option>
				<option value="zh_TW">zh_TW</option>
				<option value="en" selected>en</option>
			</select> <input type="submit" name="submit" value="CC" /> <input type="submit" name="submit" value="EB" /> <input type="submit" name="submit" value="ORSO" /> <input type="submit" name="submit" value="MPF" /> <input type="submit" name="submit" value="VT" />

		</form>
	</div>

	<!-- for Non-SSOID -->
	<form action="" method="post">

		<label for="username" isrequired="false">Non-SSOUID</label> <input type="input" name="username" value="042940605" />
		<!--  zh_CN, zh_TW,and en_HK  -->
		<select name="language">
			<option value="zh_CN">zh_CN</option>
			<option value="zh_TW">zh_TW</option>
			<option value="en" selected>en</option>
		</select> <input type="submit" name="submit" value="CC" /> <input type="submit" name="submit" value="EB" /> <input type="submit" name="submit" value="ORSO" /> <input type="submit" name="submit" value="MPF" /> <input type="submit" name="submit" value="VT" />

	</form>
	</div>
	<BR>

	<a href="../sps/IdpDevSAML/saml20/logininitial?RequestBinding=HTTPPost&PartnerId=columbus&NameIdFormat=email">VMP</a> &nbsp;&nbsp;
	<a href="../sps/IdpDevSAML/saml20/logininitial?RequestBinding=HTTPPost&PartnerId=http://123.57.221.117/&NameIdFormat=email">SAMLT117</a> &nbsp;&nbsp;
 	<a href="../sso/common/clp.jsp">CLP</a> &nbsp;&nbsp;
	

	<br>
	<pre>
	<%
		out.println("\n====  POST  ====== ");
		java.util.Enumeration enumt = request.getParameterNames();
		while (enumt.hasMoreElements()) {
			String str = enumt.nextElement().toString();
			out.println(str + " = " + request.getParameter(str));
		}
		out.println("====  Headers  ====== ");

		java.util.Enumeration enumt1 = request.getHeaderNames();
		while (enumt1.hasMoreElements()) {
			String name = enumt1.nextElement().toString();
			out.println("request.getHeader('<font color=red>" + name + "</font>') = " + request.getHeader(name));
		}
	%>
	</pre>

</body>
</html>

