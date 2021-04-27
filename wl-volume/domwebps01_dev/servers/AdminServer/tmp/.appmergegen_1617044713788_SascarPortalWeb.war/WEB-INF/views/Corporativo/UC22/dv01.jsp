<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/CadastrarSolicitacaoInstalacaoServlet/consultarListaSegurados?acao=1" context="/SascarPortalWeb"  />
	<c:import url="/PesquisarOrdensServico/listarMarcas?acao=1" context="/SascarPortalWeb"  />
</c:catch>

<script type="text/javascript">
	$(document).ready(function(){
		
		/* VIGENCIA */
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
		
		$("#nascSegurado").datepicker({
			dateFormat: 'dd/mm/yy',
			changeMonth: true,
			changeYear: true
		});
		
		$("#dataInstalacao").datepicker({
			dateFormat: 'dd/mm/yy',
			changeMonth: true,
			changeYear: true
		});

		$('#inicioVigencia, #fimVigencia, #nascSegurado, #dataInstalacao').blur(function(){
			$(this).setMask('date');
		}).focus(function(){
			$(this).unsetMask();
		});
		
		$(".decimal").setMask('decimal');
		
		$("#cepInstalacao, #cepSegurado").setMask('cep');


		$('#cpf').setMask('cpf');
		$('#cnpj').setMask('cnpj');
		
		
		$("#foneSolicitante").setMask({mask:'999999999999'});
		$("#foneResponsavel").setMask({mask:'999999999999'});
		$("#foneComercial").setMask({mask:'999999999999'});
		$("#foneInstalacao").setMask({mask:'999999999999'});
		$("#foneResidencial").setMask({mask:'999999999999'});
		$("#foneCelular").setMask({mask:'999999999999'});
		$("#numSegurado").setMask({mask:'9999999999'});
		$("#numInstalacao").setMask({mask:'9999999999'});
		$("#proposta").setMask({mask:'99999999999999999999'});
		$("#ie").setMask({mask:'99999999999999999999'});
		$("#numeroItem").setMask({mask:'99999999999999999999'});
		$("#numeroSurcusal").setMask({mask:'99999999999999999999'});
		$("#codigoCia").setMask({mask:'99999999999999999999'});
		$("#anoFabricacaoI").setMask({mask:'9999'});
		$("#renavamI").setMask({mask:'999999999999999'});
		
		var container = $('div.container2');
		var submitted = false;
		
		$("#formCadastro").validate({
			showErrors: function(errorMap, errorList) {
		          if (submitted) {
		              var summary = "";
		              $.each(errorList, function() {
		            	summary += "<li><label for='"+ this.element.name;
		              	summary += "' class='error'>" + this.message + "</label></li>"; 
		              });
		              submitted = false;
		          	  this.defaultShowErrors();
		          	  
					var containerHeight = container.height();
					var iframeHeigth = $(window).height();
		          	
					var newFrameHeigth = 0;
		          	if(iframeHeigth == 0){
		          		newFrameHeigth = 1700;
		          	}else{
		          		newFrameHeigth = iframeHeigth + containerHeight;
		          	}

		          	setTimeout(function(){
						setIframeParentHeight(newFrameHeigth);
					}, 500);
		          	  
		          }
		      },    
		    invalidHandler: function(form, validator) { submitted = true; },
		    onfocusout: function(element) { this.element(element); },
		    errorClass: "error",
			rules: {
				inicioVigencia: {
					dateBR:  true,
					required: true
				},
				fimVigencia: {
					dateHigher: "#inicioVigencia",
					dateBR:  true,
					required: true
				},
				dataInstalacao: {
					dateBR:  true,
					required: true,
					dateHigherNow: true
				}, 
				emailSolicitante:{
					email:  true,
					required: true
				},
				seguradora: "required",
				nomeSolicitante: "required",
				foneSolicitante: "required",
				nomeSegurado: "required",
				responsavelSegurado: "required",
				tipoSegurado: "required",
				ruaSegurado: "required",
				numSegurado: "required",
				bairroSegurado: "required",
				estadoSegurado: "required",
				cidadeSegurado: "required",
				cepSegurado: "required",
				foneResidencial: "required",
				foneComercial: "required",
				foneCelular: "required",
				proposta: "required",
				apolice: "required",
				numeroItem: "required",
				localInstalacao: "required",
				numeroPlacaI: "required",
				numeroChassiI: "required",
				anoFabricacaoI: "required",
				codigoMarcaI: "required",
				codigoModeloI: "required",
				corI: "required"
			},
			messages: {
				inicioVigencia: {
					dateBR:  '<fmt:message key="label.dataInicialInvalida" />',
					required: '<fmt:message key="mensagem.campoObrigatorio.dataInicial" />'
				},
				fimVigencia: {
					dateHigher: '<fmt:message key="mensagem.informacao.dataFinalMaiorInicial" />',
					dateBR:  '<fmt:message key="label.dataFinalInvalida" />',
					required: '<fmt:message key="mensagem.campoObrigatorio.dataFinal" />'
				},
				dataInstalacao: {
					dateBR:  '<fmt:message key="mensagem.campoInvalido.dataDeInstalacao" />',
					required: '<fmt:message key="mensagem.campoObrigatorio.dataDeInstalacao" />',
					dateHigherNow: '<fmt:message key="mensagem.informacao.dataInstalacaoMaiorIgualAtual" />'
				}, 
				emailSolicitante:{
					email:  '<fmt:message key="mensagem.campoInvalido.emailSolicitante" />',
					required: '<fmt:message key="mensagem.campoObrigatorio.emailSolicitante" />'
				},
				seguradora: '<fmt:message key="mensagem.campoObrigatorio.tipoDeContrato" />',
				nomeSolicitante: '<fmt:message key="mensagem.campoObrigatorio.nomeSolicitante" />',
				foneSolicitante: '<fmt:message key="mensagem.campoObrigatorio.telefoneSolicitante" />',
				nomeSegurado: '<fmt:message key="mensagem.campoObrigatorio.nomeSegurado" />',
				responsavelSegurado: '<fmt:message key="mensagem.campoObrigatorio.responsavelSegurado" />',
				tipoSegurado: '<fmt:message key="mensagem.campoObrigatorio.tipoSegurado" />',
				cpf: '<fmt:message key="mensagem.campoObrigatorio.cpf" />',
				cnpj: '<fmt:message key="mensagem.campoObrigatorio.cnpj" />',
				ie: '<fmt:message key="mensagem.campoObrigatorio.inscricaoEstadual" />',
				simples: '<fmt:message key="mensagem.campoObrigatorio.optantePeloSimples" />',
				ruaSegurado: '<fmt:message key="mensagem.campoObrigatorio.ruaSegurado" />',
				numSegurado: '<fmt:message key="mensagem.campoObrigatorio.numeroSegurado" />',
				bairroSegurado: '<fmt:message key="mensagem.campoObrigatorio.bairroSegurado" />',
				estadoSegurado: '<fmt:message key="mensagem.campoObrigatorio.estadoSegurado" />',
				cidadeSegurado: '<fmt:message key="mensagem.campoObrigatorio.cidadeSegurado" />',
				cepSegurado: '<fmt:message key="mensagem.campoObrigatorio.cepSegurado" />',
				foneResidencial: '<fmt:message key="mensagem.campoObrigatorio.telefoneResidencial" />',
				foneComercial: '<fmt:message key="mensagem.campoObrigatorio.telefoneComercial" />',
				foneCelular: '<fmt:message key="mensagem.campoObrigatorio.telefoneCelular" />',
				proposta: '<fmt:message key="mensagem.campoObrigatorio.nProposta" />',
				apolice: '<fmt:message key="mensagem.campoObrigatorio.nApolice" />',
				numeroItem: '<fmt:message key="mensagem.campoObrigatorio.numeroItem" />',
				localInstalacao: '<fmt:message key="mensagem.campoObrigatorio.localInstalacao" />',
				numeroPlacaI: '<fmt:message key="mensagem.campoObrigatorio.placa" />',
				numeroChassiI: '<fmt:message key="mensagem.campoObrigatorio.chassi" />',
				anoFabricacaoI: '<fmt:message key="mensagem.campoObrigatorio.ano" />',
				codigoMarcaI: '<fmt:message key="mensagem.campoObrigatorio.marca" />',
				codigoModeloI: '<fmt:message key="mensagem.campoObrigatorio.modelo" />',
				corI: '<fmt:message key="mensagem.campoObrigatorio.cor" />'
			},
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler : function(form) {
				submeterSolicitacao(form);
				return false;
			}
		});
		
		// Carregando Estados
		carregarEstados(1, "#estadoInstalacao");
		carregarEstados(1, "#estadoSegurado");
		
		if ($("#observacoes").length) {
			$('#observacoes').limit('250','#charsLeft');
		}
		
	});
	
	function submeterSolicitacao(form) {
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
					$("#dialog_mensagem #popup_msg_modal").html("Solicitação cadastrada com sucesso.");
					$("#botaoPopUp").click(function(){
						window.location.href='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC22/dv01&menu=${param.menu}';
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

	function carregarCidades(siglaUF, idSelect) {
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
					
					select.focus();
				} else {
					$.showMessage(json.mensagem);
				}
			}
		});
	}
	
	function showCamposTipoPessoa() {
			var simples = $("#simples");
			var cpf = $("#cpf");
			var cnpj = $("#cnpj");
			var dataNasc = $("#nascSegurado");
			var ie = $("#ie");
			
			if ($("#tipoSegurado").val() == 'F') {
				$(".trSeguradoFisico").show();
				$(".trSeguradoJuridico").hide();
				
				//O campo CPF deve ser informado;
				cpf.addClass("required");
				//O campo Data de Nascimento deve ser informado.
				dataNasc.addClass("required");
				dataNasc.rules("add", {
				 required: true,
				 dateBR:  true,
				 messages: {
				   required: '<fmt:message key="mensagem.campoObrigatorio.dataDeNascimento" />',
				   dateBR: '<fmt:message key="mensagem.campoInvalido.dataNascimentoInvalida" />'
				 }
				});
				
				cnpj.removeClass("required");
				ie.removeClass("required");
				simples.removeClass("required");
				
				//Remove o texto de erro
				$("label[for='cnpj']").parent().remove();
				$("label[for='ie']").parent().remove();
				$("label[for='simples']").parent().remove();
				
			} else {
				$(".trSeguradoFisico").hide();
				$(".trSeguradoJuridico").show();
				
				//O campo CNPJ deve ser informado;
				cnpj.addClass("required");
				//O campo Inscrição Estadual deve ser informado.
				ie.addClass("required");
				//O campo Optante pelo Simples deve ser informado;
				simples.addClass("required");
				
				cpf.removeClass("required");
				dataNasc.removeClass("required");
				dataNasc.removeClass("dateBR");
				dataNasc.rules("remove");
				
				//Remove o texto de erro
				$("label[for='nascSegurado']").parent().remove();
				$("label[for='cpf']").parent().remove();

			}
		}
		
	function carregarModelosI(codigoMarca) {

		if (codigoMarca == 0) {
			$("option[value!='0']","#codigoModeloI").remove();
			return;
		}

		var selectModelos = $('#codigoModeloI')[0];
		
		$.ajax({
			"url": "/SascarPortalWeb/PesquisarOrdensServico/listarModeloPorMarca",
			"data" : { "codigoMarca": codigoMarca, "acao" : 2 },
			"dataType" : "json",
			"beforeSend": function(){
				$("option[value!='0']","#codigoModeloI").remove();
			},
			"success": function(json){
				if (json.success) {
					$.each(json.modelos, function(i, modelo){
						var option = new Option(modelo.value, modelo.id);
						if ($.browser.msie) {
							selectModelos.add(option);
						} else {
							selectModelos.add(option,null);
						}
					});
					$("#codigoModeloI").focus();
					
				} else {
					$.showMessage(json.mensagem);
				}
			}
		});
	}
	
