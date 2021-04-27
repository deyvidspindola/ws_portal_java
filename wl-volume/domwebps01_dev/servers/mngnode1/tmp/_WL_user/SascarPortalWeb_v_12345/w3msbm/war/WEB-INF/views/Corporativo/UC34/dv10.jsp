<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>	

<c:catch var="helper" >
	<c:import url="/RetirarEquipamentosAcessorios/listarVeiculosReinstalacao?acao=9" context="/SascarPortalWeb"  />
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
	
		function concluirGerarNovaOS(form){
			$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv01");
			$(form).unbind('submit').submit();
		}
		
		function gerarNovaOS(form){
			var data = $(form).serialize();
		
			$.ajax({
				url: "/SascarPortalWeb/RetirarEquipamentosAcessorios/gerarOrdemServicoReinstalacaoRetirada?acao=10",
				data: data || {},
				dataType:"json",
				success: function(json){
				
					if (json.success) {
						
						var ordemServicoReinstalacao = json.ordemServicoReinstalacao;
						$("#ordemServicoReinstalacao").val(ordemServicoReinstalacao);
						abrirModalConfirmacaoNovaOS(form);
						
					} else {
						$(form).attr("action", "");
						$.showMessage(json.mensagem);
					}
					
				}
			});
		}
		
		function abrirModalConfirmacaoNovaOS(form){
			
			var data = $(form).serialize();
		
			$.ajax({
				url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC34/dv11",
				data: data || {
					"ordemServicoReinstalacao" : $("#ordemServicoReinstalacao").val()			
				},
				dataType:"html",
				success: function(html){
					$("#popupConcluirGeracaoNovaOS").html(html).jOverlay({
						bgClickToClose : false, 
						closeOnEsc : false
					});
				}
			});
		}
	
	</script>
	
	<!-- FORM VOLTAR  -->
	<form method="post" id="formVoltar" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC34/dv08">
		<input type="hidden" name="numeroCPF" value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS" value="${param.numeroOS}" />
	</form>
	
	<form method="post" action="" id="formListaVeiculosReinstalacao">
		<input type="hidden" name="tipoSumbeterVeiculoReinstalacao" value="I" />
		<input type="hidden" name="ordemServicoReinstalacao" id="ordemServicoReinstalacao" value="" />
		<input type="hidden" name="numeroCPF" value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS"  value="${param.numeroOS}" />
	
		<div class="cabecalho3">
			<div class="caminho3" style="*margin-left:360px;">
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; 
				<a href="#" class="linktres"><fmt:message key="label.informacoes" /></a> &gt; 
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC34/dv01"  class="linkquatro"><fmt:message key="label.retiradaEquipamentoAcessorio" /></a>
			</div>
			<fmt:message key="label.retiradaEquipamentoAcessorio" />
		</div>		
	
		<!-- ABRE DIV PRINCIPAL -->
		<div class="principal">
		
			<!-- INICIO BLOCO 01 -->
			<div class="tarjaAzul">
				<label><fmt:message key="label.listaVeiculosReinstalacao" /></label>
			</div>
			
			<div class="bloco">
			
				<p class="texttable_azul_veiculos_reinstalacao"><fmt:message key="mensagem.selecione.placaGerarReinstalacao" /></p>
				
				<div id="tabelaVeiculosReinstalacao" class="divTabelaVeiculosReinstalacao">
					
					<table style="margin:10px 10px 10px 0px;" cellspacing="0" width="300px" ID="alter">
					
						<tr id="headar_tabelaPlacasAdicionadas">
							<th class="texttable_azul" width="10%" >&nbsp;</th>
							<th class="texttable_azul" width="30%" ><fmt:message key="label.placa" /></th>
							<th class="texttable_azul" width="40%" ><fmt:message key="label.chassi" /></th>
							<th class="texttable_azul" width="20%"><fmt:message key="label.cor" /></th>
						</tr>
						
						<tbody id="tbodyPlacas">
							<c:forEach items="${listaVeiculosReinstalacao}" var="veiculo" varStatus="numLinha">
								
								<c:choose>  
									<c:when test="${numLinha.count % 2 == 0}">
										<tr>
									</c:when>  
									<c:otherwise>
										<tr class="dif">
									</c:otherwise>  
								</c:choose>
									
									<td class="camposinternos">
										<input type="radio" 
											   name="codVaiculoSelecionado" 
											   id="codVaiculoSelecionado" 
											   class="required"  
											   value="${veiculo.codigo}" />
									</td>
									
									<td class="camposinternos">${veiculo.placa}</td>
									<td class="camposinternos">${veiculo.chassi}</td>
									<td class="camposinternos">${veiculo.cor}</td>
										
								</tr>
			
							</c:forEach>
						</tbody>
					
					</table>
					
				</div>
				
				<!-- ANTES DE FECHAR A DIV BLOCO -->
				<div style="clear: both"></div>
			</div>
			<!-- FIM BLOCO 01 -->
			
			
			<!-- DIV BOTOES -->
			<div class="posicaoBotoes">
			     <div class="botoes">
				    <p>
				        <input type="button" class="button4" value="<fmt:message key="label.voltar" />"  onclick="$('#formVoltar').submit();"/>
				        <input type="button" class="button" value="<fmt:message key="label.concluir" />" onclick="gerarNovaOS('#formListaVeiculosReinstalacao')"/>
				    </p>
			    </div>
			    
		    	<div style="clear: both;" ></div>
		    </div>
				
		</div>
		<!-- FECHA DIV PRINCIPAL -->
	
	</form>
	
	<!-- DIV MODAL DV11 - TELA CONFIRMACAO GERACAO DE O.S. DE REINSTALACAO  -->
	<div id="popupConcluirGeracaoNovaOS" style="display: none;"></div>