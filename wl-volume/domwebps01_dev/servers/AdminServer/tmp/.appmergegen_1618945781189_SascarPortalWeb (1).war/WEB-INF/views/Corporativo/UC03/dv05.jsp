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
			<input type="hidden" value="${ordemServico.numero }" name="numeroOrdemServico" />
	
			<div id="popup_msg_modal" class="popup_padrao_pergunta"><fmt:message key="label.concordoTermoCondicoesVeiculos" /></div>
	        <hr size= 3></hr>
			<div class="popup_maior_resposta2">
			 <fmt:message key="uc03.dv05.texto.01" />
			 <br>
			 <fmt:message key="uc03.dv05.texto.02" />
			<br>
			   <b><fmt:message key="label.duvidasEntrarContatoCentral" />
                <br>
                <fmt:message key="label.telGrandesCentros" /> <br>
                <fmt:message key="label.telDemaisLocalidades" /><br>		 
			    </b>
			 
				<p>
				<input type="checkBox"/>
					<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC03/dv01" title="Solicitar nova troca ou Retirada" class="linkcinco">
						<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/1304444116_tag_blue.png" width="16" height="16" hspace="5" align="absmiddle" border="0" />
						<fmt:message key="label.prosseguir" />
					</a>
					<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC03/dv01" title="Solicitar nova troca ou Retirada" class="linkcinco">
						<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/1304444116_tag_blue.png" width="16" height="16" hspace="5" align="absmiddle" border="0" />
						<fmt:message key="label.cancelar" />
					</a>
				</p>
			</div>	
	</div>

