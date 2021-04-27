<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/AtivarEquipamentoVinculo/pesquisarOrdensServicoAtivacao?acao=1" context="/SascarPortalWeb"  />
</c:catch>

<c:if test="${not empty mensagemInventario }">
	<script type="text/javascript">
				
			$.ajax({
				url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC10/dv15",
				data: {"errosValidacao" : "erros"},
				dataType:"html",
				success: function(html){
						console.log(html);
					$("#popupErrosValidacao").html(html).jOverlay({
						bgClickToClose : false, 
						closeOnEsc : false
					});
				}
			});
	</script>
</c:if>


<c:if test="${not empty mensagem }">
	<script type="text/javascript">
		$.showMessage("${mensagem}");
	</script>
</c:if>

<c:if test="${not empty helper}" >
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>

<jsp:include page="/WEB-INF/views/Corporativo/UC10/dv01.jsp"/>
 <div id="popupErrosValidacao" style="display: none;"></div>
<c:if test="${not empty ordensServico}" >

	<h1 style="margin-left:50px;"><fmt:message key="label.buscaResultado" /></h1>
	
	<form action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv01" method="post">

		<table width="850" cellpadding="1" id="alter" cellspacing="0" style="margin-top: 15px; margin-left:50px;">
			
			<tr>
			    <th class="texttable_azul" scope="col"><fmt:message key="label.NumOS" /></th>
			    <th class="texttable_cinza" scope="col"><fmt:message key="label.dataHoraAgendamento" /></th>
			    <th class="texttable_cinza" scope="col"><fmt:message key="label.placa" /></th>
			    <th class="texttable_cinza" scope="col"><fmt:message key="label.chassi" /></th>
			    <th class="texttable_cinza" scope="col"><fmt:message key="label.NomeCliente" /></th>
			    <th class="texttable_cinza" scope="col"><fmt:message key="label.dataCadastroOS" /></th>
			    <th class="texttable_cinza" scope="col"><fmt:message key="label.Motivo" /></th>
			    <th class="texttable_azul" scope="col">&nbsp;</th>
			</tr>
			
			<c:forEach var="ordemServico" items="${ordensServico}">
				<tr>
					<td class="linkazul">${ordemServico.numero}&nbsp;</td>
					<td class="linkazulescuro">
						<fmt:formatDate value="${ordemServico.agendamento.dataAgendamento}" pattern="dd/MM/yyyy HH:mm" />&nbsp;
					</td>
					<td>${ordemServico.contrato.veiculo.placa}&nbsp;</td>
					<td>${ordemServico.contrato.veiculo.chassi}&nbsp;</td>
					<td>${ordemServico.contrato.contratante.nome}&nbsp;</td>
					<td><fmt:formatDate value="${ordemServico.dataCadastro}" pattern="dd/MM/yyyy"/>&nbsp;</td>
					<td>${ordemServico.motivo}&nbsp;</td>
					<td class="linkazulescuro" nowrap="nowrap">

					<!-- NOVAS REGRAS PARA STI84173 -->
					
						<c:choose>
												
							<c:when test="${ordemServico.status eq 'V'}"> 
							<c:choose>
							 <c:when test="${ordemServico.ofscAtividade  eq 'N' || ordemServico.ofscAtividade  eq 'false' || empty ordemServico.ofscAtividade }"> 
								<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv03&numeroOS=${ordemServico.numero}" class="linkcinco tooltip" title='<fmt:message key="uc10.dv02.cliqueVincularEquipamento" />'>
									<fmt:message key="uc10.dv02.vincularEquipamento" />
							          	</a>
								&nbsp;|&nbsp;
								<span style="color: #D0D0D0; font-weight: bold;"><fmt:message key="uc10.dv02.realizarTestes" /></span>
								&nbsp;|&nbsp; <br />
								<span style="color: #D0D0D0; font-weight: bold;"><fmt:message key="label.retiradaEquipamentosAcessorios" /></span>
							  </c:when>
							  <c:when test="${ordemServico.ofscAtividade  eq 'U'}"> 
								  <a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv03&numeroOS=${ordemServico.numero}" class="linkcinco tooltip" title='<fmt:message key="uc10.dv02.cliqueVincularEquipamento" />'>
										<fmt:message key="uc10.dv02.vincularEquipamento" />
								          	</a>
									&nbsp;|&nbsp;
									<span style="color: #D0D0D0; font-weight: bold;"><fmt:message key="uc10.dv02.realizarTestes" /></span>
									&nbsp;|&nbsp; <br />
									<span style="color: #D0D0D0; font-weight: bold;"><fmt:message key="label.retiradaEquipamentosAcessorios" /></span>
							  </c:when>
							  <c:otherwise>
							 		 <span style="color: #D0D0D0;"><fmt:message key="uc10.dv02.vincularEquipamento" /></span>&nbsp;|&nbsp;
									<span style="color: #D0D0D0;"><fmt:message key="uc10.dv02.realizarTestes" /></span> <br />
									<span style="color: #D0D0D0;"><fmt:message key="label.retiradaEquipamentosAcessorios" /></span>
							  </c:otherwise>
							</c:choose>
							</c:when>
							
							<c:when test="${ordemServico.status eq 'T'}"> 
							<c:choose>
							<c:when test="${ordemServico.ofscAtividade  eq 'N' || ordemServico.ofscAtividade  eq 'false' || empty ordemServico.ofscAtividade }"> 
										<c:if test="${ordemServico.mostraLinks}">	 
											<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv03&numeroOS=${ordemServico.numero}" class="linkcinco tooltip" title='<fmt:message key="uc10.dv02.cliqueVincularEquipamento" />'>
												<fmt:message key="uc10.dv02.vincularEquipamento" />
											</a>
											&nbsp;|&nbsp;
										</c:if>
											<c:if test="${realizarTeste}">
												<c:if test="${ordemServico.mostraLinks}">	 									
													<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv01&numeroOS=${ordemServico.numero}&numeroPlaca=${ordemServico.contrato.veiculo.placa}&motivo=${ordemServico.siglaMotivo}" class="linkcinco tooltip" title='<fmt:message key="uc10.dv02.cliqueIniciarTestes" />'>
													<fmt:message key="uc10.dv02.realizarTestes" />
													</a>
												</c:if> 
												<c:if test="${!ordemServico.mostraLinks}">
													<span style="color: #D0D0D0;"><fmt:message key="uc10.dv02.realizarTestes" /></span>
												</c:if>											
											</c:if>
											
											<c:if test="${!realizarTeste}"> 
												<span style="color: #D0D0D0;"><fmt:message key="uc10.dv02.realizarTestes" /></span>
											</c:if>								
											&nbsp;|&nbsp; <br />
											<span style="color: #D0D0D0; font-weight: bold;"><fmt:message key="label.retiradaEquipamentosAcessorios" /></span>
								</c:when>
								  <c:when test="${ordemServico.ofscAtividade  eq 'U'}"> 
								  										<c:if test="${ordemServico.mostraLinks}">	 
											<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv03&numeroOS=${ordemServico.numero}" class="linkcinco tooltip" title='<fmt:message key="uc10.dv02.cliqueVincularEquipamento" />'>
												<fmt:message key="uc10.dv02.vincularEquipamento" />
											</a>
											&nbsp;|&nbsp;
										</c:if>
											<c:if test="${realizarTeste}">
												<c:if test="${ordemServico.mostraLinks}">	 									
													<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv01&numeroOS=${ordemServico.numero}&numeroPlaca=${ordemServico.contrato.veiculo.placa}&motivo=${ordemServico.siglaMotivo}" class="linkcinco tooltip" title='<fmt:message key="uc10.dv02.cliqueIniciarTestes" />'>
													<fmt:message key="uc10.dv02.realizarTestes" />
													</a>
												</c:if> 
												<c:if test="${!ordemServico.mostraLinks}">
													<span style="color: #D0D0D0;"><fmt:message key="uc10.dv02.realizarTestes" /></span>
												</c:if>											
											</c:if>
											
											<c:if test="${!realizarTeste}"> 
												<span style="color: #D0D0D0;"><fmt:message key="uc10.dv02.realizarTestes" /></span>
											</c:if>								
											&nbsp;|&nbsp; <br />
											<span style="color: #D0D0D0; font-weight: bold;"><fmt:message key="label.retiradaEquipamentosAcessorios" /></span>
								  </c:when>
								  <c:otherwise>
								  			<span style="color: #D0D0D0;"><fmt:message key="uc10.dv02.vincularEquipamento" /></span>&nbsp;|&nbsp;
											<span style="color: #D0D0D0;"><fmt:message key="uc10.dv02.realizarTestes" /></span> <br />
											<span style="color: #D0D0D0;"><fmt:message key="label.retiradaEquipamentosAcessorios" /></span>
								  </c:otherwise>
								  </c:choose>
							</c:when> 
							
							<c:when test="${ordemServico.status eq 'R'}">
							<c:choose>
								<c:when test="${ordemServico.ofscAtividade  eq 'N' || ordemServico.ofscAtividade  eq 'false' || empty ordemServico.ofscAtividade }">  
										<span style="color: #D0D0D0; font-weight: bold;"><fmt:message key="uc10.dv02.vincularEquipamento" /></span>
										&nbsp;|&nbsp;
										<span style="color: #D0D0D0; font-weight: bold;"><fmt:message key="uc10.dv02.realizarTestes" /></span>
										&nbsp;|&nbsp; <br />
										<c:if test="${retiradaEquipamento}">								
											<c:if test="${ordemServico.mostraLinks}">
												<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC34/dv01&numeroOS=${ordemServico.numero}" class="linkcinco tooltip" title='<fmt:message key="uc10.dv02.cliqueRetirarEquipamento" />'>
												<fmt:message key="label.retiradaEquipamentosAcessorios" />
												</a>
											</c:if>
											<c:if test="${!ordemServico.mostraLinks}">
												<span style="color: #D0D0D0;"><fmt:message key="label.retiradaEquipamentosAcessorios" /></span>
											</c:if>								
										</c:if>
										<c:if test="${!retiradaEquipamento}">
											<span style="color: #D0D0D0;"><fmt:message key="label.retiradaEquipamentosAcessorios" /></span>
										</c:if>	
								</c:when>	
								<c:when test="${ordemServico.ofscAtividade  eq 'U'}">  
										<span style="color: #D0D0D0; font-weight: bold;"><fmt:message key="uc10.dv02.vincularEquipamento" /></span>
										&nbsp;|&nbsp;
										<span style="color: #D0D0D0; font-weight: bold;"><fmt:message key="uc10.dv02.realizarTestes" /></span>
										&nbsp;|&nbsp; <br />
										<c:if test="${retiradaEquipamento}">								
											<c:if test="${ordemServico.mostraLinks}">
												<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC34/dv01&numeroOS=${ordemServico.numero}" class="linkcinco tooltip" title='<fmt:message key="uc10.dv02.cliqueRetirarEquipamento" />'>
												<fmt:message key="label.retiradaEquipamentosAcessorios" />
												</a>
											</c:if>
											<c:if test="${!ordemServico.mostraLinks}">
												<span style="color: #D0D0D0;"><fmt:message key="label.retiradaEquipamentosAcessorios" /></span>
											</c:if>								
										</c:if>
										<c:if test="${!retiradaEquipamento}">
											<span style="color: #D0D0D0;"><fmt:message key="label.retiradaEquipamentosAcessorios" /></span>
										</c:if>	
								 </c:when>	
								 <c:otherwise>
								 	<span style="color: #D0D0D0;"><fmt:message key="uc10.dv02.vincularEquipamento" /></span>&nbsp;|&nbsp;
									<span style="color: #D0D0D0;"><fmt:message key="uc10.dv02.realizarTestes" /></span> <br />
									<span style="color: #D0D0D0;"><fmt:message key="label.retiradaEquipamentosAcessorios" /></span>
								 </c:otherwise>	
								 </c:choose>		
							</c:when>						
							<c:otherwise>
								<span style="color: #D0D0D0;"><fmt:message key="uc10.dv02.vincularEquipamento" /></span>&nbsp;|&nbsp;
								<span style="color: #D0D0D0;"><fmt:message key="uc10.dv02.realizarTestes" /></span> <br />
								<span style="color: #D0D0D0;"><fmt:message key="label.retiradaEquipamentosAcessorios" /></span>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
		</table>
	</form>	

	<jsp:include page="/WEB-INF/views/paginacao.jsp">
		<jsp:param name="pagina" value="${paginacao.paginaAtual}"/>
		<jsp:param name="totalPaginas" value="${paginacao.totalPaginas}"/>
		<jsp:param name="formName" value="formPesquisa"/>
		<jsp:param name="url" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv02"/>
	</jsp:include>

</c:if>
