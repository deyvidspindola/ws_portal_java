<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>
<c:catch var="helper" >
	<c:import url="/ConsultarEstoqueSintetico/consultarEstoqueImobilizado?acao=2" context="/SascarPortalWeb"  />
</c:catch>
 
<c:if test="${not empty mensagem }">
	<script type="text/javascript">
		$.showMessage("${mensagem}");
	</script>
</c:if>

<c:if test="${not empty helper}" >
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>

<div class="cabecalho2"><fmt:message key="label.consultarEstoqueSintetico" />
			<div class="caminho">
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" class="linktres"><fmt:message key="label.home" /></a> &gt;  
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv01" class="linktres"><fmt:message key="label.servicos" /></a> &gt;   
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv01" class="linkquatro"><fmt:message key="label.consultarEstoqueSintetico" /></a>
			</div>
		</div>	
	<!-- div class="cabecalho">
	
		<div class="caminho" style="">
			<a class="linktres" title="Home" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}">Home</a>
			&gt;
			<a class="linktres" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv01">Serviços</a>
			&gt;
			<a class="linkquatro" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv01">Consultar Estoque Sintético</a>
		</div>
		
		Consultar Estoque Sintético
		
	</div-->


	<div class="barraatualizacao_antiga">
		<div class="titleatualizacao_1_antiga"><fmt:message key="label.imobilizados" /></div>
		<div class="titleatualizacao_2_antiga">
			<a class="link_titleatualizacao tooltip" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv04&tipoProduto=${tipoProduto}&representanteEstoque=${codigoRepresentante}" title="<fmt:message key="label.consultarEstoqueDeMateriais" />"><fmt:message key="label.materiais" /></a>
		</div>
	</div>
	
	<%-- 
	<div class="menuDireitoAtivo">
			<div class="tituloAbaInativa">
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC08/dv01"  class="link_titleatualizacao tooltip" style="padding-left: 35px;" title="Inclua contatos autorizados e responsáveis para instalação, assistência e retirada do rastreador">
				   Informações do Cliente</a>
			</div>
			
			<div class="tituloAbaInativa">
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC08/dv02" class="link_titleatualizacao tooltip" style="padding-left: 50px;" title="Inclua contatos autorizados e responsáveis para instalação, assistência e retirada do rastreador">
				Informações de Contato/Veículo</a>
			</div>
			
			<div class="tituloAbaAtiva">
				<a href="#" style="padding-left: 50px;" class="link_titleatualizacao tooltip" title="Aqui você gerencia grupos de contato/veículos.">
				Gerenciar Grupo de Contato/Veículo
				</a>
			</div>
		</div>
	--%>


