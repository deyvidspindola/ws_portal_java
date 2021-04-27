<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>	

<c:catch var="helper" >
	<c:import url="/RetirarEquipamentosAcessorios/listarVeiculosReinstalacao?acao=9" context="/SascarPortalWeb"  />
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
	
		function concluirGerarNovaOS(form){
			$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv01");
			$(form).unbind('submit').submit();
		}
		
		function gerarNovaOS(form){
			var data = $(form).serialize();
		
			$.ajax({
				url: "/SascarPortalWeb/RetirarEquipamentosAcessorios/gerarOrdemServicoReinstalacaoRetirada?acao=10",
				data: data || {},
				dataType:"json",
				success: function(json){
				
					if (json.success) {
						
						var ordemServicoReinstalacao = json.ordemServicoReinstalacao;
						$("#ordemServicoReinstalacao").val(ordemServicoReinstalacao);
						abrirModalConfirmacaoNovaOS(form);
						
					} else {
						$(form).attr("action", "");
						$.showMessage(json.mensagem);
					}
					
				}
			});
		}
		
		function abrirModalConfirmacaoNovaOS(form){
			
			var data = $(form).serialize();
		
			$.ajax({
				url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/Mobile/UC34/dv11",
				data: data || {
					"ordemServicoReinstalacao" : $("#ordemServicoReinstalacao").val()			
				},
				dataType:"html",
				success: function(html){
					$("#popupConcluirGeracaoNovaOS").html(html).jOverlay({
						bgClickToClose : false, 
						closeOnEsc : false
					});
				}
			});
		}
	
	</script>
	
	<!-- FORM VOLTAR  -->
	<form method="post" id="formVoltar" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC34/dv08">
		<input type="hidden" name="numeroCPF" value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS" value="${param.numeroOS}" />
	</form>
	
	<form method="post" action="" id="formPesquisa">
		<input type="hidden" name="tipoSumbeterVeiculoReinstalacao" value="I" />
		<input type="hidden" name="ordemServicoReinstalacao" id="ordemServicoReinstalacao" value="" />
		<input type="hidden" name="numeroCPF" value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS"  value="${param.numeroOS}" />
		
		<table id="alter_extrato" width="100%" cellpadding="0" cellspacing="5" border="0" class="dados">
			
			<tr align="center">
				<th style="background-color: rgb(204, 204, 204); color: rgb(51, 51, 51);" scope="col" colspan="5"><fmt:message key="label.listaVeiculosReinstalacao" /></th>
			</tr>
			
			<tr>
				<th width="10%"scope="col">&nbsp;</th>
				<th width="30%" scope="col"><fmt:message key="label.placa" /></th>
				<th width="40%" scope="col"><fmt:message key="label.chassi" /></th>
				<th width="20%" scope="col"><fmt:message key="label.cor" /></th>
			</tr>
			
			<tbody id="tbodyVeiculosReinstalacao">
			
				<c:forEach items="${listaVeiculosReinstalacao}" var="veiculo" varStatus="numLinha">
								
					<c:choose>  
						<c:when test="${numLinha.count % 2 == 0}">
							<tr>
						</c:when>  
						<c:otherwise>
							<tr class="dif">
						</c:otherwise>  
					</c:choose>
					
						<td>

							<input type="radio" 
									name="codVaiculoSelecionado"
									class="required" 
									value="${veiculo.codigo}" />
							
						</td>
						<td>${veiculo.placa}</td>
						<td>${veiculo.chassi}</td>
						<td>${veiculo.cor}</td>
					
					</tr>
				
				</c:forEach>
			
			</tbody>
		
		</table>
		
		<br />
		
		<div class="pgstabela" align="center">
			<p>
				<input type="button" class="aButton ui-state-default ui-corner-all" value="<fmt:message key="label.concluir" />" onclick="gerarNovaOS('#formPesquisa');"/>
			</p>
		</div>
		
	</form>
	
	<!-- DIV MODAL DV11 - TELA CONFIRMACAO GERACAO DE O.S. DE REINSTALACAO  -->
	<div id="popupConcluirGeracaoNovaOS" style="display: none;"></div>
	
	<jsp:include page="/WEB-INF/views/Corporativo/Mobile/icones.jsp">
		<jsp:param name="voltar" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC34/dv08&numeroOS=${param.numeroOS}&numeroCPF=${param.numeroCPF}"/>
	</jsp:include>
	
	
	