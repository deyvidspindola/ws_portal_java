<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/RetirarEquipamentosAcessorios/carregarInformacoesRetiradaEquipamento?acao=4" context="/SascarPortalWeb"  />
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

	function confirmarRemocaoEquipameno(form) {
		var data = $(form).serialize();
		$.ajax({
			url: "/SascarPortalWeb/RetirarEquipamentosAcessorios/confirmarRemocaoEquipameno?acao=5",
			data: data || {},
			dataType:"json",
			success: function(json){
				if (json.success) {
					
					var quantidadeRestanteAcessorios = json.acessoriosRestantesAtual;		
					var quantidadeTotalAcessorios = json.totalAcessoriosAtual;		
					
					// valida equipamento que não tem nenhum acessorio vinculado.
					if(quantidadeTotalAcessorios == 0 ){
					
						$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC34/dv08&numeroOS=${param.numeroOS }");
						$(form).unbind('submit').submit();
						
					}else{
					
						// validae se equipamento possue acessórios para sere removidos.
						if(quantidadeRestanteAcessorios == 0 && quantidadeTotalAcessorios != 0 ){
							
							$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC34/dv08&numeroOS=${param.numeroOS }");
							$(form).unbind('submit').submit();
						}else{
							
							$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC34/dv06");
							$(form).unbind('submit').submit();
						}
					}
				
				} else {
					$(form).attr("action", "");
					$.showMessage(json.mensagem);
				}
			}
		});
	}
	
	function showModalConfirmarRetiradaEquipamento() {
		$.ajax({
			url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC34/dv05",
			data: {"serialEquipamento" : $("#serialEquipamento").val()},
			dataType:"html",
			success: function(html){
				$("#popupConfirmacaoRetirada").html(html).jOverlay({
					bgClickToClose : false, 
					closeOnEsc : false
				});
			}
		});
	}
	
</script>

	<form action="" method="post" id="formExcluirAcessorio">
		
		<input type="hidden" name="acao" value="5" />
		
		<input type="hidden" name="numeroOS"      id="numeroOS" value="${param.numeroOS }" />
		<input type="hidden" name="numeroCPF"     value="${param.numeroCPF }" />
		<input type="hidden" name="chassiVeiculo" value="${param.chassiVeiculo}" />
		<input type="hidden" name="placaVeiculo"  value="${param.placaVeiculo}" />
		
		<input type="hidden" name="serialEquipamento" id="serialEquipamento" value="${equipamento.numeroSerial}" />
		
		<div class="cabecalho3">
			<div class="caminho3" style="*margin-left:360px;">
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; 
				<a href="#" class="linktres"><fmt:message key="label.informacoes" /></a> &gt; 
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC34/dv01" class="linkquatro"><fmt:message key="label.retiradaEquipamentoAcessorio" /></a>
			</div>
			<fmt:message key="label.retiradaEquipamentoAcessorio" />
		</div>				
		
		<!-- ABRE DIV PRINCIPAL -->
	    <div class="principal">
	    
	    	<!-- INICIO BLOCO 01 - DADOS DO VEICULO -->
	    	<div class="tarjaAzul">
				<label><fmt:message key="label.dadosVeiculo" /></label>
			</div>
	    	
	    	<div class="bloco">
	    	
	    		<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.NumOS" /></label>
					</div>
				
					<div class="colulaCamposInternos">
						<label>${param.numeroOS}</label>
					</div>
				</div>
				
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.placa" /></label>
					</div>
				
					<div class="colulaCamposInternos">
						<label>${param.placaVeiculo}</label>
					</div>
				</div>
				
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.chassi" /></label>
					</div>
				
					<div class="colulaCamposInternos">
						<label>${param.chassiVeiculo}</label>
					</div>
				</div>
				
				<!-- ANTES DE FECHAR A DIV BLOCO -->
				<div style="clear: both"></div>
	    	
	    	</div>
	    	<!-- FIM BLOCO 01 - DADOS DO VEICULO -->
	    	
	    	<!-- INICIO BLOCO 2 - RETIRADA DE EQUIPAMENTO -->
			<div class="tarjaAzul">
				<label>Retirada de Equipamento</label>
			</div>
			
			<div class="bloco">
			
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.modelo" /></label>
					</div>
				
					<div class="colulaCamposInternos">
						<label>${equipamento.modelo}</label>
					</div>
				</div>
				
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.versao" /></label>
					</div>
				
					<div class="colulaCamposInternos">
						<label>${equipamento.versao}</label>
					</div>
				</div>
				
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.serie" /></label>
					</div>
				
					<div class="colulaCamposInternos">
						<label>${equipamento.numeroSerial}</label>
					</div>
				</div>
				
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.idSascarga" /> </label>
					</div>
				
					<div class="colulaCamposInternos">
						<label>${equipamento.codigoSascarga}</label>
					</div>
				</div>
			
				<!-- ANTES DE FECHAR A DIV BLOCO -->
				<div style="clear: both"></div>
			
			</div>
			<!-- FIM BLOCO 2 - RETIRADA DE EQUIPAMENTO -->
	    	
	    </div>
	    <!-- FECHA DIV PRINCIPAL -->
			
		<div class="pgstabela">
			<p>
				<input type="button" 
				       class="button4" 
				       value="<fmt:message key="label.voltar" />" 
				       onclick="javascript: location.href='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC34/dv03&numeroOS=${param.numeroOS}&numeroCPF=${param.numeroCPF}&chassiVeiculo=${param.chassiVeiculo}&placaVeiculo=${param.placaVeiculo}';" />
				
				<input class="button" 
					   value="<fmt:message key="label.continuar" />" 
					   type="button" 
					   onclick="showModalConfirmarRetiradaEquipamento()" />
			</p>
		</div>
	</form>	
	
	<!-- DIV MODAL DV05 - TELA CONFIRMACAO RETIRADA EQUIPAMENTO -->
	<div id="popupConfirmacaoRetirada" style="display: none;"></div>

