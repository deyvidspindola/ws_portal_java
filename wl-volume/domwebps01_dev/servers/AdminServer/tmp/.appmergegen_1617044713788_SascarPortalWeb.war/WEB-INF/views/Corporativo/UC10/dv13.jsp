<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/AtivarEquipamentoVinculo/listarMotivoRetirada?acao=12" context="/SascarPortalWeb"  />
</c:catch>

<c:if test="${not empty mensagem }">
	<script type="text/javascript">
		$.showMessage("${mensagem}");
	</script>
</c:if>

<c:if test="${not empty helper}">
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>

<script type="text/javascript">

	function submterEquipamento(form) {

		var data = $(form).serialize();
		$.ajax({
			url: "/SascarPortalWeb/AtivarEquipamentoVinculo/submeterEquipamento?acao=5",
			data: data || {},
			dataType:"json",
			success: function(json){
				if (json.success) {
					$("#formAtualizar").submit();
					
				} else {
					$.showMessage(json.mensagem);
				}
			}
		});
		
	}
	
	$(document).ready(function(){
		var container = $('#popupRetirarEquipamento div.container2');
		$("#formRetirarEquipamento").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler : function(form) {
				submterEquipamento(form);
			}
		});
	});
</script>

<div class="popup_maior" align="center" id="popupRetirarEquipamento">
	<div class="container2">
		<ol style="margin: 0; padding: 2px;">
			<li><label for="codigoMotivo" class="error"><fmt:message key="uc10.dv13.selecioneMotivoRetirada" />.</label></li>
		</ol>
	</div>
	
	<div class="popup_maior_pergunta" style="border-bottom: none; height: auto;">

		<form action=""	method="post" id="formRetirarEquipamento" class="filtro">

			<input type="hidden" name="numeroCPF" value="${param.numeroCPF }" />
			<input type="hidden" name="numeroOS" value="${param.numeroOS }" />
			
			<input type="hidden" name="numeroSerial" 					 value="${param.numeroSerial }" />
			<input type="hidden" name=tipoSubmeter value="R" />

			<span style="color: #666666;"><fmt:message key="mensagem.confirmacao.retiradaEquipamento" /></span>

			<div><fmt:message key="uc10.dv13.informeMotivoRetirada" />:</div>
			<select name="codigoMotivo" id="codigoMotivo" class="required">
				<option value=""><fmt:message key="label.selecione" /></option>
				
				<c:forEach var="motivo" items="${motivosRetirada}">
					<option value="${motivo.identifier}">${motivo.value}</option>
				</c:forEach>
			</select>
			
			<div style="padding: 5px;">
				<input class="button" type="submit" value="<fmt:message key="label.sim" />">
				<input class="button4 close" type="button" value="<fmt:message key="label.nao" />" onclick="$.closeOverlay();">
			</div>

		</form>
	</div>
</div>
