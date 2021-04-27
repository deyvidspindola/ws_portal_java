<%@ page contentType="text/xml; charset=ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


{"success":${empty mensagem},
"mensagem":"${mensagem}"
<c:if test="${not empty numeroRemessa}">,"numeroRemessa":"${numeroRemessa}"</c:if>
<c:if test="${not empty notaObrigatoria }">,"notaObrigatoria":"${notaObrigatoria}"</c:if>
}

