<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/RetornaParametro/retornaParametroServico?acao=1" context="/SascarPortalWeb"  />
</c:catch>

<c:if test="${not empty helper}" >
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>

<script type="text/javascript">
	$(document).ready(function(){
		
		$('#js-fechar-popup-chat').live('click', function(){
			$.closeOverlay();
		});
		
		$('#js-entrar-chat').bind('click', function(){
			$('#js-valida-placa').hide();
			$('#js-valida-nome').hide();
			
			var parametroCI = $.trim($('#js-nome').val());
			var parametroServico = $.trim("Reset%2520senha");
			var parametroCSS = "http://intranet.sascar.com.br/includes/css/chat.css";
			var valorLink = "";
			var placa = $('#js-placa').val();
			placa = $.trim(placa);
			
			//VALIDACAO DE CAMPOS
			if(placa == "" && parametroCI == ""){
				$('#js-valida-placa').show();
				$('#js-valida-nome').show();
				$('#js-nome').val("").focus();
				$('#js-placa').val("");
			}else if(placa == ""){
				$('#js-valida-placa').show();
				$('#js-placa').val("").focus();
			}else if(parametroCI == ""){
				$('#js-valida-nome').show();
				$('#js-nome').val("").focus();
			}
			else{
				valorLink = "http://chat.sascar.com.br/interact_chatclient/chat.php?ci=" + parametroCI + "&servico=" + parametroServico + "&notif=1&css=" + parametroCSS +"&da=Placa:%2520"+ placa;
				
				$.closeOverlay();
				document.location.href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/Login&page=Corporativo/UC12/dv02";
				window.open(valorLink,'','width=600,height=600');
			}
			
		});
		
	});
</script>

<div class="popup_padrao" id="js-popup-chat">
	<input type="hidden" id="js-parametroCI" name="parametroCI" value="" />
	<input type="hidden" id="js-tipoUsuario" name="tipoUsuario" value="CL"  />
	<input type="hidden" id="js-parametroServico" name="parametroServico" value="Reset%2520senha" />
	
	<table style="margin-left: 55px; margin-top: -10px;">
		<tr>
			<td><fmt:message key="label.nome" />:</td>
			<td><input type="text" id="js-nome" name="nome" maxlength="20"/></td>
		</tr>					
		<tr>
			<td><fmt:message key="label.placa" />:</td>
			<td><input type="text" id="js-placa" name="placa" maxlength="7"/></td>
		</tr>
		<tr></tr>
		<tr>
			<td><input type="button" id="js-fechar-popup-chat" name="fechar" value="<fmt:message key="label.fechar" />" class="button" /></td>
			<td><input type="button" id="js-entrar-chat" name="entrar" value="<fmt:message key="label.entrar" />" class="button" /></td>
			<td style="
				width: 170px;
				display: block;
				font-size: 11px;
				font-style: italic;
				margin-left: -94px;
				margin-top: -3px;
				color: #FF0000;">
				<span style="display: none;" class="" id="js-valida-nome">*<fmt:message key="mensagem.campoObrigatorio.nome" /></span><br />
				<span style="display: none;" class="" id="js-valida-placa">*<fmt:message key="mensagem.campoObrigatorio.placa" /></span>
			</td>				
		</tr>	
	</table>	
</div>