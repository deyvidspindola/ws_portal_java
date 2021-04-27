<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/ConsultarBorderosPagos/consultarOrdensServicoDisponiveis?acao=4" context="/SascarPortalWeb"  />
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
	
	function habilitaInputJustificativaPencia(element){
		
		elemen = $(element).attr('value');
		
		if($("#ordemServicoPendencia"+elemen).is(':checked')){
			$("#justificativaPendencia"+elemen).removeAttr("disabled");
		}else{
			$("#justificativaPendencia"+elemen).attr("disabled", "disabled");
			$("#justificativaPendencia"+elemen).val('');
		}
		
		
	}
	
	function habilitaInputObservacao(element){
		
		elemen = $(element).attr('value');
		
		if($("#ordemServico"+elemen).is(':checked')){
			$("#observacao"+elemen).removeAttr("disabled");
		}else{
			$("#observacao"+elemen).attr("disabled", "disabled");
			$("#observacao"+elemen).val('');
		}
		
	}

	function gerarBordero(form){
			
		// PEGANDO A REFERENCIA DA DIV DE MENSAGENS DE VALIDACAO
		var conteinerValidacao = $(".conteinerValidacao");
		
		// LIMPANDO AS MENSAGENS DE ERRO
		conteinerValidacao.find('li').remove();
		
		// CONCATENA AS INFORMACOES (NUMERO ORDEM SERVICO + JUSTIFICATIVA PENDENCIA)
		var dataOrdemServicoPendencia = "";
		
		// CONCATENA AS INFORMACOES (NUMERO ORDEM SERVICO + OBSERVACAO)
		var dataOrdemServico = "";
		
		// VARIAVEL UTILIZADA PARA CONCATENAR AS ORDENS DE SERVICO COM PENDENCIA SELECIONADAS
		var resultDataOrdemServicoPendencia = "";
		
		// VARIAVEL UTILIZADA PARA CONCATENAR AS ORDENS DE SERVICO SEM PENDENCIA SELECIONADAS
		var resultDataOrdemServico = "";
		
		// VARIAVEL UTILIZADA PARA CONTROLAR A REQUISICAO AJAX EM CASO DE ERRO DE VALIDACAO
		var naoPossuiErroValidacao = true;
		
		var errosValidacao = "";
		
		var checkboxSelecionados = 0;
		
		// ITERANDO TODOS checkbox
		$("input[type='checkbox']").each( function() {
			
			// VALIDA SE O checked ESTA SELECIONADO
			if($(this).is(':checked')){
				
				checkboxSelecionados = checkboxSelecionados + 1;
				
				// VERIFICA O TIPO DA ORDEM DE SERVICO, PARA VAIDAR OU NAO O CAMPO JUSTIFICATIVE DE PENDENCIA
				var tipoOrdemServico = $(this).attr('name');
				
				if(tipoOrdemServico == 'ordemServicoPendencia'){
				//Incluído para evitar que se pegue o primeiro checkbox selecionar todos
				 if(tipoOrdemServico != ''){
					var idNumeroOrdemServicoPendencia = $(this).val();
					var justificativaPendencia = $("#justificativaPendencia"+idNumeroOrdemServicoPendencia).val();
					var valorOrdemServicoPendencia = $("#valorOrdemServicoPendencia"+idNumeroOrdemServicoPendencia).val();
					var placaVeiculoPendencia = $("#placaOrdemServicoPendencia"+idNumeroOrdemServicoPendencia).val();
					var clientePendencia = $("#clientePendencia"+idNumeroOrdemServicoPendencia).val();
					
					if(justificativaPendencia != ""){
						dataOrdemServicoPendencia = idNumeroOrdemServicoPendencia+"|"+justificativaPendencia+"|"+valorOrdemServicoPendencia+"|"+placaVeiculoPendencia+"|"+clientePendencia;
						resultDataOrdemServicoPendencia = resultDataOrdemServicoPendencia + dataOrdemServicoPendencia + "'";
					}else{
						
						// CONTROLE PARA NAO IRA REALIZAR A CHAMADA AJAX
						naoPossuiErroValidacao = false;
						
						html = '<li><label><fmt:message key="uc29.texto.001.justificativaPendenciaOSNum"><fmt:param>'+ idNumeroOrdemServicoPendencia +'</fmt:param></fmt:message></label></li>';
					
						errosValidacao = errosValidacao + html; 
						
					}
				 }	
				}else{
				  //Incluído para evitar que se pegue o primeiro checkbox selecionar todos	
				  if(tipoOrdemServico != ''){	
					var idNumeroOrdemServico = $(this).val();
					var observacao = $("#observacao"+idNumeroOrdemServico).val();
					var valorOrdemServico = $("#valorOrdemServico"+idNumeroOrdemServico).val();
					var placaVeiculo = $("#placaOrdemServico"+idNumeroOrdemServico).val();
					var cliente = $("#cliente"+idNumeroOrdemServico).val();
					
					dataOrdemServico = idNumeroOrdemServico+"|"+observacao+"|"+valorOrdemServico+"|"+placaVeiculo+"|"+cliente;
					resultDataOrdemServico = resultDataOrdemServico + dataOrdemServico + "'";
				  }
				}
			}
			
		});
		
		if(checkboxSelecionados === 0){
			// CONTROLE PARA NAO IRA REALIZAR A CHAMADA AJAX
			naoPossuiErroValidacao = false;
			
			html = '<li><label><fmt:message key="uc29.texto.002.nenhumaOrdemServicoSelecionada" /></label></li>';
			conteinerValidacao.find('ol').append(html);
		}
		
		// CONTROLE PARA REALIZAR A LEITURA NA SERVLET DAS ORDENS DE SERVICO SELECIONADAS
		if(resultDataOrdemServicoPendencia === ""){
			resultDataOrdemServicoPendencia = '<fmt:message key="uc29.texto.003.nenhumaOrdemServico" />';
		}
		if(resultDataOrdemServico === ""){
			resultDataOrdemServico =  '<fmt:message key="uc29.texto.003.nenhumaOrdemServico" />';
		}
		
		// REALIZA CHAMADA A SERVLET
		if(naoPossuiErroValidacao){
			$.ajax({
				url: "/SascarPortalWeb/ConsultarBorderosPagos/submeterNovoBordero",
				data: {"ordemServicoPendencia" : resultDataOrdemServicoPendencia, "ordemServico" : resultDataOrdemServico, "acao" : 5},
				method: "post",
				dataType:"json",
				success: function(json){
					if (json != null && json.success) {
						
						var numeroBordero = json.numeroBordero;
						$("#numeroBordero").val(numeroBordero);
						
						var representanteBordero = json.representanteBordero;
						$("#representanteBordero").val(representanteBordero);
						
						var dataInclusaoBordero = json.dataInclusao;
						$("#dataInclusaoBordero").val(dataInclusaoBordero); 
						
						abrirModalConfirmacaoNovoBordero(form);
					} 
				}
			});  
		} else{
			
			$.ajax({
				url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC29/dv06",
				data: {"errosValidacao" : errosValidacao},
				dataType:"html",
				success: function(html){
					$("#popupErrosValidacao").html(html).jOverlay({
						bgClickToClose : false, 
						closeOnEsc : false
					});
				}
			});
			
		}
		
	}
	
	function abrirModalConfirmacaoNovoBordero(form){
		
		var data = $(form).serialize();
	
		$.ajax({
			url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC29/dv02",
			data: data || {
				"numeroBrdero" : $("#numeroBordero").val()
			},
			dataType:"html",
			success: function(html){
				$("#popupConfirmacaoNovoBordero").html(html).jOverlay({
					bgClickToClose : false, 
					closeOnEsc : false
				});
			}
		});
	}
	
	function abrirModalVisualizacaoObervacao(element){
		
		elemen = $(element).attr('name');
		
		var observacao = $("#observacaoOrdemServicoPendencia"+elemen).val();
		
		$.ajax({
			url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC29/dv03",
			data: {"observacao" : observacao},
			dataType:"html",
			success: function(html){
				$("#popupObservacaoOrdemServico").html(html).jOverlay({
					bgClickToClose : false, 
					closeOnEsc : false
				});
			}
		});
	}
	
	function resetForm(){
		
		/* DESABILITA E LIMPA OS CAMPOS DE INPUT */
		$("input[name='justificativaPendencia']").each( function() {
			$(this).val('');
			$(this).attr("disabled", "disabled");
		});
		
		$("input[name='observacao']").each( function() {
			$(this).val('');
			$(this).attr("disabled", "disabled");
		});
		
		/* DESABILITA OS CAMPOS checkbox */
		$("input[type='checkbox']").each( function() {
			$(this).removeAttr('checked');
		});
		
		// HABILITA NOVAMENTE A VISUALIZACAO DAS ORDENS DE SERVICO COM PENDENCIA
		if($("#div_ordens_servico_pendencia").hasClass("invisivel")){
		
			$("#div_ordens_servico_pendencia").removeClass("invisivel").addClass("visivel");
			$("#controlaExibicaoOrdensServicoPendenciaAtivo").removeClass("invisivel").addClass("visivel");
			$("#infoOrdensServicoPendencia").removeClass("invisivel").addClass("visivel");
			$("#controlaExibicaoOrdensServicoPendenciaInativo").removeClass("visivel").addClass("invisivel");
			
		}
		
		// HABILITA NOVAMENTE A VISUALIZACAO DAS ORDENS DE SERVICO SEM PENDENCIA
		if($("#div_ordens_servico_sem_pendencia").hasClass("invisivel")){
		
			$("#div_ordens_servico_sem_pendencia").removeClass("invisivel").addClass("visivel");
			$("#controlaExibicaoOrdensServicoSemPendenciaAtivo").removeClass("invisivel").addClass("visivel");
			$("#controlaExibicaoOrdensServicoSemPendenciaInativo").removeClass("visivel").addClass("invisivel");
			
		}
		
		// FUNCAO UTILIZADA PARA REDIMENCIONAR A TELA NO PORTAL EM ADF
		resizeIframeParent();
		
	}
	
	function controlaExibicaoOrdensServicoPendencia(){
		
		if($("#div_ordens_servico_pendencia").hasClass("visivel")){
			$("#div_ordens_servico_pendencia").removeClass("visivel").addClass("invisivel");
			$("#controlaExibicaoOrdensServicoPendenciaAtivo").removeClass("visivel").addClass("invisivel");
			$("#infoOrdensServicoPendencia").removeClass("visivel").addClass("invisivel");
			$("#controlaExibicaoOrdensServicoPendenciaInativo").removeClass("invisivel").addClass("visivel");
			
		}else{
			$("#div_ordens_servico_pendencia").removeClass("invisivel").addClass("visivel");
			$("#controlaExibicaoOrdensServicoPendenciaAtivo").removeClass("invisivel").addClass("visivel");
			$("#infoOrdensServicoPendencia").removeClass("invisivel").addClass("visivel");
			$("#controlaExibicaoOrdensServicoPendenciaInativo").removeClass("visivel").addClass("invisivel");
			
		}
		
		// FUNCAO UTILIZADA PARA REDIMENCIONAR A TELA NO PORTAL EM ADF
		resizeIframeParent();
		
	}
	
	function controlaExibicaoOrdensServicoSemPendencia(){

		if($("#div_ordens_servico_sem_pendencia").hasClass("visivel")){
			
			$("#div_ordens_servico_sem_pendencia").removeClass("visivel").addClass("invisivel");
			$("#controlaExibicaoOrdensServicoSemPendenciaAtivo").removeClass("visivel").addClass("invisivel");
			$("#controlaExibicaoOrdensServicoSemPendenciaInativo").removeClass("invisivel").addClass("visivel");
		
		}else{
			
			$("#div_ordens_servico_sem_pendencia").removeClass("invisivel").addClass("visivel");
			$("#controlaExibicaoOrdensServicoSemPendenciaAtivo").removeClass("invisivel").addClass("visivel");
			$("#controlaExibicaoOrdensServicoSemPendenciaInativo").removeClass("visivel").addClass("invisivel");
			
		}
		
		// FUNCAO UTILIZADA PARA REDIMENCIONAR A TELA NO PORTAL EM ADF
		resizeIframeParent();
		
	}
	
	$(document).ready(function(){
		
		
		 var container = $('div.container2');
		$("#formGerarBordero").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler : function(form) {
				gerarBordero(form);
			}
		});
		
		$("#selecionarTodosOrdensServicoPendencia").click(function(){
			
			var checked = this.checked; 
			
			$("input[name='ordemServicoPendencia']").attr("checked", checked);
			
			if(checked){
				$("input[name='justificativaPendencia']").each( function() {
					$(this).removeAttr("disabled");
				});
			}else{
				$("input[name='justificativaPendencia']").each( function() {
					$(this).val('');
					$(this).attr("disabled", "disabled");
				});
			}
			
		});
		
		$("#selecionarTodosOrdensServicoSemPendencia").click(function(){
			
			var checked = this.checked; 
			
			$("input[name='ordemServicoSemPendencia']").attr("checked", checked);
			
			if(checked){
				$("input[name='observacao']").each( function() {
					$(this).removeAttr("disabled");
				});
			}else{
				$("input[name='observacao']").each( function() {
					$(this).val('');
					$(this).attr("disabled", "disabled");
				});
			}
			
		});
		
		/* DESABILITA OS CAMPOS DE INPUT APOS CARREGAR A TELA */
		$("input[name='justificativaPendencia']").each( function() {
			$(this).attr("disabled", "disabled");
		});
		
		$("input[name='observacao']").each( function() {
			$(this).attr("disabled", "disabled");
		});
		
	});
	
