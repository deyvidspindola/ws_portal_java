<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/RetirarEquipamentosAcessorios/recuperarAcessorioEquipamento?acao=6" context="/SascarPortalWeb"  />
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
	
	function submeterDadosAcessorio(form) {
		
		var data = $(form).serialize();
		
		$.ajax({
			url: "/SascarPortalWeb/RetirarEquipamentosAcessorios/submeterDadosAcessorio?acao=7",
			data: data || {},
			dataType:"json",
			success: function(json){
			
				if (json.success) {
					
					var quantidadeRestanteAcessorios = json.acessoriosRestantesAtual;		
					var quantidadeTotalAcessorios = json.totalAcessoriosAtual;		
					
					if(quantidadeRestanteAcessorios == 0 && quantidadeTotalAcessorios != 0 ){
						$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC34/dv08&numeroOS=${param.numeroOS }");
						$(form).unbind('submit').submit();
					}else{
						$("#formAtualizar").submit();
					}
					
				} else {
					$(form).attr("action", "");
					$.showMessage(json.mensagem);
				}
				
			}
		});
	}
	
	function showModalConfirmarRetiradaAcessorio() {
		$.ajax({
			type : "POST",
			url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/Mobile/UC34/dv07",
			data: {
				"descricaoAcessorio" : $("#descricaoAcessorio").val(),
				"numeroSerialAcessorio" : $("#numeroSerialAcessorio").val()
			},
			dataType:"html",
			success: function(html){
				$("#popupConfirmacaoRetiradaAcessorioSerial").html(html).jOverlay({
					bgClickToClose : false, 
					closeOnEsc : false
				});
			}
		});
	}
</script>

	<!-- FORM ATUALIZAR -->
	<form method="get"	id="formAtualizar"	action="${pageContext.request.contextPath}/Satellite">
		<input type="hidden" name="pagename"      value="SascarPortal_Corporativo/Mobile/RepresentanteTecnico" />
		<input type="hidden" name="page"          value="Corporativo/Mobile/UC34/dv06" /> 
		<input type="hidden" name="tipoOperacao"  value="${param.tipoOperacao}" />
		<input type="hidden" name="numeroOS"      value="${param.numeroOS}" />
		<input type="hidden" name="chassiVeiculo" value="${param.chassiVeiculo}" />
		<input type="hidden" name="placaVeiculo"  value="${param.placaVeiculo}" />
		<input type="hidden" name="numeroCPF"     value="${param.numeroCPF }" />
	</form>
	
	<form action="" id="formPesquisa" method="get">
	
		<input type="hidden" name="pagename" value="SascarPortal_Corporativo/Mobile/RepresentanteTecnico" />
		<input type="hidden" name="page"     value="Corporativo/Mobile/UC34/dv08" />
	
		<input type="hidden" name="numeroOS"                 value="${param.numeroOS}" />
		<input type="hidden" name="tipoOperacao"             value="${param.tipoOperacao}" />
		<input type="hidden" name="numeroCPF"                value="${param.numeroCPF }" />
		<input type="hidden" name="codigoItem"               value="${acessorio.codigoItem}" />
		<input type="hidden" name="quantidadeAcessorio"      value="${acessorio.quantidade}" />
		<input type="hidden" name="descricaoLocalInstalacao" value="${acessorio.descricaoLocalInstalacao}" />
		<input type="hidden" name="codigoPorta"              value="${acessorio.codigoPorta}" />
		<input type="hidden" name="acessorioId"              value="${acessorio.codigo}" />
		
		<input type="hidden" id="numeroSerialAcessorio"      name="numeroSerialAcessorio" value="${acessorio.numeroSerial}" />
		<input type="hidden" id="descricaoAcessorio"         name="descricaoAcessorio"    value="${acessorio.descricao}" />
	
		<input type="hidden" name="chassiVeiculo"            value="${param.chassiVeiculo}" />
		<input type="hidden" name="placaVeiculo"             value="${param.placaVeiculo}" />
	
		<table class="detalhe" cellspacing="0">
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.retiradaEquipamentoAcessorio" /></th>
			</tr>
		</table>
		
		<fieldset>
			<legend><strong><fmt:message key="label.dadosVeiculo" /></strong></legend>
			
			<p class="input">
				<label><span><fmt:message key="label.ordemServico" />:</span></label><br />
				<input value="${param.numeroOS }" type="text" readonly="readonly" name="numeroOS" />
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
			<legend><strong><fmt:message key="label.retiradaDeAcessorio" /></strong></legend>
			
			<p class="input">
				<label><span><fmt:message key="label.acessorio" />:</span></label><br />
				<input value="${acessorio.descricao}"
				       type="text" readonly="readonly" id="descricaoAcessorio" name="modeloAcessorio"  />
			</p>
			
			<p class="input">
				<c:choose>
					<c:when test="${acessorio.indicadorSerial}">
						<label><span><fmt:message key="label.serial" />:</span></label><br />
						<input value="${acessorio.numeroSerial}" type="text" readonly="readonly" name="serial"  />
					</c:when>
					<c:otherwise>
						<label><span><fmt:message key="label.quantidade" />:</span></label><br />
						<!-- POR SOLICITACAO DA SASCAR A QUANTIDADE DE ACESSORIOS DEVERA FICAR FIXA -->
						<!--<input value="${acessorio.quantidade}" type="text" readonly="readonly" name="quantidade"  />-->
						<input value="1" type="text" readonly="readonly" name="quantidade"  />
					</c:otherwise>
				</c:choose>
			</p>
			
			<p class="input" style="padding:10px; margin-top:10px; text-align: center;">
				<input class="aButton ui-state-default ui-corner-all" 
					   value="<fmt:message key="label.continuar" />" 
					   type="button" 
					   onclick="showModalConfirmarRetiradaAcessorio()" />
			</p>
		</fieldset>
	
	</form>
	
	<!-- DIV MODAL DV7 - TELA RETIRADA DE ACESSORIO SERIAL -->
	<div id="popupConfirmacaoRetiradaAcessorioSerial" style="display: none;"></div>
	
<jsp:include page="/WEB-INF/views/Corporativo/Mobile/icones.jsp">
	<jsp:param name="voltar" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC34/dv03&tipoOperacao=${param.tipoOperacao}&numeroOS=${param.numeroOS}&numeroCPF=${param.numeroCPF}&chassiVeiculo=${param.chassiVeiculo}&placaVeiculo=${param.placaVeiculo}" />
</jsp:include>
