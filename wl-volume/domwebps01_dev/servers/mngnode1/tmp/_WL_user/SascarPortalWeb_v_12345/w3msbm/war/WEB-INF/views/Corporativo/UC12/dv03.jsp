<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<script>

	function novoCadastro(form) {
		var data = $(form).serialize();
		
		$.ajax({
			"url": "/SascarPortalWeb/LoginUsuarioServlet?acao=3",
			"data" : data,
			"dataType" : "json",
			"success": function(json){
				if (json.success) {					
					    var email = json.email;
					    var e = document.getElementById('email');
				        e.innerHTML = email;
					    $("#popupNovoCadastro").val(email);
						$("#popupNovoCadastro").jOverlay({'color':'#ffffff', 'opacity' : '0.8', closeOnEsc : false, bgClickToClose : false});
				} else {
					$.showMessage(json.mensagem);
				}
			}
		});
		return false;
	}


	function back() {
		document.formNaoSouCadastrado.action = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Login';
		document.formNaoSouCadastrado.submit();
	}
	
	$(document).ready(function(){
		var container = $('div.container2');
		$("#formNaoSouCadastrado").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler: function (form) {
				novoCadastro(form);
			}
		});
		
		
		$('#contratanteCpfCnpj').blur(function(){
			if(this.value.length <= 11) {
				$(this).setMask('cpf');
			} else {
				$(this).setMask('cnpj');
			}
		}).focus(function(){
			$(this).unsetMask();
			$(this).setMask({mask:'9', type:'repeat'});
		});
		
		$('#autorizadaCpfCnpj').blur(function(){
			if(this.value.length <= 11) {
				$(this).setMask('cpf');
			} else {
				$(this).setMask('cnpj');
			}
		}).focus(function(){
			$(this).unsetMask();
			$(this).setMask({mask:'9', type:'repeat'});
		});
		
		$("#contratanteTelefone").setMask({mask:'999999999999'});
		$("#autorizadaTelefone").setMask({mask:'999999999999'});
		$("#ano").setMask({mask:'9999'});
		
		$("form input").keypress(function (e) {   
	        if ((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)) {   
	        	$("#formNaoSouCadastrado").submit(); 
	            return false;   
	        } else {   
	            return true;   
	        }   
	    });
		
	});
	
	function limpar (){
	
		$('#formNaoSouCadastrado :text').val('');
		
	}
	
</script>

<div class="container2"> 
	<ol>
		<li><label for="contratanteNome" class="error"><fmt:message key="mensagem.campoObrigatorio.nomeContratante" /></label></li>
		<li><label for="contratanteCpfCnpj" class="error"><fmt:message key="mensagem.campoObrigatorio.cpfCnpjContratante" /></label></li>
		<li><label for="contratanteEmail" class="error"><fmt:message key="mensagem.campoObrigatorio.email" /></label></li>
		<li><label for="contratanteTelefone" class="error"><fmt:message key="mensagem.campoObrigatorio.telefoneFixo" /></label></li>
		<li><label for="chassi" class="error"><fmt:message key="mensagem.campoObrigatorio.chassi" /></label></li>
		<li><label for="ano" class="error"><fmt:message key="mensagem.campoObrigatorio.ano" /></label></li>
		<li><label for="cor" class="error"><fmt:message key="mensagem.campoObrigatorio.cor" /></label></li>
		<li><label for="autorizadaCpfCnpj" class="error"><fmt:message key="mensagem.campoObrigatorio.cpfCnpjAutorizada" /></label></li>
		<li><label for="autorizadaTelefone" class="error"><fmt:message key="mensagem.campoObrigatorio.telefoneCelular" /></label></li>
	</ol>
</div>

<div class="cabecalho"><fmt:message key="label.novoCadastro" /></div>
		
	<div class="busca_branca">
		<span class="text1" ><fmt:message key="uc12.texto.001.preenchaCamposAbaixoCriarConta" /></span> 
	</div>	
	<div class="busca_branca">
		<span class="texthelp2"><img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="13" height="13" /><fmt:message key="uc12.texto.002.preenchimentoTodosCamposObrigatorio" /></span> 
	</div>
   

	
    
		
<table width="1026" cellspacing="0" class="tbatualizacao" >
	<tr class="tbatualizacao">
    	<th class="barraazulzinha"><fmt:message key="label.contratante" /></th>
    </tr>
</table>

<form name="formNaoSouCadastrado" id="formNaoSouCadastrado"  method="post" >
	<input type="hidden" name="tipoUsuario" value="${param.tipoUsuario}" />
	<table width="100%" cellspacing="3" class="detalhe2">
		<tr>					
			<th width="200" class="barracinza"><fmt:message key="label.nome" />*</th>
			<td width="350" class="camposinternos">
				<input type="text" name="contratanteNome" id="contratanteNome" class="required" maxlength="50" />
			</td>
			
			<th width="200" class="barracinza"><fmt:message key="label.cpfCnpj" />*</th>
			<td width="350" class="camposinternos">
				<input type="text" name="contratanteCpfCnpj" id="contratanteCpfCnpj" class="required" maxlength="14"/>
	        </td>
		</tr>
	</table>
	
	<table width="1026" cellspacing="0" class="tbatualizacao" >
		<tr class="tbatualizacao">
			<th class="barraazulzinha"><fmt:message key="label.veiculo" /></th>
		</tr>
	</table>
	
	<table width="100%" cellspacing="3" class="detalhe2">
		<tr>					
			<th width="200" class="barracinza"><fmt:message key="label.chassi" />*</th>
			<td width="350" class="camposinternos">
			      <input type="text" name="chassi" id="chassi" class="required" maxlength="20"/>
	      	</td>
			
			<th width="200" class="barracinza"><fmt:message key="label.ano" />*</th>
			<td width="350" class="camposinternos">
			      <input type="text" name="ano" id="ano" class="required" />
	        </td>
		</tr>
	    <tr>					
			<th class="barracinza"><fmt:message key="label.cor" />*</th>
			<td class="camposinternos">
			    <input type="text" name="cor" id="cor" class="required" maxlength="20"/>
	      	</td>
			
			<th class="barracinza"><fmt:message key="label.placa" /></th>
			<td class="camposinternos">
			    <input type="text" name="placa" maxlength="10"/>
		    </td>
		</tr>
	</table>
	 
	<input type="button" onclick="back()" class="button3" value="<fmt:message key="label.voltar" />" />
	<div id="botoes_cadastro">
	      <input type="submit" class="button" value="<fmt:message key="label.cadastrar" />" />
	      <input type="button" onclick="limpar()" class="button4" value="<fmt:message key="label.limpar" />" />
	</div> 
</form>


<div id="popupNovoCadastro" style="display:none";>
	<div id="popup_bordacima"></div>
	
	
	<div id="popupNovoCadastrointerior">
		<fmt:message key="uc12.texto.003.seuUsuarioSenhaAcessoPortal">
			<fmt:param><div id="email"></div></fmt:param>
		</fmt:message> 
	
		<p>
	<input type="button" class="button" value="<fmt:message key="label.retornarLogin" />" onclick="document.location.href='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Login';"/>		</p>
	</div>

	<div id="popupNovoCadastro_bordarodape"></div>
</div>



 
