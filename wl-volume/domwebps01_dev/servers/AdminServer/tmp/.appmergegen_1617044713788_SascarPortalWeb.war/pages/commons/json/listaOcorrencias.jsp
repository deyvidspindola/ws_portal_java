<%@ page contentType="text/xml; charset=ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

{"success":${empty mensagem},
"mensagem":"${mensagem}",
"erro":"${erro}",
"ocorrencias":[<c:forEach items="${ocorrencias}" var="ocorrencia" varStatus="status">{"id":"${ocorrencia.idocorrencia}","value":"${ocorrencia.descricao}"}<c:if test="${not status.last}">,</c:if></c:forEach>]}