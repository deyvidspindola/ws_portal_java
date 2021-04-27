<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/EnviarSolicitacaoLoteServlet/submeterArquivo?acao=2" context="/SascarPortalWeb"  />
</c:catch>

<c:if test="${not empty helper}" >
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>

<script type="text/javascript">
	$(document).ready(function() {
		$("#popupArquivo").jOverlay({
			bgClickToClose : false,
			closeOnEsc : false,
			'css' : {'top' : '120px'}
		});
		
		setTimeout(function(){
			setIframeParentHeight($("#popupArquivo").height() + 150);
		}, 500);
	});
	
</script>


<c:choose>
	<c:when test="${not empty numeroLote }">
		<div class="rbroundbox" id="popupArquivo" style="width: 100%; *width: 30%;">
			<div class="rbtop"><div></div></div>
			
			<div class="rbcontent">
				<h4><fmt:message key="uc49.texto.007.solicitacaoEnviada" /></h4>		
				<p><fmt:message key="uc49.texto.008.numeroLoteSolicitacao" />: <c:out value="${numeroLote}"></c:out>
		        </p>
		        <p><fmt:message key="uc49.texto.009.aguardeSolicitacaoProcessada" /></p>
		        <div id="buttonPopUp">
			  		<input type="button" class="buttonPopUp" value="<fmt:message key="label.enviarOutroArquivo" />" onclick="window.location='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC49/dv01'"/>
			  	</div>
			</div>
			
			<div class="rbbot"><div></div></div>
		</div>
	
	</c:when>
	<c:otherwise>
		<div class="rbroundbox" id="popupArquivo" style="width: 60%;">
			<div class="rbtop"><div></div></div>
			
			<div class="rbcontent">
				<h4><fmt:message key="mensagem.informacao.naoPossivelRealizarUpload" /></h4>
				<p>
					<c:if test="${not empty mensagem }">
						<c:out value="${mensagem }"></c:out>
					</c:if>
				</p>   
				<div id="buttonPopUp">
			  		<input type="button" class="buttonPopUp" value="<fmt:message key="label.fechar" />" onclick="window.location='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC49/dv01'"/>
				</div>
				
			</div>
			
			<div class="rbbot"><div></div></div>
		</div>
  	</c:otherwise>	
</c:choose>
		
		
