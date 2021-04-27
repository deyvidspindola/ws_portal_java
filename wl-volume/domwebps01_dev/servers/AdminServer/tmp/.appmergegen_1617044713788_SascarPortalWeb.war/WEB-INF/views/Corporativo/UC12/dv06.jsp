<jsp:directive.include file="/WEB-INF/views/includes.jsp" />

<div id="popupPlacaFicticia">
	<div id="popup_bordacima"></div>

	<div id="popupPlacaFicticiainterior" style="height: 300px;">
		<b><fmt:message key="label.comunicadoImportante" />:</b>
		<p><fmt:message key="label.prezadoCliente" />,</p>
		<p>Identificamos que este usu&aacute;rio possui placa(s) de ve&iacute;culo(s) com dados fict&iacute;cios que precisam ser atualizados.</p>
		<B>Acesso:</B>
		<p>
			Para atualizar, acesse: 
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC08/dv03&usuarioIndicadorId=indicadorPlacasFicticias&from_link=yes">
				<fmt:message key="label.informacoes" /> > <fmt:message key="label.atualizacaoCadastral" /> > <fmt:message key="label.informacoesContatoVeiculo" />.
			</a>
		</p>
		<p>
			<input type="button" 
					class="button" 
					value="<fmt:message key="label.fechar" />"
					onclick="window.location='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&usuarioIndicadorId=indicadorPlacasFicticias'">
		</p>
	</div>

	<div id="popupPlacaFicticia_bordarodape"></div>
</div>