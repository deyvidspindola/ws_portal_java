<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/ConsultarSolicitacaoInstalacaoServlet/consultarDetalhesSolicitacaoServico?acao=2" context="/SascarPortalWeb"  />
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
	// VAR GLOBAL
	var INDEX_VEICULO = 0;
	
	
		$(document).ready(function(){
	
		$("#nascSegurado").datepicker({
			dateFormat: 'dd/mm/yy',
			changeMonth: true,
			changeYear: true
		});
		
		$("#inicioVigencia").datepicker({
			dateFormat: 'dd/mm/yy',
			changeMonth: true,
			changeYear: true,
			onClose: function( selectedDate ) {
				$( "#fimVigencia" ).datepicker( "option", "minDate", selectedDate );
			  }
		});

		$("#fimVigencia").datepicker({
			dateFormat: 'dd/mm/yy',
			changeMonth: true,
			changeYear: true,
			onClose: function( selectedDate ) {
				$( "#inicioVigencia" ).datepicker( "option", "maxDate", selectedDate );
			  }
		});

		$('#inicioVigencia, #fimVigencia, #nascSegurado').blur(function(){
			$(this).setMask('date');
		}).focus(function(){
			$(this).unsetMask();
		});
		
		$(".decimal").setMask('decimal');
		
		$("#cepInstalacao, #cepSegurado").setMask('cep');

		$('#cpf').setMask('cpf');
		$('#cnpj').setMask('cnpj');
		
		
		$("#foneSolicitante").setMask({mask:'999999999999'});
		$("#foneCorretor").setMask({mask:'999999999999'});
		$("#foneResponsavel").setMask({mask:'999999999999'});
		$("#foneComercial").setMask({mask:'999999999999'});
		$("#foneResidencial").setMask({mask:'999999999999'});
		$("#foneCelular").setMask({mask:'999999999999'});
		$("#numSegurado").setMask({mask:'999999999999'});
		$("#numInstalacao").setMask({mask:'999999999999'});
		$("#proposta").setMask({mask:'999999999999'});
		$("#ie").setMask({mask:'999999999999'});		
	
		var container = $('div.container2');
		$("#formCadastro").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			
			submitHandler : function(form) {
				
				if(validarListaVeiculo()){
					IncluirSolicitacao(form);
				}else{
					$.showMessage ("A solicitação deve possuir um veículo cadastrado");
				}
				return false;
			}
		});
	

		carregarEstados('01', '#estadoInstalacao', '${solicitacao.localInstalacao.uf }');
		<c:if test="${not empty solicitacao.localInstalacao.uf }">
			carregarCidades('${solicitacao.localInstalacao.uf  }', '#cidadeInstalacao', '${solicitacao.localInstalacao.descricaoCidade }');
		</c:if>


		carregarEstados('01', '#estadoSegurado', '${solicitacao.segurado.endereco.uf }');

		<c:if test="${not empty solicitacao.segurado.endereco.uf }">
			carregarCidades('${solicitacao.segurado.endereco.uf   }', '#cidadeSegurado', '${solicitacao.segurado.endereco.descricaoCidade }');
		</c:if>


		showCamposTipoPessoa();


	});
	
	function carregarEstados(codigoPais, idSelect, valueOptionSelected, textOptionSelected) {
		var select = $(idSelect);
		
		if (codigoPais == "") {
			$("option", select).remove();
			select.append($('<option></option>').val("").html('<fmt:message key="label.selecione" />'));
			return;
		}

		$.ajax({
			"url": "/SascarPortalWeb/EfetuarAtualizacaoCadastral/listarEstados",
			"data" : { "codigoPais": codigoPais, "acao" : 4 },
			"dataType" : "json",
			"beforeSend": function(){
				$("option", select).remove();
				select.append($('<option></option>').val("").html('<fmt:message key="label.selecione" />'));
			},
			"success": function(json){
				if (json.success) {
					$.each(json.estados, function(i, estado){
						if (estado.value && estado.id) {
							var option = new Option(estado.value, estado.id);
							if ($.browser.msie) {
								select[0].add(option);
							} else {
								select[0].add(option, null);
							}
						}
						
					});

					if (valueOptionSelected) {
						$("option[value='"+valueOptionSelected+"']", idSelect).attr("selected", true);
					}

					if (textOptionSelected) {
						$("option:contains('"+textOptionSelected+"')", idSelect).attr("selected", true);
					}
					
				} else {
					$.showMessage(json.mensagem);
				}
			}
		});
	}

	function carregarCidades(siglaUF, idSelect, valueOptionSelected, textOptionSelected) {
		var select = $(idSelect);

		if (siglaUF == "") {
			$("option", select).remove();
			select.append($('<option></option>').val("").html('<fmt:message key="label.selecione" />'));
			return;
		}

		$.ajax({
			"url": "/SascarPortalWeb/EfetuarAtualizacaoCadastral/listarCidades",
			"data" : { "siglaUF": siglaUF, "acao" : 5 },
			"dataType" : "json",
			"beforeSend": function(){
				$("option", select).remove();
				select.append($('<option></option>').val("").html('<fmt:message key="label.selecione" />'));
			},
			"success": function(json){
				var elementSelected = null;
				if (json.success) {
					$.each(json.cidades, function(i, cidade){
						if (cidade.value && cidade.id) {
							var option = new Option(cidade.value, cidade.id);
							if ($.browser.msie) {
								select[0].add(option);
							} else {
								select[0].add(option,null);
							}
						}
					});

					if (valueOptionSelected) {
						elementSelected = $("option[value='"+valueOptionSelected+"']", idSelect).attr("selected", true);
					}

					if (textOptionSelected) {
						elementSelected = $("option:contains('"+textOptionSelected+"')", idSelect).attr("selected", true);
					}

					if (elementSelected) {
						$("#enderecoCobrancaCidade").val(elementSelected.text());
					}

				} else {
					$.showMessage(json.mensagem);
				}
			}
		});
	}		

	
	function showCamposTipoPessoa() {
	
		if ($("#tipoSegurado").val() == 'F') {
			$(".trSeguradoFisico").show();
			
			$(".trSeguradoJuridico").hide();
		} else {
			$(".trSeguradoFisico").hide();
			$(".trSeguradoJuridico").show();
		
		}
	}
	
	function IncluirSolicitacao(form) {
		var data = $(form).serialize();
		$(':disabled').each( function() {
			data += '&' + this.name + '=' + $(this).val();
		});
	$.ajax({
		url: "/SascarPortalWeb/CadastrarSolicitacaoInstalacaoServlet/submeterSolicitacaoServico?acao=2",
		data: data || {},
		dataType:"json",
		success: function(json){
			if (json.success) {
				$("#dialog_mensagem #popup_msg_modal").html('<fmt:message key="mensagem.sucesso.cadastro" />');
				$("#botaoPopUp").click(function(){
					window.location.reload();
				});
				
			} else {
				$("#dialog_mensagem #popup_msg_modal").html(json.mensagem);
				$("#botaoPopUp").click(function(){
					$.closeOverlay();
					
				});
			}
			
			$("#dialog_mensagem").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
		}
	});
	}
	
	function abrirIncluirVeiculo() {
		$.ajax({
			url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC23/dv02",
			data: {},
			dataType:"html",
			success: function(html){
				$("#dialog").html(html);
				$("#dialog").jOverlay();
				
			}
		});
	}
	function abrirExcluirVeiculo(codigoVeiculo, indexVeiculo) {
		if($("#alter .veiculo").length>1){
			$("#dialog_excluir").jOverlay({'onSuccess' : function(){
				$("#codigoVeiculo").val(codigoVeiculo);
				$("#indexVeiculo").val(indexVeiculo);
				
			}});
		}else{
			$.showMessage ('<fmt:message key="mensagem.informacao.solicitacaoVeiculoCadastrado" />');
		}
	}
	
	function excluirVeiculo(codigoSolicitacao) {
		var codigoVeiculo = $("#codigoVeiculo").val();
		var indexVeiculo = $("#indexVeiculo").val();
		if(codigoSolicitacao && codigoVeiculo){
			$.ajax({
				url: "/SascarPortalWeb/CadastrarSolicitacaoInstalacaoServlet/excluirVeiculoCadastrado?acao=4",
				data: {"codigoSolicitacao" : codigoSolicitacao, "codigoVeiculo" : codigoVeiculo},
				dataType:"json",
				success: function(json){
					$("#veiculo_" + codigoVeiculo).remove();
					$("#dialog_mensagem #popup_msg_modal").html(json.mensagem);
					$("#dialog_mensagem").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
					$("#botaoPopUp").click(function(){
						$.closeOverlay();
					});
				}
			});
		}else{
			$("#veiculo_" + indexVeiculo).remove();
			$("#dialog_mensagem #popup_msg_modal").html('<fmt:message key="mensagem.sucesso.veiculoExcluido" />');
			$("#dialog_mensagem").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
			$("#botaoPopUp").click(function(){
				$.closeOverlay();
			});
		}
	}
	function voltar() {
		$("#dialog_voltar").jOverlay({'onSuccess' : function(){

			
		}});
		
	}	
	function validarListaVeiculo(){
		return $("#alter .veiculo").length>=1;
	}	
		
