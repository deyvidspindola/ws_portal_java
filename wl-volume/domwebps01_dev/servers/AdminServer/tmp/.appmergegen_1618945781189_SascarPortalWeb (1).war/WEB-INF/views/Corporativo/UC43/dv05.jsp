<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>
 
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

	function carregarComboMotivosCancelamento(){
		
		var motivosCancelamento = $('#motivosCancelamento')[0];
		
		$.ajax({
			"url" : "/SascarPortalWeb/AgendarOrdemServico/consultarMotivoCancelamento",
			"data" : {
				"acao" : 14
			},
			"dataType" : "json",
			"beforeSend" : function() {
				$("option[value!='']", "#motivosCancelamento").remove();
				$("#motivosCancelamento").append($('<option></option>').val("").html('<fmt:message key="label.selecione" />'));
			},
			"success" : function(json) {
				if (json.success) {
					$.each(json.motivosCancelamento, function(i, motivoCancelamento) {
						if (motivoCancelamento.id && motivoCancelamento.value) {
							var option = new Option(motivoCancelamento.value, motivoCancelamento.id);
							if ($.browser.msie) {
								motivosCancelamento.add(option);
							} else {
								motivosCancelamento.add(option, null);
							}
						}
					});
				} else {
					$.showMessage(json.mensagem);
				}
			}
		});
	}
	
	function cancelarAgendamento(){
		
		var obeservacaoCancelamento = $("#obeservacaoCancelamento").val();
		var numeroOrdemServico = $("#numeroOrdemServico").val();
		var codigoMotivoCancelamento = $("#motivosCancelamento").val();
		
		$.ajax({
			url : "/SascarPortalWeb/AgendarOrdemServico/cancelarAgendamentoRepresentante",
			data : {
				"acao" : 15,
				"numeroOrdemServico" : numeroOrdemServico,
				"codigoMotivoCancelamento" : codigoMotivoCancelamento,
				"obeservacaoCancelamento" : obeservacaoCancelamento
			},
			dataType : "json",
			success : function(json) {
				if (json.success) {
			
					showModalSucessoCancelamentoAgendamento(numeroOrdemServico);

				} else {
					$.showMessage(json.mensagem);
				}
			}
		});
		
	}
	
	function showModalSucessoCancelamentoAgendamento(numeroOrdemServico){
		
		var placaVeiculo = $("#placaVeiculo").val();
		
		$.ajax({
			url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC43/dv10",
			data : {
				"numeroOrdemServico" : numeroOrdemServico,
				"placaVeiculo" : placaVeiculo
			},
			dataType:"html",
			success: function(html){
				$("#popupSucessoCancelarAgendamento").html(html).jOverlay({
					bgClickToClose : false, 
					closeOnEsc : false
				});
			}
		}); 
		
	}

	$(document).ready(function(){
		
		// BLOQUEIA A INSERÇÃO DE CARACTERES ESPECIAIS
		$('#obeservacaoCancelamento').not("[readonly]").not("[disabled]").not('.decimal').not('.nofilter').not('.number').keyup(function() {
			$(this).val(
				$(this).val().replace(/[^a-zA-Z0-9!()\[\].,:;?<>{}_ \-+=]/g, '')
			);
		});
		
		// LIMPA O CAMPO AO CARREGAR A TELA
		$('#obeservacaoCancelamento').val('');
		
		carregarComboMotivosCancelamento();		
	
	});
		
</script>

<form id="formCancelarAgendamento" method="post" action="" >
	
	<input type="hidden" name="numeroOrdemServico" id="numeroOrdemServico" value="${param.numeroOrdemServico}" />
	<input type="hidden" name="placaVeiculo"       id="placaVeiculo"       value="${param.placaVeiculo}" />

	<div id="popup">
		
		<div id="popup_bordacima"></div>
		
		<div id="popupinterior">
			<label style="margin-left: 135px;">				
				<fmt:message key="uc43.dv05.texto.001.cancelarAgendamento">
					<fmt:param><span style="color:#F00;">${param.numeroOrdemServico}</span></fmt:param>
					<fmt:param><span style="color:#F00;">${param.dataAgendamento}</span></fmt:param>
				</fmt:message>				
			</label>
			
			<div style="clear:both;"></div>
			<br />
			<br />
			
			<label>
				<fmt:message key="label.motivoCancelamento" />:
				<select id="motivosCancelamento" style="width: 500px; margin-left: 10px;" ></select>
			</label>
			
			<br />
			
			<label style="margin-left: 52px;">
				<fmt:message key="label.observacao" />:
				<textarea name="obeservacaoCancelamento"
					      id="obeservacaoCancelamento"
					      class="text" >
				</textarea>
			</label>
			
		</div>
		
		<div id="divbuscapopup" style="text-align: left; padding-top: 20px;">
		
			<input class="button2" 
				   type="button" 
				   style="margin-left: 20px;" 
				   value="<fmt:message key="label.voltar" />" 
				   onclick="javascript:$.closeOverlay();" />
				   
			<input id="button" 
				   class="button" 
				   type="button" 
				   name="button2"
				   style="margin-left: 270px;" 
				   onclick="cancelarAgendamento();" 
				   value="<fmt:message key="label.cancelarAgendamento" />" />
				   
			<input class="button4" type="reset" style="" value="<fmt:message key="label.limpar" />" />
			
		</div>
		
		<div id="popup_bordarodape"></div>
	</div>

</form>
