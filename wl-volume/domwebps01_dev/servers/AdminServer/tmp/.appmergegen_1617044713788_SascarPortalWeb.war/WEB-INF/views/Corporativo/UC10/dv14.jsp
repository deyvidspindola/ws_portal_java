<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/AtivarEquipamentoVinculo/recuperarAcessorio?acao=6" context="/SascarPortalWeb" />
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

<script type="text/javascript">
	function submterAcessorio(form, acessorioInicial) {
		
		var data = $(form).serialize();
		var acao = 16;	
		
		$(':disabled').each( function() {
			data += '&' + this.name + '=' + $(this).val();
		});
		
		// CARREGA O VALOR ATUAL DA COMBO
		var valorAtualCombo = $("#codigoAcessorio");
		var acessorioAtual = valorAtualCombo.find('option').filter(':selected').val();		
	
		
		$.ajax({
			url: "/SascarPortalWeb/AtivarEquipamentoVinculo/trocaAcessorio?acao=" + acao,
			data: data || {},
			dataType:"json",
			success: function(json){
				if (json.success) {
					$("#formAtualizar").submit();
				} else {
					$.showMessage(json.mensagem);
				}
			}
		});
		
	}
	
	$(document).ready(function(){
		// CARREGA O VALOR INICIAL DA COMBO
		var valorInicialCombo = $("#codigoAcessorio");
		var acessorioInicial = valorInicialCombo.find('option').filter(':selected').val();
	
		/* CONTROLA A RENDERIZACAO E VALIDACAO DOS CAMPOS SERIAL E QUANTIDADE */
		controlarExibicaoCamposOnReady();
	
		var container = $('div.container2');
		$("#formVinculacaoAcessorio").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler : function(form) {
				submterAcessorio(form, acessorioInicial);
			}
		});

		$("#quantidade").setMask({mask:'999999999999999'});
		
		<c:if test="${totalAcessorios eq 0 }">
			<c:set var="formAction" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv09"/>
		</c:if>
		
		<c:if test="${acessoriosRestantes eq 0 and totalAcessorios gt 0 }">
			<c:set var="formAction" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv08"/>
		</c:if>

		<c:if test="${not empty formAction}">
			$("#formVinculacaoAcessorio").attr("action", "${formAction}")
										 .unbind('submit')
										 .submit();
		</c:if>	
		
	});

	function controlarExibicaoCamposOnReady(){
		var inputQuantidade = $("#quantidade");
		var inputNumeroSerial = $("#numeroSerial");

		/* CONTROLA A RENDERIZACAO E VALIDACAO DOS CAMPOS SERIAL E QUANTIDADE */
		<c:if test="${not empty acessorio.indicadorSerial}">
			var indicadorSerial = ${acessorio.indicadorSerial};

			if(indicadorSerial == true){
				$("#celulaCampoSerial").removeClass("invisivel").addClass("visivel required");
				$("#numeroSerial").addClass("required");
				$("#numeroSerial").val("");
				$("#quantidade").val("");
			}else{
				$("#celulaCampoQuantidade").removeClass("invisivel").addClass("visivel required");
				$("#quantidade").addClass("required number");
				$("#numeroSerial").val("");
				$("#quantidade").val("");
			}
		</c:if>			
		
	}

	function controlarExibicaoCamposOnchange(select){
	
		var inputQuantidade = $("#quantidade");
		var inputNumeroSerial = $("#numeroSerial");
		
		/* REMOVE AS VALIDACOES DO ACESSORIO ANTERIOR */
		if($('#celulaCampoSerial').hasClass("visivel")){
			$("#celulaCampoSerial").removeClass("visivel").addClass("invisivel");
			$("#numeroSerial").removeClass("required");
		}else{
			$("#celulaCampoQuantidade").removeClass("visivel").addClass("invisivel");
			$("#quantidade").removeClass("required number");
		}

		/* VERIFICA SE O ACESSORIO ATUAL POSSUI QUANTIDADE OU SERIAL */
		var elem = $(select);
		var verificaAcessorioSerial = elem.find('option:selected').hasClass("serial-true");
		
		if(verificaAcessorioSerial){
			$("#celulaCampoSerial").removeClass("invisivel").addClass("visivel");
			$("#numeroSerial").addClass("required");
		}else{
			$("#celulaCampoQuantidade").removeClass("invisivel").addClass("visivel");
			$("#quantidade").addClass("required number");
		}		
	}
	
