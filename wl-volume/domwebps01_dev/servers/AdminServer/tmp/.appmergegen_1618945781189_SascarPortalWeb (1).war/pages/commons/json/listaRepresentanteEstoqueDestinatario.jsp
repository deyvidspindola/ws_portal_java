<%@ page contentType="text/xml; charset=ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


{"success":${empty mensagem},
"mensagem":"${mensagem}",
"listaRepresentanteEstoqueDestinatarios":[<c:forEach items="${listaRepresentanteEstoqueDestinatarios}" var="listaRepresentanteEstoqueDestinatario" varStatus="status">{"id":"${listaRepresentanteEstoqueDestinatario.identifier}","value":"${listaRepresentanteEstoqueDestinatario.value}"}<c:if test="${not status.last}">,</c:if></c:forEach>]}