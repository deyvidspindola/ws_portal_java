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
		$("div.breadcrumb").html('<fmt:message key="mensagem.atendimentoAtivo" />');
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

<table cellspacing="0" class="detalhe" >
	<tr class="barraazulzinha">
		<th class="barraazulzinha"><fmt:message key="uc10.dv03.confirmeDadosAtivacao" /></th>
	</tr>
</table>

<table width="960" cellspacing="3" class="detalhe2">
	<tr>
		<th width="200px" class="barracinza"><fmt:message key="label.NumOS" /></th>
		<td width="350px" class="camposinternos">${ordemServico.numero}</td>
		
		<th width="200px" class="barracinza"><fmt:message key="label.dataCadastro" /></th>
		<td width="350px" class="camposinternos"><fmt:formatDate value="${ordemServico.dataCadastro}" pattern="dd/MM/yyyy"/>&nbsp;</td></td>
    </tr>
	<tr>
		<th width="200px" class="barracinza"><fmt:message key="label.tipoDeContato" /></th>
		<td width="350px" class="camposinternos">${ordemServico.contrato.tipoContrato}</td>
		
		<th width="200px" class="barracinza"><fmt:message key="label.Status" /></th>
		<td width="350px" class="camposinternos">${ordemServico.status}</td>
	</tr>
	<tr>
		<th width="200px" class="barracinza"><fmt:message key="label.servicoContrato" /></th>
		<td width="350px" class="camposinternos">${ordemServico.contrato.servicoContratado}</td>		
	
	  	<th width="200px" class="barracinza"><fmt:message key="label.prioridade" /></th>
		<td width="350px" class="camposinternos">${ordemServico.prioridade}</td>		
	</tr>
	<tr>
		<th width="200px" class="barracinza"><fmt:message key="label.modalidade" /></th>
		<td width="350px" class="camposinternos">${ordemServico.modalidade}</td>		
	</tr>
</table>

<div class="hr"></div>

<table cellspacing="0" class="detalhe" >
	<tr class="barraazulzinha">
		<th class="barraazulzinha"><fmt:message key="label.dadosCliente" /></th>
	</tr>
</table>

<table width="900" cellspacing="3" class="detalhe2">
	<tr>
		<th width="200px" class="barracinza"><fmt:message key="label.NomeCliente" /></th>
		<td width="300px" class="camposinternos">${ordemServico.contrato.contratante.nome}</td>
		<th width="200px" class="barracinza"><fmt:message key="label.endereco" /></th>
		<td width="300px" class="camposinternos">${ordemServico.contrato.contratante.endereco.descricaoLogradouro}</td>
		<td width="100px" rowspan="3">
			<c:if test="${true == ordemServico.contrato.contratante.clienteEspecial}">
				<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/especial.png" width="60" height="60" hspace="10" vspace="20" border="0" />
			</c:if>
		</td>
	</tr>
	<tr>
		<th width="200px" class="barracinza"><fmt:message key="label.cep" /></th>
		<td width="300px" class="camposinternos">${ordemServico.contrato.contratante.endereco.cep}</td>
		<th width="200px" class="barracinza"><fmt:message key="label.cidade" /></th>
		<td width="300px" class="camposinternos">${ordemServico.contrato.contratante.endereco.descricaoCidade}</td>
	</tr>
	<tr>					
		<th width="200px" class="barracinza"><fmt:message key="label.estado" /></th>
		<td width="300px" class="camposinternos">${ordemServico.contrato.contratante.endereco.uf}</td>
	</tr>
</table>

<div class="hr"></div>

<table cellspacing="0" class="detalhe" >
	<tr class="barraazulzinha">
		<th class="barraazulzinha"><fmt:message key="label.dadosVeiculo" /></th>
	</tr>
</table>

<form action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv04" method="post" id="formTrocaVeiculo" class="filtro">
	<input type="hidden" name="numeroOS" value="${param.numeroOS }" />
	<input type="hidden" name="numeroContrato" value="${ordemServico.contrato.numeroContrato}" />
	<input type="hidden" name="isPossuiRedeAcessorio" value="${isPossuiRedeAcessorio }" />
	
	<table width="900" cellspacing="3" class="detalhe2">
		<tr>
			<th width="200px" class="barracinza"><fmt:message key="label.marca" /></th>
			<td width="350px" class="camposinternos">
	        	<select style="width:250px; margin:0" name="marca" disabled="disabled"><option>${ordemServico.contrato.veiculo.descricaoMarca}</option></select>
	      	</td>
			<th width="200px" class="barracinza"><fmt:message key="label.modelo" /></th>
			<td width="350px" class="camposinternos">
	        	<select style="width:250px; margin:0" name="modelo" disabled="disabled"><option>${ordemServico.contrato.veiculo.descricaoModelo}</option></select>
	      	</td>
		</tr>
		<tr>
			<th width="200px" class="barracinza"><fmt:message key="label.ano" /></th>
			<td width="350px" class="camposinternos">
				<input type="text" name="ano" disabled="disabled" value="${ordemServico.contrato.veiculo.anoFabricacao}" />
			</td>
			<th width="200px" class="barracinza"><fmt:message key="label.placa" /></th>
			<td width="350px" class="camposinternos">
				<input type="text" name="placa" disabled="disabled"  value="${ordemServico.contrato.veiculo.placa}" />
			</td>
		</tr>
		<tr>
			<th width="200px" class="barracinza"><fmt:message key="label.chassi" /></th>
			<td width="350px" class="camposinternos">
				<input type="text" name="chassi" disabled="disabled" value="${ordemServico.contrato.veiculo.chassi}" />
			</td>
			<th width="200px" class="barracinza"><fmt:message key="label.cor" /></th>
			<td width="350px"class="camposinternos">
				<input type="text" name="cor" disabled="disabled" value="${ordemServico.contrato.veiculo.cor}" />
			</td>
		</tr>
		<tr>
			<th width="200px" class="barracinza"><fmt:message key="label.particularidades" /></th>
			<td width="350px" class="camposinternos">
				<textarea style="width:250px; margin:0" disabled="disabled" name="observacao" readonly="readonly" id="observacao" >${ordemServico.observacao}</textarea>
			</td>
			<th width="200px" class="barracinza"><fmt:message key="label.localInstalacao" /></th>
			<td width="350px" class="camposinternos">
				<input style="width:250px; margin:0" type="text" name="cor" disabled="disabled" value="${ordemServico.localInstalacaoEquipamento}" />
			</td>
		</tr>
		<tr>
			<th width="200px" class="barracinza"><fmt:message key="label.numeroContrato" /></th>
			<td width="350px" class="camposinternos">${ordemServico.contrato.numeroContrato}</td>
		</tr>
	</table>
	<br/>
	<div style="text-align: center;">
		<input type="button" class="button4" value="<fmt:message key="label.voltar" />" onclick="window.location.href='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv01';" />
		<input type="submit" class="button" value="<fmt:message key="label.continuar" />" />
	</div>
</form>
