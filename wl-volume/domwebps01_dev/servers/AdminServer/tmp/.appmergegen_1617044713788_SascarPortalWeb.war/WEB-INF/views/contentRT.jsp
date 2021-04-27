<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/RealizarPesquisaOpiniaoServlet/verificarPesquisaOpiniao?acao=1" context="/SascarPortalWeb"  />
</c:catch>

<c:if test="${not empty mensagem }">
	<script type="text/javascript">
		$.showMessage("${mensagem }");
	</script>
</c:if>

<script type="text/javascript">
	$(document).ready(function(){
		//ocultar banner duvidas 
		$("#banner_duvidas").toggle();
	});
</script>

<div class="acessorapido">
	<div id="botaoacesso"><fmt:message key="label.acessoRapido" /></div>
</div>
<div id="dashboard">
	<div id="acessorapido">
	    <p>
	    	<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/agendamento32.png" width="32" height="32" hspace="10" border="0" align="absmiddle" class="iconshome" />
			<span class="dashboard">
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv01" class="dashboard tooltip" title="<fmt:message key="label.vinculeEquipamentoTestes" />"><fmt:message key="label.ativacaoEquipamento" /></a>
			</span>
		</p>
	</div>
	
	<div id="banner_faleconosco">
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC48/dv01">
			<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/banner-fale-conosco.png" width="225" height="75" border="0" />
		</a>
	</div>
	
	<div id="banner_faleconosco">
		<a href="http://intranet.sascar.com.br/modelo_cobr_visita_tecnica.php" target="_blank">
			<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/banner_download_documentacao.png" width="225" height="75" border="0" />
		</a>
	</div>
	<div id="banner_duvidas">
		<a href="#">
			<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/banner_duvidas.png" width="225" height="75" border="0" />
		</a>
	</div>
</div>