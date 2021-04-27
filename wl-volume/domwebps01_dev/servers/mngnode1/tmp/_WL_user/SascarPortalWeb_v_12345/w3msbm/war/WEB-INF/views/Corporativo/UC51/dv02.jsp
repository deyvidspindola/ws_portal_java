<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/EnviarSolicitacaoLoteServlet/pesquisarSolicitacao?acao=3" context="/SascarPortalWeb"  />
</c:catch>

<c:if test="${not empty helper}" >
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>

<jsp:include page="/WEB-INF/views/Corporativo/UC51/dv01.jsp" />

<c:if test="${not empty lotes}">

	<h1><fmt:message key="label.resultadoDaBusca" /></h1>

	<table id="alter" width="70%" cellspacing="0">
		<tr>
			<th class="texttable_cinza" width="11%"><fmt:message key="label.nLote" /></th>
			<th class="texttable_cinza" width="20%"><fmt:message key="label.arquivo" /></th>
			<th class="texttable_cinza" width="17%"><fmt:message key="label.dataCadastro" /></th>
			<th class="texttable_cinza" width="25%"><fmt:message key="label.tipoDeContrato" /></th>
			<th class="texttable_cinza" width="17%"><fmt:message key="label.dataProcessamento" /></th>
			<th class="texttable_cinza" width="20%"><fmt:message key="label.Status" /></th>
		</tr>
	
		<c:forEach var="lote" items="${lotes}" varStatus="status">	
			<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if>>
				<td>${lote.nrLote}&nbsp;</td>
				<td>${lote.nomeArquivo}&nbsp;</td>
				<td><fmt:formatDate value="${lote.dtCadastro}" pattern="dd/MM/yyyy hh:mm:ss" />&nbsp;</td>
				<td>${lote.tpContrato}&nbsp;</td>
				<td><fmt:formatDate value="${lote.dtProcessamento}" pattern="dd/MM/yyyy hh:mm:ss" />&nbsp;</td>
				<td>${lote.status}&nbsp;</td>
			</tr>
		</c:forEach>		
	</table>
	<jsp:include page="/WEB-INF/views/paginacao.jsp">
		<jsp:param name="pagina" value="${paginacao.paginaAtual}"/>
		<jsp:param name="totalPaginas" value="${paginacao.totalPaginas}"/>
		<jsp:param name="formName" value="formPesquisa"/>
		<jsp:param name="url" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC51/dv02"/>
	</jsp:include>
</c:if>