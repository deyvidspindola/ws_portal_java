<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/AutorizarDebitoAutomaticoServlet/pesquisarHistoricoCadastroDebitoAutomatico?acao=4" context="/SascarPortalWeb"  />
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

	$(document).ready(function() {
		
		$('#tableListaHistoricoDebitoAutomatico').dataTable( {
			"sScrollY": 200,
			"sScrollX": "100%",
			"sScrollXInner": "2000px",
			"bPaginate": false,
			"bFilter": false,
			"bInfo": false,
			"bSort": false,
		} );
		
	});
		
						

</script>

	<form id="formPopupHistorico" method="post" action="" >
		
		<div id="popup">
		
			<div id="popup_bordacima_grande"></div>
			
			<div id="popupinterior_popup_agendar_ordem_servico">
			
			<div class="conteinerValidacao">
				<ol style="color: #C00;">
				</ol>
			</div>
			
				<h3><fmt:message key="label.historico" /></h3>
			
				<!-- ABRE DIV BUSCA POPUP -->
				<div id="divbuscapopup" style="width: 870px; max-height: 420px; overflow: auto; margin-top:10px;">
					
					<table cellpadding="0" cellspacing="0" border="0" class="display" id="tableListaHistoricoDebitoAutomatico">
				
					<thead>
						<tr>
							<th colspan="4" style="border-bottom: none;"></th>
							<th colspan="4" class="dadosCobrancaAnterior" style="border: solid #666666 1px; border-bottom: none; border-right: none;"><fmt:message key="label.dadosCobrancaAnterior" /></th>
							<th colspan="4" class="dadosCobrancaPosterior" style="border: solid #666666 1px; border-bottom: none;"><fmt:message key="label.dadosCobrancaPosterior" /></th>
						</tr>
						<tr>
							<th width="100"><fmt:message key="label.dataHora" /></th>
							<th width="80"><fmt:message key="label.canalEntrada" /></th>
							<th width="60"><fmt:message key="label.tipoOperacao" /></th>
							<th width="160"><fmt:message key="label.Motivo" /></th>
							
							<th width="80"  style="border-left: solid #666666 1px;"><fmt:message key="label.formaCobranca" /></th>
							<th width="80"><fmt:message key="label.banco" /></th>
							<th width="80"><fmt:message key="label.agencia" /></th>
							<th width="80"><fmt:message key="label.contaCorrente" /></th>
							
							<th width="80"  style="border-left: solid #666666 1px;"><fmt:message key="label.formaCobranca" /></th>
							<th width="80"><fmt:message key="label.banco" /></th>
							<th width="80"><fmt:message key="label.agencia" /></th>
							<th width="80"><fmt:message key="label.contaCorrente" /></th>
							
						</tr>
					</thead>
					
					<tbody>
					
						<c:forEach items="${historico}" var="historico" >
							
							<tr class="gradeA">
							
								<td class="center">
									<fmt:formatDate value="${historico.dataHoraCadastroDebitoAutomatico}" pattern="dd/MM/yyyy HH:mm:ss"/>
								</td>
								<td class="center">
									<c:choose>
										<c:when test="${historico.canalEntrada eq 'P'}">
											<fmt:message key="label.portal" />
										</c:when>
										<c:otherwise>
											<fmt:message key="label.intranet" />
										</c:otherwise>
									</c:choose>
								</td>	
								<td class="center">
									<c:choose>
										<c:when test="${historico.tipoOperacao eq 'I'}">
											<fmt:message key="label.inclusao" />
										</c:when>
										<c:otherwise>
											<fmt:message key="label.exclusao" />
										</c:otherwise>
									</c:choose>
								</td>
								<td class="center">${historico.motivo}</td>
								
								<td class="center" style="border-left: solid #666666 1px;">${historico.formaCobrancaAnterior}</td>
								<td class="center">${historico.bancoAnterior}</td>
								<td class="center">${historico.agenciaAnterior}</td>
								<td class="center">${historico.contaCorrenteAnterior}</td>
								
								<td class="center" style="border-left: solid #666666 1px;">${historico.formaCobrancaPosterior}</td>
								<td class="center">${historico.bancoPosterior}</td>
								<td class="center">${historico.agenciaPosterior}</td>
								<td class="center">${historico.contaCorrentePosterior}</td>
								
							</tr>
							
						</c:forEach>
						
					</tbody>
				</table>
					
				<div style="clear: both;"></div>
				<br />		
					
				</div>
				<!-- FECHA DIV BUSCA POPUP -->
				
				<span>
					<label>
						<input class="btnBranco close" 
							   type="button" 
							   onclick="$.closeOverlay();" 
							   value="<fmt:message key="label.sair" />" 
							   name="button4" />
					</label>
				</span>
				
			</div>
				
			<div id="popup_bordarodape_grande"></div>
			
		</div>
	
	</form>