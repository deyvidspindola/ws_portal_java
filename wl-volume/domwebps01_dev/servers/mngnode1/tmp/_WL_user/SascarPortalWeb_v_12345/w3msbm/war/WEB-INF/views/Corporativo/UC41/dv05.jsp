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


	<body>
		<div class="popup_padrao">
			<div class="popup_padrao_pergunta">
				<fmt:message key="mensagem.confirmacao.cancelamentoRemessa" />
				<br>
			</div>
			
			<div class="popup_padrao_resposta">
				<input class="button close" type="button" value=<fmt:message key="label.sim" /> onclick="window.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC29/dv01'">
				<input class="button4" type="button" value="<fmt:message key="label.nao" />" onclick="window.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC29/dv01'">
			</div>
			<p>&nbsp;</p>
		</div>
	</body>

