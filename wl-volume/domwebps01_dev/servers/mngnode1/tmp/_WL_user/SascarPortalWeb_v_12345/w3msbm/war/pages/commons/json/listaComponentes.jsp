<%@ page contentType="text/xml; charset=ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

{"success":${empty mensagem},
"mensagem":"${mensagem}",
"erro":"${erro}",
"componentes":[<c:forEach items="${componentes}" var="componente" varStatus="status">{"id":"${componente.idcomponente}","value":"${componente.descricao}"}<c:if test="${not status.last}">,</c:if></c:forEach>]}