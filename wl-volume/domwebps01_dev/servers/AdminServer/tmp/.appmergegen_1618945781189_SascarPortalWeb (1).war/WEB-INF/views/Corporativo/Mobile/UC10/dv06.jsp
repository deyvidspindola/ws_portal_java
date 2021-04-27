<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/AtivarEquipamentoVinculo/detalharOrdemServicoAtivacao?acao=4" context="/SascarPortalWeb"  />
</c:catch>

<c:if test="${not empty mensagem }">
	<script type="text/javascript">
		$.showMessage("${mensagem }");
	</script>
</c:if>

<c:if test="${not empty helper}" >
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>
	
<script type="text/javascript">
	function submterEquipamento(form) {
		var data = $(form).serialize();

		$(':disabled').each( function() {
			data += '&' + this.name + '=' + $(this).val();
		});

		$.ajax({
			url: "/SascarPortalWeb/AtivarEquipamentoVinculo/submeterEquipamento?acao=5",
			data: data || {},
			dataType:"json",
			success: function(json){
				if (json.success) {
					$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv07&numeroOS=${param.numeroOS }&numeroCPF=${param.numeroCPF }&tipoSubmeter=A");
					$(form).unbind('submit').submit();
				} else {
					$(form).attr("action", "");
					$.showMessage(json.mensagem);
				}
			}
		});
	}

	$(document).ready(function(){
		$('#ativar_equipamento').addClass('active');
	
		var container = $('div.container-error');
		$("#formPesquisa").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler : function(form) {
				//recupera validacao de equipamento vinculado
				var equipamentoVinculado = $("#equipamentoVinculado").val();
				
				//Se vinculado enviar para proxima tela
				if (equipamentoVinculado != null && equipamentoVinculado == 'true') {
					$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv07");
					$(form).unbind('submit').submit();
				} else {
					//Se nao submeter
					submterEquipamento(form);
				}
				
			}
		});
	});
