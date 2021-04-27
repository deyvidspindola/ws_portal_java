<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>


	<c:catch var="helper" >
		<c:import url="/AgendarOrdemServico/agendarOrdemServico?acao=6" context="/SascarPortalWeb"  />
	</c:catch>
	
	<c:if test="${not empty helper}" >
		<script type="text/javascript">
			openDefaultErroPage('${helper}');
		</script>
	</c:if>
	
	<div class="popup_padrao">
		<div class="popup_padrao_pergunta">
			${mensagem }
		</div>
		<div class="popup_padrao_resposta">
			<input type="button" class="button close" value="<fmt:message key="label.voltar" />" onclick="document.location.href='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC02/dv01'"/>
		</div>
	</div>
