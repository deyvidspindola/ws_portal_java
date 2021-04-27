<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/VisualizarExtratoServicosExecutadosServlet/recuperarExtratoDetalhado?acao=3" context="/SascarPortalWeb"  />
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

<script type="text/javascript">
	$(document).ready(function(){
		window.print();
	});
</script>
	<table cellspacing="0" class="detalhe_extrato">
	  <tr class="barraazulzinha">
			<th class="barraazulzinha"><fmt:message key="label.servicosExecutados" /></th>
			<span class="texthelp3" style="margin-right:20px;margin-top:5px;">
				<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="3" align="absmiddle" />
				<fmt:message key="uc19.dv04.texto.01" />
			</span>
		</tr>
	</table>
	
		
	<table style="margin-left:-1px;" width="920" cellpadding="1px" border="1px" bordercolor="666633" id="alter_extrato" cellspacing="0px">
		<tr>
		    <th width="4%"scope="col" class="tooltip" title="texto explicativo aqui"><fmt:message key="label.Status" /></th>
		    <th width="9%"scope="col"><fmt:message key="label.nAbrevBordero" /></th>
		    <th width="5%" scope="col"><fmt:message key="label.nAbrevOS" /></th>
		    <th width="5%" scope="col"><fmt:message key="label.contrato" /></th>
		    <th width="5%" scope="col"><fmt:message key="label.cliente" /></th>
		    <th width="2%" scope="col"><fmt:message key="label.placa" /></th>
		    <th width="9%" scope="col"><fmt:message key="label.servicoContratado" /></th>
		    <th width="5%" scope="col"><fmt:message key="label.tipoContrato" /></th> 
		    <th width="9%" scope="col"><fmt:message key="label.dataAtend" /></th> 
		    <th width="4%" scope="col"><fmt:message key="label.Motivo" /></th>  
		    <th width="6%" scope="col"><fmt:message key="label.instalador" /></th>  
		    <th width="7%" scope="col"><fmt:message key="label.vlrServico" /></th> 
		    <th width="4%" scope="col"><fmt:message key="label.desloc" /></th> 
		    <th width="8%" scope="col"><fmt:message key="label.valorDesloc" /></th>  
		    <th width="5%" scope="col"><fmt:message key="label.pedagio" /></th> 
		    <th width="4%" scope="col"><fmt:message key="label.total" /></th> 
		    <th width="2%" scope="col"><fmt:message key="label.dtPgto" /></th>
		</tr>
		<c:if test="${not empty mensagemOrdensServico }">
			<tr>
				<td colspan="16">${mensagemOrdensServico }</td>
			</tr>
		</c:if>
		<c:forEach var="ordemServico" items="${ordensServicoDetalhe }">
		  <tr class="dif">
		    <td>
		    	<c:if test="${ordemServico.status eq 'P'}">P</c:if>
		    	<c:if test="${ordemServico.status eq 'C'}">C</c:if>
		    	<c:if test="${ordemServico.status eq 'I'}">I</c:if>
		    </td>
			<td>${ordemServico.bordero.numeroBordero}&nbsp;</td>
			<td>${ordemServico.numero}&nbsp;</td>
			<td>${ordemServico.contrato.numeroContrato}&nbsp;</td>
			<td>${ordemServico.contrato.contratante.nome}&nbsp;</td>
			<td style="width:1px;">${ordemServico.contrato.veiculo.placa}&nbsp;</td>
			<td>${ordemServico.contrato.servicoContratado}&nbsp;</td>
			<td>${ordemServico.contrato.tipoContrato}&nbsp;</td>
			<td><fmt:formatDate value="${ordemServico.agendamento.dataAgendamento}" pattern="dd/MM/yy"/></td>
			<td>${ordemServico.observacao}&nbsp;</td>
			<td>${ordemServico.agendamento.nomeInstalador}&nbsp;</td>
			<td><fmt:formatNumber value="${ordemServico.valorServico}" type="currency"/>&nbsp;</td>
			<td>${ordemServico.valorDeslocamento}&nbsp;<BR> Km</td>
			<td><fmt:formatNumber value="${ordemServico.quantidadeDeslocamento}" type="currency"/>&nbsp;</td>
			<td><br><fmt:formatNumber value="${ordemServico.valorPedagio}" type="currency"/>&nbsp;</td>
			<c:set var="TotalOS" value="${ordemServico.valorServico + (ordemServico.valorDeslocamento * ordemServico.quantidadeDeslocamento) + ordemServico.valorPedagio}"></c:set>
			<td><fmt:formatNumber value="${TotalOS}" type="currency"/>&nbsp;</td>
			<td><fmt:formatDate value="${ordemServico.dataPagamento}" pattern="dd/MM/yy"/></td>			
		  </tr>
		</c:forEach>
	</table>
	  
	 <c:forEach var="ordemServico" items="${ordensServico}" varStatus="status">
			<c:set var="subTotal" value="${subTotal + ordemServico.valorTotalOrdemServico	}"></c:set>
	</c:forEach>	  
  	<c:forEach var="ordemServicoDetalhe" items="${ordensServicoDetalhe}" varStatus="status">
			<c:set var="subTotalServico" value="${subTotalServico + ordemServicoDetalhe.valorTotal}"></c:set>
	</c:forEach>  
	  
	<div class="total">
		<table width="300" cellpadding="1px" id="alter_total" cellspacing="0px" border="1px" bordercolor="666633" >
		  <tr>
		    <th width="10%"scope="col"><fmt:message key="label.subtotalServico" /></th>
		    <th width="7%" scope="col"><fmt:message key="label.total" /></th>
		  </tr>
		  <tr class="dif">
		    <td><fmt:formatNumber value="${subTotalServico}" type="currency"/></td>
		    <td class="linkazulescuro"><fmt:formatNumber value="${subTotal}" type="currency"/></td>
		  </tr>
		</table>
	</div>
	<div class="hr"></div>
	<table cellspacing="0" class="detalhe_extrato">
		<tr class="barraazulzinha">
			<th class="barraazulzinha"><fmt:message key="label.testesEquipamentos" /></th>
		</tr>
	</table>	
	<table width="960" cellpadding="1px" id="alter_extrato" cellspacing="0px" border="1px" bordercolor="666633" >
	  <tr>
	    <th width="10%"scope="col"><fmt:message key="label.testesRealizadosPagos" /></th>
	    <th width="7%" scope="col"><fmt:message key="label.testesRealizadosPendentes" /></th>
	    <th width="6%" scope="col"><fmt:message key="label.totalPagamentosTestesRealizados" /></th>
	  </tr>
	  <tr class="dif">
	    <td><fmt:formatNumber value="${totais.valorTotalTestes}" type="currency"/></td>
	    <td class="linkazulescuro"><fmt:formatNumber value="${totais.valorTotalPendencias}" type="currency"/></td>
	    <td><fmt:formatNumber value="${totais.valorTotalLiquido}" type="currency"/></td>
	  </tr>
	</table>	
	<table cellspacing="0" class="detalhe_extrato">
		<tr class="barraazulzinha">
			<th class="barraazulzinha"><fmt:message key="label.descontosGerais" /></th>
		</tr>
	</table>
	
	<table width="960" cellpadding="1px" id="alter_extrato" cellspacing="0px" border="1px" bordercolor="666633" >
			<tr>
				<th width="320px" scope="col"><fmt:message key="label.dataDeVencimento" /></th>
				<th width="320px" scope="col"><fmt:message key="label.valor" /></th>
				<th width="320px" scope="col"><fmt:message key="label.Motivo" /></th>
			</tr>
		<c:if test="${not empty mensagemDesconto }">
			<tr>
				<td colspan="3" style="font-size: 10px;color:#fff;text-align:center;">${mensagemDesconto }</td>
			</tr>
		</c:if>
		<c:forEach var="desconto" items="${descontos}" varStatus="status">
			<tr class="dif">
				<td><fmt:formatDate value="${desconto.dataVencimento}" pattern="dd/MM/yyyy"/></td>
				<td class="linkazulescuro"><fmt:formatNumber value="${desconto.valor}" type="currency" /></td>				
				<td>${desconto.motivo}</td>
				<c:set var="descontosAux1" value="${descontosAux1 + desconto.valor}">
				</c:set>
			</tr>
		</c:forEach>	
	</table>
			
	
	<table cellspacing="0" class="detalhe_extrato">
		  <tr class="barraazulzinha">
			<th class="barraazulzinha"><fmt:message key="label.adiantamentoDescontoRepresentante" /></th>
		  </tr>
	</table>
	
	
	<table width="960" cellpadding="1px" id="alter_extrato" cellspacing="0px" border="1px" bordercolor="666633" >
			<tr>
				<th width="10%"scope="col"><fmt:message key="label.movimentacao" /></th>
				<th width="5%" scope="col"><fmt:message key="label.dataDeCadastro" /></th>
				<th width="5%" scope="col"><fmt:message key="label.dataAdiantamento" /></th> 
				<th width="13%" scope="col"><fmt:message key="label.parcelaTotalParcelas" /></th> 
				<th width="4%" scope="col"><fmt:message key="label.observacoes" /></th>  
				<th width="6%" scope="col"><fmt:message key="label.valor" /></th>  
			</tr>
	 <c:if test="${not empty mensagemAdiantamento }">
			<tr>
				<td colspan="6" style="font-size: 10px;color:#fff;text-align:center;">${mensagemAdiantamento }</td>
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
		<table width="300" cellpadding="1px" id="alter_total" cellspacing="0px" border="1px" bordercolor="666633" >
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
	
	
	<table width="960" cellpadding="1px" id="alter_extrato" cellspacing="0px" border="1px" bordercolor="666633" >
			  <tr>
			    <th width="29%"scope="col"><fmt:message key="label.totalOsComDocumentacaoAutorizada" /></th>
			    <th width="31%" scope="col"><fmt:message key="label.totalOsComPendecia" /></th>
			    <th width="9%" scope="col"><fmt:message key="label.valorTestes" /></th> 
			    <th width="10%" scope="col"><fmt:message key="label.outrosCreditos" /></th>  
			    <th width="6%" scope="col"><fmt:message key="label.desconto" /></th>  
			    <th width="9%" scope="col"><fmt:message key="label.valorLiquido" /></th>  
			    <th width="6%" scope="col"><fmt:message key="label.valorNf" /></th>
			  </tr>
		<c:if test="${not empty mensagemTotais }">
			<tr>
				<td colspan="7" style="font-size: 10px;color:#fff;">${mensagemTotais }</td>
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
				</tr>
		</c:if>
	</table>

