<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<div class=popup_padrao2>
	
	<div class="popup_maior_pergunta" style="text-align: center; height: 15px;">
		<fmt:message key="label.exclusaoDebitoAutomatico" />:
	</div>
	
	<div style="clear:both;"></div>
	
	<div class="confirmacaoInclusaoDebitoAutomativo" style="height: 60px;">
		<p>
			<fmt:message key="uc17.dv08.texto.01" />
		</p>
		
	</div>
	
	<div style="clear:both;"></div>
	
	<div class="popup_maior_resposta" style="text-align: center;">
		<input class="button4 close" 
			   type="button" 
			   value="OK" 
			   onclick="finalizaOperacaoExclusaoDebitoAutomatico('#formAutorizarRemocaoDebitoAutomatico');">
	</div>
	
</div>