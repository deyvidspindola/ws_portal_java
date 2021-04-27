<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/AtivarEquipamentoTestes/listarTestesExecutados?acao=5" context="/SascarPortalWeb"  />
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
	function finalizarTestes(form) {
		$(':submit').attr('disabled', 'disabled');
		var data = $(form).serialize();
		$.ajax({
			url: "/SascarPortalWeb/AtivarEquipamentoTestes/finalizarTestes?acao=6",
			data: data || {},
			dataType:"json",
			success: function(json){
				if (json.success) {
					$("#dialog_mensagem").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
				} else {
					$.showMessage(json.mensagem);
				}
				$(':submit').removeAttr('disabled');
			}
		});
	}

	function reexecutar(){
		$(':button').attr('disabled', 'disabled');
		document.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC13/dv02&numeroCPF=${param.numeroCPF }&numeroOS=${param.numeroOS }&numeroPlaca=${param.numeroPlaca}&origem=${param.origem}&reiniciarTestes=S';
	}

	$(document).ready(function(){
		$('#ativar_equipamento').addClass('active');

		$("#formPesquisa").submit(function(){
			finalizarTestes(this);
			return false;
		});
	});
</script>

<h1><fmt:message key="label.testesAtivacaoEquipamento" /></h1>

<form name="formPesquisa" id="formPesquisa" action="" method="post">
	<input type="hidden" name="numeroCPF_testeEquipamento" value="${param.numeroCPF }" />
	<input type="hidden" name="numeroOS_testeEquipamento" value="${param.numeroOS }" />

	<fieldset>
		
		<div class="inputData"><fmt:message key="label.dataHora" /></div>
		<p class="font130">	
			<fmt:formatDate value="${equipamento.dataHoraPosicao }" pattern="dd/MM/yyyy HH:mm"/>
		</p>
		
		<div class="inputData"><fmt:message key="label.latitude" /></div>
		<p class="font130">${equipamento.latitude }</p>
		
		<div class="inputData"><fmt:message key="label.longitude" /></div>
		<p class="font130">${equipamento.longitude }</p>
		
		<div class="inputData"><fmt:message key="label.endereco" /></div>
		<p class="font130">${equipamento.descricaoEndereco }</p>
		
		<div class="inputData"><fmt:message key="label.satelites" /></div>
		<p class="font130">${equipamento.quantidadeSatelites }</p>
		
		<div class="inputData"><fmt:message key="label.hdop" /></div>
		<p class="font130">${equipamento.hdop }</p>
		
		<div class="inputData"><fmt:message key="label.velocidade" /></div>
		<p class="font130">${equipamento.velocidade } km/h</p>
		
		<div class="inputData"><fmt:message key="label.tensao" /></div>
		<p class="font130">${equipamento.tensao }</p>

		<div class="inputData"><fmt:message key="label.ignicao" /></div>
		<p><img width="48" height="48" src="${pageContext.request.contextPath}/sascar/images/mobile/bullet_${equipamento.statusIgnicao }.png" alt="${equipamento.statusIgnicao }" title="${equipamento.statusIgnicao }" /></p>

		<div class="inputData"><fmt:message key="label.statusGps" /></div>
		<p><img width="48" height="48" src="${pageContext.request.contextPath}/sascar/images/mobile/bullet_${equipamento.statusGPS }.png" alt="${equipamento.statusGPS }" title="${equipamento.statusGPS }" /></p>

		<div class="inputData"><fmt:message key="label.alimentacaoPrincipal" /></div>
		<p><img width="48" height="48" src="${pageContext.request.contextPath}/sascar/images/mobile/bullet_${equipamento.statusAlimentacao }.png" alt="${equipamento.statusAlimentacao }" title="${equipamento.statusAlimentacao }" /></p>

		<div class="inputData"><fmt:message key="label.statusPosicaoMemoria" /></div>
		<p><img width="48" height="48" src="${pageContext.request.contextPath}/sascar/images/mobile/bullet_${equipamento.statusPosicaoMemoria }.png" alt="${equipamento.statusPosicaoMemoria }" title="${equipamento.statusPosicaoMemoria }" /></p>

		<div class="inputData"><fmt:message key="label.statusPosicaoOnline" /></div>
		<p><img width="48" height="48" src="${pageContext.request.contextPath}/sascar/images/mobile/bullet_${equipamento.statusPosicaoOnline }.png" alt="${equipamento.statusPosicaoOnline }" title="${equipamento.statusPosicaoOnline }" /></p>
	
	</fieldset>

	<fieldset>

		<legend><strong><fmt:message key="label.testesAutomaticos" /></strong></legend>
		<c:if test="${not empty testes }">
			<table cellspacing="0" width="100%" class="list" style="margin-top: 15px;" border="0">
				<tbody>
					<tr>
						<th><fmt:message key="label.descricao" /></th>
						<th><fmt:message key="label.resultadoDoTeste" /></th>
					</tr>
					<c:forEach items="${testes }" var="teste">
						<tr>
							<td>${teste.nome }</td>
							<td>${teste.resultado }</td>
						</tr>
					</c:forEach>
				</tbody>
			 </table>
		</c:if>

		<p class="input" style="padding:10px; margin-top:10px; text-align: center;">
			<input type="button" onclick="reexecutar();" class="aButton ui-state-default ui-corner-all" value="<fmt:message key="label.reexecutarTestes" />" />
		</p>
		
		<p class="input" style="padding:10px; margin-top:10px; text-align: center;">
			<input type="submit" class="aButton ui-state-default ui-corner-all" value="<fmt:message key="label.concluir" />" /> 
		</p>

	</fieldset>
</form>

<div id="dialog_mensagem" class="window modal" style="display: none;">
	<div class="topo"></div>
	<div class="middle">
		<p style="text-align:center;"><fmt:message key="mensagem.sucesso.efetuarOperacao" /></p>
		<table width="100%" cellspacing="0">
			<tr>
				<td align="center">
					<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv01" title="<fmt:message key="label.fechar" />"><img src="${pageContext.request.contextPath}/sascar/images/corporativo/ico_voltar_modal.png" alt="<fmt:message key="label.fechar" />" /> <fmt:message key="label.fechar" /></a>
				</td>
			</tr>
		</table>
	</div>
	<div class="bottom"></div>
</div>