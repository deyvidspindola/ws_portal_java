<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/ConsultarBorderosPagos/recuperarOrdensServicoBorderoGerado?acao=6" context="/SascarPortalWeb"  />
</c:catch>

<c:if test="${not empty mensagem }">
	<script type="text/javascript">
		$.showMessage("${mensagem}");
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

	<form method="post" onsubmit="openPopupPrint(this);" action="">
	
		<input type="hidden" name="numeroBordero" 		 id="numeroBordero" value="${param.numeroBordero}" />
		<input type="hidden" name="representanteBordero" id="representanteBordero" value="${param.representanteBordero}" />
		<input type="hidden" name="dataInclusaoBordero"  id="dataInclusaoBordero" value="${param.dataInclusaoBordero}" />
	
		<table id="alter" cellspacing="0" cellpadding="2" width="800" style="border: medium none;">
			<tbody>
				<tr align="right">
					<th class="texttable_azul" align="right" width="100px"><fmt:message key="label.nAbrevBordero" /></th>
					<td style="text-align: left;">${param.numeroBordero}</td>
				</tr>
				<tr>
					<th class="texttable_azul" align="right"><fmt:message key="label.dataInclusao" /></th>
					<td style="text-align: left;">${param.dataInclusaoBordero}</td>
				</tr>
				<tr>
					<th class="texttable_azul" align="right"><fmt:message key="label.representante" /></th>
					<td style="text-align: left;">${param.representanteBordero}</td>
				</tr>
			</tbody>
		</table>
	
		<h1>Itens do Borderô</h1>
			
		<table id="alter" cellspacing="0" cellpadding="1" width="800">
			<tr>
				<th class="texttable_cinza tooltip" width="23%" title="Data da abertura do serviço" scope="col"><fmt:message key="label.nAbrevOS" /></th>
				<th class="texttable_cinza" width="8%" scope="col"><fmt:message key="label.cliente" /></th>
				<th class="texttable_cinza" width="16%" scope="col"><fmt:message key="label.placa" /></th>
				<th class="texttable_cinza" width="16%" scope="col"><fmt:message key="label.valor" /></th>
			</tr>
				
			<c:forEach var="ordensServicoBordero" items="${listaOrdensServicoBordero}" varStatus="status">
				<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if>>
					<td>${ordensServicoBordero.numero}</td>
					<td>${ordensServicoBordero.contrato.contratante.nome}</td>
					<td>${ordensServicoBordero.veiculo.placa}</td>
					<td><fmt:formatNumber value="${ordensServicoBordero.valorTotal}" type="currency"/></td>
				</tr>
			</c:forEach>	
			
			<tr class="dif">
				<td class="texttable_cinza" style="background-color: rgb(255, 255, 255); text-align: right;" colspan="3"><fmt:message key="label.total" /></td>
				<td style="background-color: rgb(255, 255, 255);"><fmt:formatNumber value="${valorTotalBordero}" type="currency"/></td>
			</tr>
		</table>
					
		<table cellspacing="0" cellpadding="1" width="800">
			<tbody>
				<tr>
					<th class="texttable_azul" align="right" width="100"><fmt:message key="label.assinatura" /></th>
					<td style="border-bottom: 1px solid rgb(102, 102, 102);">&nbsp;</td>
				</tr>
				<tr>
					<th class="texttable_azul" align="right"><fmt:message key="label.data" />:</th>
					<td style="border-bottom: 1px solid rgb(102, 102, 102);">&nbsp;</td>
				</tr>
			</tbody>
		</table>
	
	</form>
