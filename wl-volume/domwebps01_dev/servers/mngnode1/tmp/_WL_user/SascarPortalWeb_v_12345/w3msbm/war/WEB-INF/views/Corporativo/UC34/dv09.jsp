<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<div class="popup_padrao2" >

	<div class="popup_padrao_pergunta"><fmt:message key="mensagem.sucesso.operacao" /></div>
	
	<div class="barraHorizontalModal"></div>

	<div class="popup_padrao_resposta" >
		
		<p class=btnFecharGerarOSReinstalacao>
			<a href="#" class="linkbtnGerarOSReinstalacao" onclick="finalizarProcesso('#formResumoFinal');"><fmt:message key="label.fechar" /></a>
		</p>
		
		<p class="btnGerarOSReinstalacao">
			<a href="#" class="linkbtnGerarOSReinstalacao" onclick="gerarNovaOrdemServico('#formGerarOSReisntalacao');"><fmt:message key="label.gerarOSdeReinstalacao" /></a>
		</p>
	</div>
	
	<div style="clear: both;"></div>
	
</div>