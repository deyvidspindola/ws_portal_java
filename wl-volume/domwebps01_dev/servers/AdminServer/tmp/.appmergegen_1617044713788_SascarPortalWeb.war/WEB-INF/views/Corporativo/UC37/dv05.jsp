<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>
 <c:catch var="helper" >
	<c:import url="/ConsultarEstoqueSintetico/consultarDetalheImobilizado?acao=4" context="/SascarPortalWeb"  />
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


<script type="text/javascript">

		
</script>
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
			<a class="linkquatro" href=${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv01">Consultar Estoque Sintético</a>
		</div>
		
		Consultar Estoque Sintéticoo
		
	</div-->


	<!-- div class="barraatualizacao_antiga">
		<div class="titleatualizacao_1_antiga">Imobilizados</div>
		<div class="titleatualizacao_2_antiga">
			<a class="link_titleatualizacao tooltip" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv04" title="Inclua contatos autorizados e responsáveis para instalação, assistência e retirada do rastreador">Materiais</a>
		</div>
	</div-->


	<table class="detalhe" cellspacing="0">
		<tbody>
			<tr class="barraazulzinha">
				<th class="barraazulzinha">${nomeImobilizado} </th>
			</tr>
		</tbody>
	</table>


	<table class="detalhe2" cellspacing="3" width="960px;" style="margin-right: 10px; float: left;">
		<tbody>
			<tr>
				<th class="barracinza" width="200"><fmt:message key="label.nomeImobilizado" />:</th>
				<td class="camposinternos" width="200">${nomeImobilizado}</td>
				<th class="barracinza" width="200"> <fmt:message key="label.Status" />:</th>
				<td class="camposinternos" width="200"> 
                  <c:if test="${param.status == 4}"><fmt:message key="label.conferenciaIF" /></c:if> 
				  <c:if test="${param.status == 3}"><fmt:message key="label.statusRetirado" /></c:if> 
				  <c:if test="${param.status == 2}"><fmt:message key="label.statusTransito" /></c:if> 
				  <c:if test="${param.status == 1}"><fmt:message key="label.statusDisponivel" /></c:if>				


              </td>
			</tr>
		</tbody>
	</table>


<p> </p>
 <c:forEach  items="${listaImobilizados}" var="imobilizado" varStatus="contador">
              <c:if test="${not empty imobilizado.versaoImobilizado}">
                <c:set var="flagVersao" value="1"></c:set>
              </c:if>
              <c:if test="${not empty imobilizado.serieImobilizado}">
                <c:set var="serieImobilizado" value="1"></c:set>
              </c:if>
              <c:if test="${not empty imobilizado.operadora.descricao}">
                <c:set var="operadoraDescricao" value="1"></c:set>
              </c:if>
              <c:if test="${not empty imobilizado.numeroPatrimonioImobilizado}">
                <c:set var="numeroPatrimonioImobilizado" value="1"></c:set>
              </c:if>
              <c:if test="${not empty imobilizado.modeloImobilizado}">
                <c:set var="modeloImobilizado" value="1"></c:set>
              </c:if>
              <c:if test="${not empty imobilizado.descricaoProduto}">
                <c:set var="descricaoProduto" value="1"></c:set>
              </c:if>              
 </c:forEach>

	<table id="alter" cellspacing="0" cellpadding="1" width="850">
		<tbody>
		 <% int flag = 1;%>  	
		 <c:set var="TotalImobilizados" value="0"></c:set>	
         <c:forEach  items="${listaImobilizados}" var="imobilizado" varStatus="contador">
           
           <%  if (flag == 1){ %>		
			     <c:if test="${serieImobilizado  eq '1'}">	
				   <th class="texttable_azul" width="28%" title="Data da abertura do serviço" scope="col"><fmt:message key="label.serie" /></th>
			     </c:if>	 
		         <c:if test="${not empty imobilizado.versaoImobilizado}">
			         <th class="texttable_cinza" width="15%" scope="col"><fmt:message key="label.versao" /></th>				
				 </c:if>
				 <c:if test="${operadoraDescricao  eq '1'}">
				     <th class="texttable_cinza" width="16%" scope="col"><fmt:message key="label.operadora" /></th>		  			  
				 </c:if>
				 <c:if test="${numeroPatrimonioImobilizado  eq '1'}">
				     <th class="texttable_cinza" width="15%" scope="col"><fmt:message key="label.numeroDoPatrimonio" /></th>
				 </c:if>
				 <c:if test="${descricaoProduto  eq '1'}">
				     <th class="texttable_cinza" width="15%" scope="col"><fmt:message key="label.produto" /></th>
				 </c:if>
				 <c:if test="${modeloImobilizado  eq '1'}">
				     <th class="texttable_cinza" width="15%" scope="col"><fmt:message key="label.modelo" /></th>
			     </c:if>  			      
	       <%} %>
			<tr class="dif" style="background-color: rgb(255, 255, 255);">
			
			<c:if test="${serieImobilizado  eq '1'}">
			       <td class="linkazulescuro" style="background-color: rgb(255, 255, 255);"> ${imobilizado.serieImobilizado}</td>
			</c:if>
			 <c:if test="${flagVersao  eq '1'}">	
				   <td style="background-color: rgb(255, 255, 255);"> ${imobilizado.versaoImobilizado} </td>
			</c:if>
			<c:if test="${operadoraDescricao  eq '1'}">
				   <td style="background-color: rgb(255, 255, 255);"> ${imobilizado.operadora.descricao} </td>
			</c:if>	
			<c:if test="${numeroPatrimonioImobilizado  eq '1'}">
				  <td style="background-color: rgb(255, 255, 255);"> ${imobilizado.numeroPatrimonioImobilizado}</td>
	   		</c:if>
	   		<c:if test="${descricaoProduto  eq '1'}">
	   			  <td style="background-color: rgb(255, 255, 255);"> ${imobilizado.descricaoProduto}</td>
			</c:if>
			<c:if test="${modeloImobilizado  eq '1'}">
				  <td style="background-color: rgb(255, 255, 255);"> ${imobilizado.modeloImobilizado}</td>
			   
			</c:if>  
				
			</tr>
		    <c:set var="TotalImobilizados" value="${TotalImobilizados + 1}"></c:set>
		    <%flag = 0; %>		
         </c:forEach>
		</tbody>
	</table>	
	<table id="alter" cellspacing="0" cellpadding="1" width="850">
		<tbody>
			<tr class="dif">
				<td class="linkazulescuro" width="35%" style="font-weight: bold; background-color: rgb(215, 215, 215); text-align: right;"><fmt:message key="label.quantidadeTotal" />:</td>
				<td width="65%" style="text-align: left; background-color: rgb(215, 215, 215); font-weight: bold;">${TotalImobilizados}</td>
			</tr>
		</tbody>
	</table>	
	

<input id="" class="button3" type="reset" onclick="window.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv02&tipoProduto=${tipoProduto}&listarRepresentanteEstoque=${codigoRepresentante}'" value="<fmt:message key="label.voltar" />" name="button2">

	<div class="pgstabela" style="">
	</div>
