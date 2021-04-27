<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/AutorizarDebitoAutomaticoServlet/inicializarTela?acao=6" context="/SascarPortalWeb"  />
</c:catch> 

<c:if test="${not empty mensagem }">
	<script type="text/javascript">
		$.showMessage("${mensagem }");
	</script>
</c:if>

<c:if test="${not empty helper}" >
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>

	<script type="text/javascript">
	
	</script>

	<div class="container2"> 
		<ol>
			<li>
				<label for="termoAceite" class="error"><fmt:message key="mensagem.campoObrigatorio.concordoTermo" /></label>
			</li>
			<li>
				<label for="bancos" class="error"><fmt:message key="mensagem.campoObrigatorio.banco" /></label>
			</li>
			<li>
				<label for="numeroAgencia" class="error"><fmt:message key="mensagem.campoObrigatorio.numeroAgencia" /></label>
			</li>
			<li>
				<label for="numeroConta" class="error"><fmt:message key="mensagem.campoObrigatorio.numeroConta" /></label>
			</li>
		</ol>
	</div>

	<div class="cabecalho2">
		<div class="caminho3" style="*margin-left:280px;">
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; 
			<a href="#" class="linktres"><fmt:message key="label.pagamentos" /></a> &gt; 
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC17/dv01"  class="linkquatro"><fmt:message key="label.autorizarDebitoAutomatico" /></a>
		</div>
		<fmt:message key="label.autorizarDebitoAutomatico" />
	</div>

	<table cellspacing="0" class="detalhe" >
		<tr class="barraazulzinha">
			<th class="barraazulzinha"><fmt:message key="label.dadosBancarios" /></th>
		</tr>
	</table>
	
	<!-- DV03 - INCLUDE TIPO OPERACAO INCLUSAO -->
	<!-- DV04 - INCLUDE TIPO OPERACAO EXCLUSAO -->
	<!-- DV09 - BLOQUEI A OPERACAO SE O USUARIO POSSUI TIPO DE PAGAMENTO PARA CARTAO DE CREDITO -->

	<c:choose>
		<c:when test="${bloqueiaOperacao}">
			
			<jsp:include page="/WEB-INF/views/Corporativo/UC17/dv09.jsp" >
				<jsp:param name="mensagemErro" value="${mensagem}" />
			</jsp:include>
			
		</c:when>
		<c:otherwise>
			
			<c:choose>
				<c:when test="${renderizaCadastroDebito}">
					
					<jsp:include page="/WEB-INF/views/Corporativo/UC17/dv03.jsp" >
						<jsp:param name="renderizaBtnHistorico" value="${renderizaBtnHistorico}" />
					</jsp:include>
					
				</c:when>
				<c:otherwise>
					
					<jsp:include page="/WEB-INF/views/Corporativo/UC17/dv04.jsp" >
						<jsp:param name="renderizaBtnHistorico" value="${renderizaBtnHistorico}" />
					</jsp:include>
					
				</c:otherwise>
			</c:choose>
			
		</c:otherwise>
	</c:choose>
	
	

	<div class="text3" 
		 id="informacoes_autorizacao_debito_automatico" 
		 style="position: relative; 
		 		float: right; 
		 		width: 300px;"> 
		<span class="debito1"><fmt:message key="label.vejaFacilDebitoAutomatico" /></span>
		<p>
			<span class="debito2">
				<fmt:message key="uc17.dv01.texto.01" />
			</span>
		</p>
		
		<span class="debito1"><fmt:message key="label.saibaMais" />:</span>
		
		<p>
			<span class="debito3"><fmt:message key="label.ativacaoDebitoAutomatico" /></span>
		</p>
		
		<p>
			<span class="debito2">
				<fmt:message key="uc17.dv01.texto.02" />
			</span>
		</p>
		
		<span class="debito3"><fmt:message key="label.somenteClientesBancoBrasil" /></span>
		
		<p>
			<span class="debito2">	
				<fmt:message key="uc17.dv01.texto.03" />
					<a href="http://www.bb.com.br/portalbb/page44,116,2038,1,1,1,1.bb?codigoNoticia=1334&codigoMenu=164&codigoRet=649&bread=3_6" target="_blank">
						www.bb.com.br
					</a>
			</span>
		</p>
		
	</div>

<div style="clear:both"></div>

<div id="popupHistorico" style="display: none; margin-top: 280px;"></div>

<div id="popupConfirmacaoInclusaoDebitoAutomatico" style="display: none; margin-top: 280px;"></div>
<div id="popupRetornoConfirmacaoInclusaoDebitoAutomatico" style="display: none; margin-top: 280px;"></div>

<div id="popupConfirmacaoExclusaoDebitoAutomatico" style="display: none; margin-top: 280px;"></div>
<div id="popupRetornoConfirmacaoExclusaoDebitoAutomatico" style="display: none; margin-top: 280px;"></div>