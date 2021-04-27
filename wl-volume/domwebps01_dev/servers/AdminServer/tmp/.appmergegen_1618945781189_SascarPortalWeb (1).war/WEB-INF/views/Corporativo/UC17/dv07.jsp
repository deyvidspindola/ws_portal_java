<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<div class="popup_padrao">
	<div class="popup_padrao_pergunta">
		<fmt:message key="mensagem.confirmacao.exclusaoDebitoAutomatico" />
	</div>
	
	<div class="popup_padrao_resposta">
		<input class="button" 
		       value="<fmt:message key="label.sim" />" 
		       type="button" 
		       onclick="submeterExclusaoPermissaoDebitoAutomatico('#formAutorizarRemocaoDebitoAutomatico');"/>
		
		<input class="button4 close"
		       value="<fmt:message key="label.nao" />" 
		       type="button" 
		       onclick="$.closeOverlay();" />
	</div>

</div>