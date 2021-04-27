<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/VerificarPermissao" context="/SascarPortalWeb"  />
</c:catch>

<c:if test="${not empty mensagem }">
	<script type="text/javascript">
		$.showMessage("${mensagem }");
	</script>
</c:if>

<c:if test="${not empty helper}" >
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>

<script type="text/javascript">

	function atualizarContatoEmergencia(form) {
		var data = $(form).serialize();
		$.ajax({
			url: "/SascarPortalWeb/EfetuarAtualizacaoCadastral/atualizarContato?acao=8",
			data: data || {},
			dataType:"json",
			success: function(json){
				$("#dialog_mensagem .popup_padrao_pergunta").html(json.mensagem);
				$("#dialog_mensagem").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
			}
		});
	}
	
	$(document).ready(function() {
		var container = $('div.container2');
		$("#formPessoaEmergencia").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler : function(form) {
				atualizarContatoEmergencia(form);
				return false;
			}
		});
		
		$("#telefone1PessoaEmergencia").setMask({mask:'999999999999'});
		$("#telefone2PessoaEmergencia").setMask({mask:'999999999999'});
		$("#telefone3PessoaEmergencia").setMask({mask:'999999999999'});
	});
</script>

<div id="popup">
	<div id="popup_bordacima"></div>
	<div id="popupinterior">
		<div class="container2">
			<ol>
				<li><label for="nomePessoaEmergencia" class="error"><fmt:message key="uc08.texto.009.informeNomePessoaEmergencia" /></label></li>
				<li><label for="telefone1PessoaEmergencia" class="error"><fmt:message key="uc08.texto.010.informeTelResidencialPessoaEmergencia" /></label></li>
				<li><label for="telefone3PessoaEmergencia" class="error"><fmt:message key="uc08.texto.011.informeTelCelularPessoaEmergencia" /></label></li>
				<li><label for="telefone2PessoaEmergencia" class="error"><fmt:message key="uc08.texto.012.informeTelComercialPessoaEmergencia" /></label></li>
			</ol>
		</div>
	
		<h3><fmt:message key="uc08.texto.008.incluirEditarPessoaEmergencia" /></h3>
		<form action="" method="post" id="formPessoaEmergencia">
			<input type="hidden" value="E" name="tipoContato" />
			<input type="hidden" value="${param.numeroContrato }" name="numeroContrato" />
			<input type="hidden" value="${param.codigoContato }" name="codigoContato" />

			<label class="formleft"> <fmt:message key="label.nome" />:
				<input class="required imputpop_nome" type="text" name="nomeContato" id="nomePessoaEmergencia"/>
			</label>

			<br />

			<label class="formleft"><fmt:message key="label.telefoneResidencial" />:
				<input class="required imputpop" type="text" name="telefone1Contato" id="telefone1PessoaEmergencia"/>
			</label>	
				
			<label class="formleft"><fmt:message key="label.telefoneCelular" />:
				<input class="required imputpop" type="text" name="telefone3Contato" id="telefone3PessoaEmergencia"/>
			</label>

			<label class="formleft"><fmt:message key="label.telefoneComercial" />:
				<input class="required imputpop" type="text" name="telefone2Contato" id="telefone2PessoaEmergencia"/>
			</label>

			<div class="botoeslimparbuscar_popup">
				<input type="submit" class="button close" value="<fmt:message key="label.incluirAlterar" />" />
				<input type="button" class="button4 close" value="<fmt:message key="label.voltar" />" onclick="$.closeOverlay()" />
			</div>

		</form>
	</div>
	<div id="popup_bordarodape"></div>
</div>
