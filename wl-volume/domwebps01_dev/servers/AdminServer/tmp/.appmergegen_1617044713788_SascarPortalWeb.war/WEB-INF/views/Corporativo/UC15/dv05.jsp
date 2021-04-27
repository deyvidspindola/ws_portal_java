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


<c:choose>
	<c:when test="${empty detalheContrato.veiculo.dataHoraRoubo or empty detalheContrato.veiculo.dataHoraComunicadoRoubo}">
		<script type="text/javascript">
			$("#divMessageError").show().html('<fmt:message key="uc15.dv05.texto.001" />');
			
			setTimeout(function(){
			history.back(-1);
			}, 2000);
		</script>
		<br>
	</c:when>
	
	<c:otherwise>

		<style type="css/text" media="print">
			#botaoImprimir{
				display: none;
			}
		</style>

		<jsp:useBean id="dataAtual" class="java.util.Date" scope="request" />
		
		<table cellspacing="4" cellpadding="4" border="0">
			<tr>
				<td><img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/logo-sascar.jpg" alt="SASCAR" /></td>
				<td colspan="2" style="text-align: right;"><img src="${pageContext.request.contextPath}/sascar/images/corporativo/logo-iso-9001.png" alt="ISO 9001" /></td>
			</tr>
			<tr>
				<td colspan="3">
					<strong>SANTANA DO PARNA&Iacute;BA</strong> - <strong>SP</strong>, <strong><fmt:formatDate value="${dataAtual}" pattern="dd/MM/yyyy"/></strong>
					<br/><br/>
					&Agrave; <strong>${contrato.contratante.nome}</strong>.<br/><br/>
					 
					<strong>Ref.: Confirma&ccedil;&atilde;o de instala&ccedil;&atilde;o de equipamento rastreador.</strong>
					<br/><br/>
					
					Em aten&ccedil;&atilde;o &agrave; solicita&ccedil;&atilde;o de Vossa Senhoria, a Sascar informa que o ve&iacute;culo de placa <strong>${detalheContrato.veiculo.placa }</strong>,
					modelo <strong>${detalheContrato.veiculo.descricaoModelo }</strong>, marca <strong>${detalheContrato.veiculo.descricaoMarca }</strong>, 
					ano <strong>${detalheContrato.veiculo.anoFabricacao}</strong>, cor <strong>${detalheContrato.veiculo.cor}</strong>, chassi <strong>${detalheContrato.veiculo.chassi}</strong>, 
					devidamente cadastrado pelo contratante <strong>${contrato.contratante.nome}</strong>, inscrito 
					no CNPJ/MF sob o n&uacute;mero <strong>${contrato.contratante.numCpfCnpj}</strong>, possu&iacute;a instalado o equipamento rastreador da classe <strong>${detalheContrato.servicoContratado}</strong> at&eacute; a data de <strong><fmt:formatDate value="${detalheContrato.veiculo.dataHoraRoubo}" pattern="dd/MM/yyyy"/></strong>. 
		
					O ve&iacute;culo supra citado foi roubado no dia <strong><fmt:formatDate value="${detalheContrato.veiculo.dataHoraRoubo}" pattern="dd/MM/yyyy"/></strong> 
					por volta das <strong><fmt:formatDate value="${detalheContrato.veiculo.dataHoraRoubo}" pattern="HH:mm"/></strong> horas e a Sascar foi informada no dia <strong><fmt:formatDate value="${detalheContrato.veiculo.dataHoraComunicadoRoubo}" pattern="dd/MM/yyyy"/></strong>, &agrave;s <strong><fmt:formatDate value="${detalheContrato.veiculo.dataHoraComunicadoRoubo}" pattern="HH:mm"/></strong> horas. 
		
					Informamos ainda que o (a) contratante supracitado encontra-se adimplente com suas obriga&ccedil;&otilde;es financeiras junto &agrave; Sascar, at&eacute; a presente data. 
					 
					Sendo o que se apresentou para o momento, subscrevemo-nos, mantendo-nos &agrave; disposi&ccedil;&atilde;o para quaisquer esclarecimentos necess&aacute;rios. 
					<br/>
					Cordialmente, 
					
					<br/><br/>
					SASCAR TECNOLOGIA E SEGURAN&Ccedil;A AUTOMOTIVA S/A 
					
					<br/><br/>
					Estas informa&ccedil;&otilde;es decorrem da consulta ao Portal de Atendimento Sascar realizada no dia 
					<fmt:formatDate value="${dataAtual}" pattern="dd/MM/yyyy"/>, &agrave;s <fmt:formatDate value="${dataAtual}" pattern="HH:mm"/> h.  
		
					<br/><br/>
					A valida&ccedil;&atilde;o da autenticidade deste documento poder&aacute; ser feita atrav&eacute;s do site www.sascar.com.br digitando o c&oacute;digo abaixo: 
					<br/>
					<strong>${param.codigoValidador}</strong>
				</td>
			</tr>
		</table>
		
			<div class="botaoImprimir" style=" text-align: center;">
				 <input type="submit" class="button" id="submit" onclick="window.print()" value="<fmt:message key="label.imprimir" />"/>
			</div>
			
	</c:otherwise>
</c:choose>
