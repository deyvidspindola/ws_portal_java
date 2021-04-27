<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/ListarAgendaInstalador/consultarAgendaInstalador?acao=2" context="/SascarPortalWeb"  />
</c:catch>

<c:if test="${not empty helper}" >
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>

<jsp:include page="/WEB-INF/views/Corporativo/UC52/dv01.jsp" />

<c:if test="${not empty agendas}">

	<h1><fmt:message key="label.resultadoDaBusca" /></h1>
	
	<span class="texthelp2">
		<img hspace="5" height="16" align="absmiddle" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png">
		<fmt:message key="label.cliqueOrdemServicoVisualizarDetalhes" />
	</span>

	<c:forEach var="agenda" items="${agendas}" varStatus="status">
 
    <c:if test="${agenda.tipoAgenda eq 'PS'}">
     <table id="alter" width="89%" cellspacing="0" style="empty-cells: show; border-collapse: collapse;" > 
		    <tr>
			  <td class="texttable_cinza" style="background-color: rgb(102, 153, 204); text-align: left; color: rgb(255, 255, 255); padding-left: 15px;" colspan="2">
		 	    <span class="texttable_cinza" style="background-color: rgb(102, 153, 204); text-align: left; color: rgb(255, 255, 255); padding-left: 15px;"><fmt:message key="label.prestadorServico" /></span>
		   	  </td>
			  <td class="texttable_azul"  height="28" style="background-color: rgb(235, 235, 235);" colspan="7">${agenda.nomeRepresentante} </td>
		    </tr>	
		    <tr>
		 	  <th class="texttable_cinza" width="11%"><fmt:message key="label.horarioAtendimento" /></th>
			  <th class="texttable_cinza" width="10%"><fmt:message key="label.numeroDaOS" /></th>
			  <th class="texttable_cinza" width="10%"><fmt:message key="label.tipoServico" /></th>
			  <th class="texttable_cinza" width="10%"><fmt:message key="label.placa" /></th>
			  <th class="texttable_cinza" width="16%"><fmt:message key="label.cliente" /></th>
			  <th class="texttable_cinza" width="20%"><fmt:message key="label.endInstalacao" /></th>
			  <th class="texttable_cinza" width="16%"><fmt:message key="label.cidade" /> <fmt:message key="label.uf" /></th>
			  <th class="texttable_cinza" width="15%"><fmt:message key="label.instalador" /></th>
		    </tr>
	
		<c:forEach var="horario" items="${agenda.horariosAgendamentoOrdemServico}" varStatus="status">
	
			<c:if test="${horario.tipo eq 'PS' }">
		    	<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if>>
						<td class="camposinternos" style="border 1px solid;">
							<c:if test="${horario.clienteEspecial eq 't' }">
								<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/especial_icon.png" width="16" height="16" border="0" />
								<br>
							</c:if>
							<c:if test="${horario.osaemergencial eq 't' }">
								<font color="RED"><fmt:message key="uc52.texto.002.atendimentoEmergencial" /></font>
							</c:if>
							<c:if test="${horario.osaemergencial ne 't' }">
								${horario.hora_inicial}
								&nbsp;<fmt:message key="uc52.texto.001.as" />&nbsp;
								${horario.hora_final}
							</c:if>
						</td>
		
						<td class="camposinternos">
						  <a class="linkazul" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC43/dv06&numeroOrdemServico=${horario.numeroOrdemServico}&codCliente=${horario.clienteCodigo}&dataInicial=${param.dataInicial}&codigoInstalador=${param.codigoInstalador}&nome_instalador=${param.nome_instalador}&UC52=S">${horario.numeroOrdemServico}</a>
			            </td>    
			             
			              <td class="camposinternos">${horario.tipoOS}</td>
						  <td class="camposinternos">${horario.placaVeiculoAgendamento}</td>
						  <td class="camposinternos">${horario.clienteAgendamento}</td>
						  <td class="camposinternos">${horario.enderecoServico}</td>
						  		 <c:choose>
						 	<c:when test="${not empty horario.cidadeServico && not empty horario.ufServico }">
						 	  <td class="camposinternos">${horario.cidadeServico} / ${horario.ufServico}</td>
						 	</c:when>
						 	<c:otherwise>
						 	 <td class="camposinternos">${horario.cidadeServico}  ${horario.ufServico}</td>
						 	</c:otherwise>
						 </c:choose>
						 
						
						 <c:choose>
						 	<c:when test="${empty horario.nomeInstalador}">
						 	 <td class="camposinternos"><fmt:message key="label.nRoterizacao" /></td> 	
						 	</c:when>
						 	<c:otherwise>
						 	<td class="camposinternos" nowrap="nowrap">${horario.nomeInstalador}</td> 	
						 	</c:otherwise>
						 </c:choose>
						 	
					  </tr>		
		    </c:if>       
		</c:forEach>   
	</c:if>	
		
	<c:if test="${agenda.tipoAgenda eq 'TC'}">	
   	  <table id="alter" width="89%" cellspacing="0" style="empty-cells: show; border-collapse: collapse;" >
		    <tr>
			  <td class="texttable_cinza" style="background-color: rgb(102, 153, 204); text-align: left; color: rgb(255, 255, 255); padding-left: 15px;" colspan="2">
		 	    <span class="texttable_cinza" style="background-color: rgb(102, 153, 204); text-align: left; color: rgb(255, 255, 255); padding-left: 15px;"><fmt:message key="label.instalador" /></span>
		   	  </td>
			  <td class="texttable_azul"  height="28" style="background-color: rgb(235, 235, 235);" colspan="7">${agenda.nomeInstalador} </td>
		    </tr>	
		    <tr>
		 	  <th class="texttable_cinza" width="10%"><fmt:message key="label.horarioAtendimento" /></th>
			  <th class="texttable_cinza" width="9%"><fmt:message key="label.numeroDaOS" /></th>
			  <th class="texttable_cinza" width="10%"><fmt:message key="label.tipoServico" /></th>
			  <th class="texttable_cinza" width="10%"><fmt:message key="label.placa" /></th>
			  <th class="texttable_cinza" width="16%"><fmt:message key="label.cliente" /></th>
			  <th class="texttable_cinza" width="19%"><fmt:message key="label.endInstalacao" /></th>
			  <th class="texttable_cinza" width="12%"><fmt:message key="label.cidade" /></th>
			  <th class="texttable_cinza" width="20%"><fmt:message key="label.uf" /></th>
		    </tr>		  
		
		    <c:set var="codigoInstalador" value="${agenda.codigoInstalador}"></c:set>
		    
		    <c:set var="entrouLista" value="0"></c:set>
		    <c:forEach var="horario" items="${agenda.horariosAgendamentoOrdemServico}" varStatus="status">	

	   			  <c:set var="entrouLista" value="1"></c:set>
	   	
				  <tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if>>
					<td class="camposinternos" style="border 1px solid;">
						<c:if test="${horario.clienteEspecial eq 't' }">
							<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/especial_icon.png" width="16" height="16" border="0" />
							<br>
						</c:if>
						<c:if test="${horario.osaemergencial eq 't' }">
							<font color="RED"><fmt:message key="uc52.texto.002.atendimentoEmergencial" /></font>
						</c:if>
						<c:if test="${horario.osaemergencial ne 't' }">
							${horario.hora_inicial}
							&nbsp;<fmt:message key="uc52.texto.001.as" />&nbsp;
							${horario.hora_final}
						</c:if>
					</td>
					
		          <c:if test="${horario.horarioDisponivel == false  and not empty horario.numeroOrdemServico }">
		          
		        
		         
	    			<td class="camposinternos">
					  <a class="linkazul" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC43/dv06&numeroOrdemServico=${horario.numeroOrdemServico}&codCliente=${horario.clienteCodigo}&dataInicial=${param.dataInicial}&codigoInstalador=${param.codigoInstalador}&nome_instalador=${param.nome_instalador}&UC52=S">${horario.numeroOrdemServico}</a>
		            </td>    
		       
		              <td class="camposinternos">${horario.tipoOS}</td>
					  <td class="camposinternos">${horario.placaVeiculoAgendamento}</td>
					  <td class="camposinternos">${horario.clienteAgendamento}</td>
					  <td class="camposinternos">${horario.enderecoServico}</td>
					  <td class="camposinternos">${horario.cidadeServico}</td>
					  <td class="camposinternos">${horario.ufServico}</td>
			
				
				
				   </c:if>	
				   <c:if test="${horario.horarioDisponivel == false and empty horario.numeroOrdemServico }">
					  <td class="camposinternos">
					    <fmt:message key="label.indisponivel" />
		              </td>             
		              <td class="camposinternos"></td>
					  <td class="camposinternos"></td>
					  <td class="camposinternos"></td>
					  <td class="camposinternos"></td>
					  <td class="camposinternos"></td>
					  <td class="camposinternos">${horario.ufServico}</td>
				   </c:if>	
				   <c:if test="${horario.horarioDisponivel == true}">
					  <td class="camposinternos"></td>             
		              <td class="camposinternos"></td>
					  <td class="camposinternos"></td>
					  <td class="camposinternos"></td>
					  <td class="camposinternos"></td>
					  <td class="camposinternos"></td>
					  <td class="camposinternos">${horario.ufServico}</td>
					    </tr>	
			 		</c:if>		

		    </c:forEach>
		    <c:if test="${entrouLista eq '0' }">
   				<tr>
   					<td colspan="8"><b><fmt:message key="uc52.texto.003.naoExisteAgendamento" /></b></td>
   				</tr>
   			</c:if>   			 		    
   </c:if>	
 
	    

     </table>
	     
   </c:forEach>
	    
	     <div class="pgstabela">	
            <input class="button3" type="button" onclick="window.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC52/dv01'" tabindex="10" value="<fmt:message key="label.voltar" />" style="margin: 10px 0px; margin-left:0px; *margin-left:-97px;">
	     </div>
	     <div style="clear:both"></div> 		
</c:if>	
	
