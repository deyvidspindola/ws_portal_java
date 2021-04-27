<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<div class="popup_padrao">
	<div class="popup_padrao_pergunta"><fmt:message key="mensagem.sucesso.operacao" /><br />
	
		<span style="color:#666;"><fmt:message key="label.numeroDaOS" />:</span>
		<span style="color:#F00;">${param.ordemServicoReinstalacao}</span><br />
	</div>
	
	<div class="popup_padrao_resposta">
		<input class="button" 
		       value="<fmt:message key="label.fechar" />" 
		       type="button" 
		       onclick="concluirGeracaoOrdemServicoReinstalacao('#formSolicitarcaoOrdemServicoPendente');"/>
	</div>

</div>