<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>
	
<c:catch var="helper" >
	<c:import url="/AtivarEquipamentoVinculo/recuperarAcessorio?acao=6" context="/SascarPortalWeb"  />
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
		var acao = null;	
		
		$(':disabled').each( function() {
			data += '&' + this.name + '=' + $(this).val();
		});
		
		// CARREGA O VALOR ATUAL DA COMBO
		var valorAtualCombo = $("#codigoAcessorio");
		var acessorioAtual = valorAtualCombo.find('option').filter(':selected').val();		
	
		// verifica se o valor da combo #codigoAcessorio foi alterado
		if(acessorioInicial == acessorioAtual){
			acao = 7;
		}else{
			acao = 15;
		}
		
		$.ajax({
			url: "/SascarPortalWeb/AtivarEquipamentoVinculo/submeterAcessorio?acao=" + acao,
			data: data || {},
			dataType:"json",
			success: function(json){
				if (json.success) {
					document.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv07&numeroOS=${param.numeroOS }&numeroCPF=${param.numeroCPF }&codigoItem=${acessorio.codigoItem }&codigoAcessorio=${acessorio.codigo }&tipoSubmeter=A';
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
		
		$('#ativar_equipamento').addClass('active');
		
		var container = $('div.container-error');
		$("#formPesquisa").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler : function(form) {
				submterAcessorio(form, acessorioInicial);
			}/*,
			showErrors: function(errorMap, errorList) {
				this.defaultShowErrors();
				if (errorList.length) {
					document.location.href = "#top";
				}
		    }*/
		});

		/*  
			1 - EQUIPAMENTO NAO POSSUI ACESSORIO PARA VINCULAR, DIRECIONA PARA DV09
			2 - EQUIPAMENTO POSSUI ACESSORIO E TODOS JA FORAM VINCULADOS, 
			    O VALOR DO FORM DO PRIMEIRO IF E SOBRESCRITO PELO SEGUNDO IF E DIRECIONA PARA DV08.
		*/

		<c:if test="${totalAcessorios eq 0 }">
			<c:set var="formAction" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv09&numeroOS=${param.numeroOS }&numeroCPF=${param.numeroCPF }" />
		</c:if>

		<c:if test="${acessoriosRestantes eq 0 and totalAcessorios gt 0 }">
			<c:set var="formAction" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv08&numeroOS=${param.numeroOS }&numeroCPF=${param.numeroCPF }" />
		</c:if>

		<c:if test="${not empty formAction}">
			$("#formPesquisa").attr("action", "${formAction}")
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
				$("#quantidade").val("");
				$("#numeroSerial").val("");
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

	<div class="container-error"> 
		<ol>
			<li><label for="nomeAcessorio" class="error"><fmt:message key="mensagem.error.informeDescricaoAcessorio" /></label></li>
			<li><label for="numeroSerial" class="error"><fmt:message key="mensagem.error.informeSerialAcessorio" /></label></li>
			<li><label for="quantidade" class="error"><fmt:message key="mensagem.error.informeQuantidadeAcessorio" /></label></li>
			<li><label for="codigoPorta" class="error"><fmt:message key="mensagem.error.selecionePortaAcessorio" /></label></li>
			<li><label for="codigoLocalInstalacaoAcessorio" class="error"><fmt:message key="mensagem.error.selecioneLocalInstalacaoAcessorio" /></label></li>
		</ol>
	</div>
	
	<h2><fmt:message key="uc10.dv07.vinculacaoAcessorios" /></h2>

	<form id="formPesquisa" action="" method="post">
	
		<input type="hidden" name="numeroCPF" value="${param.numeroCPF}" />
		<input type="hidden" name="numeroOS" value="${param.numeroOS }" />
		<input type="hidden" name="codigoItem" value="${acessorio.codigoItem }" />
		<input type="hidden" name="tipoSubmeter" value="V" />

		<table width="100%" cellpadding="0" cellspacing="5" border="0" class="dados">
			<tr>
	            <th><fmt:message key="label.NumOS" />:</th>
	            <td style="text-align:left; padding-left: 2px;">[${ordemServicoResumida.numero}]</td>
			</tr>
			<tr>
	            <th><fmt:message key="label.placa" />:</th>
	            <td style="text-align:left; padding-left: 2px;">${ordemServicoResumida.contrato.veiculo.placa}</td>
	        </tr>
	        <tr>
	            <th><fmt:message key="label.chassi" />:</th>	
	            <td style="text-align:left; padding-l eft: 2px;">${ordemServicoResumida.contrato.veiculo.chassi}</td>
	        </tr>
	     </table>
	     
		<fieldset>
		
			<legend><strong><fmt:message key="label.acessorio" /></strong></legend>
			
			<p class="input">
				<c:choose>
					<c:when test="${acessorio.alterar}">
						<input type="hidden" name="codigoAcessorioInicial" value="${acessorio.codigo }" />
	
						<select id="codigoAcessorio" 
									name="codigoAcessorio" 
							        class="required" 
							        onchange="controlarExibicaoCamposOnchange(this);">
	
							<c:forEach items="${acessorios }" var="acessorioOpcao">
								<c:if test="${not empty acessorioOpcao.codigo and not empty acessorioOpcao.descricao}">
									
									<option class="serial-${acessorioOpcao.indicadorSerial}"  
									        value="${acessorioOpcao.codigo}" >
										${acessorioOpcao.descricao}
									</option>
									
								</c:if>
							</c:forEach>
	
						</select>
	
					</c:when>
					<c:otherwise>
						<input type="hidden" name="codigoAcessorio" value="${acessorio.codigo }" />
						<input type="text" name="nomeAcessorio" id="nomeAcessorio" class="inputComboDesabilitado required" value="${acessorio.descricao }" disabled="disabled" maxlength="50" />
					</c:otherwise>
				</c:choose>
			</p>
			
			<p id="celulaCampoSerial" class="invisivel">
				<label class="barracinza">
					<span><fmt:message key="label.serial" />:</span>
				</label>
				       
				<input type="hidden" 
				       id="numeroSerialInicial" 
				       name="numeroSerialInicial" 
				       value="${acessorio.numeroSerial}" />   
				       
		       <input id="numeroSerial" 
					   name="numeroSerial" 
					   size="25"
					   type="text" 
					   maxlength="24" 
					   class="text" 
					   value="${acessorio.numeroSerial}" /> 
			</p>
			
			<p id="celulaCampoQuantidade" class="invisivel">
				<label class="barracinza">
					<span><fmt:message key="label.quantidade" />:</span>
				</label>
				
				<input type="hidden" 
				       id="quantidadeInicial" 
				       name="quantidadeInicial" 
				       value="${acessorio.quantidade}" />
				       
       			<input id="quantidade" 
					   name="quantidade"  
					   type="text" 
					   maxlength="15" 
					   class="text" 
					   value="${acessorio.quantidade}" />
				
			</p>
			
				
			<p class="input">
				<label for="codigoPorta">
					<span>Porta:</span><br />
					<select name="codigoPorta" 
					        id="codigoPorta" 
					        class="required"
							<c:if test="${empty portas}">disabled="disabled"</c:if>>
			
						<option value=""><fmt:message key="label.selecione" /></option>
			
						<c:forEach items="${portas }" var="porta">
							<c:if test="${not empty porta.identifier and not empty porta.value}">
								<option value="${porta.identifier}">${porta.value}</option>
							</c:if>
						</c:forEach>
					</select>
				</label>	
				<div id="divLoader" style="width:40px; height:40px;"><img src="${pageContext.request.contextPath}/sascar/images/mobile/ajax-loader.gif" width="40" height="40" />Aguarde...</div>			
				<input type="hidden" id="paramNumeroOS"	value="${param.numeroOS}" />
				<input type="hidden" id="acessorioCodigo" value="${acessorio.codigo}" />			
				<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/scriptsUC10.js"></script>
				<div id="divPopup" style="display:none;"></div>				
			</p>
			
			<p class="input">
				<label for="codigoLocalInstalacaoAcessorio">
				
					<span><fmt:message key="label.localDeInstalacao" />:</span><br />
					<select name="codigoLocalInstalacaoAcessorio" 
							id="codigoLocalInstalacaoAcessorio" 
							class="required" 
							<c:if test="${empty locaisInstalacaoAcessorio}">disabled="disabled"</c:if>>
			
						<option value=""><fmt:message key="label.selecione" /></option>
							
						<c:forEach items="${locaisInstalacaoAcessorio }" var="local">
							<c:if test="${not empty local.identifier and not empty local.value}">
								<option value="${local.identifier}">${local.value}</option>
							</c:if>
						</c:forEach>
			
					</select>
			
				</label>
			</p>
			<p class="input" style="padding:10px; margin-top:10px; text-align: center;">
				<input type="submit" class="aButton ui-state-default ui-corner-all" value="<fmt:message key="label.continuar" />" />
			</p>
		</fieldset>
</form>