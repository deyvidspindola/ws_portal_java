<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>
<c:catch var="helper" >
	<c:import url="/UserServlet" context="/SascarPortalWeb" />
</c:catch>
	<div class="menu2">
		<ul>
			<li style="position: relative">
			  <div class="icon2"><img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/icons-11.png" width="48" height="48" hspace="10" vspace="20" border="0" /></div>
			  <a href="#" target="_self" >
			  	<strong><fmt:message key="label.servicos" /> </strong><span class="subtitlemenu"><fmt:message key="label.execucaoOSAtivacaoEquipamento" /></span>
			  </a>
			  <ul>
			    <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv01"><fmt:message key="label.ativacaoDeEquipamento" /></a></li>
			    <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC41/dv01"><fmt:message key="label.consultarRemessaDeEstoque" /></a></li>
			    <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC42/dv01"><fmt:message key="label.criarRemessaDeEstoque" /></a></li>
			    <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv01"><fmt:message key="label.consultarEstoqueSintetico" /></a></li>
			    <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC39/dv01"><fmt:message key="label.realizarPedidoEstoque" /></a></li>
			    <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC40/dv01"><fmt:message key="label.consultarPedidoDeEstoque" /></a></li>
			    <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC43/dv01"><fmt:message key="label.agendarAtendimento" /></a></li>			    
		   	    <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC33/dv01"><fmt:message key="label.solicitarContaIndicador" /></a></li>
			    <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC52/dv01"><fmt:message key="label.agendaInstalador" /></a></li>

			    <li id="li_representante_tecnico_chat"></li>
			  </ul>
			</li>
			
			<li id="menuAdministrativo">
			  <div class="icon2"><img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/icons-12.png" width="48" height="48" hspace="10" vspace="20" border="0" /></div>
			  <a href="#" target="_self" class="titlemenu" >
			  	<strong><fmt:message key="label.pagamentos" /> </strong><span class="subtitlemenu"><fmt:message key="label.extratoPrevisaoPgtosServicos" /></span>
			  </a>
			   <ul>
			   	 <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC19/dv01"><fmt:message key="label.extratoServicosExecutados" /></a></li>
			   	 <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC20/dv01"><fmt:message key="label.historicoPrevisaoPagamentos" /></a></li>
			   	 <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC28/dv01"><fmt:message key="label.borderosTramitacao" /></a></li>
		   	     <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC27/dv01"><fmt:message key="label.borderosPagos" /></a></li>
		   	     <li><a href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC29/dv01"><fmt:message key="label.criarBorderos" /></a></li>		   	     
			   </ul>
			</li>
		</ul>
	</div>