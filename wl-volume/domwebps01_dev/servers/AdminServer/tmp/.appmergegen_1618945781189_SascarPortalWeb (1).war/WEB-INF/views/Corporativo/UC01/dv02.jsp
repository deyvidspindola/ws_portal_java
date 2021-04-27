<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/PesquisarContratos/pesquisarContratos?acao=2" context="/SascarPortalWeb"  />
</c:catch>

<c:if test="${not empty helper}" >
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>

<jsp:include page="/WEB-INF/views/Corporativo/UC01/dv01.jsp" />

<c:if test="${not empty contratos}">

	<h1><fmt:message key="label.resultadoDaBusca" /></h1>

		<table cellspacing="0" width="850" id="alter">
			<tr>
				<c:if test="${not SascarUser.perfil eq 'CL'}">
					<th width="100" class="texttable_azul"><fmt:message key="label.cliente" /></th>
				</c:if>
				<th width="50" class="texttable_azul"><fmt:message key="label.placa" /></th>
				<th width="150" class="texttable_cinza"><fmt:message key="label.marcaModelo" /></th>
				<th width="100" class="texttable_azul"><fmt:message key="label.equipamento" /></th>
				<th width="100" class="texttable_cinza"><fmt:message key="label.servicoContrato" /></th>
				<th width="150" class="texttable_azul"><fmt:message key="label.vigencia" /></th>
				<th width="80" class="texttable_cinza"><fmt:message key="label.valorLocacao" /></th>
				<th width="80" class="texttable_azul"><fmt:message key="label.valorMonitoramento" /></th>
			</tr>
		
			<c:forEach var="contrato" items="${contratos}" varStatus="status">	
				<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if>>
					
					<c:if test="${not SascarUser.perfil eq 'CL'}">
						<td >${contrato.contratante.nome}&nbsp;</td>
					</c:if>
					<td>
						<c:url var="urlDetalhe" value="/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC01/dv03&numeroContrato=${contrato.numeroContrato}&dataInicial=${param.dataInicial}&dataFinal=${param.dataFinal}&codigoServicocontratado=${param.codigoServicocontratado }&statusContrato=${param.statusContrato }&pagina=${param.pagina}"/>
						<a href="${urlDetalhe }" class="linkazul" title="Clique para visualizar os detalhes do contrato.">${contrato.veiculo.placa}&nbsp;</a>
					</td>
					<td>${contrato.veiculo.descricaoMarca} / ${contrato.veiculo.descricaoModelo}</td>
					<td class="linkazulescuro">
						<c:choose>
							<c:when test="${fn:toUpperCase(contrato.status) eq 'I'}"><fmt:message key="label.instalado" /></c:when>
							<c:otherwise><fmt:message key="label.naoInstalado" /></c:otherwise>
						</c:choose>
					</td>
					<td>${contrato.servicoContratado}&nbsp;</td>
					<td align="center" class="linkazulescuro">
						<fmt:formatDate value="${contrato.dataInicioVigencia}" pattern="dd/MM/yyyy" /> a <fmt:formatDate value="${contrato.dataFimVigencia}" pattern="dd/MM/yyyy" />
					</td>
					<td align="right"><fmt:formatNumber value="${contrato.valorLocacao }" type="currency" /></td>
					<td align="right" class="linkazulescuro"><fmt:formatNumber value="${contrato.valorMonitoramento }" type="currency" /></td>
				</tr>
			</c:forEach>		
		</table>
	
	<jsp:include page="/WEB-INF/views/paginacao.jsp">
		<jsp:param name="pagina" value="${paginacao.paginaAtual}"/>
		<jsp:param name="totalPaginas" value="${paginacao.totalPaginas}"/>
		<jsp:param name="formName" value="formPesquisa"/>
		<jsp:param name="url" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC01/dv02"/>
	</jsp:include>
	
	<jsp:include page="/WEB-INF/views/icones.jsp">
		<jsp:param name="novabusca" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC01/dv01"/>
	</jsp:include>

</c:if>