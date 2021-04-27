<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/VisualizarExtratoServicosExecutadosServlet/detalharOrdemServico?acao=4" context="/SascarPortalWeb"  />
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
		window.print();
	});
</script>

<table cellspacing="0" width="100%" cellpadding="1px" border="1px" bordercolor="666633" id="alter_extrato" cellspacing="0px">
	<tr class="barraazulzinha">
		<th class="barraazulzinha"><fmt:message key="label.detalhamentoOrdemServico" /></th>
	</tr>
</table>

<br/>
<br/>

<table cellspacing="0" width="100%" cellpadding="1px" border="1px" bordercolor="666633" id="alter_extrato" cellspacing="0px">

	<tbody>	
		
		<tr>
			<td width="50%" ><b><fmt:message key="label.NumOS" />:</b></td>
			<td width="50%" >${param.numeroOrdemServicoSelecionada}</td>
		</tr>
	
		<tr>
			<td width="50%" ><fmt:message key="label.classe" />:</td>
			<td width="50%" >${param.classe}</td>
		</tr>
		
		<tr>
			<td width="50%" ><fmt:message key="label.instalador" />:</td>
			<td width="50%" >${param.instalador}</td>
		</tr>
	</tbody>

</table>

<br/>
<br/>

<table cellspacing="0" width="100%" cellpadding="1px" border="1px" bordercolor="666633" id="alter_extrato" cellspacing="0px">
	<tbody>	 
		<tr>
			<td width="50%" ><fmt:message key="label.valorTotalServico" /> :</td>
			<td width="50%" ><fmt:formatNumber value="${valorTotalServico}" type="currency"/></td>
		</tr>
		<tr>
			<td width="50%" ><fmt:message key="label.deslocamento" /> :</td>
			<td width="50%" ><fmt:formatNumber value="${valorDeslocamento}" /> Km</td>
		</tr>
		<tr>
			<td width="50%" ><fmt:message key="label.valorDeslocamento" /> :</td>
			<td width="50%" ><fmt:formatNumber value="${quantidadeDeslocamento}" type="currency"/></td>
		</tr>
		<tr>
			<td width="50%" ><fmt:message key="label.pedagio" /> :</td>
			<td width="50%" ><fmt:formatNumber value="${valorPedagio}" type="currency"/></td>
		</tr>
		<!-- <tr>
			<td width="50%" >Custo Eficiencia Operacional :</td>
			<td width="50%" ><fmt:formatNumber value="${param.valorCustoEficiencia}" type="currency"/></td>
		</tr>  -->
		<tr>
			<td width="50%" ><fmt:message key="label.valorTotalOrdemServico" /> :</td>
			<td width="50%" ><fmt:formatNumber value="${valorTotalServico +  (quantidadeDeslocamento *  valorDeslocamento)  + valorPedagio }" type="currency"/></td>
		</tr>
	</tbody>
		
</table>

<br/>
<br/>

<table cellspacing="0" width="100%" cellpadding="1px" border="1px" bordercolor="666633" id="alter_extrato" cellspacing="0px">
	<thead>
		<tr>
			<th width="70%" ><fmt:message key="label.Motivo" /></th>
			<th width="30%" ><fmt:message key="label.valorServico" /></th>
		</tr>
	</thead>
	
	<c:forEach var="ordemServico" items="${ordensServico}" varStatus="status">
		<tbody>	 
			<tr>
				<td width="70%">${ordemServico.observacao}</td>
				<td width="30%" style="text-align: center;"><fmt:formatNumber value="${ordemServico.valorServico}" type="currency"/></td>
			</tr>
		</tbody>
	</c:forEach>
		
</table>

