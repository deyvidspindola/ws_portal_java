<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<script type="text/javascript">
	
	function redirectToChat(){
		$.ajax({
			url : "/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC12/dv12",
			dataType : "html",
			success : function(html) {
				$('#popup-chat-teste').html('');
				$('#popup-chat-teste').html(html);
				$('#popup-chat-teste').jOverlay();
			}			
		});
	}
	
	function recuperarSenha(form) {
		var data = $(form).serialize();
		
		$.ajax({
			"url": "/SascarPortalWeb/LoginUsuarioServlet?acao=2",
			"data" : data,
			"dataType" : "json",
			"success": function(json){
				if (json.success) {
						$("#popupConfirmacao").jOverlay({'color':'#ffffff', 'opacity' : '0.8', closeOnEsc : false, bgClickToClose : false});
				} else {
					$.showMessage(json.mensagem);
					$("#online-chat").hide();
					if(json.erroCode != "1910"){
						$("#online-chat").show();
					}
				}
			}
		});
		return false;
	}
	
	function back() {
		document.formEsqueciSenha.action = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Login';
		document.formEsqueciSenha.submit();
	}
	
	$(document).ready(function(){
		var container = $('div.container2');
		$("#formEsqueciSenha").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler: function (form) {
				recuperarSenha(form);
			}
		});
		
		$("form input").keypress(function (e) {   
	        if ((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)) {   
	        	$("#formEsqueciSenha").submit();
	            return false;   
	        } else {   
	            return true;   
	        }   
	    });
	});
</script>


<div class="container2"> 
	<ol>
		<li><label for="usuario" class="error"><fmt:message key="mensagem.campo.usuario" /></label></li>
		<li><label for="logon" class="error"><fmt:message key="mensagem.campo.login" /></label></li>
		<li><label for="email" class="error"><fmt:message key="mensagem.campo.email" /></label></li>
	</ol>
</div>



	<div class="cabecalho"><fmt:message key="uc12.dv02.esqueciMinhaSenha" /></div>
		
	<div class="busca_branca">
		<span class="text1"><fmt:message key="uc12.dv02.dadosRecuperacaoSenha" /></span> 
	</div>
	
	<table width="1026" cellspacing="0" class="tbatualizacao" >
		<tr class="tbatualizacao">
	    	<th class="barraazulzinha"><fmt:message key="label.dadosUsuario" /></th>
	    </tr>
	</table>
	<form name="formEsqueciSenha" id="formEsqueciSenha" method="post" >
		<table width="100%" cellspacing="3" class="detalhe2">
			<tr>					
				<th width="200" class="barracinza"><fmt:message key="label.usuario" />*</th>
				<td width="350" class="camposinternos">
				    <input type="text" name="usuario" id="usuario" class="required" maxlength="20"/>
	      		</td>
			
				<th width="200" class="camposinternos">&nbsp;</th>
				<td width="350" class="camposinternos"></td>
			</tr>
	    	<tr>
				<th class="barracinza"><fmt:message key="label.email" />*</th>
				<td class="camposinternos">
			    	<input type="text" name="email" id="email" class="required email " maxlength="50"/>
		    	</td>
			</tr>
		</table>
		
		<input type="button" onclick="back()" class="button3" value="<fmt:message key="label.voltar" />" />
		<div id="botoes_cadastro">
	    	<input type="submit" class="button" value="<fmt:message key="label.enviar" />" />
	    	<input type="reset" class="button4" value="<fmt:message key="label.limpar" />" />
	    </div> 
	    			
		
	</form>


<div id="popupConfirmacao" class="popup_padrao" style="display: none;">
	<div id="popup_msg_modal" class="popup_padrao_pergunta">
		<fmt:message key="uc12.dv02.senhaEnviadoEmail" />
	</div>
	<div class="popup_padrao_resposta">
		<input type="button" class="button4" value="<fmt:message key="label.retornarLogin" />" onclick="document.location.href='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Login';"/>
	</div>
</div>

<div class="online-chat" id="online-chat" style="display: none;">
	<img src="/SascarPortalWeb/sascar/images/corporativo_new/icon-chat.png">
	<a href="javascript:void(0)" title="ATENDIMENTO ONLINE" onclick="redirectToChat();">
		Atendimento Online
	</a>
</div>


<div class="" id="popup-chat-teste" style="display: none;"/>