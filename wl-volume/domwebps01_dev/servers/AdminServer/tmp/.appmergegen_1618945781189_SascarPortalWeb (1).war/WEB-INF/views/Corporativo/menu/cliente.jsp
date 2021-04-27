<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<script type="text/javascript">

	function getXmlHttpRequest() {
		if (window.XMLHttpRequest) {
			return new XMLHttpRequest();
		}
		else if (window.ActiveXObject) {
			// Based on http://jibbering.com/2002/4/httprequest.html
			/*@cc_on @*/
			/*@if (@_jscript_version >= 5)
			try {
				return new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				try {
					return new ActiveXObject("Microsoft.XMLHTTP");
				} catch (E) {
					return null;
				}
			}
			@end @*/
		}
		else {
			return null;
		}
	};

	function keepSessionAlive() {

		if($("#dialogAvl").is(':visible')) {

			var xmlHttpRequest = getXmlHttpRequest();
			
			if (xmlHttpRequest != null) {

			    xmlHttpRequest.onreadystatechange = function(){
					if(xmlHttpRequest.readyState == 4){
						if(xmlHttpRequest.status == 200){
							var json = $.parseJSON(xmlHttpRequest.responseText);

							if (json.success) {
								if ('${pageContext.session.id}' == json.sessionID) {
									window.setTimeout("keepSessionAlive()", (60000 * 5)); // A cada 5 minutos
								} else {
									document.location.href = '/SascarPortalWeb/ContentServer?pagename=SascarPortal_Corporativo/Login';
								}
							} else {
								document.location.href = '/SascarPortalWeb/ContentServer?pagename=SascarPortal_Corporativo/Login';
							}

						} else {
							document.location.href = '/SascarPortalWeb/ContentServer?pagename=SascarPortal_Corporativo/Login';
						}
					}
			    };
			}
		}

	}

	function openAvl(){

		$("#loadingAvl").show();

		// Fazer AJAX
		$.ajax({
			"url": "/SascarPortalWeb/LoginUsuarioServlet/submeterHashSessao",
			"data" : {"acao" : 8},
			"dataType" : "json",
			"success": function(json){
				if (json.success) {

					$('#dialogAvl').jOverlay({'closeOnEsc' : true, 'bgClickToClose': true, onSuccess: function(){
						$('#dialogAvl iframe').attr('src', 'http://avl.sascar.com.br/logarportal?id=${pageContext.session.id}');
					}});
					
				} else {
					$.showMessage(json.mensagem);
				}
			}
		});
	}

	$(document).ready(function(){
		$('#dialogAvl iframe').css({'width' : $(window).width() - 50 + 'px', 'height': $(window).height() - 70 + 'px'});
		$('#dialogAvl iframe').load(function() {
			$("#loadingAvl").hide();
			
			keepSessionAlive();
		});
	});

</script>

<div id="dialogAvl" style="display: none;">

	<div id="loadingAvl" class="carregando_padrao" style="position:absolute; top: 50%; left: 50%; margin-left:-102.5px; margin-top:-27px;">
		<div class="carregando_text">
			<img 
				src="${pageContext.request.contextPath}/sascar/images/corporativo_new/ajax-loader.gif" 
				width="16" height="16" 
				hspace="10" border="0" 
				align="absmiddle" />
				<fmt:message key="label.carregando" />
		</div>
	</div>
	
	<div id="bordamonitoramento"> 
		<span style="margin-left:150px"><fmt:message key="label.monitoramento" /></span>
		<img style="*position:absolute;*right:10px;*top:13px;" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/1306437664_button_grey_close.png" width="24" height="24" align="absmiddle" style="float:right" onclick="$.closeOverlay();" />
	</div>
		
	<iframe frameborder="0" src="about:blank"></iframe>
</div>

<ul>
	<li id="CMI" style="display: none;">
	  <div class="icon"><img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/icons-10.png" width="48" height="48" hspace="10" vspace="20" border="0" /></div>
	  <a href="#" target="_self" class="titlemenu" >
	  	<strong><fmt:message key="label.informacoes" /></strong><span class="subtitlemenu"><fmt:message key="menu.cliente.subMenuInformacoes" /> </span>
	  </a>
	  <div>
	    <ul>
	      <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC08/dv01"><fmt:message key="label.atualizacaoCadastral" /></a></li>
	      <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC01/dv01"><fmt:message key="label.servicosContratados" /></a></li>
	      <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC14/dv01"><fmt:message key="label.declaracaoVeiculosMonitorados" /></a></li>
	      <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC07/dv02"><fmt:message key="label.pesquisaSatisfacao" /></a></li>
	      <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC09/dv01"><fmt:message key="label.alteracaoDeSenha" /></a></li>
	      <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC45/dv01"><fmt:message key="label.perguntasFrequentes" /></a></li>
	      <li id="li_cliente_chat"></li>
	      </ul>
	  </div>
	</li>
	
	<li id="CMS" style="display: none;">
	  <div class="icon"><img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/icons-11.png" width="48" height="48" hspace="10" vspace="20" border="0" /></div>
	  <a href="#" target="_self" >
	  	<strong><fmt:message key="label.servicos" /></strong><span class="subtitlemenu"><fmt:message key="menu.cliente.subMenuServicos" /></span>
	  </a>
	  <ul>
	    <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC02/dv01"><fmt:message key="label.agendarAtendimento" /></a></li>
	    <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC03/dv01"><fmt:message key="label.solicitarRetiradaReinstalacao" /></a></li>
        <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC46/dv01"><fmt:message key="label.cadastrarVeiculosReinstalacao" /></a></li>
        <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC47/dv01"><fmt:message key="label.solicitarOSReinstalacaoPendente" /></a></li>
        <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC35/dv01"><fmt:message key="label.direcionamentoSinal" /></a></li>
        <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC56/dv01"><fmt:message key="label.consultarVeiculosDesatualizados" /></a></li>
        <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC57/dv01"><b><fmt:message key="label.contratosPendentesReinstalacao" /></b></a></li>
      </ul>
	</li>

	<li id="CMP" style="display: none;">
	  <div class="icon"><img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/icons-12.png" width="48" height="48" hspace="10" vspace="20" border="0" /></div>
	  <a href="#" target="_self" class="titlemenu" >
	  	<strong><fmt:message key="label.pagamentos" /> </strong><span class="subtitlemenu"><fmt:message key="menu.cliente.subMenuPagamentos" /></span>
	  </a>
	   <ul>
	   	 <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC16/dv01&menu=1"><fmt:message key="label.2viaBoleto" /></a></li>
	     <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC17/dv01"><fmt:message key="label.autorizacaoDebitoAutomatico" /></a></li>
	     <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC16/dv01&menu=3"><fmt:message key="label.consultas" /></a></li>
	     <li><a href="/SascarPortalWeb/ConsultarNotaFiscalEletronica/consultarNotaFiscalEletronica?acao=1" target="_blank"><fmt:message key="label.nfEletronicaServico" /></a></li>
	   </ul>
	</li>
	
	<li>
	  <div class="icon"><img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/icons-13.png" width="42" height="42" hspace="10" vspace="20" border="0" /></div>
	  <a href="#avl" onclick="openAvl();">
	  	<strong><fmt:message key="label.monitoramento" /></strong><span class="subtitlemenu"><fmt:message key="menu.cliente.subMenu.monitoramento" /></span>
	  </a>
	</li>
	
</ul>