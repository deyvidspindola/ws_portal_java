<%@page import="br.com.sascar.portal.integration.response.dto.Response"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
<script type="text/javascript">
	function redirect() {

		switch ($('#ambiente').val()) {

		case "homologacao":
			window.open("http://www.sascar.com.br", '_parent');
			break;
		case "delivery":
			window.open("http://www.sascar.com.br", '_parent');
			break;
		}
	}
</script>

</head>
<body onload="redirect()">
	<%
		String environment = System.getProperty("SascarEnvironment");
	%>
	<input type="hidden" value="<%=environment%>" id="ambiente" />
</body>
</html>