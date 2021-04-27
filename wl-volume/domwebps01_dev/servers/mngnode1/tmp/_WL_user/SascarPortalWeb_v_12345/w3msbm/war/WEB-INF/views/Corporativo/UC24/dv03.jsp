<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/ConsultarVeiculosServlet/listarHistoricos?acao=2" context="/SascarPortalWeb"  />
</c:catch>

<c:if test="${not empty mensagem }">
	<script type="text/javascript">
		$.showMessage("${mensagem }");
	</script>
</c:if>

<c:if test="${not empty helper}" >
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>

<script type="text/javascript">
		$(document).ready(function(){
			$("div.breadcrumb").html('<fmt:message key="label.tituloAtendimentoConsultasVeiculos" />');
		});
</script>

<c:choose>
	<c:when test="${param.menu eq 1}">
		<c:set var="titulo">
			<fmt:message key="label.consultarVeiculos" />
		</c:set>
	</c:when>
	<c:when test="${param.menu eq 2}">
		<c:set var="titulo">
			<fmt:message key="label.declaracaoDeVeiculosMonitorados" />
		</c:set>
	</c:when>
	<c:when test="${param.menu eq 3}">
		<c:set var="titulo">
			<fmt:message key="label.retiradaDeEquipamentos" />
		</c:set>
	</c:when>
</c:choose>

<div class="cabecalho3">
	<div class="caminho3" style="*margin-left:350px">
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> > 
		<a href="#" class="linktres"><c:choose><c:when test="${param.menu > 2}"><fmt:message key="label.servicos" /></c:when><c:otherwise><fmt:message key="label.informacoes" /></c:otherwise></c:choose></a> > 
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC24/dv01&menu=${param.menu }" class="linkquatro">${titulo }</a>
	</div>
	${titulo} 
</div>
		
<table width="1026" cellspacing="0" class="tbatualizacao" >
	<tr class="tbatualizacao">
		<th class="barraazulzinha"><fmt:message key="label.detalhesDaSolicitacao" /></th>
	</tr>
</table>

<table width="960" cellspacing="3" class="detalhe2">
	<tr>
		<th width="160" class="barracinza"><fmt:message key="label.solicitante" /></th>
		<td width="350" class="camposinternos" style="font-weight:bold">${param.nome }</td>
	</tr>
	<tr>
		<th  width="160" class="barracinza"><fmt:message key="label.nProposta" /></th>
		<td  width="160" class="camposinternos">${param.proposta }</td>
		<th  width="160" class="barracinza"><fmt:message key="label.placa" /></th>
		<td  width="160" class="camposinternos">${param.placa }</td>
	</tr>
	<tr>
		<th  width="160" class="barracinza"><fmt:message key="label.dataDaSolicitacao" /></th>
		<td  width="160" class="camposinternos">${param.dataSolicitacao}</td>
		<th  width="160" class="barracinza"><fmt:message key="label.chassi" /></th>
		<td  width="160" class="camposinternos">${param.chassi }</td>
	</tr>
	<tr>
		<th  width="160" class="barracinza"><fmt:message key="label.dataDoCadastro" /></th>
		<td  width="160" class="camposinternos">${param.dataCadastro }</td>
		<th  width="160" class="barracinza"><fmt:message key="label.nomeSegurado" /></th>
		<td  width="160" class="camposinternos">${param.nomeSegurado }</td>					
	</tr>
	<tr>
		<th  width="160" class="barracinza"><fmt:message key="label.marca" /></th>
		<td  width="160" class="camposinternos">${param.marca }</td>					
		<th  width="160" class="barracinza"><fmt:message key="label.cpfCnpj" /></th>
		<td  width="160" class="camposinternos">${param.cpfCnpj }</td>
	</tr>
	<tr>
		<th  width="160" class="barracinza"><fmt:message key="label.modelo" /></th>
		<td  width="160" class="camposinternos">${param.modelo }</td>
		<th  width="160" class="barracinza"><fmt:message key="label.ano" /></th>
		<td  width="160" class="camposinternos">${param.ano }</td>
	</tr>
	<tr>
		<th  width="160" class="barracinza"><fmt:message key="label.cor" /></th>
		<td  width="160" class="camposinternos">${param.cor }</td>
	</tr>
</table>


<c:if test="${not empty historicos}" >

	<table width="850" cellpadding="1px" id="alter" cellspacing="0px">
		<tr>
			<th width="50" class="texttable_azul" scope="col"><fmt:message key="label.data" /></th>
			<th width="100" class="texttable_cinza" scope="col"><fmt:message key="label.situacaoRegistrada" /></th>
			<th width="150" class="texttable_azul"  scope="col"><fmt:message key="label.responsavelPRegistroInformacao" /></th>
			<th width="150" class="texttable_cinza" scope="col"><fmt:message key="label.dataAgendamentoInstalacao" /></th>
			<th width="400" class="texttable_cinza" scope="col"><fmt:message key="label.observacoes" /></th>
		</tr>
		<c:forEach var="historico" items="${historicos }">
			<tr class="dif">
				<td><fmt:formatDate value="${historico.dataRegistro }" pattern="dd/MM/yyyy"/></td>
				<td>${historico.situacaoRegistrada}</td>
				<td class="linkazulescuro">${historico.nomeResponsavel}</td>
				<td><fmt:formatDate value="${historico.dataAgendamento }" pattern="dd/MM/yyyy"/></td>
				<td>${historico.observacao}</td>
			</tr>
		</c:forEach>
	</table>
</c:if>
	<div class="botoesvoltar">
		<form id="formSubmeter" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC24/dv02" method="post">
				<input type="hidden" name="dataInicial" value="${param.dataInicial }" />
				<input type="hidden" name="dataFinal" value="${param.dataFinal }" />
				<input type="hidden" name="statusCadastro" value="${param.statusCadastro }" />
				<input type="hidden" name="numeroPlaca" value="${param.numeroPlaca }" />
				<input type="hidden" name="tipoSeguradora" value="${param.tipoSeguradora }" />
				<input type="hidden" name="nomeCliente" value="${param.nomeCliente }" />
				<input type="hidden" name="numeroChassi" value="${param.numeroChassi }" />
				<input type="hidden" name="numeroProposta" value="${param.numeroProposta }" />
				<input type="hidden" name="numeroCpfCnpj" value="${param.numeroCpfCnpj }" />
				<input type="hidden" name="menu" value="${param.menu}" />
				<input type="hidden" name="pagina" value="${param.paginaAtual}" />
				
				<input type="submit" class="button3" value="<fmt:message key="label.voltar" />"/>
		</form>
	</div>

