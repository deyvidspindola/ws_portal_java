<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>	

<c:catch var="helper" >
	<c:import url="/RetirarEquipamentosAcessorios/carregarResumoFinal?acao=8" context="/SascarPortalWeb"  />
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

	function showModalBtnConcluir(){
		$.ajax({
			url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC34/dv09",
			dataType:"html",
			success: function(html){
				$("#popupConcluir").html(html).jOverlay({
					bgClickToClose : false, 
					closeOnEsc : false
				});
			}
		});
	}
	
	function finalizarProcesso(form){
		$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv01");
		$(form).unbind('submit').submit();
	}
	
	function concluirRemocao(form){
		
		var data = $(form).serialize();
		
		$.ajax({
			url: "/SascarPortalWeb/RetirarEquipamentosAcessorios/finalizarOrdemServico?acao=11",
			data: data || {},
			dataType:"json",
			success: function(json){
				if (json.success) {
					
					showModalBtnConcluir();
					
				} else {
					$(form).attr("action", "");
					$.showMessage(json.mensagem);
				}
			}
		});
		
	}	
	
	function gerarNovaOrdemServico(form){
		$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC34/dv10");
		$(form).unbind('submit').submit();
	}

</script>
	
	<div class="cabecalho3">
		<div class="caminho3" style="*margin-left:360px;">
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; 
			<a href="#" class="linktres"><fmt:message key="label.informacoes" /></a> &gt; 
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC34/dv01"  class="linkquatro"><fmt:message key="label.retiradaEquipamentoAcessorio" /></a>
		</div>
		<fmt:message key="label.retiradaEquipamentoAcessorio" />
	</div>		

	<form method="post"	id="formGerarOSReisntalacao" action="">
		<input type="hidden" name="numeroCPF" value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS" value="${param.numeroOS}" />
	</form>

	<form id="formResumoFinal" method="post" action="">
	
		<input type="hidden" name="numeroCPF" value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS" value="${param.numeroOS}" />

		<table cellspacing="0" class="detalhe" >
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.servicosRetiradosDoContrato" /></th>
			</tr>
		</table>
	
		<table width="960" cellpadding="1px" ID="alter_extrato" cellspacing="0px">
			<tr>
				<th colspan="6"scope="col" style="background-color:#CCC; color:#333"><fmt:message key="label.servicosRetiradosDoContrato" /></th>
			</tr>
			
			<tr>
				<th width="50%"scope="col"><fmt:message key="label.equipamentoAcessorio" /></th>
				<th width="30%" scope="col"><fmt:message key="label.Status" /></th>
			</tr>
			
			<c:forEach var="acessorios" items="${acessoriosQuantidade}" varStatus="status">
				<tr class="dif">
					<td>${acessorios.descricao}</td>
					<td class="linkazul"><fmt:message key="label.retirado" /></td>
				</tr>
			</c:forEach>
	
		</table>
		
		<div class="pgstabela" style="*margin-left:0px;">
			<p>
				<input type="button" 
				       class="button4" 
					   value="<fmt:message key="label.voltar" />" 
					   onclick="javascript: location.href='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC34/dv03&numeroOS=${param.numeroOS}&numeroCPF=${param.numeroCPF}&chassiVeiculo=${param.chassiVeiculo}&placaVeiculo=${param.placaVeiculo}';" />
				
				<input type="button" class="button" value="<fmt:message key="label.concluir" />" onclick="concluirRemocao('#formResumoFinal');"/>
			</p>
		</div>
	
	</form>
	
	<!-- CHAMA A PAGINA DV09 -->
	<div id="popupConcluir" style="display: none;"></div>