<c:forEach  items="${listaGrupoImobilizado}" var="imobilizado" varStatus="contador">

	<table class="detalhe" cellspacing="0">
		<tbody>
			<tr class="barraazulzinha">
				<th class="barraazulzinha">${imobilizado.descricao}</th>
			</tr>
		</tbody>
	</table>

 	<table id="alter" cellspacing="0" cellpadding="1" width="850">
		<tbody>
			<tr>	
				<c:if test="${imobilizado.codigo == '24'}">					
			      <th class="texttable_azul" width="28%" title="<fmt:message key="label.dataAberturaServico" />" scope="col"><fmt:message key="label.produto" /></th>
				</c:if>
				<c:if test="${imobilizado.codigo !='24'}">					
			      <th class="texttable_azul" width="28%" title="<fmt:message key="label.dataAberturaServico" />" scope="col"><fmt:message key="label.modelo" /></th>
				</c:if>
				<th class="texttable_cinza" width="15%" scope="col"><fmt:message key="label.statusDisponivel" /></th>
				<th class="texttable_cinza" width="16%" scope="col"><fmt:message key="label.statusTransito" /></th>
				<th class="texttable_cinza" width="15%" scope="col"><fmt:message key="label.statusRetirado" /></th>
				<th class="texttable_cinza" width="26%" scope="col"><fmt:message key="label.conferenciaIF" /></th>
			</tr>
	          <c:set var="flagCodigoBlackPower" value="0"></c:set>	       
	          <c:set var="flagCodigoBlackPower" value="1"></c:set>
	     
	        
	        <c:set var="subTotal" value="1"></c:set>
		    <c:forEach  items="${imobilizado.produtos}" var="itemImobilizado" varStatus="count">		
			
			<tr class="dif" style="background-color: rgb(255, 255, 255);">
				
				<td class="linkazulescuro" style="background-color: rgb(255, 255, 255);">${itemImobilizado.modeloImobilizado}</td>
				
				<td style="background-color: rgb(255, 255, 255);">
				  <c:if test="${itemImobilizado.quantidadeStatusDisponivel  > 0}">
					<a class="linkazul" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv03&codigoRepresentante=${codigoRepresentante}&tipoProduto=${tipoProduto}&status=1&codigoModelo=${itemImobilizado.codigoModeloImobilzado}&tipoImobilizado=${imobilizado.codigo}&nomeImobilizado=${itemImobilizado.modeloImobilizado}"    title="<fmt:message key="label.quantidadeStatusDisponivel" />"> ${itemImobilizado.quantidadeStatusDisponivel}</a>
				  </c:if>
				  <c:if test="${itemImobilizado.quantidadeStatusDisponivel == 0}">
					 ${itemImobilizado.quantidadeStatusDisponivel}
				  </c:if>
				</td>
				<td style="background-color: rgb(255, 255, 255);">
				  <c:if test="${itemImobilizado.quantidadeStatusTransito > 0}">
					<a class="linkazul" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv03&codigoRepresentante=${codigoRepresentante}&tipoProduto=${tipoProduto}&status=2&codigoModelo=${itemImobilizado.codigoModeloImobilzado}&tipoImobilizado=${imobilizado.codigo}&nomeImobilizado=${itemImobilizado.modeloImobilizado}"    title="<fmt:message key="label.quantidadeStatusTransito" />"> ${itemImobilizado.quantidadeStatusTransito} </a>
				  </c:if>
				  <c:if test="${itemImobilizado.quantidadeStatusTransito == 0}">
					${itemImobilizado.quantidadeStatusTransito} 
				  </c:if>
				</td>
				<td style="background-color: rgb(255, 255, 255);">
				   <c:if test="${itemImobilizado.quantidadeStatusRetirado > 0}">
					 <a class="linkazul" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv03&codigoRepresentante=${codigoRepresentante}&tipoProduto=${tipoProduto}&status=3&codigoModelo=${itemImobilizado.codigoModeloImobilzado}&tipoImobilizado=${imobilizado.codigo}&nomeImobilizado=${itemImobilizado.modeloImobilizado}"    title="<fmt:message key="label.quantidadeStatusRetirado" />"> ${itemImobilizado.quantidadeStatusRetirado}</a>
				   </c:if>
				     <c:if test="${itemImobilizado.quantidadeStatusRetirado == 0}">
					  ${itemImobilizado.quantidadeStatusRetirado}
				   </c:if>
				</td>
				<td style="background-color: rgb(255, 255, 255);">
				    <c:if test="${itemImobilizado.quantidadeStatusBloqueadoInstalacao > 0}">
					  <a class="linkazul" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv03&codigoRepresentante=${codigoRepresentante}&tipoProduto=${tipoProduto}&status=4&codigoModelo=${itemImobilizado.codigoModeloImobilzado}&tipoImobilizado=${imobilizado.codigo}&nomeImobilizado=${itemImobilizado.modeloImobilizado}"    title="<fmt:message key="label.quantidadeConferenciaIF" />"> ${itemImobilizado.quantidadeStatusBloqueadoInstalacao}</a>
				    </c:if>
				    <c:if test="${itemImobilizado.quantidadeStatusBloqueadoInstalacao ==0}">
					   ${itemImobilizado.quantidadeStatusBloqueadoInstalacao}
				    </c:if>
				</td>
				<c:set var="TotalStatusDisponivel" value="${TotalStatusDisponivel + itemImobilizado.quantidadeStatusDisponivel}"></c:set>
				<c:set var="TotalStatusTransito" value="${TotalStatusTransito + itemImobilizado.quantidadeStatusTransito}"></c:set>
				<c:set var="TotalQuantidadeStatusRetirado" value="${TotalQuantidadeStatusRetirado + itemImobilizado.quantidadeStatusRetirado}"></c:set>
				<c:set var="TotalQuantidadeStatusBloqueadoInstalacao" value="${TotalQuantidadeStatusBloqueadoInstalacao + itemImobilizado.quantidadeStatusBloqueadoInstalacao}"></c:set>
			</tr>		
	</c:forEach>
	<tr>
        <th class="texttable_cinza" width="15%" scope="col"></th>
	    <th class="texttable_cinza" width="15%" scope="col"><fmt:message key="label.totalStatusDisponivel" /></th>
		<th class="texttable_cinza" width="16%" scope="col"><fmt:message key="label.totalStatusTransito" /></th>
		<th class="texttable_cinza" width="15%" scope="col"><fmt:message key="label.totalRetirado" /></th>
		<th class="texttable_cinza" width="26%" scope="col"><fmt:message key="label.totalBloqueInsConferenciaIF" /></th>
			</tr>
	 <tr class="dif">
		<td class="texttable_azul" style="background-color: #d7d7d7" ><fmt:message key="label.total" /></td>
		<c:if test="${TotalStatusDisponivel  > 0}">
          <td style="background-color: #d7d7d7"><a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv05&codigoRepresentante=${codigoRepresentante}&tipoProduto=${tipoProduto}&status=1&codigoModelo=&tipoImobilizado=${imobilizado.codigo}"  class="linkazul"><fmt:formatNumber value="${TotalStatusDisponivel}" /></a></td>
        </c:if>
        <c:if test="${TotalStatusDisponivel == 0}">
                <td style="background-color: #d7d7d7"><fmt:formatNumber value="${TotalStatusDisponivel}" /></td>
        </c:if>
        
        <c:if test="${TotalStatusTransito > 0}">
          <td style="background-color: #d7d7d7"><a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv05&codigoRepresentante=${codigoRepresentante}&tipoProduto=${tipoProduto}&status=2&codigoModelo=&tipoImobilizado=${imobilizado.codigo}"  class="linkazul"><fmt:formatNumber value="${TotalStatusTransito}" /></a></td>
        </c:if>
        <c:if test="${TotalStatusTransito == 0}">
           <td style="background-color: #d7d7d7"><fmt:formatNumber value="${TotalStatusTransito}" /></td>          
        </c:if>
        
        <c:if test="${TotalQuantidadeStatusRetirado > 0}">
          <td style="background-color: #d7d7d7"><a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv05&codigoRepresentante=${codigoRepresentante}&tipoProduto=${tipoProduto}&status=3&codigoModelo=&tipoImobilizado=${imobilizado.codigo}"  class="linkazul"><fmt:formatNumber value="${TotalQuantidadeStatusRetirado}" /></a></td>
        </c:if>        
        <c:if test="${TotalQuantidadeStatusRetirado == 0}">
                <td style="background-color: #d7d7d7"><fmt:formatNumber value="${TotalQuantidadeStatusRetirado}" /></td>
        </c:if>
        <c:if test="${TotalQuantidadeStatusBloqueadoInstalacao > 0}">
          <td style="background-color: #d7d7d7"><a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv05&codigoRepresentante=${codigoRepresentante}&tipoProduto=${tipoProduto}&status=4&codigoModelo=&tipoImobilizado=${imobilizado.codigo}"  class="linkazul"><fmt:formatNumber value="${TotalQuantidadeStatusBloqueadoInstalacao}" /></a></td>
        </c:if>
        
        <c:if test="${TotalQuantidadeStatusBloqueadoInstalacao ==0}">
           <td style="background-color: #d7d7d7"><fmt:formatNumber value="${TotalQuantidadeStatusBloqueadoInstalacao}" /></td>
        </c:if>
    </tr>		
	  <c:set var="TotalStatusDisponivel" value="0"></c:set>
	  <c:set var="TotalStatusTransito" value="0"></c:set>
	  <c:set var="TotalQuantidadeStatusRetirado" value="0"></c:set>
	  <c:set var="TotalQuantidadeStatusBloqueadoInstalacao" value="0"></c:set>
   </tbody>
</table>
</c:forEach>
	<input class="button3" type="button" value="<fmt:message key="label.voltar" />" onclick="window.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv01'">

	<div class="pgstabela" style="">
			<input class="button" type="submit" style="" onclick="window.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC38/dv01&codigoRepresentante=${codigoRepresentante}&tipoProduto=${tipoProduto}'" value="<fmt:message key="label.verEstoqueAnalitico" />">
		<input class="button" type="submit" style="" onclick="window.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC39/dv01'" value="<fmt:message key="label.solicitarNovoPedido" />">
	</div>

