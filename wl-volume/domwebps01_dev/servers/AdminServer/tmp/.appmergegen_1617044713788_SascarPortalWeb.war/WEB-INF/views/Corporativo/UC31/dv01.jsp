<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/VerificarPermissao" context="/SascarPortalWeb"  />
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


<div class="cabecalho">
	<fmt:message key="label.atualizacaoCadastral" />
	<div class="caminho">
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; 
		<a href="#" class="linktres"><fmt:message key="label.informacoes" /></a> &gt;
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC08/dv01" class="linkquatro"><fmt:message key="label.atualizacaoCadastral" /></a>
	</div>
</div>

<jsp:include page="/WEB-INF/views/Corporativo/UC08/MenuAbas.jsp">
	<jsp:param name="abaAtiva" value="direita" />
</jsp:include>
	
<body>	
	<table class="tbatualizacao" cellspacing="0" width="960">
		<tbody>
			<tr class="tbatualizacao">
				<th class="abatualizacao">
					<fmt:message key="uc8.menuAbas.aquiGerenciaGruposContatos" />					
				</th>				
			</tr>
		</tbody>
	</table>
	
	<form method="post" action="" id="formUC31DV01" name="formUC31DV01">
	<div class="busca_branca">
		<span class="text1"><fmt:message key="uc30.dv01.label.cliqueIncluirExcluirReplicar" /></span>
	</div>
		
	<div class="replicacao_base">
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC30/dv02"><div class="replicacao">
		  <p><img src="/SascarPortalWeb/sascar/images/corporativo_new/replicacao-16.png" width="72" height="45" border="0" style="*margin-top:20px;" /> </p>
		  <p><fmt:message key="label.replicar" /></p>
		  <span class="text_replicacao"><fmt:message key="uc30.dv01.replicarContato" /></span>
		</div></a>
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC31/dv02"><div class="replicacao">
		  <p><img src="/SascarPortalWeb/sascar/images/corporativo_new/replicacao-18.png" width="72" height="45" border="0" style="*margin-top:20px;" /></p>
		  <p><fmt:message key="label.incluir" /></p>
		  <span class="text_replicacao"><fmt:message key="uc30.dv01.IncluirContato" /></span>
		</div></a>
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC32/dv02"><div class="replicacao">
		  <p><img src="/SascarPortalWeb/sascar/images/corporativo_new/replicacao-17.png" width="72" height="45" border="0" style="*margin-top:20px;" /></p>
		  <p><fmt:message key="label.excluir" /></p>
		  <span class="text_replicacao"><fmt:message key="uc30.dv01.ExcluirContato" /></span>
		</div></a>
	</div>

	</form>
	
	<br clear="all"/>
	
	<div class="clear:both"></div>
</body>