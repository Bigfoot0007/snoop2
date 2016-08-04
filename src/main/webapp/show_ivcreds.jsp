<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="util.PDUtil"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>Decode IV Creds</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
</head>

<body>
<a href="index.jsp">Home</a>
	<%
		out.println("Decode IV Creds from request:");
		out.println("<br/>------------------------------------------------------------------------<br/>");
		String value = request.getParameter("iv-creds");
		if (value != null) {
			try {
				Hashtable<String, Object> result = PDUtil.decodeCred(value);
				for (String key : result.keySet()) {
					out.println(key + ":" + result.get(key) + "<br/>");
				}
			} catch (Exception e) {
			}
		}
		out.println("------------------------------------------------------------------------<br/>");
	%>
</body>
</html>
