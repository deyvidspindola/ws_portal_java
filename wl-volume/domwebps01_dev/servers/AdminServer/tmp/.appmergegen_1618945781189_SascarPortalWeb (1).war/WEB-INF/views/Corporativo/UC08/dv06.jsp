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

	function atualizarContatoAutorizado(form) {
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
		$("#formPessoaAutorizada").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler : function(form) {
				atualizarContatoAutorizado(form);
				return false;
			}
		});
		$("#cpfPessoaAutorizada").setMask("cpf");
		$("#telefone1PessoaAutorizada").setMask({mask:'999999999999'});
		$("#telefone2PessoaAutorizada").setMask({mask:'999999999999'});
		$("#telefone3PessoaAutorizada").setMask({mask:'999999999999'});
		$("#numRGPessoaAutorizada").setMask({mask:'9999999999'});
	});
</script>


<div id="popup">
	<div id="popup_bordacima"></div>
	<div id="popupinterior">
		<div class="container2">
			<ol>
				<li><label for="nomePessoaAutorizada" class="error"><fmt:message key="uc8.texto.001.informeNomePessoaAutorizada" /></label></li>
				<li><label for="numRGPessoaAutorizada" class="error"><fmt:message key="uc8.texto.002.informeRgPessoaAutorizada" /></label></li>
				<li><label for="cpfPessoaAutorizada" class="error"><fmt:message key="uc8.texto.003.informeCpfPessoaAutorizada" /></label></li>
				<li><label for="telefone1PessoaAutorizada" class="error"><fmt:message key="uc08.texto.004.informeTelResidencialPessoaAutorizada" /></label></li>
				<li><label for="telefone3PessoaAutorizada" class="error"><fmt:message key="uc08.texto.005.informeTelCelularPessoaAutorizada" /></label></li>
				<li><label for="telefone2PessoaAutorizada" class="error"><fmt:message key="uc08.texto.006.informeTelComercialPessoaAutorizada" /></label></li>
			</ol>
		</div>

		<h3><fmt:message key="uc08.texto.007.incluirEditarPessoaAutorizada" /></h3>
		<form action="" method="post" id="formPessoaAutorizada">
			<input type="hidden" value="A" name="tipoContato" />
			<input type="hidden" value="${param.numeroContrato }" name="numeroContrato" />
			<input type="hidden" value="${param.codigoContato }" name="codigoContato" />
		
	    	<label class="formleft"> 
	    		<fmt:message key="label.nome" />:
	      		<input class="required imputpop_nome" type="text" name="nomeContato" id="nomePessoaAutorizada" />
	      	</label>
	      	<label class="formleft">
	       		<fmt:message key="label.rg" />:
	       		<input class="required number imputpop" type="text" name="numeroRgContato" id="numRGPessoaAutorizada"/>
	    	</label>
	     	
	     	<label> 
				<fmt:message key="label.cpf" />:
	  			<input  class="required imputpop" type="text" name="cpfContato" id="cpfPessoaAutorizada" maxlength="14"/>
			</label>
	     	<br />
	     	<label class="formleft"> 
	     		<fmt:message key="label.telefoneResidencial" />:
	       		<input class="required number imputpop" type="text" name="telefone1Contato" id="telefone1PessoaAutorizada"/>
	       	</label>
	       	<label class="formleft">
	       		<fmt:message key="label.telefoneCelular" />:
	       		<input  class="required number imputpop" type="text" name="telefone3Contato" id="telefone3PessoaAutorizada"/>
		     </label>
	    	 <label class="formleft">
	    	 	<fmt:message key="label.telefoneComercial" />:
	       		<input  class="required number imputpop" type="text" name="telefone2Contato" id="telefone2PessoaAutorizada"  />
	       	 </label>

	       	 <div class="botoeslimparbuscar_popup">
		    	<input type="submit" class="button close" value="<fmt:message key="label.incluirAlterar" />" />
		    	<input type="button" class="button4 close" value="<fmt:message key="label.voltar" />" onclick="$.closeOverlay()"/>
		     </div>   	 
		</form>
	</div>
  
	<div id="popup_bordarodape"></div>

</div>
