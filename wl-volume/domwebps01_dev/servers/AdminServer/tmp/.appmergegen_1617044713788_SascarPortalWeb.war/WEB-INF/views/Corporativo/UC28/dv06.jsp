<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<div class="popup_maior">
	<div class="popup_maior_pergunta" style="text-align: left;">
		<fmt:message key="label.obsConferenciaSascar" />:
		<textarea rows="2" cols="40" readonly="readonly" style="resize: none;" class="textAreaObervacaoOrdemServico" >${param.observacao}</textarea>
	</div>
	
	<div class="popup_maior_resposta" style="text-align: right;">
		<input class="button4 close" type="button" style="" value="<fmt:message key="label.fechar" />" onclick="javascript:$.closeOverlay();">
	</div>
</div>

