<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/VisualizarDeclaracaoServlet/verificarCodigoValidador?acao=2" context="/SascarPortalWeb"  />
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

<style type="text/css" media="print">
	.botaoImprimir{
		display: none;
	}
</style>

<c:if test="${not empty contrato}">
	<c:choose>
		<c:when test="${fn:toUpperCase(contrato.status) eq 'I'}">
			<jsp:include page="/WEB-INF/views/Corporativo/UC15/dv03.jsp"/>
		</c:when>
		<c:when test="${fn:toUpperCase(contrato.status) eq 'F'}">
			<jsp:include page="/WEB-INF/views/Corporativo/UC15/dv04.jsp"/>
		</c:when>
		<c:when test="${fn:toUpperCase(contrato.status) eq 'R'}">
			<jsp:include page="/WEB-INF/views/Corporativo/UC15/dv05.jsp"/>
		</c:when>
	</c:choose>
</c:if>
