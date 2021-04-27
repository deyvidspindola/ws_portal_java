<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/RetirarEquipamentosAcessorios/carregarOrdemServicoRetiradaEquipamentoAcessorios?acao=1" context="/SascarPortalWeb"  />
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
	$(document).ready(function(){
		$('#remover_equipamento').addClass('active');
	});
</script>

	<form id="formPesquisa" method="get" action="${pageContext.request.contextPath}/Satellite" >
		
		<input type="hidden" name="pagename"      value="SascarPortal_Corporativo/Mobile/RepresentanteTecnico" />
		<input type="hidden" name="page"          value="Corporativo/Mobile/UC34/dv02" />
		
		<input type="hidden" name="numeroOS"      value="${ordemServico.numero}" />
	    <input type="hidden" name="chassiVeiculo" value="${ordemServico.contrato.veiculo.chassi}" />
	    <input type="hidden" name="placaVeiculo"  value="${ordemServico.contrato.veiculo.placa}" />
	
		<table width="100%" cellpadding="0" cellspacing="5" border="0" class="dados">
			<tr>
	            <th><fmt:message key="label.NumOS" />:</th>
	            <td style="text-align:left; padding-left: 2px;">[${ordemServico.numero}]</td>
			</tr>
			<tr>
	            <th><fmt:message key="label.prioridade" />:</th>
	            <td style="text-align:left; padding-left: 2px;">[${ordemServico.prioridade}]</td>
			</tr>
			<tr>
	            <th><fmt:message key="label.Status" />:</th>
	            <td style="text-align:left; padding-left: 2px;">${ordemServico.status}</td>
	        </tr>
	        <tr>
	            <th><fmt:message key="label.cadastro" />:</th>
	            <td style="text-align:left; padding-left: 2px;">
					<fmt:formatDate value="${ordemServico.dataCadastro}" pattern="dd/MM/yyyy"/>
				</td>
	        </tr>
			<tr>
	            <th><fmt:message key="label.cliente" />:</th>
	            <td style="text-align:left; padding-left: 2px;">${ordemServico.contrato.contratante.nome}</td>
	        </tr>
	        <tr>
	            <th><fmt:message key="label.contrato" />:</th>	
	            <td style="text-align:left; padding-left: 2px; ">${ordemServico.contrato.tipoContrato}</td>
	        </tr>
	        <tr>
	            <th><fmt:message key="label.servico" />:</th>
	            <td style="text-align:left; padding-left: 2px;">${ordemServico.contrato.servicoContratado}</td>
	        </tr>
		</table>
		
		
		<fieldset>
			<legend><strong><fmt:message key="label.dadosCliente" /></strong></legend>
		
			<p class="input">
				<label><span><fmt:message key="label.cliente" />:</span></label><br />
				<input value="${ordemServico.contrato.contratante.nome}" 
				       type="text" readonly="readonly" name="nomeCliente" />
			</p>
	
			<p class="input">
				<label><span><fmt:message key="label.enderecoCliente" />:</span></label><br />
				<input value="${ordemServico.contrato.contratante.endereco.descricaoLogradouro}" 
				       type="text" readonly="readonly" name="enderecoCliente"  />
			</p>
	
			<p class="input">
				<label><span><fmt:message key="label.cepCliente" />:</span></label><br />
				<input type="text" readonly="readonly" name="cepCliente" value="${ordemServico.contrato.contratante.endereco.cep}" />
			</p>
	
			<p class="input">
				<label><span><fmt:message key="label.cidadeCliente" />:</span></label><br />
				<input value="${ordemServico.contrato.contratante.endereco.descricaoCidade}"  
					   type="text" readonly="readonly" name="cidadeCliente" />
			</p>
			
			<p class="input">
				<label><span><fmt:message key="label.estadoCliente" />:</span></label><br />
				<input value="${ordemServico.contrato.contratante.endereco.descricaoUf}" 
					   type="text" readonly="readonly" name="estadoCliente"  />
			</p>
		</fieldset>
		
		<br><br>
		
		<fieldset>
			<legend><strong><fmt:message key="label.dadosVeiculo" /></strong></legend>
		
			<p class="input">
				<label><span><fmt:message key="label.marca" />:</span></label><br />
				<input type="text" readonly="readonly" name="marca" value="${ordemServico.contrato.veiculo.descricaoMarca}"/>
			</p>
			
			<p class="input">
				<label><span><fmt:message key="label.ano" />:</span></label><br />
				<input type="text" readonly="readonly" name="ano" value="${ordemServico.contrato.veiculo.anoFabricacao}" />
			</p>
			
			<p class="input">
				<label><span><fmt:message key="label.chassi" />:</span></label><br />
				<input type="text" readonly="readonly" name="chassi" value="${ordemServico.contrato.veiculo.chassi}" />
			</p>
			
			<p class="input">
			<label><span><fmt:message key="label.particularidades" />:</span></label>
		</p>
		
		<div style="white-space:pre-wrap; text-align: left; margin: 3px 0 20px 5px; border: 1px solid #505050;">${ordemServico.observacao}</div>
			
			<p class="input">
				<label><span><fmt:message key="label.numeroContrato" />:</span></label><br />
				<input type="text" name="localInstalação" readonly="readonly" value="${ordemServico.contrato.numeroContrato}" />
			</p>
			
			<p class="input">
				<label><span><fmt:message key="label.modelo" />:</span></label><br />
				<input type="text" readonly="readonly" name="modelo" value="${ordemServico.contrato.veiculo.descricaoModelo}" />
			</p>
	
			<p class="input">
				<label><span><fmt:message key="label.placa" />:</span></label><br />
				<input type="text" readonly="readonly" name="placa" value="${ordemServico.contrato.veiculo.placa}" />
			</p>
			
			<p class="input">
				<label><span><fmt:message key="label.cor" />:</span></label><br />
				<input type="text" readonly="readonly" name="cor" value="${ordemServico.contrato.veiculo.cor}" />
			</p>
	
			<p class="input">
				<label><span><fmt:message key="label.localInstalacao" />:</span></label><br />
				<input type="text" name="localInstalação" readonly="readonly" value="${ordemServico.localInstalacaoEquipamento}" />
			</p>
			
			<p class="input" style="padding:10px; margin-top:10px; text-align: center;">
				<input type="submit" class="aButton ui-state-default ui-corner-all" value="<fmt:message key="label.continuar" />" />
			</p>	
		</fieldset>
	</form>

<jsp:include page="/WEB-INF/views/Corporativo/Mobile/icones.jsp">
	<jsp:param name="voltar" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv02"/>
</jsp:include>