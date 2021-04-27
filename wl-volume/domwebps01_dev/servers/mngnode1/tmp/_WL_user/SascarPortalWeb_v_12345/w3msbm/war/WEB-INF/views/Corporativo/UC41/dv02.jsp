<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>
<c:catch var="helper" >
	<c:import url="/ConsultarRemessaEstoque/consultarRemessaEstoque?acao=1" context="/SascarPortalWeb"  />
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

<jsp:include page="/WEB-INF/views/Corporativo/UC41/dv01.jsp" />

  <c:if test="${ not empty remessasEstoque}">
	<h1 style="margin-top: 40px;"><fmt:message key="label.resultadoDaBusca" /></h1>

	<span class="texthelp2">
		<img hspace="5" height="16" align="absmiddle" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png">
		<fmt:message key="label.cliqueRemessaVisualizarDetalhes" />
	</span>


	<table id="alter" cellspacing="0px" cellpadding="1px" width="920" style="margin: 10px 0px; margin-left:20px;">
		<tbody>
			<tr>
				<td class="texttable_azul" height="28" style="background-color: rgb(235, 235, 235);" colspan="2">&nbsp;</td>
				<td class="texttable_azul" style="background-color: rgb(45, 115, 173); text-align: left; color: rgb(255, 255, 255); padding-left: 15px; height: 30px;" colspan="2">
					<span class="texttable_azul" style="background-color: rgb(45, 115, 173); text-align: left; color: rgb(255, 255, 255); padding-left: 15px; height: 30px;"><fmt:message key="label.remetente" /></span>
				</td>
				<td class="texttable_cinza" style="background-color: rgb(102, 153, 204); text-align: left; color: rgb(255, 255, 255); padding-left: 15px;" colspan="2">
					<span class="texttable_cinza" style="background-color: rgb(102, 153, 204); text-align: left; color: rgb(255, 255, 255); padding-left: 15px;"><fmt:message key="label.destinatario" /></span>
				</td>
				<td class="texttable_azul" style="background-color: rgb(235, 235, 235);" colspan="4">&nbsp;</td>
			</tr>
			<tr>
				<td class="texttable_azul" height="28" width="56" style="background-color: rgb(235, 235, 235);"><fmt:message key="label.data" /></td>
				<td class="texttable_cinza" width="91" style="background-color: rgb(235, 235, 235);"><fmt:message key="label.numRemessa" /></td>
				<td class="texttable_cinza" width="170" style="background-color: rgb(235, 235, 235);"><fmt:message key="label.representanteResponsavel" /></td>
				<td class="texttable_cinza" width="137" style="background-color: rgb(235, 235, 235);"><fmt:message key="label.representanteEstoque" /></td>
				<td class="texttable_cinza" width="172" style="background-color: rgb(235, 235, 235);"><fmt:message key="label.representanteResponsavel" /></td>
				<td class="texttable_cinza" width="138" style="background-color: rgb(235, 235, 235);"><fmt:message key="label.representanteEstoque" /></td>
				<td class="texttable_azul" width="91" style="background-color: rgb(235, 235, 235);"><fmt:message key="label.Status" /></td>
				<td class="texttable_cinza" width="87" style="background-color: rgb(235, 235, 235);"><fmt:message key="label.usuario" /></td>
				<td class="texttable_cinza" width="87" style="background-color: rgb(235, 235, 235);"><fmt:message key="label.nfRemessa" /></td>
				<td class="texttable_cinza" width="87" style="background-color: rgb(235, 235, 235);"></td>
				
			</tr>
			<% int countRemessa = 0; %>
		    <c:forEach  items="${remessasEstoque}" var="remessaEstoque" varStatus="contador">		  
			<tr>
				<td class="linkazulescuro"> ${remessaEstoque.dataRemessa}</td>
				<td> 
					<a class="linkazul" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC41/dv03&statusRemessaField=${param.statusRemessaField}&numeroRemessaField=${param.numeroRemessaField}&numeroRemessaF=${remessaEstoque.numeroRemessa}&statusRemessa=${remessaEstoque.statusRemessa}&dataInicialPesquisa=${param.dataInicialPesquisa}&dataFinalPesquisa=${param.dataFinalPesquisa}">${remessaEstoque.numeroRemessa}</a>
				</td>
				<td>${remessaEstoque.representante.remetenteReprResponsavel}</td>
				<td>${remessaEstoque.representante.remetenteReprEstoque}</td>
				<td>${remessaEstoque.representante.descricaoRepresentanteEstoqueDestinatario}</td>
				<td>${remessaEstoque.representante.destinatarioReprEstoque}</td>				
				<td class="linkazulescuro">${remessaEstoque.statusRemessa}</td>
				<td>${remessaEstoque.representante.nome}</td>
				<td>${remessaEstoque.nfRemessa}</td>
				<c:choose>
  				<c:when test="${not empty remessaEstoque.imprimirNF}">
			  		 <td> <a href="${remessaEstoque.imprimirNF}" target="_blank"><img hspace="5" height="16" align="absmiddle" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo/ico_imprimir.png"></a></td>
			   	 </c:when>
				  <c:otherwise>
				    <td></td>
				 </c:otherwise>
				</c:choose>
			</tr>
			<%countRemessa++; %>			
			</c:forEach>
		</tbody>
	</table>
	<table class="detalhe2" cellspacing="3" width="100%" style="margin: 10px 0px; margin-left:17px;">
		<tbody>
			<tr>
				<th class="barracinza" width="209"><fmt:message key="label.quantidade" /></th>
				<td class="camposinternos" width="358"><%=countRemessa %></td>
				<th class="camposinternos" width="200">&nbsp;</th>
				<td class="camposinternos" width="350">&nbsp;</td>
			</tr>
		</tbody>		
	</table>
	  <input class="button3" type="button" onclick="window.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC41/dv01&numeroRemessa='" tabindex="10" value="<fmt:message key="label.voltar" />" style="margin: 10px 0px; margin-left:17px;">
	  <div style="clear:both"></div> 
      <br /> 
  </c:if>