<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>
 
<c:catch var="helper" >
	<c:import url="/AgendarOrdemServico/listarOSRepresentante?acao=9" context="/SascarPortalWeb"  />
</c:catch>

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


<script type="text/javascript">

	function showModalCancalarAgendamento(paramNumeroOrdemServico){
		
		var numeroOrdemServico = paramNumeroOrdemServico;
		var dataAgendamento = $("#dataAgendamentoOrdemServicoCancelamento"+numeroOrdemServico).val();
		var placaVeiculo = $("#placaVeiculoOrdemServicoCancelamento"+numeroOrdemServico).val();
		
		$.ajax({
			url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC43/dv05",
			data: {
				"numeroOrdemServico" : numeroOrdemServico, 
				"dataAgendamento" : dataAgendamento,
				"placaVeiculo" : placaVeiculo
			},
			dataType:"html",
			success: function(html){
				$("#popupCancelarAgendamento").html(html).jOverlay({
					bgClickToClose : false, 
					closeOnEsc : false
				});
			}
		}); 
	}
	
	function agendarOrdemServico(element){
		
		// NUMERO DA ORDEM DE SERVICO SELECIONADA PARA AGENDAMENTO
		numeroOrdemServico = $(element).attr('name');
		
		// PLACA RELACIONADA A ORDEM DE SERVICO SELECIONADA PARA AGENDAMENTO
		var placa = $("#placaOrdemServico"+numeroOrdemServico).val();
		
		$("#ordemServicoAgendamento").val(numeroOrdemServico);
		$("#placaAgendamento").val(placa);
		
		$("#formCadastro").attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC43/dv03");
		$("#formCadastro").unbind('submit').submit();
		
	}
	
	$(document).ready(function(){
		
		// LIMPANDO PARAMETROS DO FORM
		$("#ordemServicoAgendamento").val('');
		$("#placaAgendamento").val('');
		
	});
		
