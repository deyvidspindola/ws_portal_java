<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<script>
	function alterarSenha(form) {
		var senhaAtual = $.trim(form.senhaAtual.value.toUpperCase());
		var novaSenha = $.trim(form.novaSenha.value.toUpperCase());
		var novaSenhaConf = $.trim(form.novaSenhaConf.value.toUpperCase());

		$.ajax({
			"url": "/SascarPortalWeb/LoginUsuarioServlet?acao=4",
			"data" : {"senhaAtual": senhaAtual, "novaSenha": novaSenha, "novaSenhaConf": novaSenhaConf},
			"dataType" : "json",
			"success": function(json){
				if (json.success) {
					/*if (json.primeiroAcesso) {
						$("#linkPopupConf").attr("href", "javascript:back()");
						$("#labelPopupConf").html("Retornar ao login");
					} else {
						$("#linkPopupConf").attr("href", "#").click(function () {$.closeOverlay()});
						$("#labelPopupConf").html("Fechar");
					}
					$("#popupConfirmacao").jOverlay({closeOnEsc : false, bgClickToClose : false});
					
					*/
				$("#dialog_mensagem .popup_padrao_pergunta").html("Senha alterada com sucesso.");
				$("#dialog_mensagem").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
			
					
				} else {
					form.senhaAtual.value = '';
					form.novaSenha.value = '';
					form.novaSenhaConf.value = '';
					$.showMessage(json.mensagem);
				}
			}
		});
		return false;
	}


	function back() {
		document.formAlterarSenha.action = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Login';
		document.formAlterarSenha.submit();
	}
	
	/*Validação para login*/
	$.validator.methods.NotEqualLogin = function(value, element, param) {
	   return value != $(param).val();
	};
	
	/*Validação para usuario*/
	$.validator.methods.NotEqualUsuario = function(value, element, param) {
	   return value !=  $(param).val();
	};
	
	/*Tranforma a senha para verificar se é a atual*/
	$.validator.addMethod("equalToMD5", function(value, element, param) {
		return this.optional(element) || MD5($.trim(value.toUpperCase())) === $(param).val();
	}, '<fmt:message key="mensagem.campoInvalido.senhaAtual" />');
	
	/*Verifica se a senha digita nao é igual a atual em MD5*/
	$.validator.addMethod("NotEqualToMD5", function(value, element, param) {
		return this.optional(element) || MD5($.trim(value)) != $(param).val();
	}, '<fmt:message key="uc09.dv01.text.01" />');
		
		
	/*Exibe o div com o texto de ajuda*/
	function prepareInputsForHints() {
		$("input").focus(function(){
			$(this).parent().find(".hint").css("display", "inline");
		}).blur(function(){
			$(this).parent().find(".hint").css("display", "none");
		});
	}
	
	$(document).ready(function(){
		
		prepareInputsForHints();

		$('#novaSenha').keyup(function(){
			$('#result').html(passwordStrength($('#novaSenha').val(),$('#usuario').val(), $('#login').val()));
		});
		
		var container = $('div.container2');
		var validator = $("#formAlterarSenha").validate({
			rules: {
				senhaAtual: {
					required: true,
					equalToMD5: "#senhaAtualHash"
				},
				novaSenha: {
					required: true,
					NotEqualToMD5: "#senhaAtualHash",
					NotEqualUsuario : "#usuario", 
					NotEqualLogin : "#login",
					minlength: 8
				},
				novaSenhaConf: {
					required: true,
					equalTo: "#novaSenha"
				}
			},
			messages: {
				senhaAtual: {
					required: '<fmt:message key="mensagem.campoObrigatorio.senhaAtual" />',
					equalToMD5: '<fmt:message key="mensagem.campoInvalido.senhaAtual" />'
				},
				novaSenha: {
					required: '<fmt:message key="mensagem.campoObrigatorio.novaSenha" />',
					NotEqualToMD5: '<fmt:message key="uc09.dv01.text.01" />',
					NotEqualUsuario: '<fmt:message key="uc09.dv01.text.07" />',
					NotEqualLogin: '<fmt:message key="uc09.dv01.text.08" />',
					minlength: '<fmt:message key="mensagem.validacao.novaSenhaMinimo8" />'
				},
				novaSenhaConf: {
					required: '<fmt:message key="mensagem.campoObrigatorio.confirmarNovaSenha" />',
					equalTo: '<fmt:message key="mensagem.validacao.confirmacaoSenhaIgualSenha" />' 
				}
			},
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler: function (form) {
				alterarSenha(form);
			}
		});
		
		$("form input").keypress(function (e) {   
	        if ((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)) {   
	        	$("#formAlterarSenha").submit(); 
	            return false;   
	        } else {   
	            return true;   
	        }   
	    });
	    
	    $(".showpasswordcheckbox").click(function() {
	    	var tipoCampo = $(this).is(":checked") ? "text" : "password";
			exibeSenha(tipoCampo);
        });
        
        $(".button4").click(function() {
		    validator.resetForm();
		});
        
	    
	});
	
	//Exibe a senha, criando um novo campo tipo text
	function exibeSenha(tipoCampo){
		$(".showpassword").each(function(index,input) {
			var $input = $(input);
          
          	var rep = $("<input type='" + tipoCampo + "' />")
              .attr("id", $input.attr("id"))
              .attr('class', $input.attr('class'))
              .attr('style', $input.attr('style'))
              .attr('maxlength', $input.attr('maxlength'))
              .attr("name", $input.attr("name"))
              .val($input.val())
              .insertBefore($input);
          	$input.remove();
          	$input = rep;
          });
          prepareInputsForHints();
	}

	//Reseta a senha para o tipo de campo password	
	function limparCampos(){
		exibeSenha("password");
	}