</script>

	<div class="container2" id="container2"> 
		<ol></ol>
	</div>

	<div class="cabecalho3">
		<div class="caminho3" style="*margin-left:340px;">
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/SegCorretora" class="linktres"><fmt:message key="label.home" /></a> > 
			<a href="#" class="linktres"><fmt:message key="label.servicos" /></a> > 
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC22/dv01" class="linkquatro"><fmt:message key="label.solicitacaoInstalacaoEquipamento" /></a>
		</div>
	  	 <fmt:message key="label.solicitacaoInstalacaoEquipamento" />
	</div>


	<form action="" method="post" class="filtro" id="formCadastro">
	
		<table cellspacing="0" class="detalhe" >
			<tr>
				<th width="200" class="barracinza"><fmt:message key="label.tipoDeContrato" /><span class="asterisco">*</span></th>
				<td width="350" class="camposinternos"> 
					<select  name="seguradora" id="seguradora" class="required" >
						<c:if test="${fn:length(listaSeguradora) > 1}">
							<option value=""><fmt:message key="label.selecione" /></option>
						</c:if>
						<c:forEach  var="seguradora" items="${listaSeguradora}">
							<c:if test="${not empty seguradora.identifier and not empty seguradora.value}">
								<option value="${seguradora.identifier}" <c:if test="${fn:toUpperCase(solicitacao.apolice.nomeSeguradora) eq fn:toUpperCase(seguradora.value)}">selected="selected"</c:if>>${seguradora.value}</option>
							</c:if>
						</c:forEach>
					</select>
				</td>
			</tr>
		</table>
		
		<table cellspacing="0" class="detalhe" >
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.dadosDoSolicitanteCorretor" /></th>
			</tr>
		</table>
		
		<table width="900" cellspacing="3" class="detalhe2">
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.nome" /> <span class="asterisco">*</span></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="nomeSolicitante"  value="" size="45" class="required" maxlength="40"/>
				</td>
				<th width="200px" class="barracinza"><fmt:message key="label.email" /> <span class="asterisco">*</span></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="emailSolicitante" id="emailSolicitante" value="" size="45"  class="required email" maxlength="40"/>
				</td>
			</tr>
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.telefone" /> <span class="asterisco">*</span></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="foneSolicitante" id="foneSolicitante" value="" class="required" maxlength="12"/>
				</td>
			</tr>
		</table>
		
		<div class="hr"></div>
		
		<table cellspacing="0" class="detalhe" >
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.dadosDoSegurado" /></th>
			</tr>
		</table>
		
		<table width="900" cellspacing="3" class="detalhe2">
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.nome" /> <span class="asterisco">*</span></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="nomeSegurado" value="" class="required" size="45" maxlength="40"/>
				</td>
				<th width="200px" class="barracinza"><fmt:message key="label.contatoResponsavel" /> <span class="asterisco">*</span></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="responsavelSegurado" value="" class="required" maxlength="40"/>
				</td>
			</tr>
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.tipoPessoa" /> <span class="asterisco">*</span></th>
				<td width="350px" class="camposinternos">
					<select class="required" name="tipoSegurado" id="tipoSegurado" onchange="showCamposTipoPessoa();">
						<option value=""><fmt:message key="label.selecione" /></option>
						<option value="J"
							<c:if test="${fn:toUpperCase(solicitacao.segurado.tipoPessoa) eq 'J'}">selected="selected"
							</c:if>><fmt:message key="label.tipoPessoa.juridica" />
						</option>
						<option value="F" 
							<c:if test="${fn:toUpperCase(solicitacao.segurado.tipoPessoa) eq 'F'}">selected="selected"
							</c:if>><fmt:message key="label.tipoPessoa.fisica" />
						</option>
					</select>
				</td>
			</tr>
			<tr class="trSeguradoJuridico" style="display: none;">
				<th width="200px" class="barracinza"><fmt:message key="label.cnpj" /> <span class="asterisco">*</span></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="cnpj" id="cnpj" value="" maxlength="20"/>
				</td>
				<th width="200px" class="barracinza"><fmt:message key="label.inscricaoEstadual" /> <span class="asterisco">*</span></th>
				<td width="350px" class="camposinternos">
					<input  type="text" name="ie" id="ie" value="" maxlength="20"/>
				</td>
			</tr>
			<tr class="trSeguradoJuridico" style="display: none;">
				<th width="200px" class="barracinza"><fmt:message key="label.optantePeloSimples" /> <span class="asterisco">*</span></th>
				<td width="350px" class="camposinternos">
					<select name="simples" id="simples">
						<option value=""><fmt:message key="label.selecione" /></option>
						<option value="1"><fmt:message key="label.sim" /></option>
						<option value="0"><fmt:message key="label.nao" /></option>
					</select>
				</td>
			</tr>
			<tr class="trSeguradoFisico" style="display: none;">
				<th width="200px" class="barracinza"><fmt:message key="label.cpf" /> <span class="asterisco">*</span></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="cpf" id="cpf" value="" maxlength="15"/>
				</td>
				<th width="200px" class="barracinza"><fmt:message key="label.dataDeNascimento" /> <span class="asterisco">*</span></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="nascSegurado" id="nascSegurado" readonly="readonly" class="dateBR" maxlength="10" value="" />
				</td>
				
			</tr>
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.rua" /> <span class="asterisco">*</span></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="ruaSegurado"  class="required"  value="" size="45" maxlength="40"/>
				</td>
				<th width="200px" class="barracinza"><fmt:message key="label.numero" /> <span class="asterisco">*</span></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="numSegurado" id="numSegurado" value="" class="required number" maxlength="10"/>
				</td>
			</tr>
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.complemento" /></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="complemSegurado"  value=""  maxlength="20"/>
				</td>
				<th width="200px" class="barracinza"><fmt:message key="label.bairro" /> <span class="asterisco">*</span></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="bairroSegurado"  value="" class="required" maxlength="30"/>
				</td>
			</tr>
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.estado" /> <span class="asterisco">*</span></th>
				<td width="350px" class="camposinternos">
					<select name="estadoSegurado" id="estadoSegurado" class="required" onchange="carregarCidades(this.value, '#cidadeSegurado');">
						<option value=""><fmt:message key="label.selecione" /></option>
					</select>
				</td>
				<th width="200px" class="barracinza"><fmt:message key="label.cidade" /> <span class="asterisco">*</span></th>
				<td width="350px" class="camposinternos">
					<select name="cidadeSegurado" id="cidadeSegurado" class="required">
						<option value=""><fmt:message key="label.selecione" /></option>
					</select>
				</td>
			</tr>
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.cep" /> <span class="asterisco">*</span></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="cepSegurado" id="cepSegurado" value="" class="required" maxlength="8"/>
				</td>
				<th width="200px" class="barracinza"><fmt:message key="label.telefoneComercial" /> <span class="asterisco">*</span></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="foneComercial" id="foneComercial" value="" class="required" maxlength="12"/>
				</td>
			</tr>
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.telefoneResidencial" /> <span class="asterisco">*</span></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="foneResidencial" id="foneResidencial"  value=""  class="required" maxlength="12"/>
				</td>
				<th width="200px" class="barracinza"><fmt:message key="label.telefoneCelular" /> <span class="asterisco">*</span></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="foneCelular"  value="" id="foneCelular" class="required" maxlength="12"/>
				</td>
			</tr>
		</table>
		
		<table cellspacing="0" class="detalhe" >
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.dadosDaApolice" /></th>
			</tr>
		</table>
		
		<table width="900" cellspacing="3" class="detalhe2">
			<tr>
				<th width="200" class="barracinza"><fmt:message key="label.nProposta" /> <span class="asterisco">*</span></th>
				<td width="350" class="camposinternos">
					<input type="text" name="proposta"  id="proposta" value=""  class="required" maxlength="20"/>
				</td>
				
				<th width="200" class="barracinza"><fmt:message key="label.nApolice" /> <span class="asterisco">*</span></th>
				<td width="350" class="camposinternos">
					<input type="text" name="apolice"  id="apolice" value=""  class="required" maxlength="20"/>
				</td>
			</tr>
			<tr>
				<th width="200" class="barracinza"><fmt:message key="label.nItem" /> <span class="asterisco">*</span></th>
				<td width="350" class="camposinternos">
					<input type="text" name="numeroItem"  id="numeroItem" value=""  class="required" maxlength="20"/>
				</td>
				
				<th width="200" class="barracinza"><fmt:message key="label.nSucursal" /></th>
				<td width="350" class="camposinternos">
					<input type="text" name="numeroSurcusal"  id="numeroSurcusal" value="" maxlength="20"/>
				</td>
			</tr>
			<tr>
				<th width="200" class="barracinza"><fmt:message key="label.codigoCIA" /></th>
				<td width="350" class="camposinternos">
					<input type="text" name="codigoCia"  id="codigoCia" value=""  maxlength="20"/>
				</td>
			</tr>
			<tr>
				<th width="200" class="barracinza"><fmt:message key="label.inicioDeVigencia" /> <span class="asterisco">*</span></th>
				<td width="350" class="camposinternos"> 
					<input type="text" name="inicioVigencia" readonly="readonly" id="inicioVigencia" maxlength="10" value=""/>
				</td>					
				
				<th width="200" class="barracinza"><fmt:message key="label.terminoDeVigencia" /> <span class="asterisco">*</span></th>
				<td width="350"class="camposinternos">
					<input type="text" name="fimVigencia" readonly="readonly" id="fimVigencia" maxlength="10" value=""/>
				</td>
			</tr>
		</table>
		
		<table cellspacing="0" class="detalhe" >
			<tr class="barraazulzinha">
			<th class="barraazulzinha"><fmt:message key="label.dadosDeInstalacao" /></th>
			</tr>
		</table>

		<table width="900" cellspacing="3" class="detalhe2">
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.localDeInstalacao" /> <span class="asterisco">*</span></th>
				<td width="350px" class="camposinternos">
					<select  name="localInstalacao" id="localInstalacao" class="required">
						<option value=""><fmt:message key="label.selecione" /></option>
						<option value="1"><fmt:message key="label.localInstalacao.concessionaria" /></option>
						<option value="3"><fmt:message key="label.localInstalacao.empresaDoCliente" /></option>
						<option value="2"><fmt:message key="label.localInstalacao.residenciaDoCliente" /></option>
						<option value="4"><fmt:message key="label.localInstalacao.outros" /></option>
					</select>
				</td>
				<th width="200px" class="barracinza"><fmt:message key="label.dataDeInstalacao" /> <span class="asterisco">*</span></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="dataInstalacao" readonly="readonly" id="dataInstalacao" class="dateBR required" maxlength="10" value=""/>
				</td>
			</tr>
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.nome" /></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="nomeInstalacao"  value="" size="40" maxlength="40"/>
				</td>
			</tr>
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.rua" /></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="ruaInstalacao"  value="" size="40" maxlength="40"/>
				</td>
				<th width="200px" class="barracinza"><fmt:message key="label.numero" /></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="numInstalacao" id="numInstalacao" value=""  maxlength="10"/>
				</td>
			</tr>
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.complemento" /></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="complemInstalacao"  value=""  maxlength="20"/>
				</td>
				<th width="200px" class="barracinza"><fmt:message key="label.bairro" /></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="bairroInstalacao" id="bairroInstalacao"  value="" maxlength="30"/>
				</td>
			</tr>
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.estado" /></th>
				<td width="350px" class="camposinternos">
					<select name="estadoInstalacao" id="estadoInstalacao" onchange="carregarCidades(this.value, '#cidadeInstalacao');">
						<option value=""><fmt:message key="label.selecione" /></option>
					</select>
				</td>
				<th width="200px" class="barracinza"><fmt:message key="label.cidade" /></th>
				<td width="350px" class="camposinternos">
					<select name="cidadeInstalacao" id="cidadeInstalacao">
						<option value=""><fmt:message key="label.selecione" /></option>
					</select>
				</td>
			</tr>
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.cep" /></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="cepInstalacao"  id="cepInstalacao" value=""  maxlength="8"/>
				</td>
				<th width="200px" class="barracinza"><fmt:message key="label.telefone" /></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="foneInstalacao" id="foneInstalacao" value=""  maxlength="12"/>
				</td>
			</tr>
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.responsavel" /></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="responsavelInstalacao"  value="" maxlength="40"/>
				</td>
				<th width="200px" class="barracinza"><fmt:message key="label.telefoneResponsavel" /></th>
				<td width="350px" class="camposinternos">
					<input type="text" name="foneResponsavel" id="foneResponsavel" value=""  maxlength="12"/>
				</td>
			</tr>
		</table>
		
		
		<table cellspacing="0" class="detalhe" >
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.dadosVeiculo" /></th>
		 	</tr>
		</table>

		<table width="900" cellspacing="3" class="detalhe2">
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.placa" /> <span class="asterisco">*</span></th>
				<td width="350px" class="camposinternos">
					<input type="text" id="numeroPlacaI" name="numeroPlacaI" class="required" maxlength="7"/>
				</td>
				<th width="200px" class="barracinza"><fmt:message key="label.chassi" /> <span class="asterisco">*</span></th>
				<td width="350px" class="camposinternos">
					<input type="text" id="numeroChassiI" name="numeroChassiI" class="required" maxlength="17"/>
				</td>
			</tr>
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.marca" /> <span class="asterisco">*</span></th>
				<td width="350px" class="camposinternos">
					<select name="codigoMarcaI" id="codigoMarcaI"  onchange="carregarModelosI(this.value);" class="required">
						<option value=""><fmt:message key="label.selecione" /></option>
						<c:forEach var="marca" items="${marcas}">
							<c:if test="${not empty marca.identifier && not empty marca.value}">
								<option value="${marca.identifier}">${marca.value}</option>
							</c:if>
						</c:forEach>
					</select>
				</td>
				<th width="200px" class="barracinza"><fmt:message key="label.modelo" /> <span class="asterisco">*</span></th>
				<td width="350px" class="camposinternos">
					<select name="codigoModeloI" id="codigoModeloI" class="required">
							<option value=""><fmt:message key="label.selecione" /></option>
						</select>
				</td>
			</tr>
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.ano" /> <span class="asterisco">*</span></th>
				<td width="350px" class="camposinternos">
					<input style="width:50px;" type="text" id="anoFabricacaoI" name="anoFabricacaoI" class="required" maxlength="4"/>   
				</td>
				<th width="200px" class="barracinza"><fmt:message key="label.cor" /> <span class="asterisco">*</span></th>
				<td width="350px" class="camposinternos">
					<input style="width:80px;" type="text" id="corI" name="corI" class="required" maxlength="15"/>
				</td>
			</tr>
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.renavam" /></th>
				<td width="350px" class="camposinternos">
					<input type="text" id="renavamI" name="renavamI" maxlength="15"/>   
				</td>
			</tr>
		</table>
		
		
		<table cellspacing="0" class="detalhe" >
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.observacoesGerais" /></th>
			</tr>
		</table>
		
		<table width="900" cellspacing="3" class="detalhe2">
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="label.observacao" /></th>
				<td width="350px" class="camposinternos">
					<textarea rows="5" cols="3" style="width: 500px; heigth: 80px;" name="observacoes" id="observacoes"></textarea>
				</td>
			</tr>
		</table>
		
		<div style="height: 200px;">
		
		<input type="button" class="button3" value="<fmt:message key="label.voltar" />" onclick="window.location.href='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC21/dv01&menu=${param.menu}';" />
	
		<div class="pgstabela">
			<input type="submit" class="button" value="<fmt:message key="label.incluir" />" />
		</div>
		
		</div>		
		
		<br clear="all"/>
       
		<div class="clear:both"></div>
	</form>
		
	<div id="dialog" class="window modal_big" style="display: none;"></div>

	<div id="dialog_mensagem" class="popup_padrao" style="display: none;">
		<div id="popup_msg_modal" class="popup_padrao_pergunta"></div>
		<div class="popup_padrao_resposta">
			<input type="button" class="button" value="<fmt:message key="label.fechar" />" id="botaoPopUp"/>
		</div>
	</div>

