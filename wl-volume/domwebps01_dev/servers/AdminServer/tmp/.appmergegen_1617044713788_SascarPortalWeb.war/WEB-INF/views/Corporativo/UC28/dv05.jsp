<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/ConsultarBorderosPagos/detalharOrdemServicoBordero?acao=3" context="/SascarPortalWeb"  />
</c:catch>

<c:if test="${not empty mensagem }">
	<script type="text/javascript">
		$.showMessage('${mensagem}');
	</script>
</c:if>

<c:if test="${not empty helper}">
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>

	<div class="cabecalho3" style="padding-left: 40px; width: 920px;">
	
		<fmt:message key="label.borderosTramitacao" />
		
		<span style="font-size: 11px;"> - <fmt:message key="label.conjuntoOSAbrev" /></span>
		
		<div class="caminho" style="margin-left: 200px;">
			<a class="linktres" title="<fmt:message key="label.home" />" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}"><fmt:message key="label.home" /></a>
			&gt;
			<a class="linktres" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC28/dv01"><fmt:message key="label.pagamentos" /></a>
			&gt;
			<a class="linkquatro" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC28/dv01"><fmt:message key="label.borderosTramitacao" /></a>
		</div>
	</div>

	<table class="tbatualizacao" cellspacing="0" width="1026">
		<tbody>
			<tr class="tbatualizacao">
				<th class="barraazulzinha"><fmt:message key="label.detalhesOS" /></th>
			</tr>
		</tbody>
	</table>

<form id="formVoltar" method="post" 
	  action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC28/dv04">

	<input type="hidden" name="numeroBordero"  value="${param.numeroBordero}" />
	
	<input type="hidden" id="filtroNumeroOS" 			   name="filtrotNumeroOS" 			   value="${param.filtroNumeroOS}" />
	<input type="hidden" id="filtroNumeroBordero" 		   name="filtroNumeroBordero" 		   value="${param.filtroNumeroBordero}" />
	<input type="hidden" id="filtroDataInicialFechamento"  name="filtroDataInicialFechamento"  value="${param.filtroDataInicialFechamento}" />
	<input type="hidden" id="filtroDataFinalFechamento"    name="filtroDataFinalFechamento"    value="${param.filtroDataFinalFechamento}" />
	<input type="hidden" id="filtroStatusBordero"          name="filtroStatusBordero"          value="${param.filtroStatusBordero}" />
	
	<input type="hidden" id="filtroImputNumeroOS" 			   name="filtroImputNumeroOS" 			   value="${param.filtroNumeroOS}" />
	<input type="hidden" id="filtroImputNumeroBordero" 		   name="filtroImputNumeroBordero" 		   value="${param.filtroNumeroBordero}" />
	<input type="hidden" id="filtroImputDataInicialFechamento" name="filtroImputDataInicialFechamento" value="${param.filtroDataInicialFechamento}" />
	<input type="hidden" id="filtroImputDataFinalFechamento"   name="filtroImputDataFinalFechamento"   value="${param.filtroDataFinalFechamento}" />
	<input type="hidden" id="filtroImputStatusBordero"         name="filtroImputStatusBordero"         value="${param.filtroStatusBordero}" />

	<table class="detalhe2" cellspacing="3" width="900">
		<tbody>
				<tr>
				<th class="barracinza" width="200px"><fmt:message key="label.numDaOrdemServico" /></th>
				<td class="camposinternos" width="350px">${ordemServico.numero}</td>
				<th class="barracinza" width="200px"> <fmt:message key="label.cliente" /></th>
				<td class="camposinternos" width="350px">${ordemServico.contrato.contratante.nome}</td>
			</tr>
			<tr>
				<th class="barracinza" width="200px"><fmt:message key="label.placa" /></th>
				<td class="camposinternos" width="350px">${ordemServico.contrato.veiculo.placa}</td>
				<th class="barracinza" width="200px"><fmt:message key="label.servicoContratado" /></th>
				<td class="camposinternos" width="350px">${ordemServico.contrato.servicoContratado}</td>
			</tr>
			<tr></tr>
			<tr>
				<th class="barracinza" width="200px"><fmt:message key="label.tipoContrato" /></th>
				<td class="camposinternos" width="350px">${ordemServico.contrato.tipoContrato}</td>
				<th class="barracinza" width="200px"><fmt:message key="label.valorDeslocamento" /></th>
				<td class="camposinternos" width="350px">
					<fmt:formatNumber value="${ordemServico.valorDeslocamento}" type="currency" />
				</td>
			</tr>
			<tr>
				<th class="barracinza" width="200px"><fmt:message key="label.valorPedagio" /></th>
				<td class="camposinternos" width="350px">
					<fmt:formatNumber value="${ordemServico.valorPedagio}" type="currency" />
				</td>
				<th class="barracinza" width="200px"><fmt:message key="label.valorServico" /></th>
				<td class="camposinternos" width="350px">
					<fmt:formatNumber value="${ordemServico.valorServico}" type="currency" />
				</td>
			</tr>
			<tr>
				<th>&nbsp;</th>
				<td class="camposinternos" width="350px">&nbsp;</td>
				<th class="barracinza" width="200px"><fmt:message key="label.valorTotal" /></th>
				<td class="camposinternos" width="350px">
					<fmt:formatNumber value="${ordemServico.valorTotalOrdemServico}" type="currency" />
				</td>
			</tr>
		</tbody>
	</table>
	
		
	<div class="botaovoltar">
		<input class="button3" type="submit" value="<fmt:message key="label.voltar" />" name="Voltar" />
	</div>

</form>