</script>

	<div class="container-error"> 
		<ol>
			<li><label for="numeroSerial" class="error"><fmt:message key="mensagem.campo.InformeSerial" /></label></li>
			<li><label for="codigoLocalInstalacaoEquipamento" class="error"><fmt:message key="uc10.dv06.selecioneInstalacaoEquipamento" /></label></li>
			<li><label for="codigoLocalInstalacaoAntenaGPS" class="error"><fmt:message key="uc10.dv06.selecioneInstalacaoAntenaGPS" /></label></li>
			<li><label for="codigoLocalInstalacaoAntenaGSM" class="error"><fmt:message key="uc10.dv06.selectioneInstalacaoAntenaGSM" /></label></li>
		</ol>
	</div>
	
	<h2><fmt:message key="uc10.dv06.vinculacaoEquipamento" /></h2>

	<form id="formPesquisa" action="" method="post">
	
		<input type="hidden" name="numeroCPF" value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS" value="${param.numeroOS }" />
		<input type="hidden" name="tipoSubmeter" value="A" />
		<input type="hidden" id="equipamentoVinculado" name="equipamentoVinculado" value="${equipamentoVinculado}" />
	
		<table width="100%" cellpadding="0" cellspacing="5" border="0" class="dados">
			<tr>
	            <th><fmt:message key="label.NumOS" />:</th>
	            <td style="text-align:left; padding-left: 2px;">[${ordemServicoResumida.numero}]</td>
			</tr>
			<tr>
	            <th><fmt:message key="label.placa" />:</th>
	            <td style="text-align:left; padding-left: 2px;">${ordemServicoResumida.contrato.veiculo.placa}</td>
	        </tr>
	        <tr>
	            <th><fmt:message key="label.chassi" />:</th>	
	            <td style="text-align:left; padding-l eft: 2px; ">${ordemServicoResumida.contrato.veiculo.chassi}</td>
	        </tr>
	        <tr>
	            <th><fmt:message key="label.servicos" />:</th>
	            <td style="text-align:left; padding-l eft: 2px; ">${ordemServicoResumida.contrato.servicoContratado}</td>
	        </tr>
		</table>
		
		<fieldset>
		
			<legend><strong><fmt:message key="label.dadosEquipamento" /></strong></legend>
		
			<p class="input">
				<label for="numeroSerial">
					<span>Serial:</span><br />
					<input type="text" 
					       id="numeroSerial" 
					       name="numeroSerial" 
					       size="25"
					       value="${equipamento.numeroSerial}" 
					       maxlength="24" 
					       <c:if test="${not empty equipamento.numeroSerial}">disabled="disabled"</c:if>
				       />
				</label>
			</p>
			
			<p class="input">
				<label for="codigoLocalInstalacaoEquipamento">
					<span><fmt:message key="label.localDeInstalacao" />:</span><br />
					<select name="codigoLocalInstalacaoEquipamento" 
							id="codigoLocalInstalacaoEquipamento" 
							class="required"
							<c:if test="${not empty equipamento.codigoLocalInstalacaoEquipamento}">disabled="disabled"</c:if>>
	
						<option value=""><fmt:message key="label.selecione" /></option>
						<c:forEach items="${locaisInstalacaoEquipamento }" var="local">
							<c:if test="${not empty local.identifier and not empty local.value}">
								<option <c:if test="${equipamento.codigoLocalInstalacaoEquipamento eq local.identifier}">selected="selected"</c:if> value="${local.identifier}">${local.value}</option>
							</c:if>
						</c:forEach>
					</select>
				</label>
			</p>
			
			<p class="input">
				<label for="codigoLocalInstalacaoAntenaGPS">
					<span><fmt:message key="uc10.dv06.localInstalacaoAntenaGPS" />:</span><br />
					<select name="codigoLocalInstalacaoAntenaGPS"
							id="codigoLocalInstalacaoAntenaGPS"
							class="required"
							<c:if test="${not empty equipamento.codigoLocalInstalacaoAntenaGPS}">disabled="disabled"</c:if>>
									
						<option value=""><fmt:message key="label.selecione" /></option>
						<c:forEach items="${locaisInstalacaoAntenaGPS }" var="local">
							<c:if test="${not empty local.identifier and not empty local.value}">
								<option <c:if test="${equipamento.codigoLocalInstalacaoAntenaGPS eq local.identifier}">selected="selected"</c:if> value="${local.identifier}">${local.value}</option>
							</c:if>
						</c:forEach>
					</select>
				</label>
			</p>
			
			<p class="input">
				<label for="codigoLocalInstalacaoAntenaGSM">
					<span><fmt:message key="uc10.dv01.localInstalacaoAntenaGSM" />:</span><br />
					<select name="codigoLocalInstalacaoAntenaGSM"
							id="codigoLocalInstalacaoAntenaGSM"
							class="required"
							<c:if test="${not empty equipamento.codigoLocalInstalacaoAntenaGSM}">disabled="disabled"</c:if>>
		
						<option value=""><fmt:message key="label.selecione" /></option>
						<c:forEach items="${locaisInstalacaoAntenaGSM }" var="local">
							<c:if test="${not empty local.identifier and not empty local.value}">
								<option <c:if test="${equipamento.codigoLocalInstalacaoAntenaGSM eq local.identifier}">selected="selected"</c:if> value="${local.identifier}">${local.value}</option>
							</c:if>
						</c:forEach>
					</select>
				</label>
			</p>
			
			<p class="input" style="padding:10px; margin-top:10px; text-align: center;">
				<input type="submit" class="aButton ui-state-default ui-corner-all" value="<fmt:message key="label.continuar" />" />
			</p>
		</fieldset>
	</form>
	
	<jsp:include page="/WEB-INF/views/Corporativo/Mobile/icones.jsp">
		<jsp:param name="voltar" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv05&numeroOS=${param.numeroOS }&numeroCPF=${param.numeroCPF}"/>
	</jsp:include>