</script>

	<jsp:include page="/WEB-INF/views/Corporativo/UC43/dv01.jsp" />
	
	<form id="formCadastro" action="" method="post">
		
	<input type="hidden" id="ordemServicoAgendamento" name="ordemServicoAgendamento" value="" /> 
	<input type="hidden" id="placaAgendamento" 		  name="placaAgendamento" 		 value="" />
	
	<input type="hidden" name="dataInicial" 		value="${param.dataInicial}" /> 
	<input type="hidden" name="dataFinal" 			value="${param.dataFinal}" /> 
	<input type="hidden" name="placa" 				value="${param.placa}" /> 
	<input type="hidden" name="chassi" 				value="${param.chassi}" /> 
	<input type="hidden" name="numeroOrdemServico"  value="${param.numeroOrdemServico}" /> 
	<input type="hidden" name="nomeCliente" 		value="${param.nomeCliente}" /> 
	<input type="hidden" name="tipoServico" 		value="${param.tipoServico}" /> 
	
		<!-- EVITA A RENDENRIZACAO DA TABELA A PESQUISA NAO RETORNE NENHUM RESULTADO -->
		<c:if test="${not empty ordensServico}">
		
			<h1 style="margin-top: 40px;"><fmt:message key="label.resultadoDaBusca" /></h1>
			
			<span class="texthelp2">
				<img hspace="5" height="16" align="absmiddle" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png">
				<fmt:message key="label.cliqueOrdemServicoVisualizarDetalhes" />
			</span>
			
			<div style="clear:both;"></div>
			
			<table id="alter" cellspacing="0" cellpadding="1" width="850" style="margin-top: 0pt;">
				<tbody>
					<tr>
						<th class="texttable_azul"  width="9%"  scope="col"><fmt:message key="label.NumOS" /></th>
						<th class="texttable_azul"  width="9%"  scope="col"><fmt:message key="label.Status" /></th>
						<th class="texttable_cinza" width="13%" scope="col"><fmt:message key="label.dataAbertura" /></th>
						<th class="texttable_cinza" width="13%" scope="col"><fmt:message key="label.tipoServico" /></th>
						<th class="texttable_cinza" width="8%"  scope="col"><fmt:message key="label.placa" /></th>
						<th class="texttable_cinza" width="16%" scope="col"><fmt:message key="label.chassi" /></th>
						<th class="texttable_cinza" width="18%" scope="col"><fmt:message key="label.cliente" /></th>
						<c:if test="${renderizaDataAgendamento}">
							<th class="texttable_cinza" width="14%" scope="col"><fmt:message key="label.dataAgendamento" /></th>
						</c:if>
					</tr>
					
					<c:forEach var="ordemServico" items="${ordensServico}" varStatus="status">
						
						<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if> >
							<td class="linkazulescuro">
								<a class="linkcinco" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC43/dv06&numeroOrdemServico=${ordemServico.numero}&dataInicial=${param.dataInicial}&dataFinal=${param.dataFinal}&placa=${param.placa}&chassi=${param.chassi}&nomeCliente=${param.nomeCliente}&tipoServico=${param.tipoServico}&codCliente=${ordemServico.contrato.contratante.codigo}">
									${ordemServico.numero}
								</a>
							</td>
							<td>${ordemServico.status}</td>
							<td><fmt:formatDate value="${ordemServico.dataGeracao}" pattern="dd/MM/yyyy"/></td>
							<td>${ordemServico.tipoServico}</td>
							<td>
								<input type="hidden" id="placaOrdemServico${ordemServico.numero}" value="${ordemServico.contrato.veiculo.placa}" />
								${ordemServico.contrato.veiculo.placa}
							</td>
							<td>${ordemServico.contrato.veiculo.chassi}</td>
							<td>${ordemServico.contrato.contratante.nome}</td>
							<c:if test="${renderizaDataAgendamento}">
								<c:choose>
									<c:when test="${not empty ordemServico.agendamento.dataAgendamento}">
										<td>
											<fmt:formatDate value="${ordemServico.agendamento.dataAgendamento}" pattern="dd/MM/yyyy"/>
											
											<input type="hidden" 
												   id="dataAgendamentoOrdemServicoCancelamento${ordemServico.numero}" 
												   value="<fmt:formatDate value="${ordemServico.agendamento.dataAgendamento}" pattern="dd/MM/yyyy HH:mm:ss"/>"/>
												   
											<input type="hidden" 
												   id="placaVeiculoOrdemServicoCancelamento${ordemServico.numero}" 
												   value="${ordemServico.contrato.veiculo.placa}"/>
												   
											<a href="#" onclick="showModalCancalarAgendamento(${ordemServico.numero});">
												<img height="16" border="0" align="absmiddle" width="16" 
												     src="${pageContext.request.contextPath}/sascar/images/corporativo_new/agendamento32.png" />
											</a>
										</td>
									</c:when>
									<c:otherwise>
										<td>
											<input class="button2" 
												   type="button" 
												   value="<fmt:message key="label.agendar" />" 
												   name="${ordemServico.numero}" 
												   onclick="agendarOrdemServico(this);" />
										</td>
									</c:otherwise>				
								</c:choose>
							</c:if>
						</tr>
					</c:forEach>
					
				</tbody>
			</table>
			
			<div style="clear: both;"></div>
			<br />		
				
			<p style="position: relative;
					 float: right;
					 margin: 0px 10px 0px 0px;
					 color: #4D4D4D;
				     font-size: 12px;
				     font-weight: bold;"><fmt:message key="label.totalOrdensServico" />: ${totalOrdensServico}</p>
		
			<div style="clear: both;"></div>
			<br />	
		
			<div class="pgstabela">
				<input id="button" 
					   class="button" 
					   type="button" 
					   value="<fmt:message key="btn.novaBusca" />" 
					   name="button"
					   onclick="window.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC43/dv01'" />
			</div>
		
		</c:if>
	
	</form>
	
	<!-- DIV MODAL DV05 - TELA CANCELAMENTO DE ORDEM SERVICO  -->
	<div id="popupCancelarAgendamento" style="display: none;"></div>
	
	<!-- DIV MODAL DV10 - TELA MENSAGEM DE CANCELAMENTO DE ORDEM SERVICO EFETUADO COM SUCESSO -->
	<div id="popupSucessoCancelarAgendamento" style="display: none;"></div>
