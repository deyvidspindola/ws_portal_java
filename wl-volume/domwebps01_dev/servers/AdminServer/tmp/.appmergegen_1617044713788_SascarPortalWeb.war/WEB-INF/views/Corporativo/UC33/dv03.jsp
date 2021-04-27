<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/SolicitarContaIndicador/pesquisarContaIndicador?acao=1" context="/SascarPortalWeb"  />
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


	<h1><fmt:message key="label.servicosIndicados" /></h1>
	
	<body>
		<table id="alter" cellspacing="0" cellpadding="1" width="700">
			<tbody>
				<tr>
					<th class="texttable_azul" width="100" scope="col"><fmt:message key="label.placa" /></th>
					<th class="texttable_cinza" width="300" scope="col"><fmt:message key="label.nomeDoCliente" /></th>
					<th class="texttable_cinza" width="100" scope="col"><fmt:message key="label.Status" /></th>
					<th class="texttable_cinza" width="100" scope="col"><fmt:message key="label.instalado" /></th>
					<th class="texttable_cinza" width="125" scope="col"><fmt:message key="label.valorFaturado" /></th>
					<th class="texttable_cinza" width="125" scope="col"><fmt:message key="label.valorIndicacao" /></th>
				</tr>
				 
				<c:forEach items="${listaContaIndicador}" var="contaIndicador" varStatus="status">
							
					<c:set var="bgColor" value="#EEEEEE"/>
					<c:if test="${status.count % 2 != 0 }">
						<c:set var="bgColor" value="#FFFFFF"/>
					</c:if>

					<tr style="background-color: ${bgColor}">
						<td class="linkazulescuro">${contaIndicador.veiculo.placa}</td>
						<td>${contaIndicador.cliente.nome}</td>
						<td>${contaIndicador.status}</td>
						<td>${contaIndicador.instalado}</td>
						<td>${contaIndicador.valorFaturado}</td>
						<td>${contaIndicador.valorIndicacao}</td>
					</tr>

				</c:forEach>
				
			</tbody>
			
		</table>
		
		
		<table id="alter" cellspacing="0" cellpadding="1" width="850">
			<tbody>
				<tr class="dif">
					<td class="texttable_azul" width="500" style="background-color: #fff; text-align: right;"><fmt:message key="label.total" /></td>
					<td width="250" style="background-color: #fff">${valorTotalContaIndicador}</td>
				</tr>
			</tbody>
		</table>

