<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>
	
<script type="text/javascript">
	function validarCPF(form) {
		var data = $(form).serialize();
		$("input[type='submit']").attr('disabled', 'disabled');
		$.ajax({
			url: "/SascarPortalWeb/AtivarEquipamentoVinculo/validarCpfInstalador?acao=3",
			data: data || {},
			dataType:"json",
			success: function(json){
				if (json.success) {
					$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC13/dv02");
					$(form).unbind('submit').submit();
				} else {
					$(form).attr("action", "");
					$.showMessage(json.mensagem);
					$("input[type='submit']").removeAttr('disabled');
				}
			}
		});
	}

	$(document).ready(function(){
		
		$('#ativar_equipamento').addClass('active');

		var container = $('div.container-error');
		$("#formPesquisa").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler : function(form) {
				validarCPF(form);
			}
		});

		$('#numeroCPF').setMask('cpf');

	});
</script>

<div class="container-error"> 
	<ol>
		<li><label for="numeroCPF" class="error"><fmt:message key="mensagem.campoObrigatorio.cpfInstalador" /></label></li>
	</ol>
</div>

<h1><fmt:message key="label.testesAtivacaoEquipamento" /></h1>

<form name="formPesquisa" id="formPesquisa" action="" method="post">

	<input type="hidden" name="origem" 			value="T" />
	<input type="hidden" name="reiniciarTestes" value="N" />
	<input type="hidden" name="numeroOS"        value="${param.numeroOS }" />
	<input type="hidden" name="numeroPlaca"     value="${param.numeroPlaca}" />
	<input type="hidden" name="reenviarConf"	value="S" />
	
	<fieldset>
		
		<h4><fmt:message key="mensagem.informacao.iniciarTestesVeiculo" /></h4>
		
		<p class="input">
			<label for="numeroCPF">
				<span><fmt:message key="label.cpfInstalador" />:</span><br />
				<input type="text" id="numeroCPF" name="numeroCPF" class="required" maxlength="11" value="${param.numeroCPF }"/>
			</label>
		</p>
		<p class="input" style="padding:10px; margin-top:10px; text-align: center;">
			<input type="submit" class="aButton ui-state-default ui-corner-all" value="<fmt:message key="label.continuar" />" />
		</p>

	</fieldset>

</form>
