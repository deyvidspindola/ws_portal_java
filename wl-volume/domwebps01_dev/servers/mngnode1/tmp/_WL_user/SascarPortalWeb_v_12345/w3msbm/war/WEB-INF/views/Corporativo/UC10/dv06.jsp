<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/AtivarEquipamentoVinculo/recuperarEquipamento?acao=4" context="/SascarPortalWeb"  />
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
					$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv07");
					$(form).unbind('submit').submit();
				} else {
					$(form).attr("action", "");
					$.showMessage(json.mensagem);
				}
			}
		});
	}

	$(document).ready(function(){
		
		$('#rf').setMask({mask:'999'});
		
		$("div.breadcrumb").html('<fmt:message key="mensagem.informacao.atendimentoAtivacaoAutomaticaEquipamento" />');

		var container = $('div.container2');
		$("#formVinculacaoEquipamento").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler : function(form) {
				// Valor usado para não submeter o equipamento e sim avançar para a próxima página,
				// pois o equipamento já está vinculado
				var totalDesabilitados = $("#formVinculacaoEquipamento :disabled").length;

				var bloquearPorFoto = $("#bloquearPorFoto").val();
				
				if(bloquearPorFoto == 'false'){
					if (totalDesabilitados === 4) {
						$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv07");
						$(form).unbind('submit').submit();
					} else {
						submterEquipamento(form);
					}
				}else {
					$(form).attr("action", "");
					$.showMessage('<fmt:message key="uc10.dv06.envioFotoObrigatorio" />');
				}
			}
		});
	});