</script>


		<div class="container2"> 
			<ol>
				<li><label for="nomeSolicitante" class="error"><fmt:message key="mensagem.campoObrigatorio.nomeSolicitante" /></label></li>
				<li><label for="emailSolicitante" class="error"><fmt:message key="mensagem.campoObrigatorio.emailSolicitante" /></label></li>
				<li><label for="seguradora" class="error"><fmt:message key="mensagem.campoObrigatorio.listaSeguradorasCorretoras" /></label></li>
				<li><label for="tipoSeguro" class="error"><fmt:message key="mensagem.campoObrigatorio.tipoSeguro" /></label></li>
				<li><label for="proposta" class="error"><fmt:message key="mensagem.campoObrigatorio.nCalculoProposta" /></label></li>
				<li><label for="inicioVigencia" class="error"><fmt:message key="mensagem.campoObrigatorio.inicioVigencia" /></label></li>
				<li><label for="fimVigencia" class="error"><fmt:message key="mensagem.campoObrigatorio.terminoVigencia" /></label></li>
				<li><label for="valorVeiculo" class="error"><fmt:message key="mensagem.campoObrigatorio.valorVeiculo" /></label></li>
				<li><label for="premioLiquido" class="error"><fmt:message key="mensagem.campoObrigatorio.premioLiquido" /></label></li>
				<li><label for="premioTotal" class="error"><fmt:message key="mensagem.campoObrigatorio.premioTotalSeguro" /></label></li>
				<li><label for="nomeCorretor" class="error"><fmt:message key="mensagem.campoObrigatorio.nomeCorretor" /></label></li>
				<li><label for="foneCorretor" class="error"><fmt:message key="mensagem.campoObrigatorio.numerotelefoneCorretor" /></label></li>
				<li><label for="emailCorretor" class="error"><fmt:message key="mensagem.campoObrigatorio.emailCorretor" /></label></li>
				<li><label for="nomeSegurado" class="error"><fmt:message key="mensagem.campoObrigatorio.nomeSegurado" /></label></li>
				<li><label for="tipoSegurado" class="error"><fmt:message key="mensagem.campoObrigatorio.tipo" /></label></li>
				<li><label for="optanteSimples" class="error"><fmt:message key="mensagem.campoObrigatorio.optantePeloSimples" /></label></li>
				<li><label for="cpf" class="error"><fmt:message key="mensagem.campoObrigatorio.cpf" /></label></li>
				<li><label for="cnpj" class="error"><fmt:message key="mensagem.campoObrigatorio.cnpj" /></label></li>
				<li><label for="foneResidencial" class="error"><fmt:message key="mensagem.campoObrigatorio.telefoneResidencial" /></label></li>
				<li><label for="foneComercial" class="error"><fmt:message key="mensagem.campoObrigatorio.telefoneComercial" /></label></li>
				<li><label for="foneCelular" class="error"><fmt:message key="mensagem.campoObrigatorio.telefoneCelular" /></label></li>
				<li><label for="localInstalacao" class="error"><fmt:message key="mensagem.campoObrigatorio.localInstalacao" /></label></li>
			</ol>
		</div>


		<div class="cabecalho3">
			<div class="caminho3" style="*margin-left:340px;">
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico" class="linktres"><fmt:message key="label.home" /></a> > 
				<a href="#" class="linktres"><fmt:message key="label.servicos" /></a> > 
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC21/dv01" class="linkquatro"><fmt:message key="label.solicitacaoInstalacaoEquipamento" /></a>
			</div>
		  	<fmt:message key="label.solicitacaoInstalacaoEquipamento" />
		</div>


	<form action="" method="post" class="filtro" id="formCadastro">

		<table cellspacing="0" class="detalhe" >
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.dadosSolicitante" /></th>
			</tr>
		</table>


		<span class="texthelp2">
			<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" /><fmt:message key="uc23.texto.01.informeDadosSolicitante" /> 
		</span>

		<input type="hidden" name="numeroSolicitacao" value="${param.numeroSolicitacao}"/>
						
		<table width="900" cellspacing="3" class="detalhe2">
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.nome" />
					<span class="asterisco">*
		  			</span></th> 
				<td width="350px" class="camposinternos">
					<input type="text" name="nomeSolicitante"  value="${solicitacao.solicitante.nome }"  class="required" size="45" maxlength="40"/>
			    </td>
			  	<th width="200px" class="barracinza"><fmt:message key="label.telefoneSolicitante" /></th>
				<td width="350px" class="camposinternos"> 
					<input type="text" id="foneSolicitante" name="foneSolicitante"  value="${solicitacao.solicitante.telefone1 }" class="number" maxlength="15"/>
				</td>
			</tr>
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.emailSolicitante" />
					<span class="asterisco">*
		  			</span></th>
				<td width="350px" class="camposinternos"><input type="text" name="emailSolicitante" id="emailSolicitante" value="${solicitacao.solicitante.email }"  class="required" maxlength="40"/></td>
				<th width="200px" class="barracinza"><fmt:message key="label.departamento" /></th>
				<td width="350px" class="camposinternos"><input type="text" name="departamento"  value="${solicitacao.solicitante.departamento }"  maxlength="40"/></td>
			</tr>
		    <tr>
				<th width="200px" class="barracinza"><fmt:message key="label.filialEscritorioPac" /></th>
				<td width="350px" class="camposinternos"><input type="text" name="filial"  value="${solicitacao.solicitante.filial }"  maxlength="40"/></td>
			</tr>
		</table>

		<div class="hr"></div>


		<table cellspacing="0" class="detalhe" >
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.dadosDaApolice" /></th>
			</tr>
		</table>


		<span class="texthelp2">
			<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" /><fmt:message key="uc23.texto.02.informeDadosApolice" /> 
		</span>


		<table width="900" cellspacing="3" class="detalhe2">
			<tr>
				<th width="200" class="barracinza"><fmt:message key="label.seguradoraCorretora" />
					<span class="asterisco">*
		  			</span>
		  		</th>
				<td width="350" class="camposinternos"> 
					<select  name="seguradora" id="seguradora" >
						<option value=""><fmt:message key="label.selecione" /></option>
						<c:forEach  var="seguradora" items="${listaSeguradora}">
							<c:if test="${not empty seguradora.identifier and not empty seguradora.value}">
								<option value="${seguradora.identifier}" 
									<c:if test="${fn:toUpperCase(solicitacao.apolice.nomeSeguradora) eq fn:toUpperCase(seguradora.value)}">selected="selected"</c:if>>${seguradora.value}
								</option>
							</c:if>
						</c:forEach>
					</select>
				</td>
				<th width="200" class="barracinza"><fmt:message key="label.tipoSeguro" /><span class="asterisco">*</span></th>
				<td width="350" class="camposinternos">
					<select  name="tipoSeguro" id="tipoSeguro" class="required">
						<option value=""><fmt:message key="label.selecione" /></option>
						<option value="N" <c:if test="${fn:toUpperCase(solicitacao.apolice.tipoSeguro) eq 'N'}">selected="selected"</c:if>><fmt:message key="label.tipoSeguro.seguroNovo" /></option>
						<option value="R" <c:if test="${fn:toUpperCase(solicitacao.apolice.tipoSeguro) eq 'R'}">selected="selected"</c:if>><fmt:message key="label.tipoSeguro.renovacaoCIA" /></option>
						<option value="E" <c:if test="${fn:toUpperCase(solicitacao.apolice.tipoSeguro) eq 'E'}">selected="selected"</c:if>><fmt:message key="label.tipoSeguro.endosso" /></option>
						<option value="F" <c:if test="${fn:toUpperCase(solicitacao.apolice.tipoSeguro) eq 'F'}">selected="selected"</c:if>><fmt:message key="label.tipoSeguro.frota" /></option>
						<option value="I" <c:if test="${fn:toUpperCase(solicitacao.apolice.tipoSeguro) eq 'I'}">selected="selected"</c:if>><fmt:message key="label.tipoSeguro.individual" /></option>
						<option value="P" <c:if test="${fn:toUpperCase(solicitacao.apolice.tipoSeguro) eq 'P'}">selected="selected"</c:if>><fmt:message key="label.tipoSeguro.premiumIndividual" /></option>
					</select>
				</td>
			</tr>
			<tr>
				<th width="200" class="barracinza"><fmt:message key="label.nCalculoProposta" />
					<span class="asterisco">*
		  			</span></th>
				<td width="350" class="camposinternos">
					<input type="text" name="proposta"  value="${solicitacao.apolice.numeroProposta }"  class="required" maxlength="20"/></td>
				<th width="200" class="barracinza"><fmt:message key="label.inicioDeVigencia" />
					<span class="asterisco">*
		  			</span></th>
					<fmt:formatDate var="iniVigencia" value="${solicitacao.apolice.dataInicialVigencia }" pattern="dd/MM/yyyy"/>
				<td class="camposinternos">
					<input type="text" id="inicioVigencia" readonly="readonly" name="inicioVigencia"  value="${iniVigencia}" class="required" maxlength="10"/></td>
			</tr>
			<tr>
				<th width="200" class="barracinza"><fmt:message key="label.terminoDeVigencia" />
					<span class="asterisco">*
		  			</span></th>
					<fmt:formatDate var="finalVigencia" value="${solicitacao.apolice.dataFinalVigencia }" pattern="dd/MM/yyyy"/>					
				<td width="350"class="camposinternos">
					<input type="text" id="fimVigencia" readonly="readonly" name="fimVigencia"  value="${finalVigencia }" class="required" maxlength="10"/></td>
				<th width="200" class="barracinza"><fmt:message key="label.valorVeiculo" />
					<span class="asterisco">*
		  			</span></th>
				<td width="350"class="camposinternos"> 
					<fmt:formatNumber var="valVeiculo" value="${solicitacao.apolice.valorVeiculo }" type="currency" currencySymbol=""/>
					<input type="text" name="valorVeiculo"  value="${valVeiculo }"  class="required decimal" maxlength="10"/>
				</td>
			</tr>
		    <tr>					
				<th width="200" class="barracinza"><fmt:message key="label.valorCarroceria" /></th>
				<fmt:formatNumber var="valCarroceria" value="${solicitacao.apolice.valorCarroceria }" type="currency" currencySymbol=""/>
				<td width="350"class="camposinternos">
					<input type="text" name="valorCarroceria"  value="${valCarroceria }"  maxlength="10"/></td>
				<th width="200" class="barracinza"><fmt:message key="label.valorBlindagem" /></th>
				<td width="350"class="camposinternos">
					<fmt:formatNumber var="valBlindagem" value="${solicitacao.apolice.valorBlindagem }" type="currency" currencySymbol=""/>
					<input type="text" name="valorBlindagem"  value="${valBlindagem }" maxlength="10" class="decimal"/>
				</td>
			</tr>
			<tr>					
				<th width="200" class="barracinza"><fmt:message key="label.valorEquipamento" /></th>
				<td width="350"class="camposinternos">
					<fmt:formatNumber var="valEquipamento" value="${solicitacao.apolice.valorEquipamento }" type="currency" currencySymbol=""/>
					<input type="text" name="valorEquipamento"  value="${valEquipamento }" maxlength="10" class="decimal"/>
				</td>
				<th width="200" class="barracinza"><fmt:message key="label.descricaoEquipamento" /></th>
				<td width="350"class="camposinternos">
					<input type="text" name="descEquipamento"  value="${solicitacao.apolice.descricaoEquipamento }" maxlength="30"/></td>
			</tr>
			<tr>					
				<th width="200" class="barracinza"><fmt:message key="label.valorAcessorio" /></th>
				<td width="350"class="camposinternos">
					<fmt:formatNumber var="valAcessorio" value="${solicitacao.apolice.valorAcessorio }" type="currency" currencySymbol=""/>
					<input type="text" name="valorAcessorio"  value="${valAcessorio }"  maxlength="10" class="decimal"/>
				</td>
				<th width="200" class="barracinza"><fmt:message key="label.descricaoAcessorio" /></th>
				<td width="350"class="camposinternos">
					<input type="text" name="descAcessorio"  value="${solicitacao.apolice.descricaoAcessorio }"  maxlength="30"/></td>
			</tr>
			<tr>					
				<th width="200" class="barracinza"><fmt:message key="label.premioLiquidoSeguro" />
					<span class="asterisco">*
		  			</span></th>
				<td width="350"class="camposinternos">
					<fmt:formatNumber var="valPremLiquido" value="${solicitacao.apolice.valorPremioLiquido }" type="currency" currencySymbol=""/>
					<input type="text" name="premioLiquido"  value="${valPremLiquido }"  class="required decimal" maxlength="10"/>
				</td>
				<th width="200" class="barracinza"><fmt:message key="label.premioTotalSeguro" />
					<span class="asterisco">*
		  			</span></th>
				<td width="350"class="camposinternos">
					<fmt:formatNumber var="valTotalSeguro" value="${solicitacao.apolice.valorPremioTotal }" type="currency" currencySymbol=""/>
					<input type="text" name="premioTotal"  value="${valTotalSeguro }"  class="required decimal" maxlength="10"/>
				</td>
			</tr>
			<tr>					
				<th width="200" class="barracinza"><fmt:message key="label.observacoes" /></th>
				<td width="350" class="camposinternos" colspan="3">
					<textarea rows="5" cols="3" style="width: 250px" name="observacoes">${solicitacao.apolice.observacao }</textarea></td>
			</tr>
		</table>


		<table cellspacing="0" class="detalhe" >
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.corretorGerenteNegocios" /></th>
			</tr>
		</table>

		<br>

		<table width="900" cellspacing="3" class="detalhe2">
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.nome" />
					<span class="asterisco">*
		  			</span></th>
				<td width="350px" class="camposinternos">
					<input  type="text" id="nomeCorretor" name="nomeCorretor"  value="${solicitacao.corretor.nome }" maxlength="40" size="45"/></td>
				
				<th width="200px" class="barracinza"><fmt:message key="label.telefoneCorretor" />
					<span class="asterisco">*
		  			</span></th>
				<td width="350px" class="camposinternos">
					<input  type="text" id="foneCorretor"  name="foneCorretor"  value="${solicitacao.corretor.telefone1 }"  maxlength="15"/></td>	
			</tr>
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.emailCorretor" />
					<span class="asterisco">*
		  			</span></th>
				<td width="350px" class="camposinternos">
					<input  type="text" id="emailCorretor" name="emailCorretor"  value="${solicitacao.corretor.email }"  maxlength="40"/></td>
				<th width="200px" class="barracinza"><fmt:message key="label.susep" /></th>
				<td width="350px" class="camposinternos">
					<input  type="text" id="susep" name="susep"  value="${solicitacao.corretor.numeroSusep }"  maxlength="20"/></td>
			</tr>
		</table>	


		<table cellspacing="0" class="detalhe" >
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.dadosDeInstalacao" /></th>
			</tr>
		</table>


		<span class="texthelp2">
			<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" />Informe o local de instalação sugerido pelo segurado. 
		</span>


		<table width="900" cellspacing="3" class="detalhe2">
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.localDeInstalacao" /></th>
				<td width="350px" class="camposinternos">
					<select name="localInstalacao" id="localInstalacao" class="required">
						<option value="1" <c:if test="${solicitacao.localInstalacaoEquipamento eq '1'}">selected="selected"</c:if>><fmt:message key="label.localInstalacao.concessionaria" /></option>
						<option value="2" <c:if test="${solicitacao.localInstalacaoEquipamento eq '2'}">selected="selected"</c:if>><fmt:message key="label.localInstalacao.empresaDoCliente" /></option>
						<option value="3" <c:if test="${solicitacao.localInstalacaoEquipamento eq '3'}">selected="selected"</c:if>><fmt:message key="label.localInstalacao.residenciaDoCliente" /></option>
						<option value="4" <c:if test="${solicitacao.localInstalacaoEquipamento eq '4'}">selected="selected"</c:if>><fmt:message key="label.localInstalacao.outros" /></option>
					</select> 
				</td>
			  	<th width="200px" class="barracinza"><fmt:message key="label.nome" /></th>
				<td width="350px" class="camposinternos"><input type="text" name="nomeInstalacao"  value=""  maxlength="40" size="45"/></td>
			</tr>
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.rua" /></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="ruaInstalacao"  value="${solicitacao.localInstalacao.descricaoLogradouro }"  maxlength="40" size="45"/></td>
				<th width="200px" class="barracinza"><fmt:message key="label.numero" /></th>
				<td width="350px" class="camposinternos">
					<input type="text" id="numInstalacao" name="numInstalacao" value="${solicitacao.localInstalacao.numero }"  maxlength="10"/></td>
			</tr>
		    <tr>
				<th width="200px" class="barracinza"><fmt:message key="label.complemento" /></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="complemInstalacao"  value="${solicitacao.localInstalacao.complemento }"  maxlength="20"/></td>
				<th width="200px" class="barracinza"><fmt:message key="label.bairro" /></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="bairroInstalacao"  value="${solicitacao.localInstalacao.descricaoBairro }" /></td>
			</tr>
		    <tr>
				<th width="200px" class="barracinza"><fmt:message key="label.estado" /></th>
				<td width="350px" class="camposinternos">
					<select  name="estadoInstalacao" id="estadoInstalacao" onchange="carregarCidades(this.value, '#cidadeInstalacao'); ">
						<option value=""><fmt:message key="label.selecione" /></option>
				  	</select>
				</td>
				<th width="200px" class="barracinza"><fmt:message key="label.cidade" /></th>
				<td width="350px" class="camposinternos">
					<select  name="cidadeInstalacao" id="cidadeInstalacao">
						<option value=""><fmt:message key="label.selecione" /></option>
					</select>
				</td>
			</tr>
		    <tr>
				<th width="200px" class="barracinza"><fmt:message key="label.cep" /></th>
				<td width="350px" class="camposinternos">
					<input type="text" id="cepInstalacao" name="cepInstalacao"  value="${solicitacao.localInstalacao.cep }"  maxlength="8"/></td>
				<th width="200px" class="barracinza"><fmt:message key="label.telefone" /></th>
				<td width="350px" class="camposinternos">
					<input type="text" id="foneInstalacao" name="foneInstalacao"  value="${solicitacao.telefoneInstalacao }"  maxlength="10"/></td>
			</tr>
		    <tr>
				<th width="200px" class="barracinza"><fmt:message key="label.responsavel" /></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="responsavelInstalacao"  value="${solicitacao.responsavelInstalacao }" maxlength="40"/></td>
				<th width="200px" class="barracinza"><fmt:message key="label.telefoneResponsavel" /></th>
				<td width="350px" class="camposinternos">
					<input type="text"  id="foneResponsavel" name="foneResponsavel"  value="${solicitacao.telefoneResponsavelInstalacao }"  maxlength="10"/></td>
		    </tr>
		</table>


		<table cellspacing="0" class="detalhe" >
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.segurado" /></th>
		  </tr>
		</table>


		<span class="texthelp2">
			<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" />Informe os dados do segurado que está contratando o seguro. 
		</span>


		<table width="900" cellspacing="3" class="detalhe2">
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.nome" />
					<span class="asterisco">*
		  			</span></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="nomeSegurado"  value="${solicitacao.segurado.nome }"  class="required" maxlength="40" size="45"/>
				</td>
			  	<th width="200px" class="barracinza"><fmt:message key="label.contatoResponsavel" /></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="responsavelSegurado"  value="${solicitacao.segurado.endereco.contato }"  maxlength="40"/>
				</td>
			</tr>
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.tipo" />
					<span class="asterisco">*
		  			</span></th>
				<td width="350px" class="camposinternos">
					<select  name="tipoSegurado" id="tipoSegurado"  onchange="showCamposTipoPessoa();">
						<option value="J" <c:if test="${fn:toUpperCase(solicitacao.segurado.tipoPessoa) eq 'J'}">selected="selected"</c:if>>Juridica</option>
						<option value="F" <c:if test="${fn:toUpperCase(solicitacao.segurado.tipoPessoa) eq 'F'}">selected="selected"</c:if>>Fisica</option>
					</select>
				</td>
				<th width="200px" class="barracinza"><fmt:message key="label.rua" /></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="ruaSegurado"  value="${solicitacao.segurado.endereco.descricaoLogradouro }"  maxlength="40" size="45"/>
				</td>
			</tr>
		   	<tr class="trSeguradoJuridico" style="display: none;">
				<th width="200px" class="barracinza"><fmt:message key="label.cnpj" />
					<span class="asterisco">*
		  			</span></th>
				<td width="350px" class="camposinternos">
					<input  type="text" name="cpfCnpj" id="cnpj" value="${solicitacao.segurado.numCpfCnpj }" maxlength="20"/>
				</td>
				<th width="200px" class="barracinza"><fmt:message key="label.inscricaoEstadual" /></th>
				<td width="350px" class="camposinternos">
					<input  type="text" name="ie" id="ie"  value="${solicitacao.segurado.inscricaoEstadual }"  maxlength="20"/>
				</td>
			</tr>
		  	<tr class="trSeguradoJuridico" style="display: none;">
				<th width="200px" class="barracinza"><fmt:message key="label.optantePeloSimples" />
					<span class="asterisco">*
		  			</span></th>
			  	<td width="350px" class="camposinternos">
			  		<select  name="simples" id="simples">
						<option 
							<c:if test="${not solicitacao.segurado.optanteSimples}">selected="selected"
							</c:if> value="0"><fmt:message key="label.nao" />
						</option>
						<option 
							<c:if test="${solicitacao.segurado.optanteSimples}">selected="selected"
							</c:if> value="1"><fmt:message key="label.sim" />
						</option>
				  	</select>
			  	</td>
			</tr>
			<tr class="trSeguradoFisico" style="display: none;">
				<th width="200px" class="barracinza"><fmt:message key="label.cpf" />
					<span class="asterisco">*
		  			</span></th>
				<td width="350px" class="camposinternos">
					<input  type="text" id="cpf" name="cpfCnpj"  value="${solicitacao.segurado.numCpfCnpj }" maxlength="15"/>
				</td>
				<th width="200px" class="barracinza"><fmt:message key="label.rg" /></th>
				<td width="350px" class="camposinternos">
					<input  type="text" name="rg"  value="${solicitacao.segurado.numRG }"  maxlength="15"/>
				</td>
			</tr>
		  	<tr class="trSeguradoFisico" style="display: none;">
				<th width="200px" class="barracinza"><fmt:message key="label.dataNascimento" /></th>
			  	<td width="350px" class="camposinternos">
			  		<fmt:formatDate var="dtNascSegurado" value="${solicitacao.segurado.dataNascimento }" pattern="dd/MM/yyyy"/>
			  		<input  type="text" id="nascSegurado" readonly="readonly" name="nascSegurado"  value="${dtNascSegurado}"  maxlength="15"/>
			  	</td>
				<th width="200px" class="barracinza"><fmt:message key="label.estadoCivil" /></th>
			  	<td width="350px" class="camposinternos">
			  		<select  name="estadoCivil" id="estadoCivil" >
						<option value="1" <c:if test="${solicitacao.segurado.estadoCivil eq '1'}">selected="selected"</c:if>><fmt:message key="label.estadoCivil.solteiro" /></option>
						<option value="2" <c:if test="${solicitacao.segurado.estadoCivil eq '2'}">selected="selected"</c:if>><fmt:message key="label.estadoCivil.casado" /></option>
						<option value="3" <c:if test="${solicitacao.segurado.estadoCivil eq '3'}">selected="selected"</c:if>><fmt:message key="label.estadoCivil.amasiado" /></option>
						<option value="4" <c:if test="${solicitacao.segurado.estadoCivil eq '4'}">selected="selected"</c:if>><fmt:message key="label.estadoCivil.divorciado" /></option>
						<option value="5" <c:if test="${solicitacao.segurado.estadoCivil eq '5'}">selected="selected"</c:if>><fmt:message key="label.estadoCivil.viuvo" /></option>
					</select>
			  	</td>
			</tr>
		  	<tr class="trSeguradoFisico" style="display: none;">
				<th width="200px" class="barracinza"><fmt:message key="label.naturalidade" /></th>
			  	<td width="350px" class="camposinternos">
			  		<input  type="text" name="naturalidade"  value="${solicitacao.segurado.naturalidade }"  maxlength="40"/>
			  	</td>
			</tr>
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.numero" /></th>
				<td width="350px" class="camposinternos">
					<input type="text" id="numSegurado" name="numSegurado"  value="${solicitacao.segurado.endereco.numero }" maxlength="10"/>
				</td>
				<th width="200px" class="barracinza"><fmt:message key="label.complemento" /></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="complemSegurado"  value="${solicitacao.segurado.endereco.complemento }"  maxlength="20"/>
				</td>
			</tr>
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.bairro" /></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="bairroSegurado"  value="${solicitacao.segurado.endereco.descricaoBairro }" maxlength="30"/>
				</td>
				<th width="200px" class="barracinza"><fmt:message key="label.estado" /></th>
				<td width="350px" class="camposinternos">
					<select  name="estadoSegurado" id="estadoSegurado" onchange="carregarCidades(this.value, '#cidadeSegurado'); ">
						<option value=""><fmt:message key="label.selecione" /></option>
					</select>
				</td>
			</tr>
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.cidade" /></th>
				<td width="350px" class="camposinternos">
					<select  name="cidadeSegurado" id="cidadeSegurado" >
						<option value=""><fmt:message key="label.selecione" /></option>
					</select>
				</td>
				<th width="200px" class="barracinza"><fmt:message key="label.cep" /></th>
				<td width="350px" class="camposinternos">
					<input type="text" id="cepSegurado" name="cepSegurado"  value="${solicitacao.segurado.endereco.cep }" maxlength="8"/>
				</td>
			</tr>
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.pontoReferencia" /></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="pontoReferencia"  value="${solicitacao.segurado.endereco.pontoReferencia }"  maxlength="80"/>
				</td>
				<th width="200px" class="barracinza"><fmt:message key="label.telefoneComercial" />
					<span class="asterisco">*
		  			</span></th>
				<td width="350px" class="camposinternos">
					<input type="text" id="foneComercial" name="foneComercial"  value="${solicitacao.segurado.telefone2 }" id="telefoneCobranca2"  class="required" maxlength="15"/>
				</td>
			</tr>
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.telefoneResidencial" />
					<span class="asterisco">*
		  			</span></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="foneResidencial" id="foneResidencial"  value="${solicitacao.segurado.telefone1 }"  class="required" maxlength="15"/>
				</td>
				<th width="200px" class="barracinza"><fmt:message key="label.telefoneCelular" />
					<span class="asterisco">*
		  			</span></th>
				<td width="350px" class="camposinternos">
					<input type="text" id="foneCelular" name="foneCelular"  value="${solicitacao.segurado.telefone3 }" id="telefoneCobranca3" class="required" maxlength="15"/>
				</td>
			</tr>
		</table>


		<table cellspacing="0" class="detalhe" >
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.veiculosCadastrados" />
					<div class="lembretes" style="*position:relative;*margin-right:30px;*margin-top:0px">
						<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/icon_arrow_down.png" width="16" height="16"  align="absmiddle"/>
							<a href="javascript:abrirIncluirVeiculo();" title="Incluir"  class="linkum"><fmt:message key="label.incluir" /></a>
			  		</div>
		    	</th>
		  </tr>
		</table>


		<span class="texthelp2">
			<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" /><fmt:message key="uc23.texto.03.informarMaisVeiculo" /> 
		</span>


		<table width="750" cellpadding="1" id="alter" cellspacing="0">
			<tr>
			    <th width="12%" class="texttable_azul" scope="col"><fmt:message key="label.placa" /></th>
			    <th width="11%" class="texttable_cinza" scope="col"><fmt:message key="label.chassi" /></th>
			    <th width="18%" class="texttable_cinza"  scope="col"><fmt:message key="label.marca" /></th>
			    <th width="8%" class="texttable_cinza" scope="col"><fmt:message key="label.modelo" /></th>
			    <th width="8%" class="texttable_cinza" scope="col"><fmt:message key="label.ano" /></th>
			    <th width="13%" class="texttable_cinza" scope="col"><fmt:message key="label.cor" /></th>
			    <th width="26%" class="texttable_cinza" scope="col"><fmt:message key="label.renavam" /></th>
			    <th width="4%" class="texttable_cinza" scope="col"><fmt:message key="label.excluir" /></th>
		  	</tr>
			
			<c:forEach var="veiculo" items="${listaVeiculos }" varStatus="status">
			
			  	<tr class="<c:if test="${status.count % 2 != 0 }">dif</c:if> veiculo" id="veiculo_${veiculo.codigo }">
			  		<td class="linkazul">${veiculo.placa }&nbsp;</td>
					<td>${veiculo.chassi }&nbsp;</td>
					<td>${veiculo.descricaoMarca }&nbsp;</td>
					<td>${veiculo.descricaoModelo }&nbsp;</td>
					<td>${veiculo.anoFabricacao }&nbsp;</td>
					<td>${veiculo.cor }&nbsp;</td>
					<td>${veiculo.renavan }&nbsp;</td>
					<td>
						<a href="javascript:abrirExcluirVeiculo(${veiculo.codigo }, null);" title="Excluir"><img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/excluir16-10.png" alt="Excluir" border="0" /></a>
					</td>
			  	</tr>
			</c:forEach>
		</table>
			 
			 
			<input type="hidden" name="dataInicial" value="${param.dataInicial }" />
			<input type="hidden" name="dataFinal" value="${param.dataFinal }" />
			<input type="hidden" name="numeroPlaca" value="${param.numeroPlaca }" />
			<input type="hidden" name="numeroChassi" value="${param.numeroChassi }" />
			<input type="hidden" name="nomeCliente" value="${param.nomeCliente }" />
			<input type="hidden" name="numSolicitacao" value="${param.numSolicitacao }" />
			<input type="hidden" name="numeroProposta" value="${param.numeroProposta }" />
			<input type="hidden" name="tipoSeguro" value="${param.tipoSeguro }" />
			<input type="hidden" name="statusSolicitacao" value="${param.statusSolicitacao }" />
			<input type="hidden" name="menu" value="${param.menu}" />
			<input type="button" class="button3" value="<fmt:message key="label.voltar" />"  onclick="voltar();"/>
			
			<div class="pgstabela">
				<input type="submit" class="button" value="<fmt:message key="label.atualizar" />" />
			</div>		
	</form>


	<div id="dialog" class="window modal_big" style="display: none;">
	</div>


	<div id="dialog_mensagem" class="popup_padrao" style="display: none;">
		     
		<div id="popup_msg_modal" class="popup_padrao_pergunta"></div>
		<div class="popup_padrao_resposta">
			<input type="button" class="button" value="Fechar" id="botaoPopUp"/>
		</div>
	</div>


	<div id="dialog_excluir" class="popup_padrao" style="display: none;">
		<form action="" id="formExcluirVeiculo">
			<input type="hidden" id="codigoVeiculo" name="codigoVeiculo" />
			<input type="hidden" id="indexVeiculo" name="indexVeiculo" />

			<div class="popup_padrao_pergunta"><fmt:message key="mensagem.confirmacao.excluirVeiculo" /></div>
			<div class="popup_padrao_resposta">
				<input type="button" class="button4 close" value="Não" onclick="javascript:$.closeOverlay();" />
				<input name="" type="button" class="button close" value="Sim" onclick="excluirVeiculo(${param.numeroSolicitacao });"/>
			</div>
		</form>
	</div>


	<div id="dialog_voltar" class="popup_padrao" style="display: none;">
		<form action="" id="formVoltar">

			<div class="popup_padrao_pergunta" style="height:30px;"><fmt:message key="uc23.texto.04.camposNaoForamSalvos" /></div>
			<div class="popup_padrao_resposta">
				<input type="button" class="button4 close" value="Não" onclick="javascript:$.closeOverlay();" />
				<input name="" type="button" class="button close" value="Sim" onclick="window.location.href='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC21/dv03&numeroSolicitacao=${param.numeroSolicitacao}&numSolicitacao=${param.numSolicitacao}&dataInicial=${param.dataInicial}&dataFinal=${param.dataFinal}&numeroPlaca=${param.placa}&numeroChassi=${param.chassi}&nomeCliente=${param.nomeCliente}&numeroProposta=${param.numeroProposta}&tipoSeguro=${param.tipoSeguro}&statusSolicitacao=${param.statusSolicitacao}&menu=${param.menu}';"/>
			</div>
		</form>
	</div>

