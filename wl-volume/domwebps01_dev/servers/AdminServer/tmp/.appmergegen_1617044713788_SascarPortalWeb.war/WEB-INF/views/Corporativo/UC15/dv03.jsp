<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/VisualizarDeclaracaoServlet/detalharDeclaracao?acao=3" context="/SascarPortalWeb"  />
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

<jsp:useBean id="dataAtual" class="java.util.Date" scope="request" />

<table cellspacing="4" cellpadding="4" border="0">
	<tr>
		<td><img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/logo-sascar.jpg" alt="SASCAR" /></td>
		<td colspan="2" style="text-align: right;"><img src="${pageContext.request.contextPath}/sascar/images/corporativo/logo-iso-9001.png" alt="ISO 9001" /></td>
	</tr>
	<tr>
		<td colspan="3" style="text-align: right;"><fmt:message key="label.saoJoseDosPinhais" />, <fmt:formatDate value="${dataAtual}" type="both" pattern="dd 'de' MMMM 'de' yyyy"/>.</td>
	</tr>
	<tr>
		<td colspan="3">
			<strong><fmt:message key="label.artigoContratante" /> ${contrato.contratante.nome}.</strong>
			<br/><br/>
			
			<strong><fmt:message key="label.referenciaConfirmacaoInstalacao" /></strong>
			<br/><br/>
			
			Em aten&ccedil;&atilde;o &agrave; solicita&ccedil;&atilde;o de Vossa Senhoria, a SASCAR informa que o ve&iacute;culo de placa <strong>${detalheContrato.veiculo.placa }</strong>, modelo <strong>${detalheContrato.veiculo.descricaoModelo}</strong>,
			ano <strong>${detalheContrato.veiculo.anoFabricacao}</strong>, cor <strong>${detalheContrato.veiculo.cor}</strong>, chassi <strong>${detalheContrato.veiculo.chassi}</strong>, devidamente cadastrado pelo contratante <strong>${contrato.contratante.nome}</strong>
			, inscrito no CNPJ/MF sob o n&ordm; <strong>${detalheContrato.contratante.numCpfCnpj}</strong>, possui equipamento rastreador
			instalado, atualmente da classe <strong>${detalheContrato.servicoContratado}</strong>.
			Informamos ainda  que a(o) contratante supracitado encontra-se adimplente com suas obriga&ccedil;&otilde;es financeiras
			junto &agrave; Sascar, at&eacute; a presente data.
			
			<br/>
			Sendo o que se apresentou para o momento, subescrevemo-nos, mantendo-nos a disposi&ccedil;&atilde;o para quaisquer
			esclarecimentos necess&aacute;rios.
			<br/>
			Cordialmente,
			<br/><br/>
			SASCAR TECNOLOGIA E SEGURAN&Ccedil;A AUTOMOTIVA S/A.
			<br/><br/>
			<strong>Estas informa&ccedil;&otilde;es decorrem de consulta ao <i>Portal Atendimento Sascar</i> realizado no dia <fmt:formatDate value="${dataAtual}" pattern="dd/MM/yyyy"/>, &agrave;s <fmt:formatDate value="${dataAtual}" pattern="HH:mm"/> h.</strong>
			
			<br/><br/>
			A valida&ccedil;&atilde;o da autencidade deste documento poder&aacute; ser feita atrav&eacute;s do site www.sascar.com.br digitando
			o c&oacute;digo abaixo: 
			
			<br/>
			<strong>${param.codigoValidador}</strong>
		</td>
	</tr>
</table>

<div class="botaoImprimir" style=" text-align: center;">
 	<input type="submit" class="button" id="submit" onclick="window.print()" value="<fmt:message key="label.imprimir" />"/>
</div>
		
		
