<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>
      
<div class="popup_padrao">
	<div class="popup_padrao_pergunta">
		<span style="color:#666;">
		<fmt:message key="mensagem.confirmacao.desejaExcluirOSBordero">
			<fmt:param><span style="color:#F00;">${param.ordemServico}</span></fmt:param>
			<fmt:param><span style="color:#F00;">${param.numeroBordero}</span></fmt:param>
		</fmt:message>
	</div>
	
	<div class="popup_padrao_resposta">
		<input class="button" 
		       value="<fmt:message key="label.sim" />" 
		       type="button" 
		       onclick="confirmarExclusaoOrdemServico(${param.ordemServico}, ${param.numeroBordero});"/>
		
		<input class="button4 close"
		       value="<fmt:message key="label.nao" />" 
		       type="button" 
		       onclick="$.closeOverlay();" />
	</div>

</div>