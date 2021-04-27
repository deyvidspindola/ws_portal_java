<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/AtivarEquipamentoVinculo/pesquisarOrdensServicoAtivacao?acao=1" context="/SascarPortalWeb"  />
</c:catch>

<c:if test="${not empty mensagem }">
	<script type="text/javascript">
		$(document).ready(function(){
			$.showMessage("${mensagem}");
			window.setTimeout(function(){
				window.history.back(-1);
			}, 2000);
		});
	</script>
</c:if>

<script type="text/javascript">
	$(document).ready(function(){
		$('#ativar_equipamento').addClass('active');
	});
</script>

	<c:if test="${not empty ordensServico}" >
	
		<form id="formPesquisa" name="formPesquisa" method="post">
			<input type="hidden" name="tipoDataPesquisa" value="${param.tipoDataPesquisa}" />
			<input type="hidden" name="dataInicial" 	value="${param.dataInicial}" />
			<input type="hidden" name="dataFinal" 		value="${param.dataFinal}" />
			<input type="hidden" name="numeroOS" 		value="${param.numeroOS}" />
			<input type="hidden" name="numeroPlaca" 	value="${param.numeroPlaca}" />
			<input type="hidden" name="numeroChassi" 	value="${param.numeroChassi}" />
			<input type="hidden" name="nomeCliente" 	value="${param.nomeCliente}" />
		</form>
		
		<h1><fmt:message key="label.buscaResultado" /></h1>
		
		
		<jsp:include page="/WEB-INF/views/paginacao.jsp">
			<jsp:param name="pagina" value="${paginacao.paginaAtual}"/>
			<jsp:param name="totalPaginas" value="${paginacao.totalPaginas}"/>
			<jsp:param name="formName" value="formPesquisa"/>
			<jsp:param name="url" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv02"/>
		</jsp:include>	
		
		
		<c:forEach var="ordemServico" items="${ordensServico}">
			
			<c:set var="numeroOs" >
				[${ordemServico.numero}]
			</c:set>
			
			<table cellspacing="0" width="100%" class="listaItens" border="0">
				<tr>
					<th><fmt:message key="label.NumOS" /></th>
					<th><fmt:message key="label.dataAgendamento" /></th>
				</tr>
				<tr>
					<td style="text-align: left;">&#160;${numeroOs}&nbsp;</td>
					<td style="text-align: left;"><fmt:formatDate value="${ordemServico.agendamento.dataAgendamento}" pattern="dd/MM/yyyy HH:mm" />&nbsp;</td>
				</tr>
				<tr>
					<th><fmt:message key="label.placa" /></th>
					<th><fmt:message key="label.chassi" /></th>
				</tr>
				<tr>
					<td style="text-align: left;">${ordemServico.contrato.veiculo.placa}&nbsp;</td>
					<td style="text-align: left;">${ordemServico.contrato.veiculo.chassi}&nbsp;</td>
				</tr>
				<tr>
					<th colspan="2"><fmt:message key="label.nomeDoCliente" /></th>
				</tr>
				<tr>
					<td colspan="2">${ordemServico.contrato.contratante.nome}&nbsp;</td>
				</tr>
				<tr>
					<th colspan="2"><fmt:message key="label.dataCadastroOS" /></th>
				</tr>
				<tr>
					<td><fmt:formatDate value="${ordemServico.dataCadastro}" pattern="dd/MM/yyyy"/>&nbsp;</td>
				</tr>
				<tr>
					<th colspan="2"><fmt:message key="label.Motivo" /></th>
				</tr>
				<tr>
					<td colspan="2">${ordemServico.motivo}&nbsp;</td>
				</tr>				
				<tr>
					<td colspan="2" align="center">
						<c:choose>
							
							<c:when test="${ordemServico.status eq 'V'}">
								<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv03&numeroOS=${ordemServico.numero}" title="<fmt:message key="uc10.dv02.cliqueVincularEquipamento" />">
									<fmt:message key="uc10.dv02.vincularEquipamento" />
								</a>
								<br/>
								<span style="color: #D0D0D0; font-size: 30px;"><fmt:message key="uc10.dv02.realizarTestes" /></span>
								<br/>
								<span style="color: #D0D0D0; font-size: 30px;"><fmt:message key="label.retiradaEquipamentosAcessorios" /></span>
							</c:when>
							
							<c:when test="${ordemServico.status eq 'T'}">
								<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv03&numeroOS=${ordemServico.numero}" title="<fmt:message key="uc10.dv02.cliqueVincularEquipamento" />">
									<fmt:message key="uc10.dv02.vincularEquipamento" />
								</a>
								<br/>
								<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC13/dv01&numeroOS=${ordemServico.numero}&numeroPlaca=${ordemServico.contrato.veiculo.placa}" title="<fmt:message key="uc10.dv02.cliqueIniciarTestes" />">
									<fmt:message key="uc10.dv02.realizarTestes" />
								</a>
								<br/>
								<span style="color: #D0D0D0; font-size: 30px;"><fmt:message key="label.retiradaEquipamentosAcessorios" /></span>
							</c:when>
							
							<c:when test="${ordemServico.status eq 'R'}">
								<span style="color: #D0D0D0; font-size: 30px;"><fmt:message key="uc10.dv02.vincularEquipamento" /></span>
								<br/>
								<span style="color: #D0D0D0; font-size: 30px;"><fmt:message key="uc10.dv02.realizarTestes" /></span>
								<br/>
								<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC34/dv01&numeroOS=${ordemServico.numero}" title="<fmt:message key="uc10.dv02.cliqueRetirarEquipamento" />">
									<fmt:message key="label.retiradaEquipamentosAcessorios" />
								</a>
							</c:when>
							
							<c:otherwise>
								<span style="color: #D0D0D0;"><fmt:message key="uc10.dv02.vincularEquipamento" /></span>
								<br/>
								<span style="color: #D0D0D0;"><fmt:message key="uc10.dv02.realizarTestes" /></span>
								<br />
								<span style="color: #D0D0D0;"><fmt:message key="label.retiradaEquipamentosAcessorios" /></span>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</table>
			<br/><br/>
		</c:forEach>
			
			
		<jsp:include page="/WEB-INF/views/paginacao.jsp">
			<jsp:param name="pagina" value="${paginacao.paginaAtual}"/>
			<jsp:param name="totalPaginas" value="${paginacao.totalPaginas}"/>
			<jsp:param name="formName" value="formPesquisa"/>
			<jsp:param name="url" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv02"/>
		</jsp:include>	
		
		<div class="clear"></div>
			
	</c:if>