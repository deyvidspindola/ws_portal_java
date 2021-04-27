<%@ taglib uri="http://java.sun.com/jsp/jstl/core" 	prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" 	prefix="fmt" %>

<div class="pgstabela">
    
    <c:if test="${not empty param.historyBack }">
		<input type="button" class="button3" value="Voltar" onclick="history.back(-1);"/>
	</c:if>
	
	<c:if test="${not empty param.formBack }">
		<input type="button" class="button3" value="Voltar" onclick="$('#${param.formBack}').submit();"/>
	</c:if>
	
	<c:if test="${not empty param.novabusca }">
		<form method="post" action="${param.novabusca }">
			<input type="submit" class="button" value="Nova Busca" />
		</form>
	</c:if>
	
	<c:if test="${not empty param.continuar }">
		<input type="button" class="button" value="Continuar" onclick="${param.continuar}"/>
	</c:if>
	
	<c:if test="${not empty param.emitir }">
		<input type="button" class="button" value="Emitir Declara&ccedil;&atilde;o" onclick="${param.emitir}"/>
	</c:if>

</div>