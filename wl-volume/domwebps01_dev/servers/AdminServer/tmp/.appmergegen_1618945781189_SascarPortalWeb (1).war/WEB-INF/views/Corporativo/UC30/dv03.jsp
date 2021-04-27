<jsp:directive.include file="/WEB-INF/views/includes.jsp" />

<c:catch var="helper">
	<c:import url="/ReplicarGrupoContatoVeiculo/pesquisarContratos?acao=1"
		context="/SascarPortalWeb" />
</c:catch>

<c:if test="${not empty mensagem }">
	<script type="text/javascript">
		$.showMessage("${mensagem }");
	</script>
</c:if>

<c:if test="${not empty helper}">
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>


<jsp:include page="/WEB-INF/views/Corporativo/UC30/dv02.jsp"/>

<c:if test="${not empty contratos}">
	<h1><fmt:message key="label.resultadoDaBusca" /></h1>

	<span class="text1" style="margin-left:100px;"><fmt:message key="label.cliqueNaplacaSelecionar" />:</span>

	<table cellspacing="0" width="850px" ID="alter">
		<tr>
			<th class="texttable_azul" width="50%" ><fmt:message key="label.placa" /></th>
			<th class="texttable_cinza" width="50%"><fmt:message key="label.chassi" /></th>
		</tr>

		<c:forEach var="contrato" items="${contratos}" varStatus="status">

			<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if>>
				<td class="camposinternos">
					<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC30/dv04&numeroContrato=${contrato.numeroContrato}&numeroPlaca=${contrato.veiculo.placa}&pagina=${paginacao.paginaAtual}" title="Veículos / Contatos" class="linkcinco">${contrato.veiculo.placa}</a>
				</td>
				<td>${contrato.veiculo.chassi}</td>
			</tr>

		</c:forEach>

	</table>
	
		<!-- PAGINAÇÃO INCLUÍDA EM 25/02/2013, PARA O RETORNO DO WS LISTACONTRATO -->
    <jsp:include page="/WEB-INF/views/paginacao.jsp">
	  <jsp:param name="pagina" value="${paginacao.paginaAtual}"/>
	  <jsp:param name="totalPaginas" value="${paginacao.totalPaginas}"/>
	  <jsp:param name="formName" value="formPesquisa"/>
	  <jsp:param name="url" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC30/dv03"/>
    </jsp:include>	

</c:if>
<br clear="all" />

<div class="clear:both"></div>