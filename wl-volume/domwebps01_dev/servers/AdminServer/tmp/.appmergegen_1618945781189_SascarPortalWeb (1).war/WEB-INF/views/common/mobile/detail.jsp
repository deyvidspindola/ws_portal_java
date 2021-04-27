<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:if test="${not empty param.page }">
	<jsp:include page="/WEB-INF/views/${param.page}.jsp" />
</c:if>