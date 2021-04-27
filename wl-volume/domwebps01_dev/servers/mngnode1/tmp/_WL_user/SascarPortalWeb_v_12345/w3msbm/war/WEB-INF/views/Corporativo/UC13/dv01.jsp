<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<script type="text/javascript">
	function validarCPF(form) {
		var data = $(form).serialize();
		$.ajax({
			url: "/SascarPortalWeb/AtivarEquipamentoVinculo/validarCpfInstalador?acao=3",
			data: data || {},
			dataType:"json",
			success: function(json){
				if (json.success) {
					$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv02");
					$(form).unbind('submit').submit();
				} else {
					$(form).attr("action", "");
					$.showMessage(json.mensagem);
				}
			}
		});
	}

	$(document).ready(function(){
		$("div.breadcrumb").html('<fmt:message key="label.atendimento" /> &gt; <fmt:message key="label.informacoes" /> &gt; <fmt:message key="label.testesAtivacaoEquipamento" />');

		var container = $('div.container2');
		$("#formTesteEquipamento").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler : function(form) {
				validarCPF(form);
			}
		});

		$("#numeroCPF").setMask('cpf');
		
		habilitarRodapeLinkVersaoMobile();
	});
</script>


	<div class="container2"> 
		<ol>
			<li><label for="numeroCPF" class="error"><fmt:message key="mensagem.campoObrigatorio.cpfInstalador" /></label></li>
		</ol>
	</div>


	<div class="cabecalho3"><fmt:message key="label.testesAtivacaoEquipamento" />
		<div class="caminho3" style="*margin-left:100px;">
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a>&gt; 
			<a href="#" class="linktres"><fmt:message key="label.informacoes" /></a> &gt; 
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv01"  class="linkquatro"><fmt:message key="label.testesAtivacaoEquipamento" /></a>
		</div>
	</div>


	<div class="busca_branca">
		<span class="text1"><fmt:message key="mensagem.informacao.iniciarTestesVeiculo" /></span>
	</div>
	
	
	<form name="formTesteEquipamento" id="formTesteEquipamento" action="" method="post" class="filtro">
	
		<input type="hidden" name="origem" 			value="T" />
		<input type="hidden" name="reiniciarTestes" value="N" />
		<input type="hidden" name="numeroOS"        value="${param.numeroOS }" />
		<input type="hidden" name="numeroPlaca"     value="${param.numeroPlaca}" />
		<input type="hidden" name="motivo"			value="${param.motivo}" />
		<input type="hidden" name="reenviarConf"	value="S" />
		<input type="hidden" name="validarObrigacaoBuzzer"	value="true" />
		
		
		<div class="busca_cinza">
			<label>
				<span class="text2"><fmt:message key="label.cpfInstalador" /> <input type="text" id="numeroCPF" name="numeroCPF" class="text required" maxlength="11" value="${param.numeroCPF }"/></span>
	      		<input type="submit" value="<fmt:message key="label.iniciarTestes" />" class="button" />
	    	</label>
		</div>
	</form>

