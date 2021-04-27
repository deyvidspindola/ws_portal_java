<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/RetirarEquipamentosAcessorios/carregarOrdemServicoRetiradaEquipamentoAcessorios?acao=1" context="/SascarPortalWeb"  />
</c:catch>

<script type="text/javascript">
	$(document).ready(function(){
		habilitarRodapeLinkVersaoMobile();
	});
</script>

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

	<div class="cabecalho3" >
			<div class="caminho3" style="*margin-left:360px;">
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; 
				<a href="#" class="linktres"><fmt:message key="label.informacoes" /></a> &gt; 
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC34/dv01"  class="linkquatro"><fmt:message key="label.retiradaEquipamentoAcessorio" /></a>
			</div>
		<fmt:message key="label.retiradaEquipamentoAcessorio" />
	</div>

	<form action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC34/dv02" 
		  id="formConfirmacaoDados" method="post" >
		  
	    <input type="hidden" name="numeroOS"         value="${ordemServico.numero}" />
	    <input type="hidden" name="chassiVeiculo"    value="${ordemServico.contrato.veiculo.chassi}" />
	    <input type="hidden" name="placaVeiculo"     value="${ordemServico.contrato.veiculo.placa}" />
	    
	    <!-- ABRE DIV PRINCIPAL -->
	    <div class="principal">
	    	
	    	<!-- INICIO BLOCO 01 - CONFIRMAÇÃO DE DADOS DE RETIRADA -->
	    	<div class="tarjaAzul">
				<label><fmt:message key="label.confirmeDadosRetirada" /></label>
			</div>
	    	
	    	<!-- A DIV BLOCO ENGLOBA OS CAMPOS DO FORMULARIO ( LABEL E INPUT  ) -->	
			<div class="bloco">
			
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.NumOS" /></label>
					</div>
				
					<div class="colulaCamposInternos">
						<label>${ordemServico.numero}</label>
					</div>
				</div>
				
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.dataCadastro" /></label>
					</div>
					
					<div class="colulaCamposInternos">
						<label>
							<fmt:formatDate value="${ordemServico.dataCadastro}" pattern="dd/MM/yyyy"/>
						</label>
					</div>
				</div>
				
				
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.prioridade" /></label>
					</div>
					
					<div class="colulaCamposInternos">
						<label>${ordemServico.prioridade}</label>
					</div>
				</div>
				
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.tipoDoContrato" /></label>
					</div>
					
					<div class="colulaCamposInternos">
						<label>${ordemServico.contrato.tipoContrato}</label>
					</div>
				</div>
				
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.Status" /></label>
					</div>
					
					<div class="colulaCamposInternos">
						<label>${ordemServico.status}</label>
					</div>
				</div>
				
				<div class="celula">
					<div class="colunaLabel">
						<label>Serviço Contratado</label>
					</div>
					
					<div class="colulaCamposInternos">
						<label>${ordemServico.contrato.servicoContratado}</label>
					</div>
				</div>
				
				<!-- ANTES DE FECHAR A DIV BLOCO -->
				<div style="clear: both"></div>
				
			</div>
	    	<!-- FIM BLOCO 01 - - CONFIRMAÇÃO DE DADOS DE RETIRADA -->
	    	
	    	<!-- INICIO BLOCO 2 - DADOS DO CLIENTE -->
			<div class="tarjaAzul">
				<label><fmt:message key="label.dadosCliente" /></label>
			</div>
			
			<div class="bloco">
			
				<!-- A DIV CELULA ENGLOBA A LABEL ( BARRA CINZA ) E O CAMPO DE APRESENTÇÃO DE DADOS DA SERVLET OU DE PARAMETROS DO FORM DA PAGINA ANTERIOR -->
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.NomeCliente" /></label>
					</div>
				
					<div class="colulaCamposInternos">
						<label>${ordemServico.contrato.contratante.nome}</label>
					</div>
				</div>
				
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.endereco" /></label>
					</div>
					
					<div class="colulaCamposInternos">
						<label>${ordemServico.contrato.contratante.endereco.descricaoLogradouro}</label>
					</div>
				</div>
				
				
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.cep" /></label>
					</div>
					
					<div class="colulaCamposInternos">
						<label>${ordemServico.contrato.contratante.endereco.cep}</label>
					</div>
				</div>
				
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="mensagem.selecione.cidade" /></label>
					</div>
					
					<div class="colulaCamposInternos">
						<label>${ordemServico.contrato.contratante.endereco.descricaoCidade}</label>
					</div>
				</div>
				
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="mensagem.selecione.estado" /></label>
					</div>
					
					<div class="colulaCamposInternos">
						<label>${ordemServico.contrato.contratante.endereco.descricaoUf}</label>
					</div>
				</div>
				
				<!-- ANTES DE FECHAR A DIV BLOCO -->
				<div style="clear: both"></div>
			
			</div>
			<!-- FIM BLOCO 2 - DADOS DO CLIENTE -->
			
			<!-- INICIO BLOCO 03 - Dados do Veículo -->
			<div class="tarjaAzul">
				<label><fmt:message key="label.dadosVeiculo" /></label>
			</div>
			
			<!-- A DIV BLOCO ENGLOBA OS CAMPOS DO FORMULARIO ( LABEL E INPUT  ) -->	
			<div class="bloco">
	    	
	    	
	    		<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.marca" /></label>
					</div>
					
					<div class="colunaInput" > 
						<select name="marca" class="colunaInputCombo" disabled="disabled">
							<option>${ordemServico.contrato.veiculo.descricaoMarca}</option>
						</select>
					</div>
				</div>
				
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.modelo" /></label>
					</div>
					
					<div class="colunaInput">
						<select name="modelo" class="colunaInputCombo" disabled="disabled">
							<option>${ordemServico.contrato.veiculo.descricaoModelo}</option>
						</select>
					</div>
				</div>
				
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.ano" /></label>
					</div>
					
					<div class="colunaInput">
						<input type="text" name="ano" class="inputCelula" disabled="disabled" value="${ordemServico.contrato.veiculo.anoFabricacao}" />
					</div>
				</div>
				
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.placa" /></label>
					</div>
					
					<div class="colunaInput">
						<input type="text" name="ano" class="inputCelula" disabled="disabled" value="${ordemServico.contrato.veiculo.placa}" />
					</div>
				</div>
				
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.chassi" /></label>
					</div>
					
					<div class="colunaInput">
						<input type="text" name="ano" class="inputCelula" disabled="disabled" value="${ordemServico.contrato.veiculo.chassi}" />
					</div>
				</div>
				
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.cor" /></label>
					</div>
					
					<div class="colunaInput">
						<input type="text" name="ano" class="inputCelula" disabled="disabled" value="${ordemServico.contrato.veiculo.cor}" />
					</div>
				</div>
				
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.particularidades" /></label>
					</div>
					
					<div class="colunaInput">
						<textarea id="observacao" class="colunaInputTextArea" disabled="disabled" name="observacao"  readonly="readonly" >
							${ordemServico.observacao} 
						</textarea>
					</div>
				</div>
				
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.localDeInstalacao" /></label>
					</div>
					
					<div class="colunaInput">
						<input type="text" name="ano" class="inputCelula" disabled="disabled" value="${ordemServico.localInstalacaoEquipamento}" />
					</div>
				</div>
				
				<div style="clear: both"></div>
				
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.numeroDoContrato" /></label>
					</div>
					
					<div class="colunaInput">
						<input type="text" name="ano" class="inputCelula" disabled="disabled" value="${ordemServico.contrato.numeroContrato}" />
					</div>
				</div>
	    
	    			
	    		<!-- ANTES DE FECHAR A DIV BLOCO -->
				<div style="clear: both"></div>
				
			</div>
	    	<!-- FIM BLOCO 03 - Dados do Veículo -->
	    
	    </div>
		<!-- FECHA DIV PRINCIPAL -->
				
		<div class="pgstabela">
			<p>
				<input class="button4" 
					   value="<fmt:message key="label.voltar" />" 
					   type="button"
					   onclick="javascript: location.href='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv02';" />
			
				<input class="button" value="<fmt:message key="label.continuar" />" type="submit" />
			</p>
		</div>
	
	</form>
