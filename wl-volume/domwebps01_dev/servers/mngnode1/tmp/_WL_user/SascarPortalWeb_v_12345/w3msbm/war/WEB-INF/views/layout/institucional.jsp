<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="pt-br" xml:lang="pt-br" dir="ltr">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Sascar - Paix&atilde;o pela Inova&ccedil;&atilde;o</title>
		<link rel="shortcut icon" href="${pageContext.request.contextPath}/sascar/images/favicon_sascar.ico" />

 		<!--[if IE 7]><link href="${pageContext.request.contextPath}/sascar/css/corporativo/iehacks.css" rel="stylesheet" type="text/css" media="screen" /><![endif]-->

		<link href="${pageContext.request.contextPath}/sascar/css/corporativo/geral.css" media="all" rel="stylesheet" type="text/css" />
		<link href="${pageContext.request.contextPath}/sascar/css/corporativo/menu.css" media="all" rel="stylesheet" type="text/css" />
		<link href="${pageContext.request.contextPath}/sascar/css/corporativo/home.css" media="all" rel="stylesheet" type="text/css" />
		<link href="${pageContext.request.contextPath}/sascar/css/corporativo/sistema.css" media="all" rel="stylesheet" type="text/css" />
		<!--[if IE]> <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sascar/css/corporativo/iehacks.css" /> <![endif]-->
		<!--[if IE 7]>  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sascar/css/corporativo/iehacks-7.css" />  <![endif]-->
		
		<link href="${pageContext.request.contextPath}/sascar/css/corporativo/jquery-ui-1.8.6.custom.css" media="screen" rel="stylesheet" type="text/css" />

		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/jquery.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/jquery.cookie.js"></script>	
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/jquery-ui-1.8.6.custom.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/jquery.ui.datepicker-pt-BR.js"></script>	
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/jquery.meio.mask.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/jquery.validate.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/messages_ptbr.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/jquery.joverlay.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/md5.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/jquery.slidingmessage.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/validators.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/jquery.limit-1.2.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/sascar.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/jquery.tooltip.1.1.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				$(".tooltip").simpletooltip();
			});
		</script>
			
	</head>
	
	<body>
		
		<div id="divMessageError" class="error_div" style="display: none;">
			<h3 class="erro">
				<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/001_19.png" width="24" height="24" hspace="5" border="0" align="absmiddle" />
				<span></span>
			</h3>
		</div>
		
		<c:if test="${not empty param.page and param.page eq 'Corporativo/UC15/dv01' }">
			<div id="header">
				<div id="logo">
					<a href="http://www.sascar.com.br">
						<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/logo-sascar.jpg" border="0" />
					</a>
				</div>
			</div>
		</c:if>

		<div>
			<jsp:directive.include file="/WEB-INF/views/common/detail.jsp"/>
		</div>

		<div id="rodape"></div>
		
		<jsp:directive.include file="/WEB-INF/views/common/footer.jsp"/>
	</body>
</html>