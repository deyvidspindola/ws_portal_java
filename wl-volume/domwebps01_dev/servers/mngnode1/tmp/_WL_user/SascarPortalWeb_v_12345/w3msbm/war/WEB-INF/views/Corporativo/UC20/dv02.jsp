<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/VisualizarPagamentosServicosExecutadosServlet/recuperarPagamentos?acao=1" context="/SascarPortalWeb"  />
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
	
	
	<jsp:include page="/WEB-INF/views/Corporativo/UC20/dv01.jsp"/>

	<c:if test="${not empty pagamentos}">
		
		<div class="hr"></div>
		
		<h1><fmt:message key="label.resultadoDaBusca" /></h1>
		
		<span class="texthelp2">
			<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" /> <fmt:message key="label.legendaParaStatus" />:
			<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/status_A.png" width="16" height="16" align="absmiddle" /><fmt:message key="label.pago" />
			<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/status_P.png" width="16" height="16" align="absmiddle" /><fmt:message key="label.pendente" /> 
		</span>
		
		
		<table width="750" cellpadding="1px" id="alter" cellspacing="0px">
			<tr>
				<th width="17%" class="texttable_azul" scope="col"><fmt:message key="label.numNotaFiscal" /></th>
				<th width="18%" class="texttable_cinza" scope="col"><fmt:message key="label.vencimento" /></th>
				<th width="10%" class="texttable_azul"  scope="col"><fmt:message key="label.Status" /></th>
				<th width="11%" class="texttable_cinza" scope="col"><fmt:message key="label.valor" /></th>
				<th width="15%" class="texttable_cinza" scope="col"><fmt:message key="label.pagoEm" /></th>
				<th width="29%" class="texttable_azul" scope="col"><fmt:message key="label.valorPago" /></th>
			</tr>
			<c:forEach var="notaFiscal" items="${pagamentos}">
				<tr class="dif">
					<td class="linkazul">${notaFiscal.numeroReferencia}</td>
					<td>
						<fmt:formatDate value="${notaFiscal.dataVencimento}" pattern="dd/MM/yyyy" />
					</td>
					<td class="linkazulescuro">
						<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/status_${notaFiscal.status}.png" alt="${notaFiscal.status}" title="${notaFiscal.status}" />
					</td>
					<td>
						<fmt:formatNumber value="${notaFiscal.valor}" type="currency"/>
					</td>
					<td>
						<fmt:formatDate value="${notaFiscal.dataPagamento}" pattern="dd/MM/yyyy" />
					</td>
					<td class="linkazulescuro">
						<fmt:formatNumber value="${notaFiscal.valorPago}" type="currency"/>
					</td>
					<c:set var="totalValor" value="${totalValor + notaFiscal.valor}"/>
					<c:set var="totalPago" value="${totalPago + notaFiscal.valorPago}"/>
				</tr>
			</c:forEach>
				<tr>
					<th width="17%" class="texttable_azul2" scope="col"><fmt:message key="label.total" /></th>
					<th width="18%" class="texttable_cinza2" scope="col">&nbsp;</th>
					<th width="10%" class="texttable_azul2"  scope="col">&nbsp;</th>
					<th width="11%" class="texttable_cinza2" scope="col"><fmt:formatNumber value="${totalValor}" type="currency"/></th>
					<th width="15%" class="texttable_cinza2" scope="col">&nbsp;</th>
					<th width="29%" class="texttable_azul2" scope="col"><fmt:formatNumber value="${totalPago}" type="currency"/></th>
				</tr>
		</table>
	</c:if>
		
		