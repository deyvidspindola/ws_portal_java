<%@ page contentType="text/xml; charset=ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

{"success":${empty mensagem},
"mensagem":"${mensagem}"
<c:if test="${not empty numeroBordero}">,"numeroBordero":"${numeroBordero}"</c:if>
<c:if test="${not empty dataInclusao}">,"dataInclusao":"${dataInclusao}"</c:if>
<c:if test="${not empty representanteBordero}">,"representanteBordero":"${representanteBordero}"</c:if>
}

