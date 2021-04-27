<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/VerificarPermissao/consultarHistoricoContato?acao=2" context="/SascarPortalWeb"  />
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

    <jsp:include page="/WEB-INF/views/Corporativo/UC48/dv02.jsp"/>
			
 <c:if test="${not empty historicos}" > 
 	  <h1><fmt:message key="label.resultadoDaBusca" />:</h1>
        <form id="formHistoricos" action="" method="post">
		  <table cellspacing="0" width="280" id="alter"  style="margin-left: 97px;">
			<tr>	
				<th width="100" class="texttable_cinza"><fmt:message key="label.numeroProtocoloFaleConosco" /></th>				
			    <th width="120" class="texttable_cinza"><fmt:message key="label.Status" /></th>
			</tr>
			<tbody id="listaVeiculosAtualizacao">	
			  <c:forEach var="historico" items="${historicos}" >
			    <tr>			
			      <td>${historico.numeroProtocolo}</td>
			      <td>${historico.situacaoRegistrada}</td>
		        </tr>		       	       
		     </c:forEach>		   		    
			</tbody>			
		</table> 
			<div style="clear: both"></div> 
	  </form>  
      <input class="button3" type="button" value="<fmt:message key="label.voltar" />" onclick="window.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC48/dv02'">
 </c:if>  
<div class="busca_branca"></div>
<div class="busca_branca"></div>