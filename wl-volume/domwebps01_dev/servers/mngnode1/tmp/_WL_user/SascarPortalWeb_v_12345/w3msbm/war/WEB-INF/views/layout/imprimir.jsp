<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="pt-br" xml:lang="pt-br" dir="ltr">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Sascar - Paix&atilde;o pela Inova&ccedil;&atilde;o</title>
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/sascar/images/favicon_sascar.ico" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/jquery.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/jquery.slidingmessage.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/jquery.joverlay.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/sascar.js"></script>
	<link href="${pageContext.request.contextPath}/sascar/css/corporativo/sistema.css" media="all" rel="stylesheet" type="text/css" />
	<!--[if IE]> <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sascar/css/corporativo/iehacks.css" /> <![endif]-->
	<!--[if IE 7]>  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sascar/css/corporativo/iehacks-7.css" />  <![endif]-->
		<style> body {
			background: #FFFFFF;
			text-align: justify;
		}
	
		body, table, tr, td {
			font-family:Arial, Verdana, Sans-Serif;
			color: #000000;
			font-size: 12pt;
			text-align: justify; 
		}
	
		td {
			line-height: 26px;
		}
		
		table.list {
		    border-collapse: collapse;
		}
		
		table.list th {
		    font: bold 11px Arial;
		    padding: 2px;
		    text-align: left;
		    border: 1px solid #505050;
		}

		table.list td.first {
		    border-left: 1px solid #505050;
		}

		table.list td {
		    background-color: #FFFFFF;
		    border: 1px solid #505050;
		    color: #505050;
		    padding: 2px;
		    font: 11px Arial;
		}
		
		.error_div {
			height: 30px;
			padding: 10px 20px 0px 100px;
		}
		
		h3.erro {
		    color: #FF0000;
		    font-size: 12px;
		}
		
		input {
		    -moz-border-radius: 5px 5px 5px 5px;
		    border: 1px solid #D4D4D4;
		    color: #666666;
		    font-size: 13px;
		    height: 18px;
		    width: auto;
		}
		.button {
		    background: none repeat scroll 0 0 #00417B;
		    color: #FFFFFF;
		    cursor: pointer;
		    font-size: 11px;
		    font-weight: bold;
		    height: 25px;
		    margin-right: 6px;
		    text-align: center;
		    text-decoration: none;
		}
		
		
	</style>
</head>

<script type="text/javascript">
	function imprimir(){
		window.print();
		window.close();
	}
</script>

<body onload="$.closeOverlay();">
	
	<div id="divMessageError" class="error_div" style="display: none;">
		<h3 class="erro">
			<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/001_19.png" width="24" height="24" hspace="5" border="0" align="absmiddle" />
			<span></span>
		</h3>
	</div>

	<jsp:directive.include file="/WEB-INF/views/common/detail.jsp"/>
	
</body>
</html>

