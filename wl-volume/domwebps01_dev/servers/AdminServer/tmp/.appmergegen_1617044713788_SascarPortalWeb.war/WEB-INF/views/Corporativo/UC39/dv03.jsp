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

		
</script>

<div class="popup_padrao">
	<div class="popup_padrao_pergunta">
		<fmt:message key="mensagem.sucesso.pedidoRealizado" />
		<br>
		<span style="color: rgb(204, 0, 0);"><fmt:message key="label.numeroDoPedido" />: ${param.numeroPedido}</span>
	</div>
	<div class="popup_padrao_resposta">
		<input class="button close" 
			   type="button" 
			   onclick="$('#formFinalizarPedido').submit();"
			   value="<fmt:message key="label.fechar" />" />
	</div>
</div>
	
	