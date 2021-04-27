<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/PesquisarContratos/detalharContrato?acao=3" context="/SascarPortalWeb"  />
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

<div class="cabecalho">
	<fmt:message key="label.servicosContratados" />
	<div class="caminho">
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; 
		<a href="#" class="linktres"><fmt:message key="label.informacoes" /></a> &gt;
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC01/dv01"  class="linkquatro"><fmt:message key="label.servicosContratados" /></a>
	</div>
</div>

<table width="1026" cellspacing="0" class="tbatualizacao" >
	<tr class="tbatualizacao">
		<th class="barraazulzinha"><fmt:message key="label.detalheServicoContratado" />
			<div class="lembretes">
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC08/dv01" class="linkum"><img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/atualizardados32.png" width="24" height="24" hspace="3" border="0" align="absmiddle" /><fmt:message key="label.atualizarInformacoes" /><fmt:message key="label.atualizarInformacoes" /></a>
			</div>
		</th>
	</tr>
</table>

<table width="100%" cellspacing="3" class="detalhe2">
	<tr>
		<th width="200" class="barracinza"><fmt:message key="label.servicoContrato" /></th>
		<td width="350" class="camposinternos">${contrato.servicoContratado }</td>
		
		<th>&nbsp;</th>
		<td class="camposinternos">&nbsp;</td>
	</tr>
	<tr>		
		<th width="200" class="barracinza"><fmt:message key="label.vigencia" /></th>
	  	<td width="350" class="camposinternos"><fmt:formatDate value="${contrato.dataInicioVigencia}" pattern="dd/MM/yyyy" /> a <fmt:formatDate value="${contrato.dataFimVigencia}" pattern="dd/MM/yyyy" /></td>
	</tr>
	<tr>					
		<th width="200" class="barracinza"><fmt:message key="label.valorMonitoramento" /></th>
		<td width="350" class="camposinternos"><fmt:formatNumber value="${contrato.valorMonitoramento}" type="currency" /></td>
	</tr>
	<tr>
		<th width="200" height="20" class="barracinza"><fmt:message key="label.valorParaLocacao" /></th>
	  	<td width="350" class="camposinternos"><fmt:formatNumber value="${contrato.valorLocacao}" type="currency" /></td>
	</tr>
    <tr>					
		<th width="200" height="20" class="barracinza"><fmt:message key="label.proRata" /></th>
	  	<td width="350" class="camposinternos"><fmt:formatNumber value="${contrato.valorProRata}" type="currency" /></td>
	</tr>
	<tr>					
		<th width="200" class="barracinza"><fmt:message key="label.dataAgendamento2" /></th>
		<td width="350" class="camposinternos"><fmt:formatDate value="${contrato.dataAgendamento}" pattern="dd/MM/yyyy HH:mm:ss"/></td>
	</tr>
</table>

<table cellspacing="0" class="detalhe" >
	<tr class="barraazulzinha">
		<th class="barraazulzinha"><fmt:message key="label.dadosVeiculo" />
			<div class="lembretes" style="width: 250px;">
				<c:if test="${fn:toUpperCase(contrato.status) eq 'I'}">
					<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC03/dv03&numeroContrato=${contrato.numeroContrato}" class="linkum"><img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/atualizardados32.png" width="24" height="24" hspace="3" border="0" align="absmiddle" /><fmt:message key="label.solicitacaoRetiradaReinstalacao" /></a>
				</c:if>
				<c:if test="${fn:toUpperCase(contrato.status) eq 'N'}">
					<fmt:message key="label.solicitacaoRetiradaReinstalacao" />
				</c:if>
		  	</div>
		</th>
	</tr>
</table>

<table width="100%" cellspacing="3" class="detalhe2">
	<tr>
		<th width="200" class="barracinza"><fmt:message key="label.placa" /></th>
		<td width="350" class="camposinternos">${contrato.veiculo.placa }</td>

		<th width="200" class="barracinza"><fmt:message key="label.chassi" /></th>
		<td width="350" class="camposinternos">${contrato.veiculo.chassi }</td>

	</tr>
	
	<tr>
		<th width="200" class="barracinza"><fmt:message key="label.marcaModelo" /></th>
		<td width="350" class="camposinternos">${contrato.veiculo.descricaoMarca } / ${contrato.veiculo.descricaoModelo }</td>
		
		<th width="200" class="barracinza"><fmt:message key="label.renavam" /></th>
		<td width="350" class="camposinternos">${contrato.veiculo.renavan}</td>	</tr>
	
	<tr>					
		<th width="200" class="barracinza"><fmt:message key="label.cor" /></th>
		<td width="350" class="camposinternos">${contrato.veiculo.cor }</td>

	</tr>
	<tr>	
		<th width="200" class="barracinza"><fmt:message key="label.ano" /></th>
		<td width="350" class="camposinternos">${contrato.veiculo.anoFabricacao}</td>
	</tr>
	<tr>					
		<td></td>
		<td></td>
		<td></td>
		<td></td>
	</tr>

