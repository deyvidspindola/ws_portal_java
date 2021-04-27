<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/EfetuarTrocaVeiculoRetirada/efetuarTrocaVeiculoRetirada?acao=5" context="/SascarPortalWeb"  />
</c:catch>

<c:if test="${not empty helper}" >
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>

	<div id="dialog_mensagem" class="popup_maior" style="display: block">
		<form action="" id="formTrocaRetirada">
			<input type="hidden" value="${ordemServico.numero }" name="numeroOrdemServico" />
	
			<div id="popup_msg_modal" class="popup_padrao_pergunta">${mensagem }</div>
	         <br><br>
			<div class="popup_maior_resposta2">
				 <!--<c:if test="${not empty ordemServico.numero}"> 
					<p>
						<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC02/dv03&numeroOS=${ordemServico.numero}" title="<fmt:message key="label.cliqueVisualizarDetalheOS" />" class="linkcinco">
							<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/1304444121_tag_red.png" width="16" height="16" hspace="5" align="absmiddle" border="0" />
							<fmt:message key="mensagem.confirmacao.desejaAgendarAgoraExecucaoServico" />
						</a>
					</p>
				</c:if>-->
				<p>
					<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC03/dv01" title="<fmt:message key="label.solicitarNovaTrocaRetirada" />" class="linkcinco">
						<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/1304444116_tag_blue.png" width="16" height="16" hspace="5" align="absmiddle" border="0" />
						<fmt:message key="mensagem.confirmacao.querSolicitarRetiradaReinstalacao" />
					</a>
				</p>
			</div>
		</form>
	</div>

