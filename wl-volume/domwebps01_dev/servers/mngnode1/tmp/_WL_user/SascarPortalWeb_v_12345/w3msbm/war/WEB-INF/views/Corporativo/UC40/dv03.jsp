<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>
<c:catch var="helper" >
	<c:import url="/ConsultarPedidoEstoque/consultarDetalhePedido?acao=2" context="/SascarPortalWeb"  />
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
	<body>	
	
	<div class="cabecalho2"><fmt:message key="label.consultarPedidoEstoque" />
			<div class="caminho">
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" class="linktres"><fmt:message key="label.home" /></a> &gt;  
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC40/dv01" class="linktres"><fmt:message key="label.servicos" /></a> &gt;   
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC40/dv01" class="linkquatro"><fmt:message key="label.consultarPedidoEstoque" /></a>
			</div>
		</div>	
	
		<!-- div class="cabecalho2">
			<div class="caminho" style="">
				<a class="linktres" title="Home" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}">Home</a>
				&gt;
				<a class="linktres" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC40/dv01">Serviços</a>
				&gt;
				<a class="linkquatro" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC40/dv01">
				<strong>Consultar Pedido de Estoque</strong>
				</a>
			</div>
			
			<strong>Consultar Pedido de Estoque</strong>
		</div-->
		
		
		<table class="detalhe2" cellspacing="3" width="100%">
			<tbody>
				<tr>
					<th class="barracinza" width="200"><fmt:message key="label.numeroDoPedido" /></th>
					<td class="camposinternos" width="350">${pedidoNumero}</td>
					<th>&nbsp;</th>
					<td class="camposinternos" width="350">&nbsp;</td>
				</tr>
				<tr>
					<th class="barracinza" width="200"><fmt:message key="label.dataDoPedido" /></th>
					<td class="camposinternos" width="350">${pedidoData} </td>
					<th>&nbsp;</th>
					<td class="camposinternos" width="350">&nbsp;</td>
				</tr>
				<tr>
					<th class="barracinza" width="200"><fmt:message key="label.statusDoPedido" /></th>
					<td class="camposinternos" width="350">
						<!-- img height="16" border="0" align="absmiddle" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/status_pend.png"></img-->
						 <c:if test="${pedidoStatus eq 'C'}"><fmt:message key="label.pedidoStatus.concluido" /></c:if>
				         <c:if test="${pedidoStatus eq 'P'}"><fmt:message key="label.pedidoStatus.pendente" /></c:if>
				         <c:if test="${pedidoStatus eq 'N'}"><fmt:message key="label.pedidoStatus.naoAutorizado" /></c:if>
				         <c:if test="${pedidoStatus eq 'A'}"><fmt:message key="label.pedidoStatus.aguardandoAutorizacao" /></c:if>
				         <c:if test="${pedidoStatus eq 'AA'}"><fmt:message key="label.pedidoStatus.aguardandoAutorizacaoAutomatica" /></c:if>
				         <c:if test="${pedidoStatus eq 'E' }"><fmt:message key="label.pedidoStatus.cancelado" /></c:if>
					<th>&nbsp;</th>
					<td class="camposinternos" width="350">&nbsp;</td>
				</tr>
			</tbody>
		</table>
		<table class="detalhe" cellspacing="0">
			<tbody>
				<tr class="barraazulzinha">
					<th class="barraazulzinha"><fmt:message key="label.equipamentos" /></th>
				</tr>
			</tbody>
		</table>
<c:if test="${empty equipamentos}">	
<div align="center"><label> <fmt:message key="mensagem.informacao.naoHaEquipamentosCadastrados" /></label></div>
</c:if>		
<c:if test="${not empty equipamentos}">				
		<table id="alter" cellspacing="0" cellpadding="1" width="850" style="">
			<tbody>
				<tr>
					<th class="texttable_azul" width="20%" title="Data da abertura do serviço" scope="col"><fmt:message key="label.equipamento" /></th>
					<th class="texttable_cinza" width="20%" scope="col"><fmt:message key="label.quantidade" /></th>
					<th class="texttable_cinza" width="12%" scope="col"><fmt:message key="label.operadora" /></th>
					<th class="texttable_cinza" width="60%" scope="col"><fmt:message key="label.observacao" /></th>
				</tr>
				<c:forEach  items="${equipamentos}" var="pedidoEquipamento" varStatus="contador">
				<tr class="dif">
					<td class="linkazulescuro">${pedidoEquipamento.descricaoEquipamento}</td>
					<td>${pedidoEquipamento.quantidadeEquipamento}</td>
					<td>${pedidoEquipamento.operadora.descricao} </td>
					<td>${pedidoEquipamento.observacaoEquipamento}</td>
				</tr>			
				</c:forEach>
			</tbody>
		</table>
</c:if>			
		<p> </p>
			
		<table class="detalhe" cellspacing="0">
			<tbody>
				<tr class="barraazulzinha">
					<th class="barraazulzinha"><fmt:message key="label.materiais" /></th>
				</tr>
			</tbody>
		</table>
		
<c:if test="${empty materiais}">
<div align="center"><label><fmt:message key="mensagem.informacao.naoHaMateriaisCadastrados" /></label></div>
</c:if>		
<c:if test="${not empty materiais}">		
		<table id="alter" cellspacing="0" cellpadding="1" width="850">
			<tbody>
				<tr>
					<th class="texttable_azul" width="70%" title="Data da abertura do serviço" scope="col"><fmt:message key="label.material" /></th>
					<th class="texttable_cinza" width="30%" scope="col"><fmt:message key="label.quantidade" /></th>
				</tr>
				<c:forEach  items="${materiais}" var="materiais" varStatus="contador">
				  <tr class="dif">
					<td class="linkazulescuro">${materiais.descricao}</td>
					<td>${materiais.quantidade}</td>
				  </tr>
				</c:forEach>
			</tbody>
		</table>
</c:if>		
	<input class="button3" style="margin-left:2px;" type="button" onclick="window.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC40/dv02&numeroPedido=${param.np}&dataInicial=${param.dataInicial}&dataFinal=${param.dataFinal}&statusPedido=${param.statusPedido}'" tabindex="10" value="<fmt:message key="label.voltar" />">		
		<div class="pgstabela" >
		
		</div>
		
	</body>

