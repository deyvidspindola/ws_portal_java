<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/ExcluirGrupoContatoVeiculo/pesquisarContratos?acao=3" context="/SascarPortalWeb"  />
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
<%--
    ATIVIDADE: COLOCAR PAGINAÇÃO PARA O WS ListarContratos.
    CONDICIONAL ALTERADA PARA QUE SE ADAPTE À PAGINAÇÃO; POIS
    CASO A ÚLTIMA PÁGINA RETORNE APENAS UM REGISTRO, ELA AINDA
    DEVERA ENTRAR NESTA CONDIÇÃO.
 --%>
<c:choose>
	<c:when test="${not empty contratos}">

		<c:choose>
			<c:when test="${fn:length(contratos) > 1 or not empty param.pagina}">
				
				<jsp:include page="/WEB-INF/views/Corporativo/UC32/dv08.jsp" >
					<jsp:param name="numeroPlaca" value="${param.numeroPlaca}" />
					<jsp:param name="contratos" value="${contratos}" />
				</jsp:include>
				<jsp:include page="/WEB-INF/views/paginacao.jsp">
	              <jsp:param name="pagina" value="${paginacao.paginaAtual}"/>
	              <jsp:param name="totalPaginas" value="${paginacao.totalPaginas}"/>
	              <jsp:param name="formName" value="formPesquisa"/>
	              <jsp:param name="url" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC32/dv09&paginacao=${paginacao.paginaAtual}"/>
                </jsp:include>
         
			</c:when>	
			<c:otherwise>
		
				<c:forEach var="contrato" items="${contratos}" varStatus="status">
				<jsp:include page="/WEB-INF/views/Corporativo/UC32/dv07.jsp" >
					<jsp:param name="numeroContrato" value="${contrato.numeroContrato}" />
					<jsp:param name="numeroPlaca" value="${contrato.veiculo.placa}" />
				</jsp:include>
				</c:forEach>
				
			</c:otherwise>
		</c:choose>

	</c:when>	
	<c:otherwise>
		<jsp:include page="/WEB-INF/views/Corporativo/UC32/dv06.jsp" >
			<jsp:param name="numeroPlaca" value="${contrato.veiculo.placa}" />
		</jsp:include>
	</c:otherwise>
</c:choose>
	