<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

 <c:catch var="helper" >
	<c:import url="/ConsultarEstoqueAnalitico/consultarEstoqueAnalitico?acao=1" context="/SascarPortalWeb"  />
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
<div class="cabecalho2"><fmt:message key="label.consultarEstoqueAnalitico" />
			<div class="caminho">
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" class="linktres"><fmt:message key="label.home" /></a> &gt;  
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv01" class="linktres"><fmt:message key="label.servicos" /></a> &gt;   
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv01" class="linkquatro"><fmt:message key="label.consultarEstoqueAnalitico" /></a>
			</div>
		</div>	
	<!-- div class="cabecalho">
	
		<div class="caminho" style="">
			<a class="linktres" title="Home" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}">Home</a>
			&gt;
			<a class="linktres" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv01">Serviços</a>
			&gt;
			<a class="linkquatro" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv01">Consultar Estoque
			  <strong>Analítico</strong>
			</a>
		</div>
		
		Consultar Estoque
		<strong>Analítico</strong>
		
	</div-->
	
	<%int countItem=0; %>   
	<c:forEach items="${listaGrupoImobilizado}" var="grupoItemImobilizado">
	<table class="detalhe" cellspacing="0">      
		<tbody>		
			<tr class="barraazulzinha">
				<th class="barraazulzinha"> ${grupoItemImobilizado.descricao }</th>
			</tr>
		</tbody>
	</table>
	
	<table id="alter" cellspacing="0" cellpadding="1" width="850">
		<tbody>
		<% int flag = 1;%>  
		<c:forEach  items="${grupoItemImobilizado.produtos}" var="itemImobilizado" varStatus="contador">			 	
			 
			<%  if (flag == 1){ %>
			
			 	<c:if test="${not empty itemImobilizado.serieImobilizado}">
			 	  <th class="texttable_azul" width="28%" title="<fmt:message key="label.dataAberturaServico" />" scope="col" id="serie" ><fmt:message key="label.serie" /></th>
			    </c:if>
			    
			    <c:if test="${not empty itemImobilizado.descricaoItemImobilizado}">
				  <th class="texttable_azul" width="28%" title="<fmt:message key="label.dataAberturaServico" />" scope="col" id="serie" ><fmt:message key="label.descricao" /></th>
				</c:if>		
					
				<c:if test="${not empty  itemImobilizado.versaoImobilizado}">
			 	  <th class="texttable_cinza" width="15%" scope="col"><fmt:message key="label.versao" /></th>
			    </c:if>	
					
			    <c:if test="${not empty  itemImobilizado.numeroPatrimonioImobilizado}">
			 	  <th class="texttable_cinza" width="15%" scope="col"><fmt:message key="label.patrimonio" /></th>
			    </c:if>	
			    
			     <c:if test="${not empty  itemImobilizado.modeloImobilizado}">
			 	  <th class="texttable_cinza" width="15%" scope="col"><fmt:message key="label.modelo" /></th>
			    </c:if>	
			    
			    <c:if test="${not empty  itemImobilizado.statusImobilizado}">
			 	  <th class="texttable_cinza" width="15%" scope="col"><fmt:message key="label.Status" /></th>
			    </c:if>	
			
 		   <% } %>
 		   			
		    <tr class="dif">		    
				<c:if test="${not empty itemImobilizado.serieImobilizado }">
      		  	  <td class="linkazulescuro">${itemImobilizado.serieImobilizado}</td>
				</c:if>			
				
				<c:if test="${not empty itemImobilizado.descricaoItemImobilizado }">
				  <td class="linkazulescuro">${itemImobilizado.descricaoItemImobilizado}</td>
				</c:if>	
				
				<c:if test="${not empty itemImobilizado.versaoImobilizado }">
      			  <td> ${itemImobilizado.versaoImobilizado}</td>
      			</c:if> 	          
	          
				<c:if test="${not empty itemImobilizado.numeroPatrimonioImobilizado}">
				  <td> ${itemImobilizado.numeroPatrimonioImobilizado}</td>
	            </c:if>	            
	            
				<c:if test="${not empty itemImobilizado.modeloImobilizado }">
				  <td> ${itemImobilizado.modeloImobilizado} </td>	
			    </c:if>	
	          
	            <c:if test="${not empty itemImobilizado.statusImobilizado }">
				  <td> ${itemImobilizado.statusImobilizado}</td>
				</c:if>  								
		    </tr>
			<%countItem++; %>
			<%flag = 0; %>		
			</c:forEach>			
	</table>	
		<table cellspacing="0" cellspacing="0" cellpadding="1" width="850">      
		<tbody>		
			<tr>
				<td class="linkazulescuro" width="12%" style="font-weight: bold; background-color: rgb(215, 215, 215); text-align: left;"><fmt:message key="label.quantidade" />:</td>
				<td width="88%" style="text-align: left; background-color: rgb(215, 215, 215); font-weight: bold;"><%= countItem %></td>			
			</tr>	
		</tbody>
	</table>
	<%countItem = 0; %>			 
	</c:forEach>
	<input id="" class="button3" type="button" onclick="window.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv02&tipoProduto=${tipoProduto}&listarRepresentanteEstoque=${codigoRepresentante}'" value="<fmt:message key="label.voltar" /> " name="button2">
		
	<div class="pgstabela" style="">
	</div>