</table>

<c:if test="${not empty contrato.acessorios}">

	<h1><fmt:message key="label.acessoriosContratados" /></h1>
	
	<table cellspacing="0" width="750" id="alter" >
		<tr>
			<th width="40%" class="texttable_azul" style="text-align:left;"><fmt:message key="label.descricao" /></th>
			<th width="20%" class="texttable_cinza"><fmt:message key="label.valor" /></th>
			<th width="20%" class="texttable_cinza"><fmt:message key="label.instalado" /></th>
		</tr>
		
		<c:forEach var="acessorio" items="${contrato.acessorios}" varStatus="status">
		
			<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if>>
				<td class="linkazulescuro"  style="text-align:left;">${acessorio.descricao }</td>
				<td><fmt:formatNumber value="${acessorio.valor}" type="currency" /></td>
				<td>
					<c:choose>
						<c:when test="${fn:toUpperCase(acessorio.situacao) eq 'I'}"><fmt:message key="label.instalado" /></c:when>
						<c:otherwise><fmt:message key="label.naoInstalado" /></c:otherwise>
					</c:choose>
				</td>
			</tr>
			
		</c:forEach>
		
	</table>
	
</c:if>

<c:if test="${not empty contrato.pessoasAutorizadas}">
	
	<h1><fmt:message key="label.contatosAutorizados" /></h1>
	
	<table cellspacing="0" width="750" id="alter">

		<tr>
			<th width="60%" class="texttable_azul"  style="text-align:left;"><fmt:message key="label.nome" /></th>
			<th width="10%" class="texttable_cinza"><fmt:message key="label.cpf" /></th>
			<th width="10%" class="texttable_cinza"><fmt:message key="label.rg" /></th>
			<th width="10%" class="texttable_cinza""><fmt:message key="label.telefone1" /></th>
			<th width="10%" class="texttable_cinza"><fmt:message key="label.telefone2" /></th>
		</tr>

		<c:forEach var="pessoaAutorizada" items="${contrato.pessoasAutorizadas}" varStatus="status">

			<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if>>
				<td class="linkazulescuro"   style="text-align:left;">${pessoaAutorizada.nome }</td>
				<td align="right">${pessoaAutorizada.numCpfCnpj}</td>
				<td align="right">${pessoaAutorizada.numRG}</td>
				<td>${pessoaAutorizada.telefone1}</td>
				<td>${pessoaAutorizada.telefone2}</td>
			</tr>

		</c:forEach>

	</table>
	
</c:if>

<c:if test="${not empty contrato.pessoasEmergencia}">
	
	<h1><fmt:message key="label.contatosEmergencia" /></h1>
	
	<table width="750" cellpadding="1" id="alter" cellspacing="0">
		<tr>
		    <th class="texttable_azul" scope="col" width="60%" style="text-align:left;"><fmt:message key="label.nome" /></th>
		    <th class="texttable_cinza" scope="col" width="10%"><fmt:message key="label.cpf" /></th>
		    <th class="texttable_cinza" scope="col" width="10%"><fmt:message key="label.rg" /></th>
		    <th class="texttable_cinza" scope="col" width="10%"><fmt:message key="label.telefone1" /></th>
		    <th class="texttable_cinza" scope="col" width="10%"><fmt:message key="label.telefone2" /></th>
		</tr>
		
		<c:forEach var="pessoaEmergencia" items="${contrato.pessoasEmergencia}" varStatus="status">
		
			<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if>>
			    <td class="linkazul"  style="text-align:left;">${pessoaEmergencia.nome}</td>
			    <td>${pessoaEmergencia.numCpfCnpj}</td>
			    <td >${pessoaEmergencia.numRG}</td>
			    <td>${pessoaEmergencia.telefone1 }</td>
			    <td>${pessoaEmergencia.telefone2}</td>
		  	</tr>

		</c:forEach>

	</table>
	
</c:if>

<div class="pgstabela">
	<form method="post" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC01/dv02&pagina=${param.pagina}">
		<input type="hidden" name="dataInicial" value="${param.dataInicial }" />
		<input type="hidden" name="dataFinal" value="${param.dataFinal }" />
		<input type="hidden" name="codigoServicocontratado" value="${param.codigoServicocontratado }" />
		<input type="hidden" name="statusContrato" value="${param.statusContrato }" />
		<input type="submit" class="button3" value="<fmt:message key="label.voltar" />" />
	</form>
</div>
