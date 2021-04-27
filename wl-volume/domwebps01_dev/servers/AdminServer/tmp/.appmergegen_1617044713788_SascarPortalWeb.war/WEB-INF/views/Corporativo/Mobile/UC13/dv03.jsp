<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/AtivarEquipamentoTestes/recuperarInstrucaoTeste?acao=3" context="/SascarPortalWeb"  />
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

<c:choose>
	<c:when test="${param.tipoEquipamento eq 'S' }">
		
		<jsp:include page="/WEB-INF/views/Corporativo/Mobile/UC13/dv11.jsp" >
			<jsp:param name="tipoEquipamento" value="${param.tipoEquipamento}" />
		</jsp:include>
		
	</c:when>	
	<c:when test="${param.tipoEquipamento eq 'C' }">
		
		<jsp:include page="/WEB-INF/views/Corporativo/Mobile/UC13/dv12.jsp" >
			<jsp:param name="tipoEquipamento" value="${param.tipoEquipamento}" />
		</jsp:include>
		
	</c:when>	
</c:choose>
	