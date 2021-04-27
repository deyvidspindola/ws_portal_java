<jsp:directive.include file="/WEB-INF/views/includes.jsp" />

<div id="popupPendenciaFinanceira">
	<div id="popup_bordacima"></div>

	<div id="popupPendenciaFinanceirainterior" style="height: 300px;">
		<b><fmt:message key="label.comunicadoImportante" />:</b>
		<p><fmt:message key="label.prezadoCliente" />,</p>
		<p>
			<c:out value="${mensagemPendenciaFinanceira}" />
		</p>
		
		<p>		
			<c:if test="${flag_redirect}">			
				<input type="button" 
					class="button" 
					value="<fmt:message key="label.fechar" />"
					onclick="window.location='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC08/dv03&usuarioIndicadorId=indicadorPendenciasFinanceiras'">
			</c:if>
			<c:if test="${!flag_redirect}">
			<input type="button" 
					class="button" 
					value="<fmt:message key="label.fechar" />"
					onclick="window.location='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&usuarioIndicadorId=indicadorPendenciasFinanceiras'">
		    </c:if>
		</p>
	</div>
	<div id="popupPendenciaFinanceira_bordarodape"></div>
</div>