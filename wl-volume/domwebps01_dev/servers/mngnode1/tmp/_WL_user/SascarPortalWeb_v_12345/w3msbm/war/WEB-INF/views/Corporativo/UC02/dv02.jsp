<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>


<c:catch var="helper" >
	<c:import url="/PesquisarOrdensServico/pesquisarOrdensServico?acao=3" context="/SascarPortalWeb"  />
</c:catch>

<c:if test="${not empty helper}" >
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>


<jsp:include page="/WEB-INF/views/Corporativo/UC02/dv01.jsp"/>


	<c:if test="${not empty ordensServico}" >
	
		<h1 class="tooltip" title="<fmt:message key="uc02.dv02.text.01" />"><fmt:message key="label.resultadoDaBusca" /></h1>
		<span class="text1" style="margin-left:100px;"><fmt:message key="uc02.dv02.text.02" /></span>
		<p>
				
					<span class="texthelp2"><br />
						<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" />
						<fmt:message key="uc02.dv02.text.03" />
					</span>
					<br/>
				</label>
			</p>	
		<table width="750" cellpadding="1" id="alter" cellspacing="0">
			<tr>
				<th width="10%" class="texttable_azul" scope="col"><fmt:message key="label.NumOS" /></th>
				<th width="25%" class="texttable_cinza tooltip" scope="col" title="<fmt:message key="label.dataAberturaServico" />"><fmt:message key="label.dataAbertura" /></th>
				<th width="20%" class="texttable_cinza" scope="col"><fmt:message key="label.tipoServico" /></th>
				<th width="10%" class="texttable_cinza" scope="col"><fmt:message key="label.placa" /></th>
				<th width="10%" class="texttable_cinza" scope="col"><fmt:message key="label.chassi" /></th>
				<th width="25%" class="texttable_azul" scope="col"><fmt:message key="label.dataAgendamento2" /></th>
			</tr>
			
			<c:forEach items="${ordensServico}" var="ordemServico" varStatus="contador">
				<tr <c:if test="${contador.count % 2 != 0 }">class="dif"</c:if>>
					<td class="linkcinco">
						<a class="linkcinco" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC02/dv03&numeroOS=${ordemServico.numero}&numeroPlaca=${param.numeroPlaca }&dataInicial=${param.dataInicial }&dataFinal=${param.dataFinal }&numeroChassi=${param.numeroChassi }&codigoMarca=${param.codigoMarca }&codigoModelo=${param.codigoModelo }&pagina=${param.pagina }" 
							title="Clique para visualizar os detalhes da OS.">&nbsp;${ordemServico.numero}&nbsp;
						</a>
					</td>
					<td align="center">
					<fmt:formatDate value="${ordemServico.dataGeracao}" pattern="dd/MM/yyyy" />&nbsp;</td>
					<td class="linkazulescuro">${ordemServico.tipoServico}&nbsp;</td>
					<td>${ordemServico.contrato.veiculo.placa}&nbsp;</td>
					<td>${ordemServico.contrato.veiculo.chassi}&nbsp;</td>
					<c:choose>
						<c:when test="${not empty ordemServico.agendamento.dataAgendamento}" >
							<td class="linkazulescuro">
								<fmt:formatDate value="${ordemServico.agendamento.dataAgendamento}" pattern="dd/MM/yyyy HH:mm" />&nbsp;
								<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC11/dv01&numeroPlacaVeiculo=${ordemServico.contrato.veiculo.placa}&numeroOS=${ordemServico.numero}" class="linkum">
									<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/agendamento32.png" width="16" height="16" hspace="2" align="absmiddle" border="0"/>
								</a>
							</td>
						</c:when>
						
						<c:otherwise>
							<td class="linkazulescuro">
								<form class="validate-access-UC11" id="form1" style="display: inline;" name="form1" method="post" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC11/dv01">
									<input name="button" type="submit" class="button2" value="Agendar" />
									<input type="hidden" name="numeroOS" value="${ordemServico.numero}" />
									<input type="hidden" name="numeroPlaca" value="${param.numeroPlaca }" />
									<input type="hidden" name="dataInicial" value="${param.dataInicial }" />
									<input type="hidden" name="dataFinal" value="${param.dataFinal }" />
									<input type="hidden" name="numeroChassi" value="${param.numeroChassi }" />
									<input type="hidden" name="codigoMarca" value="${param.codigoMarca }" />
									<input type="hidden" name="codigoModelo" value="${param.codigoModelo }" />
									<input type="hidden" name="numeroPlacaVeiculo" value="${ordemServico.contrato.veiculo.placa}" />
									<input type="hidden" name="pagina" value="${param.pagina }" />
								</form>&nbsp;
							</td>
						</c:otherwise>
					</c:choose>
				</tr>
			</c:forEach>
		</table>
			 
			 
		<jsp:include page="/WEB-INF/views/paginacao.jsp">
			<jsp:param name="pagina" value="${paginacao.paginaAtual}"/>
			<jsp:param name="totalPaginas" value="${paginacao.totalPaginas}"/>
			<jsp:param name="formName" value="formPesquisa"/>
			<jsp:param name="url" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC02/dv02"/>
		</jsp:include>
			
			
		<jsp:include page="/WEB-INF/views/icones.jsp">
			<jsp:param name="novabusca" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC02/dv01"/>
		</jsp:include>
		
	</c:if>
