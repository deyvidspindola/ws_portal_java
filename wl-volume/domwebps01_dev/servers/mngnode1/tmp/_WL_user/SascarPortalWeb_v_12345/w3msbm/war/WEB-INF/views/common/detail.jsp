<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:choose>

	<c:when test="${not empty helper}">
		<script type="text/javascript">
			$(document).ready(function(){
				blockAccess('${helper}');  
			}); 
		</script>
	</c:when>

	<c:otherwise>

		<c:choose>
			<c:when test="${not empty param.page }">
				<jsp:include page="/WEB-INF/views/${param.page}.jsp" />
			</c:when>
			<c:otherwise>
				<c:if test="${not empty SascarUser and not SascarUser.mobile}">
					<c:choose>
						<c:when test="${SascarUser.perfil eq 'CL'}">
				            <jsp:include page="/WEB-INF/views/content.jsp" />
						</c:when>
						<c:when test="${SascarUser.perfil eq 'SC'}"> 
							<jsp:include page="/WEB-INF/views/contentSC.jsp" />
						</c:when>
						<c:when test="${SascarUser.perfil eq 'RT'}">
							<jsp:include page="/WEB-INF/views/contentRT.jsp" />
						</c:when>
					</c:choose>
				</c:if>
			</c:otherwise>
		</c:choose>

	</c:otherwise>

</c:choose>