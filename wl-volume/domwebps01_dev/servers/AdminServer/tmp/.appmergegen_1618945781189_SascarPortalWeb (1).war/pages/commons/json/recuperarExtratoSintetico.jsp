<%@ page contentType="text/xml; charset=ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

{"success":${empty mensagem},
"mensagem":"${mensagem}"
<c:if test="${not empty extrato}">,"valorTotalOrdemServico":"${extrato.valorTotalOrdemServico}","valorTotalPendencias":"${extrato.valorTotalPendencias}","valorTotalTestes":"${extrato.valorTotalTestes }","valorTotalOutrosCreditos":"${extrato.valorTotalOutrosCreditos}","valorTotalLiquido":"${extrato.valorTotalLiquido}","valorTotalNotaFiscal":"${extrato.valorTotalNotaFiscal}","valorTotalDescontos":"${extrato.valorTotalDescontos}","valorCustoEficiencia":"${extrato.valorCustoEficiencia}"</c:if>}

