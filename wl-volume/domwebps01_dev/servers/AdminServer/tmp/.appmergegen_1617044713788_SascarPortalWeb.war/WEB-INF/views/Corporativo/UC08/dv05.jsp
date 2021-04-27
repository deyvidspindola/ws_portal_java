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
	function atualizarContato(form) {
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
		$("#formContatoInstalacao").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler : function(form) {
				atualizarContato(form);
				return false;
			}
		});

		$("#telefone1Contato").setMask({mask:'999999999999'});
		$("#telefone2Contato").setMask({mask:'999999999999'});
		$("#telefone3Contato").setMask({mask:'999999999999'});
	});
</script>

<div id="popup">
	<div id="popup_bordacima"></div>
  	<div id="popupinterior">
  	
  		<div class="container2">
			<ol>
				<li><label for="nomeContato" class="error"><fmt:message key="mensagem.informacao.nomeContatoInstalacao" /></label></li>
				<li><label for="telefone1Contato" class="error"><fmt:message key="mensagem.informacao.telResidenciaContatoInstalacao" /></label></li>
				<li><label for="telefone3Contato" class="error"><fmt:message key="mensagem.informacao.telCelularContatoInstalacao" /></label></li>
				<li><label for="telefone2Contato" class="error"><fmt:message key="mensagem.informacao.tecComercialContatoInstalacao" /></label></li>
				<li><label for="observacaoContato" class="error"><fmt:message key="mensagem.informacao.ObsContatoInstalacao" /></label></li>
			</ol>
		</div>  	
		
		
  		<h3><fmt:message key="mensagem.informacao.incluirEditarContatoInstalacao" /></h3>
  		<form action="" method="post" id="formContatoInstalacao">
  			<input type="hidden" value="C" name="tipoContato" />
			<input type="hidden" value="${param.codigoContato }" name="codigoContato" />
	
      		<label class="formleft"> 
      			<fmt:message key="label.nome" />:
        		<input type="text" name="nomeContato" id="nomeContato" class="imputpop_nome required" value="" />
      		</label>
      
      		<label class="formleft"> 
      			<br /><fmt:message key="label.telefoneResidencial" />:
        		<input type="text" name="telefone1Contato" id="telefone1Contato" class="imputpop required number" value="" />
        	</label>
        	
        	<label class="formleft">
        		<fmt:message key="label.telefoneCelular" />:
        		<input type="text" name="telefone3Contato" id="telefone3Contato" class="imputpop required number" value="" />
		    </label>
      
      		<label class="formleft">
      			<fmt:message key="label.telefoneComercial" />:
       			<input type="text" name="telefone2Contato" id="telefone2Contato" class="imputpop required number" value="" notEqualTo="#telefone1Contato" title="É obrigatório dois números de telefones diferentes." />
      		</label>
    		
    		<label class="formleft">
    			<fmt:message key="label.observacao" />:
        		<input type="text" value="" name="observacaoContato" id="observacaoContato" class="imputpop_obs required" style="width: 534px" maxlength="50" />
      		</label>
    	
	  		<div class="botoeslimparbuscar_popup">
			    <input type="submit" class="button close" value="<fmt:message key="label.incluirAlterar" />"  />
			    <input type="button" class="button4 close" value="<fmt:message key="label.voltar" />" onclick="window.location.reload();"/>
			</div>
		</form>			
  	</div>
  
  	<div id="popup_bordarodape"></div>
</div>	
