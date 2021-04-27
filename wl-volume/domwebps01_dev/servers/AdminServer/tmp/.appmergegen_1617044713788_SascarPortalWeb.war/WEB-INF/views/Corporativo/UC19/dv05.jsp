<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/VisualizarExtratoServicosExecutadosServlet/detalharOrdemServico?acao=4" context="/SascarPortalWeb"  />
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
	<div class="cabecalho2"><fmt:message key="label.extratoServicosExecutados" />
			<div class="caminho" style="*margin-left:260px;">
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" class="linktres"><fmt:message key="label.home" /></a> &gt;  
				<a href="#" class="linktres"><fmt:message key="label.pagamentos" /></a> &gt;   
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC19/dv01" class="linkquatro"><fmt:message key="label.extratoServicosExecutados" /></a>
			</div>
	</div>
	<table cellspacing="0" class="detalhe_extrato">
		<tr class="barraazulzinha">
			<th class="barraazulzinha"><fmt:message key="label.detalhamentoOrdemServico" /></th>
		</tr>
	</table>
	
	<form id="formPesquisa" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Imprimir&page=Corporativo/UC19/dv06" method="post" onsubmit="openPopupPrint(this);" class="filtro">
		<input type="hidden" name="dataInicial" 	 value="${param.dataInicial}" />
		<input type="hidden" name="dataFinal" 		 value="${param.dataFinal}" />
		<input type="hidden" name="codigoInstalador" value="${param.codigoInstalador }" />
		<input type="hidden" name="codigoStatus"	 value="${param.codigoStatus }" />
		<input type="hidden" name="numeroOS" 		 value="${param.numeroOS }" />
		
		<input type="hidden" name="numeroOrdemServicoSelecionada" value="${param.numeroOrdemServicoSelecionada}" />
		<input type="hidden" name="classe" 						  value="${param.classe}" />
		<input type="hidden" name="instalador" 		 			  value="${param.instalador}" />
		<input type="hidden" name="valorTotalOrdemServico" 		  value="${param.valorTotalOrdemServico}" />
		<input type="hidden" name="valorCustoEficiencia" 		  value="${custoEficiencia}"/>
		
	
		<!-- ABRE DIV  div_container_detalha_ordem_servico -->
		<div class="divContainerDetalhaOrdemServico">
		
			<div class="infoOrdemServico">
				<p style="font-size: 16px;"><b><fmt:message key="label.nAbrevOS" />:&nbsp;${param.numeroOrdemServicoSelecionada}</b></p>
				<p><b><fmt:message key="label.classe" />:</b>&nbsp;${param.classe}</p>
				<p><b><fmt:message key="label.instalador" />:</b>&nbsp;${param.instalador}</p>
			</div>
			<!-- ABRE DIV TOTAIS ORDEM SERVICO -->
			<div class="totaisOrdemServico" id="totaisOrdemServico">

				<table cellpadding="2" id="alter_extrato" cellspacing="0" width="100%">
					<tbody>	 
						<tr class="dif">
							<td width="50%" ><fmt:message key="label.valortotalOS" /> :</td>
							<td width="50%" ><fmt:formatNumber value="${valorTotalServico}" type="currency" /></td>
						</tr>
						<tr>
							<td width="50%" ><fmt:message key="label.deslocamento" /> :</td>
							<td width="50%" ><fmt:formatNumber value="${quantidadeDeslocamento}" /> Km</td>
						</tr>
						<tr class="dif">
							<td width="50%" ><fmt:message key="label.valorDeslocamento" /> :</td>
							<td width="50%" ><fmt:formatNumber value="${valorDeslocamento * quantidadeDeslocamento} " type="currency"/></td>
						</tr>
						<tr>
							<td width="50%" ><fmt:message key="label.pedagio" /> :</td>
							<td width="50%" ><fmt:formatNumber value="${valorPedagio}" type="currency" /></td>
						</tr>
						<tr class="dif">
							<td width="50%" ><fmt:message key="label.custoEficienciaOperacional" /> :</td>
							<td width="50%" ><fmt:formatNumber value="${custoEficiencia}" type="currency" /></td>
						</tr>
						<tr>
							<td width="50%" ><fmt:message key="label.valorTotalOrdemServico" /> :</td>
							<c:set var="totais" value="${ordemServico.valorServico + (ordemServico.valorDeslocamento * ordemServico.quantidadeDeslocamento) + ordemServico.valorPedagio + custoEficiencia}"></c:set>
							<td width="50%" ><fmt:formatNumber value="${valorTotalServico + (quantidadeDeslocamento *  valorDeslocamento) + valorPedagio + custoEficiencia}" type="currency" /></td>
						</tr>
					</tbody>

				</table>
				
			</div>
			<!-- FECHA DIV TOTAIS ORDEM SERVICO -->
			
			<!-- ABRE DIV MOTIVOS -->
			<div class="motivosOrdemServico" id="motivosOrdemServico">
				
				<table cellpadding="2" id="alter_extrato" cellspacing="0" width="100%">
					<thead>
						<tr>
							<th width="70%" ><fmt:message key="label.Motivo" /></th>
							<th width="30%" ><fmt:message key="label.valorServico" /></th>
						</tr>
					</thead>
					
					<c:forEach var="ordemServico" items="${ordensServico}" varStatus="status">
						<tbody>	 
							<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if>>
								<td width="70%">${ordemServico.observacao}</td>
								<td width="30%" style="text-align: center;"><fmt:formatNumber value="${ordemServico.valorServico}" type="currency" /></td>
							</tr>
						</tbody>
					</c:forEach>
						
				</table>
			
			</div>
			<!-- FECHA DIV MOTIVOS -->
			
			<div style="clear:both;"></div>
					
		</div>
		<!-- FECHA DIV  div_container_detalha_ordem_servico -->
		
		<div class="pgstabela">
				<input type="submit" class="button" value="<fmt:message key="label.imprimir" />" tabindex="5"/>
		</div>
	
	</form>
	
	<form method="post" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC19/dv03&
																										vtOS=${param.vtOS}&
																										vtPend=${param.vtPend}&
																										vtTestes=${param.vtTestes}&
																										vtOCred=${param.vtOCred }&
																										vtDesc=${param.vtDesc }&
																										vtLiq=${param.vtLiq }&																									
																										vtNf=${param.vtNf}">
		<input type="hidden" name="dataInicial" 	 value="${param.dataInicial}" />
		<input type="hidden" name="dataFinal" 		 value="${param.dataFinal}" />
		<input type="hidden" name="codigoInstalador" value="${param.codigoInstalador }" />
		<input type="hidden" name="codigoStatus"	 value="${param.codigoStatus }" />
		<input type="hidden" name="numeroOS" 		 value="${param.numeroOS}" />
		<input type="hidden" name="valorCustoEficiencia" value="${param.valorCustoEficiencia}"/>
		<input type="hidden" name="tipoPesquisa" value="${param.tipoPesquisa}" >
				
		<input type="submit" class="button3"  tabindex="4" value="<fmt:message key="label.voltar" />" style="margin-bottom:20px;*position:relative;" />
	</form>
	
	<br clear="all"/>
       
	<div class="clear:both"></div>