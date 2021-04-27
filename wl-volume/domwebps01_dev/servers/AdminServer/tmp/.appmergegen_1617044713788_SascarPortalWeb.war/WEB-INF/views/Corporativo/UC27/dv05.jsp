<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/ConsultarBorderosPagos/listarOrdensServicoBordero?acao=2" context="/SascarPortalWeb"  />
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
	
		<input type="hidden" name="numeroBordero"     value="${param.numeroBordero}" />
		<input type="hidden" name="representante"     value="${param.representante}" />
		<input type="hidden" name="dataFechamento" 	  value="${param.dataFechamento}" />
		<input type="hidden" name="valorTotalBordero" value="${param.valorTotalBordero}" />
		<input type="hidden" name="filtroStatusBordero" value="${param.filtroStatusBordero}" />
	
		<table id="alter" cellspacing="0" cellpadding="2" width="850" style="border: medium none;">
			<tbody>
				<tr align="right">
					<th class="texttable_azul" align="right" width="100"><fmt:message key="label.nAbrevBordero" /></th>
					<td style="text-align: left;">${param.numeroBordero}</td>
				</tr>
				<tr>
					<th class="texttable_azul" align="right"><fmt:message key="label.dataInclusao" /></th>
					<td style="text-align: left;">${param.dataFechamento}</td>
				</tr>
				<tr>
					<th class="texttable_azul" align="right"><fmt:message key="label.representante" /></th>
					<td style="text-align: left;">${param.representante}</td>
				</tr>
			</tbody>
		</table>
				
		<h1><fmt:message key="label.itensDBordero" /></h1>
		
		<table width="850" cellpadding="1" id="alter" cellspacing="0">
		  <tr>
		    <th width="30%" class="texttable_cinza" scope="col" align="center"><fmt:message key="label.nAbrevOS" /></th>
		    <th width="40%" class="texttable_cinza" scope="col" align="center"><fmt:message key="label.cliente" /></th>
		    <th width="20%" class="texttable_cinza" scope="col" align="center"><fmt:message key="label.placa" /></th>
		    <th width="10%" class="texttable_cinza" scope="col" align="center"><fmt:message key="label.valor" /></th>
		  </tr>
		  
		  <c:forEach var="ordensServicoBordero" items="${listaOrdensServicoBordero}">
		  	
			<tr class="dif">
				<td>${ordensServicoBordero.numero}</td>
				<td>${ordensServicoBordero.contrato.contratante.nome}</td>
				<td>${ordensServicoBordero.veiculo.placa}</td>
				<td><fmt:formatNumber value="${ordensServicoBordero.valorTotal}" type="currency"/></td>
			</tr>
					  
		  </c:forEach>
		  
		</table>
		
		<table cellspacing="0" cellpadding="1" width="200" style="position: relative; float: right; margin: 0px 0px 0px 0px;">
				<tr>
					<td width="30%" class="texttable_azul"><fmt:message key="label.total" /></td>
					<td width="70%"><fmt:formatNumber value="${param.valorTotalBordero}" type="currency"/></td>
				</tr>
		</table>
		
		<table cellspacing="0" cellpadding="1" width="850">
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
