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
			url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/Mobile/UC34/dv09",
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
		$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv01");
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
		$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC34/dv10");
		$(form).unbind('submit').submit();
	}

</script>

<form method="post"	id="formGerarOSReisntalacao" action="">
	<input type="hidden" name="numeroCPF" value="${param.numeroCPF }" />
	<input type="hidden" name="numeroOS" value="${param.numeroOS}" />
</form>

<form action="" method="post" id="formPesquisa" class="filtro">	
	<input type="hidden" name="chassiVeiculo" value="${param.chassiVeiculo}" />
	<input type="hidden" name="placaVeiculo"  value="${param.placaVeiculo}" />
	<input type="hidden" name="numeroOS" value="${param.numeroOS}" />
		
		<table id="alter_extrato" width="100%" cellpadding="0" cellspacing="5" border="0" class="dados">
			<tr align="center">
				<th style="background-color: rgb(204, 204, 204); color: rgb(51, 51, 51);" scope="col" colspan="5"><fmt:message key="label.servicosRetiradosDoContrato" /></th>
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
		
		<br />
		
		<div class="pgstabela" align="center">
			<p>
				<input type="button" class="aButton ui-state-default ui-corner-all" value="<fmt:message key="label.concluir" />" onclick="concluirRemocao('#formPesquisa');"/>
			</p>
		</div>
		
	</form>
	
	<!-- CHAMA A PAGINA DV09 -->
	<div id="popupConcluir" style="display: none;"></div>
	
	<jsp:include page="/WEB-INF/views/Corporativo/Mobile/icones.jsp">
		<jsp:param name="voltar" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC34/dv03&numeroOS=${param.numeroOS}&numeroCPF=${param.numeroCPF}&chassiVeiculo=${param.chassiVeiculo}&placaVeiculo=${param.placaVeiculo}"/>
	</jsp:include>
