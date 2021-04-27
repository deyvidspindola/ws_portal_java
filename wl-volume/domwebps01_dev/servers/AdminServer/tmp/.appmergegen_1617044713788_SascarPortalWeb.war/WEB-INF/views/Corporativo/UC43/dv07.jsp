<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

 
<c:if test="${not empty mensagem }">
	<script type="text/javascript">
		$.showMessage("${mensagem}");
	</script>
</c:if>

<c:if test="${not empty helper}" >
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>


<script type="text/javascript">

	function imprimirOrdemServico(urlOrdemServicoImpressao){
		
		// PEGANDO A REFERENCIA DA DIV DE MENSAGENS DE VALIDACAO
		var conteinerValidacao = $(".conteinerValidacao");
		
		// LIMPANDO AS MENSAGENS DE ERRO
		conteinerValidacao.find('li').remove();
		
		if(urlOrdemServicoImpressao != ''){
			
			/* ABRE TELA DE IMPRESSAO */
			window.open(urlOrdemServicoImpressao, '_blank'); 
		
		}else{
			
			html = '<li><label><fmt:message key="mensagem.informacao.naoPossivelRealizarImpressaoOS" /></label></li>';
			conteinerValidacao.find('ol').append(html);
		
		}
		
	}
		
</script>

<div class="popup_padrao2">
	<div class="popup_padrao_pergunta_redimensiona_altura">
	
		<div class="conteinerValidacao">
			<ol style="color: #C00;">
			</ol>
		</div>
	
		<span style="color:#666; font-size:11px;"><fmt:message key="mensagem.sucesso.agendamentoEfetuado" /></span>
	
		<div style="clear: both;"></div>
		
	</div>
		
	<div style="clear: both;"></div>

	<div class="popup_padrao_resposta">
	
		<input class="button close" 
			   type="button" 
			   value="<fmt:message key="label.imprimir" />" 
			   onclick="imprimirOrdemServico('${param.urlImpressaoOrdemServico}');" />
		
		<input class="button4" 
			   type="button" 
			   value="<fmt:message key="label.fechar" />" 
			   onclick="document.location.href='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC43/dv01'"/>
	</div>
</div>
