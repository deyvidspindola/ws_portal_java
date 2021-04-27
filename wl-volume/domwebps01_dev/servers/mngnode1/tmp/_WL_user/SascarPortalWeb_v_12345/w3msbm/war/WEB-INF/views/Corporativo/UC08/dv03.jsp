<jsp:directive.include file="/WEB-INF/views/includes.jsp" />

<c:catch var="helper">
	<c:import url="/EfetuarAtualizacaoCadastral/pesquisarContratos?acao=2"
		context="/SascarPortalWeb" />
</c:catch>

<c:if test="${not empty mensagem }">
	<script type="text/javascript">
		$.showMessage("${mensagem }");
	</script>
</c:if>

<c:if test="${not empty helper}">
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>

<jsp:include page="/WEB-INF/views/Corporativo/UC08/dv02.jsp" />


<table cellspacing="0" class="detalhe">
	<tr class="barraazulzinha">
		<th class="barraazulzinha"><fmt:message key="label.resultadoDaBusca" /></th>
	</tr>
</table>

<c:if test="${not empty contratos}">
	<span class="text3" style="margin-left: 20px"><fmt:message key="uc08.texto.013.cliqueNumeroPlacaAtualizarDados" />:</span>
	<table width="750" cellpadding="1" id="alter" cellspacing="0">
		<tr>
			<th width="10%" class="texttable_azul" scope="col"><fmt:message key="label.placa" /></th>
			<th width="25%" class="texttable_cinza" scope="col"><fmt:message key="label.chassi" /></th>
			<th width="25%" class="texttable_cinza" scope="col"><fmt:message key="label.marca" /></th>
			<th width="25%" class="texttable_cinza" scope="col"><fmt:message key="label.modelo" /></th>
			<th width="25%" class="texttable_cinza" scope="col"><fmt:message key="label.cor" /></th>
		</tr>
		<c:forEach var="contrato" items="${contratos}" varStatus="status">

			<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if>>
				<td class="linkazul"><a
					href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC08/dv04&numeroContrato=${contrato.numeroContrato}&numeroPlaca=${param.numeroPlaca }&pagina=${numeroPagina}"
					title="Veículos / Contatos" class="linkcinco">${contrato.veiculo.placa}</a>
				</td>
				<td>${contrato.veiculo.chassi}</td>
				<td>${contrato.veiculo.descricaoMarca}</td>
				<td>${contrato.veiculo.descricaoModelo}</td>
				<td>${contrato.veiculo.cor}</td>
			</tr>

			<c:if
				test="${not empty contrato.pessoasEmergencia or not empty contrato.pessoasAutorizadas}">

				<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if>>
					<td colspan="2">
						<ul>
							<li>
								<h3>
									<a
										href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC08/dv04&numeroContrato=${contrato.numeroContrato }&numeroPlaca=${param.numeroPlaca }">
										<fmt:message key="label.listaContatos" /> </a>
								</h3>
								<table cellspacing="0" width="500" class="list">
									<tr>
										<th><fmt:message key="label.nome" /></th>
										<th><fmt:message key="label.tipoContato" /></th>
									</tr>
									<c:forEach var="pessoaAutorizada"
										items="${contrato.pessoasAutorizadas}">
										<tr>
											<td class="first">${pessoaAutorizada.nome}</td>
											<td>${pessoaAutorizada.tipoContato}</td>
										</tr>
									</c:forEach>
									<c:forEach var="pessoaEmergencia"
										items="${contrato.pessoasEmergencia}">
										<tr>
											<td class="first">${pessoasEmergencia.nome}</td>
											<td>${pessoasEmergencia.tipoContato}</td>
										</tr>
									</c:forEach>									
								</table>
															
							</li>
						</ul>
					</td>
				</tr>

			</c:if>

		</c:forEach>

	</table>
								
    <!-- PAGINAÇÃO INCLUÍDA EM 25/02/2013, PARA O RETORNO DO WS LISTACONTRATO -->
    <jsp:include page="/WEB-INF/views/paginacao.jsp">
	  <jsp:param name="pagina" value="${numeroPagina}"/>
	  <jsp:param name="totalPaginas" value="${totalPaginas}"/>
	  <jsp:param name="formName" value="formPesquisa"/>
	  <jsp:param name="url" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC08/dv03"/>
    </jsp:include>	
</c:if>