</script>


	<div class="cabecalho">
		<div class="caminho" style="*margin-left:400px;">
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="Home" class="linktres"><fmt:message key="label.home" /></a> &gt; 
			<a href="#" class="linktres"><fmt:message key="label.servicos" /></a> &gt; 
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv01" class="linkquatro"><fmt:message key="label.ativacaoEquipamento" /></a>
		</div>
	  	<fmt:message key="label.ativacaoEquipamento" />
	</div>

	<div class="container2"> 
		<ol>
			<li><label for="numeroSerial" class="error"><fmt:message key="mensagem.campo.InformeSerial" /></label></li>
			<li><label for="codigoLocalInstalacaoEquipamento" class="error"><fmt:message key="uc10.dv06.selecioneInstalacaoEquipamento" /></label></li>
			<li><label for="codigoLocalInstalacaoAntenaGPS" class="error"><fmt:message key="uc10.dv06.selecioneInstalacaoAntenaGPS" /></label></li>
			<li><label for="codigoLocalInstalacaoAntenaGSM" class="error"><fmt:message key="uc10.dv06.selectioneInstalacaoAntenaGSM" /></label></li>
		</ol>
	</div>

	<table cellspacing="0" class="detalhe" >
		<tr class="barraazulzinha">
			<th class="barraazulzinha"><fmt:message key="uc10.dv06.vinculacaoEquipamento" /></th>
		</tr>
	</table>

	<!-- FORM VOLTAR -->
	<form method="post"	id="formVoltar"	action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv05">
		<input type="hidden" name="numeroCPF" value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS" value="${param.numeroOS }" />
	</form>


	<form action=""	method="post" id="formVinculacaoEquipamento" class="filtro">
		<input type="hidden" name="numeroCPF" value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS" value="${param.numeroOS }" />
		<input type="hidden" name="tipoSubmeter" value="A" />
		<input type="hidden" id="bloquearPorFoto" name="bloquearPorFoto" value="${bloquearPorFoto }" />
		
	
		<table width="900" cellspacing="3" class="detalhe2">
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.NumOS" /></th>
				<td width="350px" class="camposinternos">${ordemServicoResumida.numero}</td>
			  	<th width="200px" class="barracinza"><fmt:message key="label.placa" /></th>
				<td  width="350px" class="camposinternos">${ordemServicoResumida.contrato.veiculo.placa}</td>
			</tr>
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.chassi" /></th>
				<td width="350px" class="camposinternos">${ordemServicoResumida.contrato.veiculo.chassi}</td>
				<th width="200px" class="barracinza"><fmt:message key="label.servicoContrato" /></th>
				<td width="350px" class="camposinternos">${ordemServicoResumida.contrato.servicoContratado}</td>
			</tr>
		    <tr>
				<th width="200px" class="barracinza"><fmt:message key="label.serial" /></th>
				<td width="420px" class="camposinternos">
					<input type="text" 
					        size="25"
							name="numeroSerial" 
							id="numeroSerial" 
							maxlength="24"
							class="text required" 
							value="${equipamento.numeroSerial }"
							<c:if test="${not empty equipamento.numeroSerial}">disabled="disabled"</c:if>/>
				</td>
				<%-- 
				<c:if test="${not empty equipamento.cargoTracck and equipamento.cargoTracck == 't'}">
					<th width="200px" class="barracinza">RF</th>
					<td width="350px" class="camposinternos">
						<input type="text" 
					        size="3"
							name="rf" 
							id="rf" 
							maxlength="3"
							class="text required" 
							value="${equipamento.rf}" />
					</td>
				</c:if> 
				--%>
			</tr>
			<tr>
				<th width="400px" class="barracinza"><fmt:message key="label.localInstalacao" />:</th>
				<td colspan="2" width="350px" class="camposinternos">
					<select name="codigoLocalInstalacaoEquipamento"	id="codigoLocalInstalacaoEquipamento" class="required"
							<c:if test="${not empty equipamento.numeroSerial}">disabled="disabled"</c:if>>
								<option value=""><fmt:message key="label.selecione" /></option>
							<c:forEach items="${locaisInstalacaoEquipamento }" var="local">
								<c:if test="${not empty local.identifier and not empty local.value}">
									<option <c:if test="${equipamento.codigoLocalInstalacaoEquipamento eq local.identifier}">selected="selected"</c:if> value="${local.identifier}">${local.value}</option>
								</c:if>
							</c:forEach>
					</select>
				</td>
			</tr>
		    <tr>
				<th width="400px" class="barracinza"><fmt:message key="uc10.dv06.localInstalacaoAntenaGPS" />:</th>
				<td width="350px"  colspan="2"  class="camposinternos">
					<select name="codigoLocalInstalacaoAntenaGPS" id="codigoLocalInstalacaoAntenaGPS" class="required"
							<c:if test="${not empty equipamento.numeroSerial}">disabled="disabled"</c:if>>
								<option value=""><fmt:message key="label.selecione" /></option>
							<c:forEach items="${locaisInstalacaoAntenaGPS }" var="local">
								<c:if test="${not empty local.identifier and not empty local.value}">
									<option <c:if test="${equipamento.codigoLocalInstalacaoAntenaGPS eq local.identifier}">selected="selected"</c:if> value="${local.identifier}">${local.value}</option>
								</c:if>
							</c:forEach>
					</select>
				</td>
			</tr> 
			<tr>
				<th width="400px" class="barracinza"><fmt:message key="uc10.dv01.localInstalacaoAntenaGSM" />:</th>
				<td width="350px"  colspan="2"  class="camposinternos">
					<select name="codigoLocalInstalacaoAntenaGSM" id="codigoLocalInstalacaoAntenaGSM" class="required"
							<c:if test="${not empty equipamento.numeroSerial}">disabled="disabled"</c:if>>
								<option value=""><fmt:message key="label.selecione" /></option>
							<c:forEach items="${locaisInstalacaoAntenaGSM }" var="local">
								<c:if test="${not empty local.identifier and not empty local.value}">
									<option <c:if test="${equipamento.codigoLocalInstalacaoAntenaGSM eq local.identifier}">selected="selected"</c:if> value="${local.identifier}">${local.value}</option>
								</c:if>
							</c:forEach>
					</select>
				</td>
			</tr>
		</table>
		
		<div class="pgstabela">
			<p>
			    <input type="button" class="button4" value="<fmt:message key="label.voltar" />" onclick="$('#formVoltar').submit();" />
	        	<input type="submit" class="button" value="<fmt:message key="label.continuar" />" />
		    </p>
		</div>
	</form>