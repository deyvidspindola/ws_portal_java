<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:set var="pagina" value="${param.pagina }" />
<c:set var="totalPaginas" value="${param.totalPaginas }" />
<c:set var="urlContext" value="${param.url }" />
<c:set var="formName" value="${param.formName }" />

<script type="text/javascript">
	function getPage(url) {
		try {
			var form = document.forms['${formName}'];
			form.action = url;
			form.submit();
		} catch (E) {
			alert('Erro ao buscar pagina.\n\n Error: '+E.description);
		}
	}
</script>

<c:set var="pagInicial">
	<c:choose>
		<c:when test="${pagina eq 1 or pagina eq 2}">1</c:when>
		<c:otherwise>${pagina-2}</c:otherwise>
	</c:choose>
</c:set>

<c:set var="pagFinal">
	<c:choose>
		<c:when test="${(pagina eq totalPaginas) or (pagina eq (totalPaginas-1))}">${totalPaginas}</c:when>
		<c:otherwise>${pagina +2}</c:otherwise>
	</c:choose>
</c:set>

<c:if test="${totalPaginas > 1}" >

	<div class="pgstabela">
		<c:if test="${pagina > 1}" >  
			<a href="javascript:void(0);" onclick="getPage('${urlContext}&pagina=${pagina-1}');" class="paginacao">&lt;</a>
		</c:if>
		<c:forEach begin="${pagInicial}" end="${pagFinal}" step="1" var="pag">
			<a href="javascript:void(0);" onclick="getPage('${urlContext}&pagina=${pag}');" class="${pag eq pagina?'active':'paginacao'}">${pag}</a>
		</c:forEach>
		<c:if test="${pagina < totalPaginas}" >
			<a href="javascript:void(0);" onclick="getPage('${urlContext}&pagina=${pagina+1}');" class="paginacao">&gt;</a>
		</c:if>
	</div>

</c:if>