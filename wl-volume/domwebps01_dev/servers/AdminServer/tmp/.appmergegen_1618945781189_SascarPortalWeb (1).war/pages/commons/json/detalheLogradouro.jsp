<%@ page contentType="text/xml; charset=ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

{"success":${empty mensagem},"mensagem":"${fn:escapeXml(mensagem)}",
"endereco":{<c:if test="${not empty endereco}">"codigoPais":"${endereco.codigoPais}","pais":"${endereco.descricaoPais}","siglaUF":"${endereco.siglaUF}","codigoLocalidade":"${endereco.codigoLocalidade}","localidade":"${endereco.descricaoLocalidade}","codigoBairro":"${endereco.codigoBairro}","bairro":"${endereco.descricaoBairro}","codigoLogradouro":"${endereco.codigoLogradouro}","logradouro":"${endereco.descricaoLogradouro}"</c:if>}}