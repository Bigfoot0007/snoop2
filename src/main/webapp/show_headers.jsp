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

<a href="index.jsp">Home</a><br>
<pre>
	<%
		Enumeration<?> enumt = request.getHeaderNames();
		while (enumt.hasMoreElements()) {
			String name = enumt.nextElement().toString();
			out.println("request.getHeader(\"<font color=red>" + name + "</font>\") = " + request.getHeader(name) );
		}

		out.println("request.getRemoteAddr() = "+request.getRemoteAddr());
		out.println("request.getRemoteHost() = "+request.getRemoteHost());
		out.println("request.getRemotePort() = "+request.getRemotePort());
		out.println("request.getAuthType() = "+request.getAuthType());
		out.println("request.getRequestURI() = "+request.getRequestURI());
		out.println("request.getContextPath() = "+request.getContextPath());
		out.println("request.getMethod() = "+request.getMethod());
		out.println("request.getRemoteUser() = "+request.getRemoteUser());
		out.println("request.getRequestedSessionId() = "+request.getRequestedSessionId());
		out.println("request.getLocalAddr() = "+request.getLocalAddr());
		
		out.println("------------------------- Decode IV Creds from current headers -------------------------");
		String iv_credential = "iv-creds";
		String value = request.getHeader(iv_credential);
	//	value="Version=1, BAKs3DCCAiQMADCCAh4wggIaAgIHAAIBADCCAg8wggILMGYMFUFaTl9DUkVEX0JST1dTRVJfSU5GTzBNMEsCAQQMRE1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDYuMTsgV09XNjQ7IFRyaWRlbnQvNy4wOyBydjoxMS4wKSBsaWtlIEdlY2tvBAAwJgwSQVpOX0NSRURfSVBfRkFNSUxZMBAwDgIBBAwHQUZfSU5FVAQAMCsMEEFaTl9DUkVEX01FQ0hfSUQwFzAVAgEEDA5JVl9VTkFVVEhfVjMuMAQAMDMMHEFaTl9DUkVEX05FVFdPUktfQUREUkVTU19CSU4wEzARAgEEDAoweGMwYTg4NjAxBAAwNgwcQVpOX0NSRURfTkVUV09SS19BRERSRVNTX1NUUjAWMBQCAQQMDTE5Mi4xNjguMTM0LjEEADAtDBlBWk5fQ1JFRF9QUklOQ0lQQUxfRE9NQUlOMBAwDgIBBAwHRGVmYXVsdAQAMDMMF0FaTl9DUkVEX1BSSU5DSVBBTF9OQU1FMBgwFgIBBAwPdW5hdXRoZW50aWNhdGVkBAAwIgwRQVpOX0NSRURfUU9QX0lORk8wDTALAgEEDAROb25lBAAwLgwSQVpOX0NSRURfVVNFUl9JTkZPMBgwFgIBBAwPdW5hdXRoZW50aWNhdGVkBAAwJwwQQVpOX0NSRURfVkVSU0lPTjATMBECAQQMCjB4MDAwMDA3MDAEAA==";
	//	value="Version=1, BAKs3DCCBPYMADCCBPAwggTsAgIHADBYMCgwHgIEt10OCAICNAUCAhHlAgIArQICAL0EBgAMKeq04AwGc2RpY3R2MCwwKjAeAgS96PB8AgJkWAICEd0CAgCPAgIAwAQGABElCCVoDAhTR01Vc2VycwIBATCCBIcwggSDMCIMFEFVVEhFTlRJQ0FUSU9OX0xFVkVMMAowCAIBBAwBMQQAMCQMF0FaTl9DUkVEX0FVVEhOTUVDSF9JTkZPMAkwBwIBBAwABAAwJQwSQVpOX0NSRURfQVVUSFpOX0lEMA8wDQIBBAwGc2RpY3R2BAAwMwwUQVpOX0NSRURfQVVUSF9NRVRIT0QwGzAZAgEEDBJleHQtYXV0aC1pbnRlcmZhY2UEADBqDBVBWk5fQ1JFRF9CUk9XU0VSX0lORk8wUTBPAgEEDEhNb3ppbGxhLzUuMCAoV2luZG93cyBOVCA2LjE7IFdPVzY0OyBydjozOC4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94LzM4LjAEADAkDA9BWk5fQ1JFRF9HUk9VUFMwETAPAgEEDAhTR01Vc2VycwQAMFQMG0FaTl9DUkVEX0dST1VQX1JFR0lTVFJZX0lEUzA1MDMCAQQMLGNuPXNnbXVzZXJzLGNuPWdyb3VwcyxkYz10YW0sREM9U0dNQU0sREM9Q09NBAAwRQwUQVpOX0NSRURfR1JPVVBfVVVJRFMwLTArAgEEDCRiZGU4ZjA3Yy02NDU4LTExZGQtOGZjMC0wMDExMjUwODI1NjgEADAmDBJBWk5fQ1JFRF9JUF9GQU1JTFkwEDAOAgEEDAdBRl9JTkVUBAAwKQwQQVpOX0NSRURfTUVDSF9JRDAVMBMCAQQMDElWX0xEQVBfVjMuMAQAMDMMHEFaTl9DUkVEX05FVFdPUktfQUREUkVTU19CSU4wEzARAgEEDAoweGMwYTg4NjAxBAAwNgwcQVpOX0NSRURfTkVUV09SS19BRERSRVNTX1NUUjAWMBQCAQQMDTE5Mi4xNjguMTM0LjEEADAtDBlBWk5fQ1JFRF9QUklOQ0lQQUxfRE9NQUlOMBAwDgIBBAwHRGVmYXVsdAQAMCoMF0FaTl9DUkVEX1BSSU5DSVBBTF9OQU1FMA8wDQIBBAwGc2RpY3R2BAAwSAwXQVpOX0NSRURfUFJJTkNJUEFMX1VVSUQwLTArAgEEDCRiNzVkMGUwOC0zNDA1LTExZTUtYWRiZC0wMDBjMjllYWI0ZTAEADAtDBFBWk5fQ1JFRF9RT1BfSU5GTzAYMBYCAQQMD1NTSzogVExTVjEyOiAwQQQAMFgMFEFaTl9DUkVEX1JFR0lTVFJZX0lEMEAwPgIBBAw3dWlkPXNkaWN0dixjbj1lbXBsb3llZXMsZGM9cGF0YWMsZGM9dGFtLGRjPXNnbWFtLGRjPWNvbQQAMB8MEkFaTl9DUkVEX1VTRVJfSU5GTzAJMAcCAQQMAAQAMCcMEEFaTl9DUkVEX1ZFUlNJT04wEzARAgEEDAoweDAwMDAwNzAwBAAwKwwYdGFndmFsdWVfbG9naW5fdXNlcl9uYW1lMA8wDQIBBAwGc2RpY3R2BAAwRwwWdGFndmFsdWVfc2Vzc2lvbl9pbmRleDAtMCsCAQQMJGVhZjYwMDU4LTM0MDUtMTFlNS04ZGM2LTAwMGMyOWVhYjRlMAQA";
		if (value != null) {
			try {
				Hashtable<String, Object> result = PDUtil.decodeCred(value);
				for (String key : result.keySet()) {
					out.println("<font color=red>"+key + "</font>:" + result.get(key) );
				}
			} catch (Exception e) {
			}
		}
		out.println("------------------------- Decode IV Creds from current headers -------------------------");

	%>
	</pre>
</body>
</html>
