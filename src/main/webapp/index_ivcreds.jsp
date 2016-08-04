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

<title>Show Headers</title>
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
	<div align="center">
		<form action="show_ivcreds.jsp" method="post">
			IV_CREDS:
			<textarea style="vertical-align: text-bottom;" rows="20" cols="50"
				name="iv-creds">Version=1, BAKs3DCCAiQMADCCAh4wggIaAgIHAAIBADCCAg8wggILMGYMFUFaTl9DUkVEX0JST1dTRVJfSU5GTzBNMEsCAQQMRE1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDYuMTsgV09XNjQ7IFRyaWRlbnQvNy4wOyBydjoxMS4wKSBsaWtlIEdlY2tvBAAwJgwSQVpOX0NSRURfSVBfRkFNSUxZMBAwDgIBBAwHQUZfSU5FVAQAMCsMEEFaTl9DUkVEX01FQ0hfSUQwFzAVAgEEDA5JVl9VTkFVVEhfVjMuMAQAMDMMHEFaTl9DUkVEX05FVFdPUktfQUREUkVTU19CSU4wEzARAgEEDAoweGMwYTg4NjAxBAAwNgwcQVpOX0NSRURfTkVUV09SS19BRERSRVNTX1NUUjAWMBQCAQQMDTE5Mi4xNjguMTM0LjEEADAtDBlBWk5fQ1JFRF9QUklOQ0lQQUxfRE9NQUlOMBAwDgIBBAwHRGVmYXVsdAQAMDMMF0FaTl9DUkVEX1BSSU5DSVBBTF9OQU1FMBgwFgIBBAwPdW5hdXRoZW50aWNhdGVkBAAwIgwRQVpOX0NSRURfUU9QX0lORk8wDTALAgEEDAROb25lBAAwLgwSQVpOX0NSRURfVVNFUl9JTkZPMBgwFgIBBAwPdW5hdXRoZW50aWNhdGVkBAAwJwwQQVpOX0NSRURfVkVSU0lPTjATMBECAQQMCjB4MDAwMDA3MDAEAA==</textarea>
			<br />
			<br />
			<input type="submit" value="解析输入框中的内容" />
			<input type="button" onClick="document.location='show_headers.jsp';" value="解析当前Header中的内容" />
		</form>
	</div>
</body>
</html>
