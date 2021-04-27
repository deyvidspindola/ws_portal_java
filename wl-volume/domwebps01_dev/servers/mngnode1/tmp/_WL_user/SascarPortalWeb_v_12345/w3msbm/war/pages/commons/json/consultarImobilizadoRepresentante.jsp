<%@ page contentType="text/xml; charset=ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


{"success":${empty mensagem},
"mensagem":"${mensagem}",
"listaProdutos":[<c:forEach items="${listaProdutos}" var="listaProduto" varStatus="status">{"codigo":"${listaProduto.codigo}","serieImobilizado":"${listaProduto.serieImobilizado}","descricaoItemImobilizado":"${listaProduto.descricaoItemImobilizado}","codigoModeloImobilzado":"${listaProduto.codigoModeloImobilzado}","versaoImobilizado":"${listaProduto.versaoImobilizado}", "modeloImobilizado":"${listaProduto.modeloImobilizado}", "statusImobilizado":"${listaProduto.statusImobilizado}"}<c:if test="${not status.last}">,</c:if></c:forEach>]}