<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<script type="text/javascript">
	$(document).ready(function(){
	
		var container = $('div.container-error');
		$("#formPesquisa").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li'/*,
			showErrors: function(errorMap, errorList) {
				this.defaultShowErrors();
				if (errorList.length) {
					document.location.href = "#top";
				}
		    }*/
		});

		$("#dataInicial, #dataFinal").datepicker({
			changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy',
			showOn: "button",
			buttonImage: "${pageContext.request.contextPath}/sascar/images/mobile/calendar.gif",
			buttonImageOnly: true
		});

		$('#dataInicial, #dataFinal').click(function(){
			$('input[name="tipoDataPesquisa"]').toggleClass('required', $(this).val() ? true : false);
		}).blur(function(){
			$(this).setMask('date');
			
			$('input[name="tipoDataPesquisa"]').toggleClass('required', $(this).val() ? true : false);
		}).focus(function(){
			$(this).unsetMask();
			$(this).setMask({mask:'9', type:'repeat'});
		});

		//$('#numeroOS').setMask({mask:'9999999999'});
		
		$('input[name="tipoDataPesquisa"]').jqTransRadioCheck();
		
		$('#ativar_equipamento').addClass('active');

		//Cache
		if (document.images) {
			var tick = new Image();
			tick.src = "${pageContext.request.contextPath}/sascar/images/mobile/tick.png";
		}

	});
	
</script>

<jsp:useBean id="dataAtual" class="java.util.Date" scope="request" />
<fmt:formatDate value="${dataAtual}" pattern="dd/MM/yyyy" var="dataFinal"/>

<div class="container-error">
	<ol>
		<li><label for="dataInicial" class="error"><fmt:message key="mensagem.informacao.dataInicial" /></label></li>
		<li><label for="dataFinal" class="error"><fmt:message key="mensagem.informacao.dataFinalMaiorIgualInicial" /></label></li>
		<li><label for="tipoDataPesquisa" class="error"><fmt:message key="mensagem.informacao.selecioneDataCadastroDataAgendamento"/></label></li>
	</ol>
</div>

<!-- CACHE  -->
<img src="${pageContext.request.contextPath}/sascar/images/mobile/tick.png" alt="" style="display: none;"/>

<form id="formPesquisa"
		name="formPesquisa"
		method="post"
		action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv02">

	<fieldset>
		<p class="input">
			<label for="dataInicial">
				<span><fmt:message key="label.dataInicial" />:</span><br />
				<input type="text" name="dataInicial" id="dataInicial" maxlength="10" value="${param.dataInicial}" class="data" />
			</label>
		</p>
		<p class="input">
			<label for="dataFinal">
				<span><fmt:message key="label.dataFinal" />:</span><br />
								
				<c:if test="${not empty param.dataFinal}">
					<c:set var="dataFinal" value="${param.dataFinal }" />
				</c:if>
				
				<input type="text" name="dataFinal" id="dataFinal" maxlength="10" dateHigher="#dataInicial"  class="data" value="${dataFinal}" />
				
			</label>
		</p>
		<p class="input">
			<input type="radio" name="tipoDataPesquisa" value="C" <c:if test="${param.tipoDataPesquisa eq 'C' }">checked="checked"</c:if> id="radio0" style="margin-right: 5px; vertical-align: middle;" /><label for="dataTipoCadastro"><fmt:message key="label.dataCadastro" /></label>
			<input type="radio" name="tipoDataPesquisa" value="I" <c:if test="${param.tipoDataPesquisa eq 'I' }">checked="checked"</c:if> id="radio1" style="margin-right: 5px; vertical-align: middle;" /><label for="dataTipoAgendamento"><fmt:message key="label.dataAgendamento2" /></label>
		</p>
		<p class="input">
			<label for="numeroOS">
				<span><fmt:message key="label.NumOS" />:</span><br />
				<input type="text" name="numeroOS" value="${param.numeroOS}" maxlength="10" />
			</label>
		</p>
		<p class="input">
			<label for="numeroPlaca">
				<span><fmt:message key="label.placa" />:</span><br />
				<input type="text" name="numeroPlaca" maxlength="10" value="${param.numeroPlaca}" />
			</label>
		</p>
		<p class="input">
			<label for="numeroChassi">
				<span><fmt:message key="label.chassi" />:</span><br />
				<input type="text" name="numeroChassi" maxlength="20" value="${param.numeroChassi}" />
			</label>
		</p>
		<p class="input">
			<label for="nomeCliente">
				<span><fmt:message key="label.nomeDoCliente" />:</span><br />
				<input type="text" class="text" name="nomeCliente" value="${param.nomeCliente}" maxlength="40" />
			</label>
		</p>

		<p class="input" style="padding:10px; margin-top:10px; text-align: center;">
			<input type="submit" class="aButton ui-state-default ui-corner-all" value="<fmt:message key="label.buscar" />" />
		</p>
	</fieldset>
</form>