<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>
<c:choose>
	<c:when test="${not empty param.abaAtiva and param.abaAtiva eq 'esquerda'}">

		<!-- MENU ESQUERDO ATIVO -->
		<div class="menuEsquerdoAtivo">
			<div class="tituloAbaAtiva">
				<a href="#" 
				   style="padding-left: 35px;"
				   class="link_titleatualizacao tooltip" 
				   title="<fmt:message key="uc8.menuAbas.incluaContatoAutorizados" />">
				<fmt:message key="label.informacoesCliente" />
				</a>
			</div>
			  
			<div class="tituloAbaInativa">
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC08/dv02" 
				   class="link_titleatualizacao tooltip" style="padding-left: 50px"
				   title="<fmt:message key="uc8.menuAbas.incluaContatoAutorizados" />"><fmt:message key="label.informacoesContatoVeiculo" /></a>
			</div>
			
			<div class="tituloAbaInativa">
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC30/dv01" 
				   class="link_titleatualizacao tooltip" style="padding-left: 50px"
				   title="<fmt:message key="uc8.menuAbas.aquiGerenciaGruposContatos" />"><fmt:message key="label.gerenciarGrupoContatoVeiculo" /></a>
			</div>
		</div>

	</c:when>
	
	<c:when test="${not empty param.abaAtiva and param.abaAtiva eq 'central'}">
	
		<!-- MENU CENTRAL ATIVO -->
		<div class="menuCentralAtivo">
			<div class="tituloAbaInativa">
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC08/dv01"  
				   class="link_titleatualizacao tooltip" style="padding-left: 35px"
				   title="<fmt:message key="uc8.menuAbas.incluaContatoAutorizados" />"><fmt:message key="label.informacoesCliente" /></a>
			</div>
			
			<div class="tituloAbaAtiva">
				<a href="#" 
				   style="padding-left: 50px;"
				   class="link_titleatualizacao tooltip"  
				   title="<fmt:message key="uc8.menuAbas.incluaContatoAutorizados" />">
				<fmt:message key="label.informacoesContatoVeiculo" /> 
				</a>
			</div>
			
			<div class="tituloAbaInativa">
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC30/dv01" 
				   style="padding-left: 50px;"
				   class="link_titleatualizacao tooltip" 
				   title="<fmt:message key="uc8.menuAbas.aquiGerenciaGruposContatos" />">
				   <fmt:message key="label.gerenciarGrupoContatoVeiculo" />
			   </a>
				
			</div>
		</div>
	
	</c:when>
	
	<c:when test="${not empty param.abaAtiva and param.abaAtiva eq 'direita'}">
	
		<!-- MENU DIREITO ATIVO -->
		<div class="menuDireitoAtivo">
			<div class="tituloAbaInativa">
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC08/dv01"  
				   class="link_titleatualizacao tooltip" style="padding-left: 35px;"
				   title="<fmt:message key="uc8.menuAbas.incluaContatoAutorizados" />"><fmt:message key="label.informacoesCliente" /></a>
			</div>
			
			<div class="tituloAbaInativa">
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC08/dv02" 
				   class="link_titleatualizacao tooltip" style="padding-left: 50px;" 
				   title="<fmt:message key="uc8.menuAbas.incluaContatoAutorizados" />"><fmt:message key="label.informacoesContatoVeiculo" /></a>
			</div>
			
			<div class="tituloAbaAtiva">
				<a href="#" 
				   style="padding-left: 50px;" 
				   class="link_titleatualizacao tooltip" title="<fmt:message key="uc8.menuAbas.aquiGerenciaGruposContatos" />">
				<fmt:message key="label.gerenciarGrupoContatoVeiculo" />
				</a>
			</div>
		</div>
	
	</c:when>
	
</c:choose>