</script>
	<div class="cabecalho">
		<div class="caminho" style="*margin-left:400px;">
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; 
			<a href="#" class="linktres"><fmt:message key="label.servicos" /></a> &gt; 
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv01" class="linkquatro"><fmt:message key="label.ativacaoEquipamento" /></a>
		</div>
	  	<fmt:message key="label.ativacaoEquipamento" />
	</div>


	<!-- FORM VOLTAR -->
	<form method="post"	id="formVoltar"	action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv05">
		<input type="hidden" name="numeroCPF" value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS" value="${param.numeroOS }" />
	</form>


	<!-- FORM ATUALIZAR -->
	<form method="post"	id="formAtualizar"	action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv05">
		<input type="hidden" name="numeroCPF" value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS" value="${param.numeroOS }" />
		
	</form>

	<div class="container2"> 
		<ol>
			<li><label for="nomeAcessorio" class="error"><fmt:message key="mensagem.error.informeDescricaoAcessorio" /></label></li>
			<li><label for="numeroSerial" class="error"><fmt:message key="mensagem.error.informeSerialAcessorio" /></label></li> 
			<li><label for="quantidade" class="error"><fmt:message key="mensagem.error.informeQuantidadeAcessorio" /></label></li>
			<li><label for="codigoPorta" class="error"><fmt:message key="mensagem.error.selecionePortaAcessorio" /></label></li>
			<li><label for="codigoLocalInstalacaoAcessorio" class="error"><fmt:message key="mensagem.error.selecioneLocalInstalacaoAcessorio" /></label></li>
		</ol>
	</div>

	<form action="" method="post" id="formVinculacaoAcessorio" class="filtro">

		<input type="hidden" name="numeroCPF" value="${param.numeroCPF}" />
		<input type="hidden" name="numeroOS" value="${param.numeroOS }" />
		<input type="hidden" name="codigoItem" value="${acessorio.codigoItem }" />
		<input type="hidden" id="indicadorRF" name="indicadorRF" value="${acessorio.indicadorRF }" />
			
	<!-- INICIO TESTE -->
	<div class="principal">
		
		<div class="tarjaAzul">
			<label><fmt:message key="uc10.dv07.vinculacaoAcessorios" /></label>
		</div>
		
		<!--  DADOS DA OS-->
		<div class="bloco1">
			
			<div class="celula">
				<div class="colunaLabel">
					<label><fmt:message key="label.NumOS" /></label>
				</div>
				<div class="colulaCamposInternos">
					<label>${ordemServicoResumida.numero}</label>
				</div>
			</div>
			
			<div class="celula">
				<div class="colunaLabel">
					<label><fmt:message key="label.chassi" /></label>
				</div>
				<div class="colulaCamposInternos">
					<label>${ordemServicoResumida.contrato.veiculo.chassi}</label>
				</div>
			</div>
			
			<div class="celula">
				<div class="colunaLabel">
					<label><fmt:message key="label.placa" /></label>
				</div>
				<div class="colulaCamposInternos">
					<label>${ordemServicoResumida.contrato.veiculo.placa}</label>
				</div>
			</div>
		
			<div style="clear: both"></div>
		</div>
			
			
		<div class="tarjaAzul">
			<label><fmt:message key="label.dadosVeiculo" /></label>
		</div>	
		
		<!-- INICIO BLOCO 2-->
		<div class="bloco2">
				
				<!-- INICIO CELULA CAMPO ACESSORIO-->
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.acessorio" />:</label>
					</div>
					<!-- ABRE DIV COLUNA INPUT -->
					<div class="colunaInput" > 
					
						<c:choose>
							<c:when test="${acessorio.alterar}">
								<input type="hidden" name="codigoAcessorioInicial" value="${acessorio.codigo }" />
									<select id="codigoAcessorio" 
											name="codigoAcessorio" 
											class="required colunaInputCombo" 
											onchange="controlarExibicaoCamposOnchange(this);">
											
										<c:forEach items="${acessorios }" var="acessorioOpcao">
											<c:if test="${not empty acessorioOpcao.codigo and not empty acessorioOpcao.descricao}">
												
												<option class="serial-${acessorioOpcao.indicadorSerial}" value="${acessorioOpcao.codigo}" >
													${acessorioOpcao.descricao}
												</option>
												
											</c:if>
										</c:forEach>
									</select>
							</c:when>
							<c:otherwise>
									<input type="hidden" name="codigoAcessorio" value="${acessorio.codigo }" />
									<input type="text" name="nomeAcessorio" id="nomeAcessorio" class="required inputCelula" value="${acessorio.descricao }" disabled="disabled" maxlength="50" />
							</c:otherwise>
						</c:choose>
						
					</div>
					<!-- FECHA DIV COLUNA INPUT -->
					
				</div>
				<!-- FIM CELULA CAMPO ACESSORIO-->
				
				<div  id="celulaCampoQuantidade" class="celula invisivel">
					<div class="colunaLabel">
						<label><fmt:message key="label.quantidade" />:</label>
					</div>
					<div class="colunaInput">
				
						<!-- VALOR USADO QUANDO FOREM ENVIADAS AS INFORMACOES DO ACESSORO INICIAL NA SUBSTITUICAO DE ACESSORIO -->
						<input type="hidden" 
						       id="quantidadeInicial" 
						       name="quantidadeInicial" 
						       value="" />
						
						<input id="quantidade" 
							   name="quantidade"  
							   type="text" 
							   maxlength="15" 
							   class="inputCelula" 
							   value="" />
					</div>
				</div>
				
				<div id="celulaCampoSerial" class="celula invisivel">
					<div class="colunaLabel">
						<label><fmt:message key="label.serial" />:</label>
					</div>
					<div class="colunaInput">
					
						<input type="hidden" 
						       id="numeroSerialInicial" 
						       name="numeroSerialInicial" 
						       maxlength="24"
						       value="" />  
					       
						<input id="numeroSerial" 
							   name="numeroSerial" 
							   type="text" 							   
							   maxlength="24" 
							   class="inputCelula" 
							   value="" />
					</div>
				</div>
				
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.porta" />:</label>
					</div>
					
					<div class="colunaInput">
						<select name="codigoPorta" id="codigoPorta" class="colunaInputCombo required" <c:if test="${empty portas}">disabled="disabled"</c:if>>
							<option value=""><fmt:message key="label.selecione" /></option>
							<c:forEach items="${portas }" var="porta">
								<c:if test="${not empty porta.identifier and not empty porta.value}">
									<option value="${porta.identifier}">${porta.value}</option>
								</c:if>
							</c:forEach>
						</select>	
						<input type="hidden" id="paramNumeroOS"	value="${param.numeroOS}" />
						<input type="hidden" id="acessorioCodigo" value="${acessorio.codigo}" />
						<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/scriptsUC10.js"></script>				
					</div>
					
				</div>
				<div id="divPopup" style="display:none;"></div>
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.localDeInstalacao" />:</label>
					</div>
					
					<div class="colunaInput">
							<select name="codigoLocalInstalacaoAcessorio" 
									id="codigoLocalInstalacaoAcessorio" 
									class="required colunaInputCombo" 
									<c:if test="${empty locaisInstalacaoAcessorio}">disabled="disabled"</c:if>>
									
								<option value=""><fmt:message key="label.selecione" /></option>
								<c:forEach items="${locaisInstalacaoAcessorio}" var="local">
									<c:if test="${not empty local.identifier and not empty local.value}">
										<option value="${local.identifier}">${local.value}</option>
									</c:if>
								</c:forEach>
							</select>
					</div>
					
				</div>
				
			</div>
			
	
		<!-- FIM BLOCO 2 -->
	
		<!-- FIM TESTE -->
			<div style="clear: both;" ></div>
		<div class="posicaoBotoes">
		     <div class="botoes">
			    <p>
			        <input type="button" class="button4"  value="<fmt:message key="label.voltar" />" onclick="$('#formVoltar').submit();" />
			        <input type="submit" class="button" value="<fmt:message key="label.continuar" />" />
			    </p>
		    </div>
	    	<div style="clear: both;" ></div>
	    </div>
	</div>   
	    
	</form>
