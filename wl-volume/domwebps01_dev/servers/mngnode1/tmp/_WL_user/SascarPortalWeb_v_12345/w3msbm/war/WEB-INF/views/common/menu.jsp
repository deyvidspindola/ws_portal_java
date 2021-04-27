<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/UserServlet" context="/SascarPortalWeb" />
</c:catch>

<c:if test="${not empty SascarUser }">
	<c:choose>
		<c:when test="${not SascarUser.trocaSenhaObrigatoria and SascarUser.perfil eq 'CL'}">
			<c:choose>
				<c:when test="${SascarUser.admin}">
					<jsp:include page="/WEB-INF/views/Corporativo/menu/cliente.jsp" />
				</c:when>
				<c:otherwise>
					<jsp:include page="/WEB-INF/views/Corporativo/menu/cliente.jsp" />
				</c:otherwise>
			</c:choose>
		</c:when>
		
		<c:when test="${not SascarUser.trocaSenhaObrigatoria and SascarUser.perfil eq 'SC'}">
			<jsp:include page="/WEB-INF/views/Corporativo/menu/seguradora.jsp" />
		</c:when>

		<c:when test="${SascarUser.perfil eq 'RT'}">
			<jsp:include page="/WEB-INF/views/Corporativo/menu/representanteTecnico.jsp" />
		</c:when>

		<c:when test="${not SascarUser.trocaSenhaObrigatoria and SascarUser.perfil eq 'VD'}"></c:when>

		<c:otherwise></c:otherwise>
	</c:choose>
</c:if>