<%@ taglib uri="http://java.sun.com/jsp/jstl/core" 	prefix="c" %>

<div class="icones">

	<c:if test="${not empty param.imprimir }">
		<a href="" class="imprimir" title="Imprimir">Imprimir</a>
	</c:if>

	<c:if test="${not empty param.pdf }">
		<a href="" class="pdf" title="Gerar PDF">Gerar PDF</a>
	</c:if>
	
	<c:if test="${not empty param.voltar }">
		<a href="${param.voltar}" class="voltar" title="Voltar">Voltar</a>
	</c:if>

</div>