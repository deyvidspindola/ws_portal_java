<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>
	
<div class="popup_maior">
	
	<div class="popup_maior_pergunta" style="text-align: left; height: 15px;">
		<fmt:message key="uc29.texto.013.obsConferenciaSascar" />
	</div>
	
	<div style="clear:both;"></div>
	
	<div class="observacaoConferenciaOrdemServico">
		<c:choose>
			<c:when test="${not empty param.observacao}">
				<p>${param.observacao}</p>
			</c:when>
			<c:otherwise>
				<p><fmt:message key="uc29.texto.014.nenhumaObsInseridaConferenciaSascar" /></p>
			</c:otherwise>
		</c:choose>
	</div>
	
	<div style="clear:both;"></div>
	
	<div class="popup_maior_resposta" style="text-align: right;">
		<input class="button4 close" type="button" style="" value="<fmt:message key="label.fechar" />" onclick="javascript:$.closeOverlay();">
	</div>
	
</div>

