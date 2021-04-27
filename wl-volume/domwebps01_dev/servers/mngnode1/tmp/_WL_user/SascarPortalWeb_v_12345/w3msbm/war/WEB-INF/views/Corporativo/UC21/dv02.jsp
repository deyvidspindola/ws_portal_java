<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/ConsultarSolicitacaoInstalacaoServlet/consultarSolicitacaoServico?acao=1" context="/SascarPortalWeb"  />
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


<jsp:include page="/WEB-INF/views/Corporativo/UC21/dv01.jsp"/>

	<c:if test="${not empty listaSolicitacoes}" >	
			<p></p>
	
	
		<h1><fmt:message key="label.resultadoDaBusca" /></h1>
		
		<span class="texthelp2">
			<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" /> <fmt:message key="label.legendaParaSituacao" />:
			<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/status_A.png" width="16" height="16" align="absmiddle" /><fmt:message key="label.statusSolicitacao.autorizado" /> 
			<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/status_R.png" width="16" height="16" align="absmiddle" /><fmt:message key="label.statusSolicitacao.recusado" /> 
			<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/status_P.png" width="16" height="16" align="absmiddle" /><fmt:message key="label.statusSolicitacao.pendente" />
		</span>
		
		<form action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC21/dv01" method="post">
			
			<table width="850" cellpadding="1px" id="alter" cellspacing="0px" style="margin-top:40px;">
				<tr>
					<th width="50px" class="texttable_azul" scope="col"><fmt:message key="label.codDaSolicitacao" /></th>
					<th width="70px" class="texttable_cinza" scope="col"><fmt:message key="label.dataDeCadastro" /></th>
					<th width="300px" class="texttable_azul"  scope="col"><fmt:message key="label.segurado" /></th>
					<th width="70px" class="texttable_cinza" scope="col"><fmt:message key="label.tipoSeguro" /></th>
					<th width="100px" class="texttable_azul" scope="col"><fmt:message key="label.cadastradoPor" /></th>
					
					<th width="50px" class="texttable_azul" scope="col"><fmt:message key="label.situacao" /></th>
					<th width="150px" class="texttable_azul" scope="col"><fmt:message key="label.autorizadoRecusadoPor" /></th>
				</tr>
				<c:forEach var="solicitacao" items="${listaSolicitacoes }" varStatus="contador">
					<tr <c:if test="${contador.count % 2 != 0 }">class="dif"</c:if>>
						<td>
							<a class="linkcinco tooltip" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC21/dv03&numeroSolicitacao=${solicitacao.numeroSolicitacao}&numSolicitacao=${param.numSolicitacao}&dataInicial=${param.dataInicial}&dataFinal=${param.dataFinal}&numeroPlaca=${param.numeroPlaca }&numeroChassi=${param.numeroChassi }&nomeCliente=${param.nomeCliente }&numeroProposta=${param.numeroProposta }&tipoSeguro=${param.tipoSeguro}&statusSolicitacao=${param.statusSolicitacao}&menu=${param.menu}&pagina=${param.pagina}" 
							title="Clique aqui para visualizar as informações da solicitação de instalação">&nbsp;${solicitacao.numeroSolicitacao}&nbsp;
							</a>
						</td>
						<td><fmt:formatDate var="dataCadastro" value="${solicitacao.dataCadastro }" pattern="dd/MM/yyyy"/>${dataCadastro}</td>
						<td class="linkazulescuro">${solicitacao.solicitante.nome}&nbsp;</td>
						<td>
							<c:choose>
								<c:when test="${fn:toUpperCase(solicitacao.apolice.tipoSeguro) eq 'N'}"><fmt:message key="label.tipoSeguro.seguroNovo" /></c:when>
								<c:when test="${fn:toUpperCase(solicitacao.apolice.tipoSeguro) eq 'R'}"><fmt:message key="label.tipoSeguro.renovacaoCIA" /></c:when>
								<c:when test="${fn:toUpperCase(solicitacao.apolice.tipoSeguro) eq 'E'}"><fmt:message key="label.tipoSeguro.endosso" /></c:when>
								<c:when test="${fn:toUpperCase(solicitacao.apolice.tipoSeguro) eq 'I'}"><fmt:message key="label.tipoSeguro.individual" /></c:when>
								<c:when test="${fn:toUpperCase(solicitacao.apolice.tipoSeguro) eq 'F'}"><fmt:message key="label.tipoSeguro.frota" /></c:when>
								<c:when test="${fn:toUpperCase(solicitacao.apolice.tipoSeguro) eq 'P'}"><fmt:message key="label.tipoSeguro.premiumIndividual" /></c:when>
							</c:choose>	
						</td>
						<td class="linkazulescuro">${solicitacao.nomeCadastrante}&nbsp;</td>
						
						<td>
							<span class="linkazulescuro">
								<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/status_${solicitacao.statusSolicitacao}.png" alt="${solicitacao.statusSolicitacao }"  />	
							</span>
						</td>
						<td class="linkazulescuro">${solicitacao.nomeAutorizador}&nbsp;</td>
					</tr>
				</c:forEach>	
			</table>
			
			<jsp:include page="/WEB-INF/views/paginacao.jsp">
				<jsp:param name="pagina" value="${paginacao.paginaAtual}"/>
				<jsp:param name="totalPaginas" value="${paginacao.totalPaginas}"/>
				<jsp:param name="formName" value="formPesquisa"/>
				<jsp:param name="url" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC21/dv02"/>
			</jsp:include>
			
		</form>
	</c:if>

