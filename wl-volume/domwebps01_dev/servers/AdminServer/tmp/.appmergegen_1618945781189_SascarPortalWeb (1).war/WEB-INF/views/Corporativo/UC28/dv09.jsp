<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<div class="popup_padrao">
	<div class="popup_padrao_pergunta"><fmt:message key="mensagem.sucesso.ordemSExcluidaBordero" /><br />
	</div>
	
	<div class="popup_padrao_resposta">
		<input class="button" 
		       value="<fmt:message key="label.fechar" />" 
		       type="button" 
		       onclick="$('#formAtualizar').submit();" />
	</div>

</div>