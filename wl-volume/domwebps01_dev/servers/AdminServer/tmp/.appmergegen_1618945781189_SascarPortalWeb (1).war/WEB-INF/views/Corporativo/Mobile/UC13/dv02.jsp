<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/AtivarEquipamentoTestes/recuperarTestesAutomaticos?acao=1" context="/SascarPortalWeb"  />
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

<!-- O INCLUDE DA TELA DV10 - TELA DE RESUMO DAS CONFIGURACOES ESTA SENDO REFERENCIADA COMO DV08 -->

<c:choose>
	<c:when test="${equipamento.tipoEquipamento eq 'S' 
		and SascarUser.login ne 'SUPORTESAT.INST'
		and SascarUser.login ne 'PRS.1571'
		and SascarUser.login ne 'SUPORTESAT' 
		and SascarUser.login ne 'MARCELOLIN.INST'
		and SascarUser.login ne 'ANDRECOSMOS'}">
		
		<jsp:include page="/WEB-INF/views/Corporativo/Mobile/UC13/dv09.jsp" >
			<jsp:param name="tipoEquipamento" value="${equipamento.tipoEquipamento}" />
		</jsp:include>
		
	</c:when>	
	<c:when test="${equipamento.tipoEquipamento eq 'S' }">
		
		<jsp:include page="/WEB-INF/views/Corporativo/UC13/dv09Piloto.jsp" >
			<jsp:param name="tipoEquipamento" value="${equipamento.tipoEquipamento}" />
			<jsp:param name="fromMobile" value="true" />
		</jsp:include>
		
	</c:when>	
	<c:when test="${equipamento.tipoEquipamento eq 'C' }">
		
		<jsp:include page="/WEB-INF/views/Corporativo/Mobile/UC13/dv10.jsp" >
			<jsp:param name="tipoEquipamento" value="${equipamento.tipoEquipamento}" />
		</jsp:include>
		
	</c:when>	
</c:choose>