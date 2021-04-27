<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/VisualizarExtratoServicosExecutadosServlet/recuperarExtratoDetalhado?acao=3&" context="/SascarPortalWeb"  />
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
		
	<table cellspacing="0" class="detalhe_extrato">
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.servicosExecutados" />
					<span class="texthelp3" style="margin-right:20px;margin-top:5px;">
						<fmt:message key="label.legendaParaStatus" />: <img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/status_A.png" width="16" height="16"  /><fmt:message key="label.entregue" />
						<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/status_P.png" width="16" height="16"/><fmt:message key="label.pendente" />
					    <img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/statusServico_I.png" width="16" height="16"/><fmt:message key="label.incompleto" />
					</span>
				</th>
			</tr>
	</table>
	
	<div class="cabecalho2"><fmt:message key="label.extratoServicosExecutados" />
		<div class="caminho" style="*margin-left:260px;">
	 	  <a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" class="linktres"><fmt:message key="label.home" /></a> &gt;  
		  <a href="#" class="linktres"><fmt:message key="label.pagamentos" /></a> &gt;   
		  <a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC19/dv01" class="linkquatro"><fmt:message key="label.extratoServicosExecutados" /></a>
		</div>
	</div>	

	<form id="formPesquisa" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Imprimir&page=Corporativo/UC19/dv04&vtOS=${param.vtOS}&vtPend=${param.vtPend}&vtTestes=${param.vtTestes}&vtOCred=${param.vtOCred}&vtDesc=${param.vtDesc}&vtLiq=${param.vtLiq}&vtNf=${param.vtNf}" method="post" onsubmit="openPopupPrint(this);" class="filtro">
	
		<input type="hidden" name="dataInicial" 	 value="${param.dataInicial}" />
		<input type="hidden" name="dataFinal" 		 value="${param.dataFinal}" />
		<input type="hidden" name="codigoInstalador" value="${param.codigoInstalador }" />
		<input type="hidden" name="codigoStatus"	 value="${param.codigoStatus }" />
		<input type="hidden" name="numeroOS" 		 value="${param.numeroOS }" />
	
		<table cellpadding="2" id="alter_extrato" cellspacing="0" width="100%">
				<thead>
					<tr>
						<th width="6%" ><fmt:message key="label.Status" /></th>
						<th width="8%" ><fmt:message key="label.bordero" /></th></th>
						<th width="9%" ><fmt:message key="label.oS" /></th></th>
						<th width="10%" ><fmt:message key="label.contrato" /></th></th>
						<th width="14%" ><fmt:message key="label.cliente" /></th></th>
						<th width="10%" ><fmt:message key="label.placa" /></th></th>
						<th width="9%" ><fmt:message key="label.tipo" /></th></th> 
						<th width="14%" ><fmt:message key="label.dataAtendimento" /></th></th> 
						<th width="10%" ><fmt:message key="label.valorTotal" /></th></th>
						<th width="15%" ><fmt:message key="label.custoEficienciaOperacional" /></th>
					</tr>
				</thead>				
		</table>
		
		<div style="width: 960px; height: 350px; overflow: auto;">
			
			<!-- INICIO TABELA DE EXTRATOS -->
			<table cellpadding="2" id="alter_extrato" cellspacing="0" width="100%">
				<tbody>	  
					<c:if test="${not empty mensagemOrdensServico }">
						<tr>
							<td colspan="16">${mensagemOrdensServico }</td>
						</tr>
					</c:if>
					<c:forEach var="ordemServico" items="${ordensServico }" varStatus="status">
						<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if>>
							<!-- STATUS DA ORDEM DE SERVICO -->
							<td width="6%" scope="col" >
								<c:choose>
									<c:when test="${ordemServico.status eq 'C'}">
										<c:set var="texto" value="Entregue" />
									</c:when>
									<c:when test="${ordemServico.status eq 'P'}">
										<c:set var="texto" value="Pendente" />
									</c:when>
									<c:when test="${ordemServico.status eq 'I'}">
										<c:set var="texto" value="Incompleto" />
									</c:when>
								</c:choose>
								<img class="tooltip" title="${texto }" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/statusServico_${ordemServico.status}.png" alt="${ordemServico.status}"/>
							</td>
							<!-- NUMERO BORDERO -->
							<td width="8%" >${ordemServico.bordero.numeroBordero}&nbsp;</td>
							<!-- NUMERO O.S -->
							<td width="9%" >
								<a tabindex="4" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC19/dv05&numeroOrdemServicoSelecionada=${ordemServico.numero}&dataInicial=${param.dataInicial}&dataFinal=${param.dataFinal}&codigoInstalador=${param.codigoInstalador}&codigoStatus=${param.codigoStatus}&classe=${ordemServico.contrato.servicoContratado}&instalador=${ordemServico.agendamento.nomeInstalador}&valorTotalOrdemServico=${ordemServico.valorTotalOrdemServico}&vtOS=${param.vtOS}&vtPend=${param.vtPend}&vtTestes=${param.vtTestes}&vtOCred=${param.vtOCred }&vtDesc=${param.vtDesc }&vtLiq=${param.vtLiq }&vtNf=${param.vtNf}&numeroOS=${param.numeroOS}&valorCustoEficiencia=${param.valorCustoEficiencia}&tipoPesquisa=${param.tipoPesquisa}" style="color: blue; text-decoration: underline;">
									${ordemServico.numero}&nbsp;
								</a>
							</td>
							<!-- NUMERO CONTRATO -->
							<td width="10%" >${ordemServico.contrato.numeroContrato}&nbsp;</td>
     						<!-- CLIENTE -->
							<td width="14%" >${ordemServico.contrato.contratante.nome}&nbsp;</td>
							<!-- PLACA -->
							<td width="10%" >${ordemServico.contrato.veiculo.placa}&nbsp;</td>
							<!-- TIPO CONTRATO -->
							<td width="9%" >${ordemServico.contrato.tipoContrato}&nbsp;</td>
							<!-- DATA DE ATENDIMENTO -->
							<td width="14%" >
								<fmt:formatDate value="${ordemServico.agendamento.dataAgendamento}" pattern="dd/MM/yyyy"/>
							</td>
	    					<!-- VALOR TOTAL DA ORDEM DE SERVICO -->
							<td width="10%" >
								<fmt:formatNumber value="${ordemServico.valorTotalOrdemServico}" type="currency"/>&nbsp;
							</td>						
							<c:set var="subTotal" value="${subTotal + ordemServico.valorTotalOrdemServico}"></c:set>
							
							<!-- CUSTO EFICIENCIA OPERACIONAL -->
							<td width="15%" >
								<fmt:formatNumber value="${ordemServico.contrato.custoEficiencia}" type="currency"/>&nbsp;
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- INICIO TABELA DE EXTRATOS -->
		</div>
     		<c:forEach var="ordemServicoDetalhe" items="${ordensServicoDetalhe}" varStatus="status">
				<c:set var="subTotalServico" value="${subTotalServico + ordemServicoDetalhe.valorTotal}"></c:set>
    		</c:forEach>	  
		   
		<div class="total">
			<table width="300" cellpadding="1px" id="alter_total" cellspacing="0px">
				<tr>
					<th width="10%"scope="col"><fmt:message key="label.subtotalServico" /></th>
					<th width="7%" scope="col"><fmt:message key="label.total" /></th>
					<th width="15%" scope="col"><fmt:message key="label.totalCustoEficienciaOperacional" /></th>
				</tr>
				<tr class="dif">
					<td><fmt:formatNumber value="${subTotalServico}" type="currency"/></td>
					<td class="linkazulescuro"><fmt:formatNumber value="${subTotal}" type="currency"/></td>
					<td class="linkazulescuro"><fmt:formatNumber value="${param.valorCustoEficiencia}" type="currency"/></td>
				</tr>
			</table>
		</div>
		
		
		<div class="hr">
		</div>
		
		
		<table cellspacing="0" class="detalhe_extrato" >
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.testesEquipamentos" /></th>
			</tr>
		</table>
		
		
		<table width="960" cellpadding="1px" id="alter_extrato" cellspacing="0px">
			<tr>
				<th width="320px"scope="col"><fmt:message key="label.testesRealizadosPagos" /></th>
				<th width="320px" scope="col"><fmt:message key="label.testesRealizadosPendentes" /></th>
				<th width="320px" scope="col"><fmt:message key="label.totalPagamentosTestesRealizados" /></th>
			</tr>
			<tr class="dif">
				<td><fmt:formatNumber value="${totais.valorTotalTestes}" type="currency"/></td>
				<td class="linkazulescuro"><fmt:formatNumber value="${totais.valorTotalPendencias}" type="currency"/></td>
				<td><fmt:formatNumber value="${totais.valorTotalLiquido}" type="currency"/></td>
			</tr>
		</table>
		
		
		<table cellspacing="0" class="detalhe_extrato" >
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.descontosGerais" /></th>
			</tr>
		</table>
		
		
		<table width="960" cellpadding="1" id="alter_extrato" cellspacing="0">
				<tr>
					<th width="320px" scope="col"><fmt:message key="label.dataDeVencimento" /></th>
					<th width="320px" scope="col"><fmt:message key="label.valor" /></th>
					<th width="320px" scope="col"><fmt:message key="label.Motivo" /></th>
				</tr>
			<c:if test="${not empty mensagemDesconto }">
				<tr>
					<td colspan="3">${mensagemDesconto }</td>
				</tr>
			</c:if>
			<c:forEach var="desconto" items="${descontos}" varStatus="status">
				<tr class="dif">
					<td><fmt:formatDate value="${desconto.dataVencimento}" pattern="dd/MM/yyyy"/></td>
					<td class="linkazulescuro"><fmt:formatNumber value="${desconto.valor}" type="currency" /></td>
					<td>${desconto.motivo}&nbsp;</td>
					<c:set var="descontosAux1" value="${descontosAux1 + desconto.valor}">
					</c:set>
				</tr>
			</c:forEach>	
		</table>
		
		
		<table cellspacing="0" class="detalhe_extrato" >
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.adiantamentoDescontoRepresentante" /></th>
			</tr>
		</table>
		
		
		<table width="960" cellpadding="1" id="alter_extrato" cellspacing="0">
				<tr>
					<th width="160px"scope="col"><fmt:message key="label.movimentacao" /></th>
					<th width="160px" scope="col"><fmt:message key="label.dataCadastro" /></th>
					<th width="160px" scope="col"><fmt:message key="label.dataAtendimento" /></th> 
					<th width="160px" scope="col"><fmt:message key="label.parcelaTotalParcelas" /></th> 
					<th width="160px" scope="col"><fmt:message key="label.observacao" /></th>   
					<th width="160px" scope="col"><fmt:message key="label.valor" /></th>  
				</tr>
			<c:if test="${not empty mensagemAdiantamento }">
				<tr>
					<td colspan="6">${mensagemAdiantamento }</td>
				</tr>
			</c:if>
			<c:set var="totalDescontos" value="0"/>
			<c:forEach var="adiantamento" items="${adiantamentos}">
				<tr class="dif">
					<td>${adiantamento.tipoMovimentacao}</td>
					<td class="linkazulescuro"><fmt:formatDate value="${adiantamento.dataCadastro}" pattern="dd/MM/yyyy"/></td>
					<td><fmt:formatDate value="${adiantamento.dataAdiantamento}" pattern="dd/MM/yyyy"/></td>
					<td>${adiantamento.descricaoParcela}</td>
					<td>&nbsp;</td>
					<td><fmt:formatNumber value="${adiantamento.valorMovimentacao}" type="currency"/></td>
					<c:set var="descontosAux2" value="${descontosAux2 + adiantamento.valorMovimentacao}"></c:set>
					<c:set var="totalDescontos" value="${descontosAux1 + descontosAux2}"></c:set>
				</tr>
			</c:forEach>
		</table>
		
		
		<div class="total">
			<table width="300" cellpadding="1px" id="alter_total" cellspacing="0px">
				<tr>
					<th width="10%"scope="col"><fmt:message key="label.totalCreditos" /></th>
					<th width="7%" scope="col"><fmt:message key="label.totalDescontos" /></th>
				</tr>
				<tr class="dif">
					<td><fmt:formatNumber value="${totais.valorTotalLiquido}" type="currency"/></td>
					<td class="linkazulescuro"><fmt:formatNumber value="${totalDescontos }" type="currency"/></td>
				</tr>
			</table>
		</div>
		
		
		<table cellspacing="0" class="detalhe_extrato" >
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.resumoPagamentoServico" /></th>
			</tr>
		</table>
		
		
		<table width="960" cellpadding="1px" id="alter_extrato" cellspacing="0px">
				<tr>
					<th width="350px""scope="col"><fmt:message key="label.totalOsDeclaracaoOriginalEntregueAutorizada" /></th>
					<th width="350px" scope="col"><fmt:message key="label.totalOsComPendecia" /></th>
					<th width="112px" scope="col"><fmt:message key="label.valorTestes" /></th> 
					<th width="112px" scope="col"><fmt:message key="label.outrosCreditos" /></th>  
					<th width="112px" scope="col"><fmt:message key="label.desconto" /></th>  
					<th width="112px" scope="col"><fmt:message key="label.valorLiquido" /></th>  
					<th width="112px" scope="col"><fmt:message key="label.valorNf" /></th>
					<th width="70" scope="col"><fmt:message key="label.custoEficienciaOperacional" /></th>
				</tr>
			<c:if test="${not empty mensagemTotais }">
				<tr>
					<td colspan="7">${mensagemTotais }</td>
				</tr>
			</c:if>
			<c:if test="${not empty totais }">
				<tr class="dif">
					<td><fmt:formatNumber value="${param.vtOS }" type="currency"/></td>
					<td class="linkazulescuro"><fmt:formatNumber value="${param.vtPend}" type="currency"/></td>
					<td><fmt:formatNumber value="${param.vtTestes}" type="currency"/></td>
					<td><fmt:formatNumber value="${param.vtOCred }" type="currency"/></td>
					<td><fmt:formatNumber value="${param.vtDesc }" type="currency"/></td>
					<td><fmt:formatNumber value="${param.vtLiq }" type="currency"/></td>
					<td><fmt:formatNumber value="${param.vtNf }" type="currency"/></td>
					<td class="linkazulescuro"><fmt:formatNumber value="${param.valorCustoEficiencia }" type="currency"/></td>
				</tr>
			</c:if>
		</table>
		
		<br><br><br>
		<input type="button" class="button3" value="<fmt:message key="label.voltar" />" tabindex="5" onclick="window.location.href='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC19/dv02&dataInicial=${param.dataInicial}&dataFinal=${param.dataFinal}&codigoInstalador=${param.codigoInstalador}&codigoStatus=${param.codigoStatus}&numeroOS=${param.numeroOS}&valorTotalOrdemServico=${param.vtOS}&valorTotalPendencias=${param.vtPend}&valorTotalTestes=${param.vtTestes}&valorTotalOutrosCreditos=${param.vtOCred}&valorTotalDescontos=${param.vtDesc}&valorTotalLiquido=${param.vtLiq}&valorTotalNotaFiscal=${param.vtNf}&valorCustoEficiencia=${param.valorCustoEficiencia}';" />
	
		<div class="pgstabela">	
				<input type="submit" class="button" value="<fmt:message key="label.imprimir" />" tabindex="6"/>
		</div>
	</form>

	<!-- form method="post" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC19/dv02">
		<input type="hidden" name="dataInicial" value="${param.dataInicial}" />
		<input type="hidden" name="dataFinal" value="${param.dataFinal}" />
		<input type="hidden" name="codigoInstalador" value="${param.codigoInstalador }" />
		<input type="hidden" name="codigoStatus" value="${param.codigoStatus }" />
		<input type="hidden" name="numeroOS" value="${param.numeroOS }" />				
		<input type="submit" class="button3" value="Voltar" style="margin-bottom:90px;*position:relative;" />
	</form-->
	
	<br clear="all"/>
       
	<div class="clear:both"></div>

