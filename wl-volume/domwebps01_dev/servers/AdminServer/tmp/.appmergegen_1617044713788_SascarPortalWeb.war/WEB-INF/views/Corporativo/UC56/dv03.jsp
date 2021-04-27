<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

  <c:catch var="helper" >
 		<c:import url="/VeiculoAtualizacao/consultarVeiculosDesatualizados?acao=1&periodo=${param.periodo}" context="/SascarPortalWeb"  />
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

    <jsp:include page="/WEB-INF/views/Corporativo/UC56/dv02.jsp"/>
			
    <c:if test="${not empty listaVeiculosDesatualizados}">
 	  <h1><fmt:message key="label.resultadoDaBusca" />:</h1>
        <form id="formVeiculosDesatualizados" action="" method="post">
		  <table cellspacing="0" width="850" id="alter"  style="margin-left: 15px;">
			<tr>	
				<th width="0" class="texttable_cinza"><fmt:message key="label.placa" /></th>				
				<th width="0" class="texttable_cinza"><fmt:message key="label.dataUltimaAtualizacao" /></th>				
				<th width="0" class="texttable_cinza"><fmt:message key="label.enderecoUltimaAtualizacao" /></th>
				<th width="0" class="texttable_cinza"><fmt:message key="label.tipoDeContato" /></th>
				<th width="0" class="texttable_cinza"><fmt:message key="label.motivoAtualizado" /></th>	
				<th width="0" class="texttable_cinza"><fmt:message key="label.dataAtualizacao" /></th>				
			</tr>
			<tbody id="listaVeiculosAtualizacao">	
			  <c:forEach var="veiculo" items="${listaVeiculosDesatualizados}" >
			    <tr>			
			      <td>${veiculo.placa}</td>
			      <td><fmt:formatDate value="${veiculo.dataUltimaAtualizacao}" pattern="dd/MM/yyyy HH:mm"/></td>
			      <td>${veiculo.contrato.contratante.endereco.descricaoLogradouro}</td>
			      <td>${veiculo.contrato.tipoContrato }</td>
			      <td>${veiculo.contrato.motivo.descricaoMotivo}</td>
			      <td><fmt:formatDate value="${veiculo.dataAtualizacao}" pattern="dd/MM/yyyy HH:mm"/></td>
		        </tr>		       	       
		     </c:forEach>		   		    
			</tbody>			
		</table>  
	  </form>  
      <input class="button3" type="button" value="<fmt:message key="label.voltar" />" onclick="window.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC56/dv02'">
   </c:if>
