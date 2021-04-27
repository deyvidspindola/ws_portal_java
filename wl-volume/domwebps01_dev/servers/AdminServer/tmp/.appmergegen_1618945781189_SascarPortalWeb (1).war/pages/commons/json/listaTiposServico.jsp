<%@ page contentType="text/xml; charset=ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

{"success":${empty mensagem},
"mensagem":"${mensagem}",
"tiposServico":[
	<c:forEach items="${tiposServicos}" var="tipoServico" varStatus="status">
		{"id":"${tipoServico.identifier}","value":"${tipoServico.value}"}
		<c:if test="${not status.last}">,</c:if>
	</c:forEach>
]}