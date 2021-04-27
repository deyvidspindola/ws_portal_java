<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

	<script type="text/javascript">
	
		function carregarTipoServico(){
			
			var tiposServico = $('#tipoServico')[0];
			
			$.ajax({
				"url" : "/SascarPortalWeb/AgendarOrdemServico/listarTipoServico",
				"data" : {
					"acao" : 17
				},
				"dataType" : "json",
				"beforeSend" : function() {
					$("option[value!='']", "#tipoServico").remove();
				},
				"success" : function(json) {
					if (json.success) {
						$.each(json.tiposServico, function(i, tipoServico) {
							if (tipoServico.id && tipoServico.value) {
								var option = new Option(tipoServico.value, tipoServico.id);
								if ($.browser.msie) {
									tiposServico.add(option);
								} else {
									tiposServico.add(option, null);
								}
							}
						});
						
						validaFormularioPesquisaVazio();
						
					} else {
						$.showMessage(json.mensagem);
					}
				}
			});
			
		}
	
		function validaForm(form){
			
			// PEGANDO A REFERENCIA DA DIV DE MENSAGENS DE VALIDACAO
			var conteinerValidacao = $(".conteinerValidacao");
			
			// LIMPANDO AS MENSAGENS DE ERRO
			conteinerValidacao.find('li').remove();
			
			var dataInicial = $("#dataInicial").val();
			var dataFinal = $("#dataFinal").val();
			
			// RECUPERA A DATA INFORMADA E TRANSFORMA EM UM ARRAY
			var arrDataInicial = dataInicial.split('/');
			var arrDataFinal = dataFinal.split('/');
			
			// VARIAVEL UTILIZADA PARA CONTROLAR MENSAGEM DE ERRO DE PERIODO DE DATA
			var erroPeriodo = false;
			
			// VALIDA O PERIODO DAS DATAS ( A DATA INICIAL NAO PODE SER MAIOR DO QUE A DATA FINAL )
			if ( arrDataInicial[2] > arrDataFinal[2] ){ 	   // COMPARA O ANO
				erroPeriodo = true;
			} else if ( arrDataInicial[1] > arrDataFinal[1] ){ // COMPARA O MES
				if(arrDataInicial[2] < arrDataFinal[2] ){
					// NÃO FAZ NADA
				}else{
					erroPeriodo = true;	
				}
		    } else if ( arrDataInicial[0] > arrDataFinal[0] ){ // COMPARA O DIA
		    	erroPeriodo =  true;
		    } 
			
			
			if($("#status").val() == ''){
				
				html = '<li><label><fmt:message key="mensagem.campoObrigatorio.osStatus" /></label></li>';
				conteinerValidacao.find('ol').append(html);
				
			}else{
				
				if(dataInicial == '' && dataFinal == ''){
					$(form).unbind('submit').submit();
				}else{
					if(dataInicial != '' && dataFinal != ''){
						
						// SE O PERIODO ESIVER INCORRETO APRESENTA A MENSAGEM DE ERRO E NAO SUBMETE O FORM
						if(erroPeriodo){
							
							$("#dataInicial").val('');
							$("#dataFinal").val('');
							
							html = '<li><label><fmt:message key="mensagem.informacao.dataInicialNaoPodeMaiorDataFinal" /></label></li>';
							conteinerValidacao.find('ol').append(html);
							
						}else{
							$(form).unbind('submit').submit();
						}
						
					}else{
						if(dataInicial != ''){
							html = '<li><label><fmt:message key="mensagem.campo.dataFinalValidaMaiorOuIgualInicial" /></label></li>';
							conteinerValidacao.find('ol').append(html);
						}else{
							html = '<li><label><fmt:message key="mensagem.campo.dataInicialValida" /></label></li>';
							conteinerValidacao.find('ol').append(html);
						}
					}
				} 
				
			}
			
			
		}
		
		function validaFormularioPesquisaVazio(){
			
			if($("#filtroImputTipoServico").val() != ''){
								
				$('#tipoServico option').each(function(){
					if($(this).val() == $("#filtroImputTipoServico").val()){
				        $(this).attr('selected',true);
				    }
				});
			}
			
			if($("#filtroImputStatus").val() != ''){
				
				$('#status option').each(function(){
				    if($(this).val() == $("#filtroImputStatus").val()){
				        $(this).attr('selected',true);
				    }
				});
			}
			
		}
		
		$(document).ready(function(){
			
			// CARREGA COMBO DE TIPOS DE SERVICOS
			carregarTipoServico();
			
			var container = $('div.container2');
			$("#formPesquisa").validate({
				errorContainer: container,
				errorLabelContainer: $("ol", container),
				wrapper: 'li',
				submitHandler : function(form) {
					validaForm(form);
				}
			});
		
			$("#dataInicial").datepicker({
				dateFormat: 'dd/mm/yy',
				changeMonth: true,
				changeYear: true,
				onClose: function( selectedDate ) {
					$( "#dataFinal" ).datepicker( "option", "minDate", selectedDate );
				  }
			});

			$("#dataFinal").datepicker({
				dateFormat: 'dd/mm/yy',
				changeMonth: true,
				changeYear: true,
				onClose: function( selectedDate ) {
					$( "#dataInicial" ).datepicker( "option", "maxDate", selectedDate );
				  }
			});
	
			$('#dataInicial, #dataFinal').blur(function(){
				$(this).setMask('date');
			}).focus(function(){
				$(this).unsetMask();
			});
	
			/* APENAS NUMEROS */
			$('#numeroOrdemServico').setMask({mask:'9999999999'});
			
		});
			
	</script>

	<div class="conteinerValidacao">
		<ol style="color: #C00;">
		</ol>
	</div>
	
	<div class="container2">
		<ol>
		</ol>
	</div>

	<form id="formPesquisa" method="post" class="filtro"
		  action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC43/dv02" >
		 
		<input type="hidden" id="filtroImputStatus" name="filtroImputStatus" value="${param.status}" /> 
		<input type="hidden" id="filtroImputTipoServico" name="filtroImputTipoServico" value="${param.tipoServico}" /> 
		  
		<div class="cabecalho2">
			<!--
			<div class="caminho" style="">
				<a class="linktres" title="<fmt:message key="label.home" />" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}"><fmt:message key="label.home" /></a>
				&gt;
				<a class="linktres" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC43/dv01"><fmt:message key="label.servicos" /></a>
				&gt;
				<a class="linkquatro" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC43/dv01">
				<strong><fmt:message key="label.agendarAtendimento" /></strong>
				</a>
			</div>
			
			<strong><fmt:message key="label.agendarAtendimento" /></strong>-->
		</div>
		
		<div class="busca_branca">
			<span class="text1"><fmt:message key="label.escolhaTipoBusca" /></span>
			<span class="texthelp2">
				<img hspace="5" height="16" align="absmiddle" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" />
				<fmt:message key="label.buscaAvancada" />
			</span>
		</div>
		
		<div class="busca_cinza">
			<span class="text2"><fmt:message key="label.peloPeriodo" />:</span>
			<label>
				<span class="text3"><fmt:message key="label.dataInicial" />:</span>
				<input id="dataInicial" name="dataInicial" class="text dateBR" type="text" maxlength="10" value="${param.dataInicial}" readonly="readonly"/>
			</label>
			<label style="margin-right: 30px;">
				<span class="text3"><fmt:message key="label.dataFinal" />:</span>
				<input id="dataFinal" name="dataFinal" class="text dateBR" type="text" maxlength="10" value="${param.dataFinal}" readonly="readonly"/>
			</label>
			
			<span class="texthelp2" style="position: absolute; margin-left: 35px; margin-bottom: 0px; margin-top: 0px;">
				<img hspace="5" height="16" align="absmiddle" width="16"  src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" />
				<fmt:message key="label.buscarTodosRegistroDataMesAno" />
			</span>
		</div>
		
		<div class="busca_branca">
			<span class="text2"><fmt:message key="label.pelaPlaca" />:</span>
			<label>
				<span class="text3"><fmt:message key="label.nAbrev" />:</span>
				<input id="placa" class="text" type="text" maxlength="10" value="" name="placa" value="${param.placa}" />
			</label>
		</div>
		
		<div class="busca_cinza">
			<span class="text2"><fmt:message key="label.peloChassi" />:</span>
			<label>
				<span class="text3"><fmt:message key="label.nAbrev" />:</span>
				<input id="chassi" class="text" type="text" maxlength="20" value="" name="chassi" value="${param.chassi}" />
			</label>
		</div>
		
		<div class="busca_branca">
			<span class="text2"><fmt:message key="label.peloTipo" />:</span>
			<label>
				<select id="tipoServico" name="tipoServico" style="width: 300px;" >
					<option value=""><fmt:message key="label.selecione" /></option>
				</select>
			</label>
		</div>
		
		<div class="busca_cinza">
			<span class="text2"><fmt:message key="label.peloStatus" />:</span>
			<span class="asterisco">*</span>
			<label>
				<select id="status" name="status" style="width: 300px;" >
					<option value=""><fmt:message key="label.selecione" /></option>
					<option value="c"><fmt:message key="label.statusOS.concluido" /></option>
					<option value="a"><fmt:message key="label.statusOS.autorizado" /></option>
				</select>
			</label>
		</div>
		
		<div class="busca_branca">
			<span class="text2"><fmt:message key="label.peloNumeroOS" />:</span>
			<span class="text3"><fmt:message key="label.nAbrev" />:</span>
			<input id="numeroOrdemServico" class="text" type="text" maxlength="10" name="numeroOrdemServico" value="${param.numeroOrdemServico}" />
		</div>
		
		<div class="busca_cinza">
			<span class="text2"><fmt:message key="label.peloNomeCliente" />:</span>
			<input id="nomeCliente" class="text" type="text" maxlength="30" name="nomeCliente" value="${param.nomeCliente}" />
		</div>
		
		<!-- <div class="busca_cinza">
			<input id="selecionarTodos" class="check" type="checkbox" name="selecionarTodos" checked="checked" />
			<span class="text2">Buscar Todos </span>
		</div> -->
		
		<div class="busca_branca">
			<input id="button" class="button" type="submit" value="<fmt:message key="label.buscar" />" name="button" />
			<input id="Limpar" class="button4" type="button" value="<fmt:message key="label.limpar" />" name="button2" onclick="limparCampos('#formPesquisa');"/>
		</div>
		
	</form>
