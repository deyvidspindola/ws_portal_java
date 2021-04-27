<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/AtivarEquipamentoVinculo/detalharOrdemServicoAtivacao?acao=2" context="/SascarPortalWeb"  />
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
		$('#ativar_equipamento').addClass('active');
	});
</script>

<form id="formPesquisa"
		method="post"
		action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv04&numeroOS=${param.numeroOS }">

	<table width="100%" cellpadding="0" cellspacing="5" border="0" class="dados">
		<tr>
            <th><fmt:message key="label.NumOS" />:</th>
            <td style="text-align:left; padding-left: 2px;">[${ordemServico.numero}]</td>
		</tr>
		<tr>
		    <th><fmt:message key="label.dataCadastro" /></th>
		    <td style="text-align:left; padding-left: 2px; "><fmt:formatDate value="${ordemServico.dataCadastro}" pattern="dd/MM/yyyy"/>&nbsp;</td>
	    </tr>		
		<tr>
            <th><fmt:message key="label.prioridade" />:</th>
            <td style="text-align:left; padding-left: 2px;">[${ordemServico.prioridade}]</td>
		</tr>
        <tr>
            <th><fmt:message key="label.contrato" />:</th>	
            <td style="text-align:left; padding-left: 2px; ">${ordemServico.contrato.tipoContrato}</td>
        </tr>
        <tr>
            <th><fmt:message key="label.Status" />:</th>
            <td style="text-align:left; padding-left: 2px;">${ordemServico.status}</td>
        </tr>
        <tr>
            <th><fmt:message key="label.servicos" />:</th>
            <td style="text-align:left; padding-left: 2px;">${ordemServico.contrato.servicoContratado}</td>
        </tr>
        <tr>
            <th><fmt:message key="label.modalidade" />:</th>
            <td style="text-align:left; padding-left: 2px;">${ordemServico.modalidade}</td>
        </tr>
        
	</table>
	
	
	<fieldset>
		<legend><strong><fmt:message key="label.dadosCliente" /></strong></legend>
	
		<p class="input">
			<label><span><fmt:message key="label.cliente" />:</span></label><br />
			<input type="text" readonly="readonly" name="marca" value="${ordemServico.contrato.contratante.nome}"/>
		</p>

		<p class="input">
			<label><span><fmt:message key="label.enderecoCliente" />:</span></label><br />
			<input type="text" readonly="readonly" name="modelo" value="${ordemServico.contrato.contratante.endereco.descricaoLogradouro}" />
		</p>

		<p class="input">
			<label><span><fmt:message key="label.cepCliente" />:</span></label><br />
			<input type="text" readonly="readonly" name="ano" value="${ordemServico.contrato.contratante.endereco.cep}" />
		</p>

		<p class="input">
			<label><span><fmt:message key="label.cidadeCliente" />:</span></label><br />
			<input type="text" readonly="readonly" name="placa" value="${ordemServico.contrato.contratante.endereco.descricaoCidade}" />
		</p>
		
		<p class="input">
			<label><span><fmt:message key="label.estadoCliente" />:</span></label><br />
			<input type="text" readonly="readonly" name="chassi" value="${ordemServico.contrato.contratante.endereco.uf}" />
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
			<label><span><fmt:message key="label.modelo" />:</span></label><br />
			<input type="text" readonly="readonly" name="modelo" value="${ordemServico.contrato.veiculo.descricaoModelo}" />
		</p>

		<p class="input">
			<label><span><fmt:message key="label.ano" />:</span></label><br />
			<input type="text" readonly="readonly" name="ano" value="${ordemServico.contrato.veiculo.anoFabricacao}" />
		</p>

		<p class="input">
			<label><span><fmt:message key="label.placa" />:</span></label><br />
			<input type="text" readonly="readonly" name="placa" value="${ordemServico.contrato.veiculo.placa}" />
		</p>
		
		<p class="input">
			<label><span><fmt:message key="label.chassi" />:</span></label><br />
			<input type="text" readonly="readonly" name="chassi" value="${ordemServico.contrato.veiculo.chassi}" />
		</p>
		
		<p class="input">
			<label><span><fmt:message key="label.cor" />:</span></label><br />
			<input type="text" readonly="readonly" name="cor" value="${ordemServico.contrato.veiculo.cor}" />
		</p>
		
		<p class="input">
			<label><span><fmt:message key="label.particularidades" />:</span></label>
		</p>
		
		<div style="white-space:pre-wrap; text-align: left; margin: 3px 0 20px 5px; border: 1px solid #505050;">${ordemServico.observacao }</div>

		<p class="input">
			<label><span><fmt:message key="label.localInstalacao" />:</span></label><br />
			<input type="text" name="localInstalação" readonly="readonly" value="${ordemServico.localInstalacaoEquipamento}" />
		</p>

		<p class="input">
			<label><span><fmt:message key="label.numeroContrato" />:</span></label><br />
			<input type="text" name="localInstalação" readonly="readonly" value="${ordemServico.contrato.numeroContrato}" />
		</p>
		
		<p class="input" style="padding:10px; margin-top:10px; text-align: center;">
			<input type="submit" class="aButton ui-state-default ui-corner-all" value="<fmt:message key="label.continuar" />" />
		</p>	
	</fieldset>
</form>

<jsp:include page="/WEB-INF/views/Corporativo/Mobile/icones.jsp">
	<jsp:param name="voltar" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv01"/>
</jsp:include>