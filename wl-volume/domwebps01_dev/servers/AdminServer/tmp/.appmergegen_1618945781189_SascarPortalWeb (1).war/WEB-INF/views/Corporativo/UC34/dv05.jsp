<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>
      
<div class="popup_padrao">
	<div class="popup_padrao_pergunta"><fmt:message key="label.confirmacaoDeRetirada" /><br />
		<span style="color:#666;"><fmt:message key="mensagem.confirmacao.retiradaEquipamento" /> </span>
		<span style="color:#F00;">${param.serialEquipamento}</span>?<br />
	</div>
	
	<div class="popup_padrao_resposta">
		<input class="button" 
		       value="<fmt:message key="label.sim" />" 
		       type="button" 
		       onclick="confirmarRemocaoEquipameno('#formExcluirAcessorio');"/>
		
		<input class="button4 close"
		       value="<fmt:message key="label.nao" />" 
		       type="button" 
		       onclick="$.closeOverlay();" />
	</div>

</div>