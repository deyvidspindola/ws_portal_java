<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<div class=popup_padrao3>
	
	<div class="popup_maior_pergunta" style="text-align: center; height: 15px;">
		<fmt:message key="label.inclusaoDebitoAutomatico" />:
	</div>
	
	<div style="clear:both;"></div>
	
	<div class="confirmacaoInclusaoDebitoAutomativo">
		<p>
			<fmt:message key="uc17.dv06.texto.01" />
		</p>
		
		<p>
			<fmt:message key="uc17.dv06.texto.02" />
		</p>
		
	</div>
	
	<div style="clear:both;"></div>
	
	<div class="popup_maior_resposta" style="text-align: center;">
		<input class="button4 close" 
			   type="button" 
			   value="OK" 
			   onclick="finalizaOperacaoInclusaoDebitoAutomatico('#formAutorizarDebitoAutomatico');">
	</div>
	
</div>