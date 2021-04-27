<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/RetirarEquipamentosAcessorios/carregarInformacoesRetiradaEquipamento?acao=4" context="/SascarPortalWeb"  />
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

	function confirmarRemocaoEquipameno(form) {
		var data = $(form).serialize();
		$.ajax({
			url: "/SascarPortalWeb/RetirarEquipamentosAcessorios/confirmarRemocaoEquipameno?acao=5",
			data: data || {},
			dataType:"json",
			success: function(json){
				if (json.success) {
					
					var quantidadeRestanteAcessorios = json.acessoriosRestantesAtual;		
					var quantidadeTotalAcessorios = json.totalAcessoriosAtual;		
					
					// valida equipamento que não tem nenhum acessorio vinculado.
					if(quantidadeTotalAcessorios == 0 ){
						
						$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC34/dv08&numeroOS=${param.numeroOS }");
						$(form).unbind('submit').submit();
						
					}else{
					
						// validae se equipamento possue acessórios para sere removidos.
						if(quantidadeRestanteAcessorios == 0 && quantidadeTotalAcessorios != 0 ){
							
							$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC34/dv08&numeroOS=${param.numeroOS }");
							$(form).unbind('submit').submit();
							
						}else{
							
							$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC34/dv06");
							$(form).unbind('submit').submit();
						}
					}
				
				} else {
					$(form).attr("action", "");
					$.showMessage(json.mensagem);
				}
			}
		});
	}
	
	function showModalConfirmarRetiradaEquipamento() {
		$.ajax({
			url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/Mobile/UC34/dv05",
			data: {"serialEquipamento" : $("#serialEquipamento").val()},
			dataType:"html",
			success: function(html){
				$("#popupConfirmacaoRetirada").html(html).jOverlay({
					bgClickToClose : false, 
					closeOnEsc : false
				});
			}
		});
	}
	
</script>

	<form action="" method="post" id="formPesquisa">
	
		<input type="hidden" name="acao" value="5" />
		
		<input type="hidden" name="numeroOS"      id="numeroOS" value="${param.numeroOS }" />
		<input type="hidden" name="numeroCPF"     value="${param.numeroCPF }" />
		<input type="hidden" name="chassiVeiculo" value="${param.chassiVeiculo}" />
		<input type="hidden" name="placaVeiculo"  value="${param.placaVeiculo}" />
		
		<input type="hidden" name="serialEquipamento" id="serialEquipamento" value="${equipamento.numeroSerial}" />
	
		<table class="detalhe" cellspacing="0">
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.retiradaEquipamentoAcessorio" /></th>
			</tr>
		</table>
		
		<fieldset>
			<legend><strong><fmt:message key="label.dadosVeiculo" /></strong></legend>
			
			<p class="input">
				<label><span><fmt:message key="label.ordemServico" />:</span></label><br />
				<input value="${param.numeroOS}" type="text" readonly="readonly" name="numeroOS" />
			</p>
			
			<p class="input">
				<label><span><fmt:message key="label.chassi" />:</span></label><br />
				<input value="${param.chassiVeiculo}" type="text" readonly="readonly" name="chassi" />
			</p>
			
			<p class="input">
				<label><span><fmt:message key="label.placa" />:</span></label><br />
				<input value="${param.placaVeiculo}" type="text" readonly="readonly" name="placa"  />
			</p>
		
		</fieldset>
		
		<br><br>
		
		<fieldset>
			<legend><strong><fmt:message key="label.retiradaDeEquipamento" /></strong></legend>
			
			<p class="input">
				<label><span><fmt:message key="label.modelo" />:</span></label><br />
				<input value="${equipamento.modelo}" type="text" readonly="readonly" name="modelo"  />
			</p>
			
			<p class="input">
				<label><span><fmt:message key="label.serie" />:</span></label><br />
				<input value="${equipamento.numeroSerial}" type="text" readonly="readonly" name="serie"  />
			</p>
			
			<p class="input">
				<label><span><fmt:message key="label.versao" />:</span></label><br />
				<input value="${equipamento.versao}" type="text" readonly="readonly" name="versao"  />
			</p>
			
			<p class="input">
				<label><span><fmt:message key="label.idSascarga" />:</span></label><br />
				<input value="${equipamento.codigoSascarga}" type="text" readonly="readonly" name="idSascarga"  />
			</p>
			
			<p class="input" style="padding:10px; margin-top:10px; text-align: center;">
				<input class="aButton ui-state-default ui-corner-all" 
					   value="<fmt:message key="label.continuar" />" 
					   type="button" 
					   onclick="showModalConfirmarRetiradaEquipamento()" />
			</p>
				
		</fieldset>
		
	</form>

	<!-- DIV MODAL DV05 - TELA CONFIRMACAO RETIRADA EQUIPAMENTO -->
	<div id="popupConfirmacaoRetirada" style="display: none;"></div>

<jsp:include page="/WEB-INF/views/Corporativo/Mobile/icones.jsp">
	<jsp:param name="voltar" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC34/dv03&numeroOS=${param.numeroOS}&numeroCPF=${param.numeroCPF}&chassiVeiculo=${param.chassiVeiculo}&placaVeiculo=${param.placaVeiculo}"/>
</jsp:include>