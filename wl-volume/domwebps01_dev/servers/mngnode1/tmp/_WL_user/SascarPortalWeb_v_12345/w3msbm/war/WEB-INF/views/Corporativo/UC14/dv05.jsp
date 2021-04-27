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

<c:choose>
	<c:when test="${empty contrato.veiculo.dataHoraRoubo or empty contrato.veiculo.dataHoraComunicadoRoubo}">
		<div id="divMessageError">
			<h3 class="erro" style="margin-top:20px;">
				<p class="text4" style="font-size:18px;">Declara&ccedil;&atilde;o não emitida!</p>
			</h3>
			<div style="font-size:12px;">Por favor, entre em contato com a nossa <img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/naemitida-42.png" align="absmiddle" width="135" height="14" />ou pelo email <a href="mailto:infosinistro@sascar.com.br" class="linkcinco">infosinistro@sascar.com.br.</div>
			<p><img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/naemitida-43.png" width="488" height="70" /></p>
			<p><input type='button' class='button' style="margin-top:20px;" value='Fechar' onclick='window.close();'/></p>
		</div>
	</c:when>
	<c:otherwise>
		
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
				<td colspan="3">
					<strong>SANTANA DE PARNA&Iacute;BA</strong> - <strong>SP</strong>, <strong><fmt:formatDate value="${dataAtual}" pattern="dd/MM/yyyy"/>.</strong> 
		
					<br/><br/>
					&Agrave; <strong>${contrato.contratante.nome}</strong>.<br/><br/>
					 
					<strong>Ref.: Confirma&ccedil;&atilde;o de instala&ccedil;&atilde;o de equipamento rastreador.</strong>
					<br/><br/>
					
					Em aten&ccedil;&atilde;o &agrave; solicita&ccedil;&atilde;o de Vossa Senhoria, a Sascar informa que o ve&iacute;culo de placa <strong>${contrato.veiculo.placa }</strong>,
					modelo <strong>${contrato.veiculo.descricaoModelo }</strong>, marca <strong>${contrato.veiculo.descricaoMarca }</strong>, 
					ano <strong>${contrato.veiculo.anoFabricacao}</strong>, cor <strong>${contrato.veiculo.cor}</strong>, chassi <strong>${contrato.veiculo.chassi}</strong>, 
					devidamente cadastrado pelo contratante <strong>${contrato.contratante.nome}</strong>, inscrito 
					no CNPJ/MF sob o número <strong>${contrato.contratante.numCpfCnpj}</strong>, possu&iacute;a instalado o equipamento rastreador da classe <strong>${contrato.servicoContratado}</strong> at&eacute; a data de <strong><fmt:formatDate value="${contrato.veiculo.dataHoraRoubo}" pattern="dd/MM/yyyy"/></strong>. 
		
					O ve&iacute;culo supra citado foi roubado no dia <strong><fmt:formatDate value="${contrato.veiculo.dataHoraRoubo}" pattern="dd/MM/yyyy"/></strong> 
					por volta das <strong><fmt:formatDate value="${contrato.veiculo.dataHoraRoubo}" pattern="HH:mm"/></strong> horas e a Sascar foi informada no dia <strong><fmt:formatDate value="${contrato.veiculo.dataHoraComunicadoRoubo}" pattern="dd/MM/yyyy"/></strong> &agrave;s <strong><fmt:formatDate value="${contrato.veiculo.dataHoraComunicadoRoubo}" pattern="HH:mm"/></strong> horas. 
		
					Informamos ainda que o (a) contratante supracitado encontra-se adimplente com suas obriga&ccedil;&otilde;es financeiras junto &agrave; Sascar, at&eacute; a presente data. 
					 
					Sendo o que se apresentou para o momento, subscrevemo-nos, mantendo-nos &agrave; disposi&ccedil;&atilde;o para quaisquer esclarecimentos necess&aacute;rios. 
					<br/>
					Cordialmente, 
					
					<br/><br/>
					SASCAR TECNOLOGIA E SEGURAN&Ccedil;A AUTOMOTIVA S/A 
					
					<br/><br/>
					Estas informa&ccedil;&otilde;es decorrem da consulta ao Portal de Atendimento Sascar realizada no dia 
					<fmt:formatDate value="${contrato.dataHoraCodigoValidador}" pattern="dd/MM/yyyy"/>, &agrave;s <fmt:formatDate value="${contrato.dataHoraCodigoValidador}" pattern="HH:mm"/> h.  
		
					<br/><br/>
					<span style="color:#0D72DA;">A valida&ccedil;&atilde;o da autenticidade deste documento poder&aacute; ser feita atrav&eacute;s do site <span style="color:#00417B;"><strong><i>www.sascar.com.br</i></strong></span> digitando o c&oacute;digo abaixo:</span>
					<br/>
					<span style="font-weight:bold; color:#00417B;">${contrato.codigoValidador}</span>
				</td>
			</tr>
		</table>
	</c:otherwise>
</c:choose>