</script>

<div class="container2"> 
	<ol>
	</ol>
</div>

<div class="cabecalho">
	<fmt:message key="label.alteracaoDeSenha" />
	<div class="caminho">
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; 
		<a href="#" class="linktres"><fmt:message key="label.informacoes" /></a> &gt;
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC09/dv01" class="linkquatro"><fmt:message key="label.alteracaoDeSenha" /></a>
	</div>
</div>
<table width="960" cellspacing="0" class="tbatualizacao" >
	<tr class="tbatualizacao">
		<th class="tbatualizacao"><fmt:message key="label.dadosUsuario" /></th>
	</tr>
</table>
<table width="550" cellspacing="0" class="detalhe2">
	<tr>
		<th width="200" class="barracinza"><fmt:message key="label.usuario" /></th>
		<td width="350" class="camposinternos">
			${SascarUser.usuario}
			<input type="hidden" id="usuario" name="usuario" value="${SascarUser.usuario}" />
		</td>
	</tr>
	<tr>	
		<th width="200" class="barracinza"><fmt:message key="label.login" /></th>
		<td  width="350" class="camposinternos">
			${SascarUser.login}
			<input type="hidden" id="login" name="usuario" value="${SascarUser.login}" />
		</td>
 	</tr>
</table>
<form name="formAlterarSenha" id="formAlterarSenha" method="post" class="filtro" >
	<div style="height: 300px;">
	<table width="550" cellspacing="3" class="detalhe2 password-container">
			<input type="hidden" name="tipoUsuario" value="${SascarUser.perfil}" />
			<input type="hidden" id="senhaAtualHash" name="senhaAtualHash" value="${SascarUser.senhaMD5}" />
			
			
			<tr>
				<th width="200" class="barracinza"><fmt:message key="label.senhaAtual" /><span class="asterisco"">*</span></th>
				<td width="350" class="camposinternos">
					<input type="password" name="senhaAtual" id="senhaAtual" class="text showpassword" maxlength="20" style="text-transform: uppercase; width:120px;"/>
				</td>
			</tr>	

			<tr>
				<th width="200" class="barracinza"><fmt:message key="label.novaSenha" /><span class="asterisco"">*</span></th>
				<td width="350" class="camposinternos">
					<input type="password" name="novaSenha" id="novaSenha" class="text showpassword" maxlength="20" style="text-transform: uppercase; width:120px;" />
					<div class="hint" style="display: none;">
						<div class="strength-indicator">
							<strong><fmt:message key="label.nivelSenha" />: </strong><span id='result'></span>
							<div class="meter"></div>
                			<ul>
								<li><fmt:message key="uc09.dv01.text.01" /></li>
								<li><fmt:message key="uc09.dv01.text.02" /></li>
								<li><fmt:message key="uc09.dv01.text.03" /></li>
								<li><fmt:message key="uc09.dv01.text.04" /></li>
							</ul>
							<fmt:message key="uc09.dv01.text.05" />
            			</div> 
						<div class="hint-arrow-id hint-arrow hint-arrowleft" style="top: 20px;">
							<div class="hint-arrowimplbefore"></div>
							<div class="hint-arrowimplafter"></div>
						</div>
					</div>
				</td>
			</tr>
			
			<tr>
				<th width="200" class="barracinza"><fmt:message key="label.confirmarNovaSenha" /><span class="asterisco">*</span></th>
				<td width="350" class="camposinternos">
					<input type="password" name="novaSenhaConf" id="novaSenhaConf" class="text showpassword" maxlength="20" style="text-transform: uppercase; width:120px;"/>
				</td>
			</tr>	
			
			<tr>				
				<c:if test="${SascarUser.trocaSenhaObrigatoria}">
					<td>
						<input type="button" onclick="back()" class="button3" value="<fmt:message key="label.voltar" />" /> &nbsp;
					</td>
				</c:if>
			</tr>
			<tr>
				<td width="200"></td>
				<td width="350" class="camposinternos">
					<label class="showpasswordlabel">
						<input type="checkbox" name="verSenha" class="showpasswordcheckbox"/>
						<span class="text2"><fmt:message key="label.verSenha" /></span>
					</label>
				</td>
			</tr>
			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;">
					<input type="submit" class="button" value="<fmt:message key="label.alterar" />" />
					<input type="reset" class="button4" value="<fmt:message key="label.limpar" />" onclick="limparCampos();"/>
				</td>
			</tr>
	</table>
	</div>
</form>		

<div id="dialog_mensagem" class="popup_padrao" style="display: none;">
	<div class="popup_padrao_pergunta"></div>
	<div class="popup_padrao_resposta">
		<input class="button close" type="button" onclick="document.location.href='/PortalSascar/adfAuthentication?logout=true&end_url=/'" value="Ok"/> 
	</div>
</div>	


