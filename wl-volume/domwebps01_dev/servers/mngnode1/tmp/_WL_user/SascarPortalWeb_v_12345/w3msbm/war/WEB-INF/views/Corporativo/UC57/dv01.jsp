<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

  <c:catch var="helper" >
 		<c:import url="/VeiculoAtualizacao/consultarPeriodoCarencia?acao=4&tipoConsulta=C" context="/SascarPortalWeb"  />
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

    <div class="container2"> 
      <ol>
	  </ol>
    </div>	

   	<div class="cabecalho" style="padding-left: 80px;width:890px; padding-left: 65px; *padding-left: 100px;*width:860px;">
		<fmt:message key="label.relatorio.contratosAguardandoReinstalacao" />
		<div class="caminho" style="width: 520px; *width: 500px;*margin-left:0px;"><a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a>&gt; <a href="#" class="linktres"><fmt:message key="label.servicos" /></a> &gt; 
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC57/dv01"  class="linkquatro"><fmt:message key="label.relatorio.contratosAguardandoReinstalacao" /></a>
		</div>
	</div>       
    <c:if test="${not empty listaPeriodoCarencia}">
        <form id="formVeiculosDesatualizados" action="" method="post">
		  <table cellspacing="0" width="850" id="alter"  style="margin-left: 0px;*margin-left:15px;margin-left:15px;">
		    <tr>	
			  <th width="80" class="texttable_cinza"><fmt:message key="label.contrato" /></th>		    		
			  <th width="80" class="texttable_cinza"><fmt:message key="label.produto" /></th>				
			  <th width="80" class="texttable_cinza"><fmt:message key="label.placa" /></th>				
			  <th width="80" class="texttable_cinza"><fmt:message key="label.chassi" /></th>
			  <th width="80" class="texttable_cinza"><fmt:message key="label.retirada" /></th>
			  <th width="80" class="texttable_cinza"><fmt:message key="label.fimCarencia" /></th>
			  <th width="80" class="texttable_cinza"><fmt:message key="label.cobranca" /></th>			
			</tr>			
			<tbody id="listaVeiculosAtualizacao">	
 		      <c:forEach var="contratosItem" items="${listaPeriodoCarencia}" >
			       <tr>		
			         <td><font color="blue">${contratosItem.numeroContrato}</font></td>	     
			         <td>${contratosItem.equipamento.classeEquipamento}</td>
			         <td>${contratosItem.veiculo.placa}</td>
			         <td>${contratosItem.veiculo.chassi}</td>			      
			         <td><fmt:formatDate value="${contratosItem.equipamento.dataRetirada}" pattern="dd/MM/yyyy"/></td>			      
			       <c:if test="${contratosItem.status eq 'Ativa'}">  
			         <td><font color ="red"><fmt:formatDate value="${contratosItem.dataFimVigencia}" pattern="dd/MM/yyyy"/></font></td>			      
			       </c:if>
			       <c:if test="${contratosItem.status eq 'Inativa'}">  
			         <td><fmt:formatDate value="${contratosItem.dataFimVigencia}" pattern="dd/MM/yyyy"/></td>			      
			       </c:if>
			      <td>${contratosItem.status}</td>			      
			     </tr>
		       </c:forEach>		       
			</tbody>			
		</table> 			  
    </form>
  </c:if>
  <c:if test="${empty listaPeriodoCarencia}">
    <div class="busca_cinza" align="center"><fmt:message key="mensagem.informacao.nenhumRegisroEncontrado" /></div>
  </c:if>
 <c:if test="${param.fromUC03 eq 'sim'}"> 
		   <input class="button3" type="button" onclick="window.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC03/dv01'" tabindex="10" value="<fmt:message key="label.voltar" />" style="margin: 10px 0px; margin-left:0px;">    
 </c:if>