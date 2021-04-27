<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<div class="menu2">
	<ul>
		<li>
		  <div class="icon2"><img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/icons-10.png" width="48" height="48" hspace="10" vspace="20" border="0" /></div>
		  <a href="#" target="_self" class="titlemenu" >
		  	<strong><fmt:message key="label.informacoes" /></strong><span class="subtitlemenu"><fmt:message key="label.consultarVeiculosEmitirDeclaracao" /></span>
		  </a>
		  <div>
		    <ul>
		      <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC24/dv01&menu=1"><fmt:message key="label.consultarVeiculos" /></a></li>
		      <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC24/dv01&menu=2"><fmt:message key="label.declaracaoDeVeiculosMonitorados" /></a></li>
		      </ul>
		  </div>
		</li>
		
		<li>
		  <div class="icon2"><img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/icons-11.png" width="48" height="48" hspace="10" vspace="20" border="0" /></div>
		  <a href="#" target="_self" >
		  	<strong><fmt:message key="label.servicos" /></strong><span class="subtitlemenu"><fmt:message key="label.solicitarInstalRetiradaEquipamento" /></span>
		  </a> 
		  <ul> 
		    <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC21/dv01&menu=1"><fmt:message key="label.instalacaoDeEquipamento" /></a></li>
		    <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC24/dv01&menu=3"><fmt:message key="label.retiradaDeEquipamento" /></a></li>
		    <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC49/dv01"><fmt:message key="label.enviarSolicitacoesLote" /></a></li>
		    <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC51/dv01"><fmt:message key="label.consultarSolicitacoesLote" /></a></li>
		    <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC22/dv01"><fmt:message key="label.novaSolicitacao" /></a></li>
	      </ul>
		</li>
	</ul>

</div>