</script>

	<div class="cabecalho3">
		<fmt:message key="label.criarBorderos" />
		<span style="font-size: 11px;"> - <fmt:message key="label.conjuntoOSAbrev" /></span>
		<div class="caminho" style="">
			<a class="linktres" title="<fmt:message key="label.home" />" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}"><fmt:message key="label.home" /></a>
			&gt;
			<a class="linktres" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC29/dv01"><fmt:message key="label.pagamentos" /></a>
			&gt;
			<a class="linkquatro" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC29/dv01"><fmt:message key="label.criarBorderos" /></a>
		</div>
	</div>

	<p>
	<span class="text1" style="margin-left: 100px;">
		<fmt:message key="uc29.texto.004.relacaoOSNovoBordero" />
	</span>
	
	<span class="texthelp2" style="margin-right: 10px;">
		<img hspace="5" height="16" align="absmiddle" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png">
		<fmt:message key="uc29.texto.006.cliqueNumeroOrdemServico" />
	</span>
	</p>

	<table class="detalhe" cellspacing="0">
		<tbody>
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="uc29.texto.008.disponivelEnvioPendencia" /></th>
				<td>
					<a href="#" 
					   onclick="controlaExibicaoOrdensServicoPendencia();" 
					   class="controladorVisualizacaoOrdensServicoGerarBordero">
						<label id="controlaExibicaoOrdensServicoPendenciaAtivo" class="visivel">+</label>
						<label id="controlaExibicaoOrdensServicoPendenciaInativo" class="invisivel">-</label>   
					</a>
				</td>	
			</tr>
		</tbody>
	</table>
	
	<span class="texthelp2 visivel" id="infoOrdensServicoPendencia" style="margin-right: 10px;">
		<img hspace="5" height="16" align="absmiddle" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png">
		<fmt:message key="uc29.texto.009.abaixoOSDevolvidas" />
	</span>
	
	<div style="clear:both;"></div>
	
	<form id="formAtualizar" method="post" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC29/dv01">
	
	</form>
	
	<form id="formGerarBordero" method="post" action="">
	
		<input type="hidden" name="numeroBordero" 		 id="numeroBordero" value="" />
		<input type="hidden" name="representanteBordero" id="representanteBordero" value="" />
		<input type="hidden" name="dataInclusaoBordero"  id="dataInclusaoBordero" value="" />
	
		<!-- ABRE DIV CONTEINER ORDENS SERVICO PENDENCIA -->
		<div id="div_ordens_servico_pendencia" class="visivel">
		
			<div class="selecionarTodasOrdensServicoPendencia">
				<input id="selecionarTodosOrdensServicoPendencia" type="checkbox" name="" border="0" />
				<label><fmt:message key="label.selecionarOrdensServicoPendencia" /></label>
			</div>
		
			<div style="clear:both;"></div>
			<br />
		
			<table id="alter" class="tabelaOrdensServicoPendencia" cellspacing="0" cellpadding="1" width="750">
			
				<c:choose>
					<c:when test="${not empty ordemServicoPendencia}">
					
						<tr>
							<th class="texttable_azul"  width="9%"  scope="col"><fmt:message key="label.cliqueAqui" /></th>
							<th class="texttable_cinza" width="23%" scope="col"><fmt:message key="label.nAbrevOS" /></th>
							<th class="texttable_cinza" width="8%"  scope="col"><fmt:message key="label.placa" /></th>
							<th class="texttable_cinza" width="16%" scope="col"><fmt:message key="label.cliente" /></th>
							<th class="texttable_azul"  width="44%" scope="col"><fmt:message key="label.justificativaPendencia" /></th>
						</tr>
					
	 					<c:forEach var="ordemServico" items="${ordemServicoPendencia}" varStatus="status">
							<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if> id="ordem_servico${ordemServico.numero}" >
								<td class="linkazul">
									<input id="ordemServicoPendencia${ordemServico.numero}" type="checkbox" name="ordemServicoPendencia" value="${ordemServico.numero}" onclick="habilitaInputJustificativaPencia(this);"/>
								</td>
								<td>
									<a class="linkazul" href="#" name="${ordemServico.numero}" onclick="abrirModalVisualizacaoObervacao(this);" >
									<input type="hidden" id="observacaoOrdemServicoPendencia${ordemServico.numero}" value="${ordemServico.observacaoConferencia}" />
									${ordemServico.numero}
									</a>
								</td>
								<td>
									<input type="hidden" id="placaOrdemServicoPendencia${ordemServico.numero}" value="${ordemServico.veiculo.placa}" />
									${ordemServico.veiculo.placa}
								</td>
								<td>
									<input type="hidden" id="clientePendencia${ordemServico.numero}" value="${ordemServico.contrato.contratante.nome}" />
									${ordemServico.contrato.contratante.nome}
								</td>
								<td>
									<input id="justificativaPendencia${ordemServico.numero}" name="justificativaPendencia" type="text" style="width: 300px;" >				
								</td> 
								<td style="display: none;">
									<input type="hidden" id="valorOrdemServicoPendencia${ordemServico.numero}" value="${ordemServico.valorTotalOrdemServico}" />
								</td>
							</tr>
						</c:forEach>
					
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="6"><fmt:message key="uc29.texto.005.nenhumaOrdemServicoDisponivelPendencia" /></td>
						</tr>
					</c:otherwise>
				</c:choose>
					
			</table>
		
		</div>
		<!-- FECHA DIV CONTEINER ORDENS SERVICO PENDENCIA -->
	
		<table class="detalhe" cellspacing="0">
			<tbody>
				<tr class="barraazulzinha">
					<th class="barraazulzinha"><fmt:message key="uc29.texto.007.disponivelEnvioSemPendencia" /></th>
					<td>
						<a href="#" 
						   onclick="controlaExibicaoOrdensServicoSemPendencia();" 
						   class="controladorVisualizacaoOrdensServicoSemPendenciaGerarBordero">
							<label id="controlaExibicaoOrdensServicoSemPendenciaAtivo" class="visivel">+</label>
							<label id="controlaExibicaoOrdensServicoSemPendenciaInativo" class="invisivel">-</label>  
						</a>
					</td>
				</tr>
			</tbody>
		</table>
	
		<!-- ABRE DIV CONTEINER ORDENS SERVICO SEM PENDENCIA -->
		<div id="div_ordens_servico_sem_pendencia" class="visivel">
		
			<div class="selecionarTodasOrdensServicoSemPendencia">
				<input id="selecionarTodosOrdensServicoSemPendencia" type="checkbox" name="" border="0" />
				<label><fmt:message key="uc29.texto.010.selecionarTodasOrdenServicoSemPendencia" /></label>
			</div>
		
			<div style="clear:both;"></div>
			<br />
		
			<table id="alter" cellspacing="0" cellpadding="1" width="750" class="tabelaOrdensServico">
		
				<c:choose>
					<c:when test="${not empty ordemServico}">
					
						<tr>
							<th class="texttable_azul"  width="9%"  scope="col"><fmt:message key="label.cliqueAqui" /></th>
							<th class="texttable_cinza" width="23%" scope="col"><fmt:message key="label.nAbrevOS" /></th>
							<th class="texttable_cinza" width="8%"  scope="col"><fmt:message key="label.placa" /></th>
							<th class="texttable_cinza" width="16%" scope="col"><fmt:message key="label.cliente" /></th>
							<th class="texttable_azul"  width="44%" scope="col"><fmt:message key="label.observacao" /></th>
						</tr>
						
						<c:forEach var="ordemServico" items="${ordemServico}" varStatus="status">
							<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if> id="ordem_servico_${ordemServico.numero}" >
								<td class="linkazul">
									<input id="ordemServico${ordemServico.numero}" type="checkbox" name="ordemServicoSemPendencia" value="${ordemServico.numero}" onclick="habilitaInputObservacao(this);"/>
								</td>
								<td>
									<a class="linkDisable" href="#">${ordemServico.numero}</a>
								</td>
								<td>
									<input type="hidden" id="placaOrdemServico${ordemServico.numero}" value="${ordemServico.veiculo.placa}" />
									${ordemServico.veiculo.placa}
								</td>
								<td>
									<input type="hidden" id="cliente${ordemServico.numero}" value="${ordemServico.contrato.contratante.nome}" />
									${ordemServico.contrato.contratante.nome}
								</td>
								<td>
									<input id="observacao${ordemServico.numero}" type="text" style="width: 300px;" name="observacao"  />
								</td> 
								<td style="display: none;">
									<input type="hidden" id="valorOrdemServico${ordemServico.numero}" value="${ordemServico.valorTotalOrdemServico}" />
								</td>
							</tr>
						</c:forEach> 
					
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="6"><fmt:message key="uc29.texto.011.nenhumaOrdemServicoDispSemPend" /></td>
						</tr>
					</c:otherwise>
				</c:choose>
					
			</table>
		
		</div>
		<!-- FECHA DIV CONTEINER ORDENS SERVICO SEM PENDENCIA -->
	
		<div class="pgstabela">
			<p>
				<input class="button4" type="button" value="<fmt:message key="label.limpar" />" onclick="resetForm();" />
				<!-- <input class="button4" type="button" value="Teste" onclick="teste();" /> -->
				<input class="button" 
					   type="submit" 
					   value="<fmt:message key="label.gerarBordero" />">
			</p>
		</div>
		
	</form>
	
	<div id="aguardandoCarregamento" class="carregando_padrao" class="invisivel">
		<div class="carregando_text">
			<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/ajax-loader.gif" 
				width="16" height="16" hspace="10" border="0" align="absmiddle" />
				<fmt:message key="label.carregando" />
		</div>
	</div>
	
	<!-- DIV MODAL DV02 - TELA CONFIRMACAO GERACAO DE NOVO BORDERO  -->
	<div id="popupConfirmacaoNovoBordero" style="display: none;"></div>
	
	<!-- DIV MODAL DV03 - TELA OBSERVACAO ORDEM SERVICO  -->
	<div id="popupObservacaoOrdemServico" style="display: none;"></div>
	
	<div id="popupErrosValidacao" style="display: none;"></div>
	
