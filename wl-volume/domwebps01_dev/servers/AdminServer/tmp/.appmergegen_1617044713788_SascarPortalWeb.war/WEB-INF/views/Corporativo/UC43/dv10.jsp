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


<form id="formReagendamento" 
	  method="post" 
	  action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC43/dv03" >
	
	<input type="hidden" name="ordemServicoAgendamento" id="ordemServicoAgendamento" value="${param.numeroOrdemServico}" />
	<input type="hidden" name="placaAgendamento" 	    id="placaAgendamento" 	     value="${param.placaVeiculo}" />

	<div class="popup_padrao">
	
		<div class="popup_padrao_pergunta">
			<fmt:message key="mensagem.sucesso.cancelamentoEfetuado" />
			<br>
		</div>
		<div class="popup_padrao_resposta">
			<input class="button close" 
				   type="submit" 
				   value="<fmt:message key="btn.reagendar" />" />
				   
			<input class="button4" 
				   type="button" 
				   value="<fmt:message key="label.fechar" />" 
				   onclick="window.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC43/dv01'">
		</div>
		<p>&nbsp;</p>
	
	</div>

</form>