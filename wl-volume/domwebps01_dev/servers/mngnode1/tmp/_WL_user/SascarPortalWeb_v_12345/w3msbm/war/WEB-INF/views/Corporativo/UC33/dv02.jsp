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
		$(window).unbind();
	});
</script>

<jsp:include page="/WEB-INF/views/Corporativo/UC33/dv01.jsp" />

	<form id="formPesquisa" 
		  method="post"
	      onsubmit="openPopupPrint(this);"
		  action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Imprimir&page=Corporativo/UC33/dv04" >
		
			
		<div style="margin-top:30px;">
	
		<h1><fmt:message key="label.resultadoDaBusca" /></h1>
		
		<div class="busca_branca">
			<span class="text1"><fmt:message key="uc33.texto.002.resultadoApresentaServicos" />:</span>
		</div>
	
	
		<table id="alter" cellspacing="0" cellpadding="1" width="850">
			<tbody>
				<tr>
					<th width="100" scope="col"><fmt:message key="label.placa" /></th>
					<th width="300" scope="col"><fmt:message key="label.nomeDoCliente" /></th>
					<th width="100" scope="col"><fmt:message key="label.Status" /></th>
					<th width="100" scope="col"><fmt:message key="label.instalado" /></th>
					<th width="125" scope="col"><fmt:message key="label.valorFaturado" /></th>
					<th width="125" scope="col"><fmt:message key="label.valorIndicacao" /></th>
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
	</div>
	
	
	<div class="pgstabela">
	
		<input id="btnBaixar" 
			   class="button tooltip" 
			   title="Baixar" 
			   type="button" 
			   style="*margin-left:60px;" 
			   onclick="window.location.href='/SascarPortalWeb/SolicitarContaIndicador/gerarRelatorioExcel?acao=2&nomeCliente=${param.nomeCliente}&dataInicial=${param.dataInicial}&dataFinal=${param.dataFinal}&filtroStatus=${param.filtroStatus}'" 
			   value="<fmt:message key="btn.baixar" />" 
			   name="buttonRelatorioExcel" >
			   
		<input id="btnImprimir" 
			   class="button tooltip" 
			   title="Imprimir" 
			   type="submit" 
			   value="<fmt:message key="label.imprimir" />" 
			   name="button">
			   
		
	</div>
</form>

