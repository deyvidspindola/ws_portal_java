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
	
	<form action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Imprimir&page=Corporativo/UC42/dv04" onsubmit="openPopupPrint(this);" method="post">
			<div class="popup_padrao">
				<div class="popup_padrao_pergunta">
					<fmt:message key="mensagem.sucesso.remessaGerada" />
					<br>
					<fmt:message key="label.numeroDaRemessa" />:
					<span style="color: rgb(204, 0, 0);">12345678</span>
					<br>
				</div>
				
				<div class="popup_padrao_resposta">
					<input class="button close" type="submit" value="<fmt:message key="label.imprimir" />">
					<input class="button4" type="button" value="<fmt:message key="label.fechar" />" onclick="window.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC29/dv01'">
				</div>
				
				<p>&nbsp;</p>
				
			</div>
	</form>
