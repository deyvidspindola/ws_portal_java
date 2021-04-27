<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/EmitirDeclaracoesServlet/detalharContratoDeclaracao?acao=2" context="/SascarPortalWeb"  />
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
  
<jsp:useBean id="dataAtual" class="java.util.Date" scope="request" />

<table cellspacing="4" cellpadding="4" border="0">
	<tr>
		<td><img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/logo-sascar.jpg" alt="SASCAR" /></td>
		<td colspan="2" style="text-align: right;"><img src="${pageContext.request.contextPath}/sascar/images/corporativo/logo-iso-9001.png" alt="ISO 9001" /></td>
	</tr>
	<tr>
		<td colspan="3" style="text-align: right;">S&atilde;o Jos&eacute; dos Pinhais, <fmt:formatDate value="${dataAtual}" type="both" pattern="dd 'de' MMMM 'de' yyyy"/>.</td>
	</tr>
	<tr>
		<td colspan="3">
			<strong>&Agrave; ${contrato.contratante.nome}.</strong>
			<br/><br/>
			
			<strong>Ref. Confirma&ccedil;&atilde;o de instala&ccedil;&atilde;o  de equipamento rastreador.</strong>
			<br/><br/>
			
			Em aten&ccedil;&atilde;o &agrave; solicita&ccedil;&atilde;o de Vossa Senhoria, a SASCAR informa que o ve&iacute;culo de placa <strong>${contrato.veiculo.placa }</strong>, modelo <strong>${contrato.veiculo.descricaoModelo}</strong>,
			ano <strong>${contrato.veiculo.anoFabricacao}</strong>, cor <strong>${contrato.veiculo.cor}</strong>, chassi <strong>${contrato.veiculo.chassi}</strong>, devidamente cadastrado pelo contratante <strong>${contrato.contratante.nome}</strong>
			, inscrito no CNPJ/MF sob o n&ordm; <strong>${contrato.contratante.numCpfCnpj}</strong>, possui equipamento rastreador
			instalado, atualmente da classe <strong>${contrato.servicoContratado}</strong>.
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
			Estas informa&ccedil;&otilde;es decorrem da consulta ao Portal de Atendimento Sascar, realizada no dia <fmt:formatDate value="${contrato.dataHoraCodigoValidador}" pattern="dd/MM/yyyy"/>, &agrave;s <fmt:formatDate value="${contrato.dataHoraCodigoValidador}" pattern="HH:mm"/> h.
			<br/><br/>
			<span style="font-weight:bold; color:#AF0C0C;">Para a valida&ccedil;&atilde;o da autenticidade deste documento, acesse o site <i>www.sascar.com.br</i>.</span>
			<br/>
			<span style="font-weight:bold; color:#00417B;">${contrato.codigoValidador}</span>
		</td>
	</tr>
</table>
