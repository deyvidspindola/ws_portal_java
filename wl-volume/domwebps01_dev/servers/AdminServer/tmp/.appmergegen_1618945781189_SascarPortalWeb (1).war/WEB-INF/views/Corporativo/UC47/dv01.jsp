<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/SolicitarOrdemServicoReinstalacaoPendente/carregarCombosVeiculos?acao=1" context="/SascarPortalWeb"  />
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
		
		function gerarOrdemServicoReinstalacao(form){
		
			var data = $(form).serialize();
			
			$.ajax({
				url: "/SascarPortalWeb/SolicitarOrdemServicoReinstalacaoPendente/gerarOrdemServicoReinstalacao?acao=2",
				data: data || {},
				dataType:"json",
				success: function(json){
					if (json.success) {
						
						var ordemServicoReinstalacao = json.ordemServicoReinstalacao;
						$("#ordemServicoReinstalacao").val(ordemServicoReinstalacao);
						abrirModalConfirmacaoGeracaoOrdemServicoReinstalacao(form);
					
					} else {
						$(form).attr("action", "");
						$.showMessage(json.mensagem);
					}
				}
			});
			
		}
		
		function abrirModalConfirmacaoGeracaoOrdemServicoReinstalacao(form){
			
			var data = $(form).serialize();
		
			$.ajax({
				url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC47/dv02",
				data: data || {
					"ordemServicoReinstalacao" : $("#ordemServicoReinstalacao").val()			
				},
				dataType:"html",
				success: function(html){
					$("#popupConcluirGeracaoOrdemServicoReinstalacao").html(html).jOverlay({
						bgClickToClose : false, 
						closeOnEsc : false
					});
				}
			});
		}
		
		function concluirGeracaoOrdemServicoReinstalacao(form){
			$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC47/dv01");
			$(form).unbind('submit').submit();
		}
	
		$(document).ready(function(){
			var container = $('div.container2');
			$("#formSolicitarcaoOrdemServicoPendente").validate({
				errorContainer: container,
				errorLabelContainer: $("ol", container),
				wrapper: 'li',
				submitHandler : function(form) {
					gerarOrdemServicoReinstalacao(form);
					return false;
				}
			});
			
		});
	</script>
	
	<!-- CSS IN LINE PARA CORRIGIR POSICIONAMENTO DO TEXTO NO CABECALHO -->
	<div class="cabecalho" style="padding-left: 140px; width: 820px;">
		<div class="caminho" style="*margin-left:400px; width: 360px;" >
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; 
			<a href="#" class="linktres"><fmt:message key="label.servicos" /></a> &gt; 
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC47/dv01" class="linkquatro"><fmt:message key="label.solicitarOSReinstalacaoPendente" /></a>
		</div>
	  	<fmt:message key="label.solicitarOSReinstalacaoPendente" />
	</div>
	
	<div class="container2">
		<ol>
			<li><label for="codContratoVeiculoRetirada" class="error"><fmt:message key="mensagem.selecione.veiculoRetirada" /></label></li>
			<li><label for="veiculoReislatacao" class="error"><fmt:message key="mensagem.selecione.veiculoReinstalacao" /></label></li>
		</ol>
	</div>
	
	<form method="post" action="" id="formSolicitarcaoOrdemServicoPendente">
		<input type="hidden" value="123456" id=numeroContrato" />
		<input type="hidden" name="ordemServicoReinstalacao" id="ordemServicoReinstalacao" value="" />
		
		<table width="960" cellspacing="3" class="detalhe2">
			
			<tr>
				<td class="camposinternos"  colspan="4">
					<p style="padding: 15px;">
						<fmt:message key="uc47.dv01.texto.01" />
				    </p>
				</td>
			</tr>	

			<tr>
				<th class="barracinza"><fmt:message key="label.veiculoRetirada" /></th>
				<td class="camposinternos">
					<select style="width:220px;" class="required" name="codContratoVeiculoRetirada" id="codContratoVeiculoRetirada">
						<option value=""><fmt:message key="label.selecione" /></option>
						<c:forEach var="contrato" items="${listaContratoVeiculosRetirada}" >
							<c:if test="${not empty contrato.veiculo.codigo && not empty contrato.numeroContrato}">
						 		<option value="${contrato.numeroContrato}">${contrato.veiculo.placa} / ${contrato.servicoContratado} </option>
							</c:if>
						</c:forEach>
					</select>
				</td>
				<th class="barracinza"><fmt:message key="label.veiculoReinstalacao" /></th>
				<td class="camposinternos">
					<select style="width:220px;" class="required" name="veiculoReislatacao" id="veiculoReislatacao">
						<option value=""><fmt:message key="label.selecione" /></option>
						<c:forEach var="veiculo" items="${listaVeiculosReinstalacao}" >
							<c:if test="${not empty veiculo.codigo && not empty veiculo.placa}">
						 		<option value="${veiculo.codigo}">${veiculo.placa} / ${veiculo.chassi}</option>
							</c:if>
						</c:forEach>
					</select>
				</td>
			</tr>	
			
			<tr>
				<td colspan="4">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="4" style="text-align: center;">
					 <input type="submit" class="button" value="<fmt:message key="label.gerarOsReinstalacao" />"/>
				</td>
			</tr>
	</table>
		
	</form>
	
	<div id="popupConcluirGeracaoOrdemServicoReinstalacao" style="display: none;"></div>