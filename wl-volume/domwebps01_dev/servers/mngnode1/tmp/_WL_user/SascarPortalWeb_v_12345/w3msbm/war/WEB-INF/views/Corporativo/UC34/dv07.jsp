<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>
      
<div class="popup_padrao2">
	
	<c:choose>
		<c:when test="${not empty param.numeroSerialAcessorio}">
		
			<div class="popup_padrao_pergunta_redimensiona_altura"><fmt:message key="label.confirmacaoDeRetirada" /><br />
				<span style="color:#666; font-size:11px;"><fmt:message key="mensagem.confirmacao.retiradaAcessorio" /> </span>
				<span style="color:#F00; font-size:11px;">${param.descricaoAcessorio}
				<span style="color:#666; font-size:11px;"><fmt:message key="label.serial" /> </span>${param.numeroSerialAcessorio}</span>?<br />
			
				<div style="clear: both;"></div>
			</div>
			
		</c:when>
		<c:otherwise>
		
			<div class="popup_padrao_pergunta_redimensiona_altura"><fmt:message key="label.confirmacaoDeRetirada" /><br />
				<span style="color:#666;"><fmt:message key="mensagem.confirmacao.retiradaAcessorio" /> </span>
				<span style="color:#F00;">${param.descricaoAcessorio}</span>?<br />
			
				<div style="clear: both;"></div>
			</div>
			
		</c:otherwise>
	</c:choose>

	<div style="clear: both;"></div>

	<div class="popup_padrao_resposta">
	
		<input class="button" 
		       value="<fmt:message key="label.sim" />" 
		       type="button" 
		       onclick="submeterDadosAcessorio('#formRetiradaAcessorio');"/>
		       
		<input class="button4 close" 
		       type="button" 
		       onclick="javascript:$.closeOverlay();" value="<fmt:message key="label.nao" />">
	</div>
	
</div>

