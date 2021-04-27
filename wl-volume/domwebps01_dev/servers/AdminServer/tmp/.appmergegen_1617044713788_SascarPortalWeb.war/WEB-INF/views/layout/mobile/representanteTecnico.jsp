<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<!DOCTYPE HTML PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.1//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile11.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/sascar/images/favicon.ico" />
		<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/sascar/images/favicon.ico" />
		<title>Sascar - Mobile</title>
		
		<link href="${pageContext.request.contextPath}/sascar/css/mobile/jquery-ui-1.8.6.custom.css" type="text/css" rel="stylesheet" media="all" />
		<link href="${pageContext.request.contextPath}/sascar/css/mobile/estilos.css" type="text/css" rel="stylesheet" media="all" />
		<link href="${pageContext.request.contextPath}/sascar/css/mobile/formTransform.css" type="text/css" rel="stylesheet" media="all" />
		
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/mobile/jquery.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/mobile/jquery-ui-1.8.6.custom.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/mobile/jquery.ui.datepicker-pt-BR.js"></script>	
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/mobile/jquery.meio.mask.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/mobile/jquery.validate.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/mobile/messages_ptbr.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/mobile/jquery.joverlay.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/mobile/jquery.slidingmessage.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/mobile/validators.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/mobile/jquery.formTransform.js"></script>			
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/mobile/sascar.js"></script>			
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/mobile/jquery.limit-1.2.js"></script>
			
		<c:catch var="helper" >
			<c:import url="/VerificarPermissao" context="/SascarPortalWeb"  />
		</c:catch>
		
		<style type="text/css">
			.ui-corner-all {
			    -moz-border-radius: 15px 15px 15px 15px;
			}
			
			.ui-button-text-only .ui-button-text {
			    padding: 0.4em 1em;
			}
			
			.ui-button .ui-button-text {
			    font-size: 120%;
			    font-weight: bold;
			}
			
			.ui-widget,
			.ui-datepicker td span,
			.ui-datepicker td a {
			     font-size: 120%;
			}
			
			.ui-datepicker-title span {
				 font-size: 120%;
				font-weight: bold;
			}
			
			.ui-datepicker-calendar th span {
				font-size: 120%;
				font-weight: bold;
			}
			
			.ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default {
				border: 2px solid #C5DBEC;
			}
			
			.aButton {
				padding: 15px 30px;
				font-size: 120%;
			}
			
			span.ui-checkbox {
				display: block;
				float: left;
				width: 16px;
				height: 16px;
				background: url('${pageContext.request.contextPath}/sascar/images/mobile/icon_checkbox.png') 0 -40px no-repeat;
			}
			span.ui-helper-hidden {
				display: none;
			}
			label {
				padding: 2px;
				
			}
			span.ui-checkbox-state-hover {
				background-position: 0 -114px;
			}
			
			span.ui-checkbox-state-checked {
				background-position: 0 -1px;
			}
			
			span.ui-checkbox-state-checked-hover {
				background-position: 0 -75px;
			}
		</style>
		
	</head>

	<body>

		<!-- Usado para mover para o topo o scroll -->
		<a name="top"></a>

		<h1 id="logo-incon" style="text-align: center;">
	        <a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico" title="SASCAR - Mobile">
	            <img src="${pageContext.request.contextPath}/sascar/images/mobile/logo-sascar-nova.png" alt="SASCAR" height="50" width="226" />
	        </a>
	    </h1>
	    
		<div id="divMessageError" class="message msg-error" style="display: none;"></div>
    
		<ul id="menu">
			<li><a id="ativar_equipamento" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv01" title="Ativar Equipamento"><span>Ativar Equipamento</span></a></li>
			<li><a href="/PortalSascar/adfAuthentication?logout=true&amp;end_url=/" title="Sair"><span>Sair</span></a></li>
		</ul>

		<div class="conteudo" id="content">
			<c:choose>
				<c:when test="${not empty helper}" >
					<script type="text/javascript">
						$(document).ready(function(){
							blockAccess('${helper}');  
						}); 
					</script>
				</c:when>
				<c:otherwise>
					<jsp:directive.include file="/WEB-INF/views/common/mobile/detail.jsp"/>
				</c:otherwise>
			</c:choose>
		</div>
		
		<form id="portal_login" action="/PortalSascar/j_security_check" method="post">
			<input type="hidden" name="j_username" value="representantesascar"/>
			<input type="hidden" name="j_password" value="representantesascar1"/>
		</form>
		
		<div id="info">
			<a id="linkVersaoWeb" href="javascript:void(0);">Ir para vers&atilde;o WEB</a>
		</div>
		
		<div id="popupPermissao" class="window modal" style="display: none;">
			<div class="topo"></div>
			<div class="middle" style="text-align: center;">
				<h3>Permiss&atilde;o de acesso</h3>
				<br/>
				<b><span id="msgPermissao"></span></b>
				<br/><br/>
				<table width="100%" cellspacing="0">
					<tr>
						<td align="center">
							<a id="linkPopupPermissao" title="Fechar" href="#">
								<img src="${pageContext.request.contextPath}/sascar/images/corporativo/ico_voltar_modal.png" class="ico" alt="Fechar" style="vertical-align: middle;"/> Fechar
							</a>
						</td>
					</tr>
				</table>
			</div>
			<div class="bottom"></div>
		</div>
		
		<div id="popupDefaultError" class="window modal" style="display: none;">
			<div class="topo"></div>
			<div class="middle">
				<h4>Desculpe-nos!</h4>
				<br/>
				<span>
					<b>As informa&ccedil;&otilde;es solicitadas est&atilde;o temporariamente indispon&iacute;veis.<br/>
					Por favor, tente novamente em alguns instantes.</b>
				</span>
				<br/><br/>
				<table width="100%" cellspacing="0">
					<tr>
						<td align="center">
							<a href="javascript:void(0);" onclick="history.back(-1);" title="Fechar">
								<img src="${pageContext.request.contextPath}/sascar/images/corporativo/ico_voltar_modal.png" class="ico" alt="Fechar" style="vertical-align: middle;"/> Voltar
							</a>
						</td>
					</tr>
				</table>
			</div>
			<div class="bottom"></div>
		</div>

		<script type="text/javascript">
			$( "#linkVersaoWeb" ).click(function() {
				document.getElementById("portal_login").submit();
			});
			
			var _gaq = _gaq || [];
			_gaq.push(['_setAccount', 'UA-31746147-1']);
			_gaq.push(['_trackPageview']);

			(function() {
			var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
			ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
			var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
			})();
		</script>

	</body>
</html>