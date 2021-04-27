<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<script type="text/javascript">
	
	function resetForm(){
		
		$("#filtroNumeroBordero").val('');
		$("#filtroImputNumeroBordero").val('');
		
		$("#filtroNumeroOS").val('');
		$("#filtroImputNumeroOS").val('');
		
		// INPUT hidden DV02
		$("#filtroDataInicialFechamento").val('');
		$("#filtroDataFinalFechamento").val('');
		
		$("#filtroDataInicialFechamentoS").val('');
		$("#filtroImputDataInicialFechamento").val('');
				
		$("#filtroDataFinalFechamentoS").val('');
		$("#filtroImputDataFinalFechamento").val('');
		
		$("#filtroStatusBordero").val('');
		$("#filtroImputStatusBordero").val('');
		
		$("#selecionarTodos").attr("checked", "checked");
		
	}
	
	function validaParametrosFiltro(){
		
		var filtroSelecionado = false;
		
		if($("#filtroImputNumeroBordero").val() != ''){
			filtroSelecionado = true;
			$("#filtroNumeroBordero").val($("#filtroImputNumeroBordero").val());
		}else{
			$("#filtroNumeroBordero").val('');
		}
		
		if($("#filtroImputNumeroOS").val() != ''){
			filtroSelecionado = true;
			$("#filtroNumeroOS").val($("#filtroImputNumeroOS").val());
		}else{
			$("#filtroNumeroOS").val('');
		}
		
		if($("#filtroImputDataInicialFechamento").val() != ''){
			filtroSelecionado = true;
			$("#filtroDataInicialFechamentoS").val($("#filtroImputDataInicialFechamento").val());
		}else{
			$("#filtroDataInicialFechamentoS").val('');
		}
				
		if($("#filtroImputDataFinalFechamento").val() != ''){
			filtroSelecionado = true;
			$("#filtroDataFinalFechamentoS").val($("#filtroImputDataFinalFechamento").val());
		}else{
			$("#filtroDataFinalFechamentoS").val('');
		}
		
		if($("#filtroImputStatusBordero").val() != ''){
			filtroSelecionado = true;
			
			$('#filtroStatusBordero option').each(function(){
			    if($(this).val() == $("#filtroImputStatusBordero").val()){
			        $(this).attr('selected',true);
			    }
			});
		}
		
		if(filtroSelecionado == true){
			$("#selecionarTodos").removeAttr("checked");
			$("#selecionarTodos").removeClass("required");
		}
	}
	
	$(document).ready(function(){

		validaParametrosFiltro();
		
		var container = $('div.container2');
		$("#formPesquisa").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			rules: {
				filtroDataInicialFechamentoS: {
					dateBR:  true,
					required: false
				},
				filtroDataFinalFechamentoS: {
					dateHigher: "#filtroDataInicialFechamentoS",
					dateBR:  true,
					required: false
				}
			},
			messages: {
				filtroDataInicialFechamentoS: {
					dateBR:  '<fmt:message key="mensagem.campo.dataInicialValida" />',
					required: ""
				},
				filtroDataFinalFechamentoS: {
					dateHigher: '<fmt:message key="mensagem.informacao.dataFinalMaiorInicial" />',
					dateBR:  '<fmt:message key="mensagem.campo.dataFinallValida" />',
					required: ""
				}
			}
		});
		
		$("#filtroDataInicialFechamentoS").datepicker({
			dateFormat: 'dd/mm/yy',
			changeMonth: true,
			changeYear: true,
			onClose: function( selectedDate ) {
				$( "#filtroDataFinalFechamentoS" ).datepicker( "option", "minDate", selectedDate );
			  }
		});

		$("#filtroDataFinalFechamentoS").datepicker({
			dateFormat: 'dd/mm/yy',
			changeMonth: true,
			changeYear: true,
			onClose: function( selectedDate ) {
				$( "#filtroDataInicialFechamentoS" ).datepicker( "option", "maxDate", selectedDate );
			  }
		});
		

		$('#filtroDataInicialFechamentoS, #filtroDataFinalFechamentoS').blur(function(){
			$(this).setMask('date');
		}).focus(function(){
			$(this).unsetMask();
		});
		
		$("#selecionarTodos").click(function(){
			if ($(this).is(':checked')){
				$("#filtroNumeroBordero").val('');
				$("#filtroNumeroOS").val('');
				$("#filtroDataInicialFechamentoS").val('');
				$("#filtroDataFinalFechamentoS").val('');
				$("#filtroStatusBordero").val('');
			}     
		});

		/* 
		 *	R1. O checkbox "Buscar Todos" deve ser marcado como default. Caso o usuário informe algum dado de filtro, 
		 *  	o checkbox deve ser desmarcado automaticamente. 
		 */
		$("#filtroNumeroOS").keypress(function(){
			if($("#filtroNumeroOS").val() != ''){
				$("#selecionarTodos").removeAttr("checked");
			}
			
		});
		
		$("#filtroNumeroBordero").keypress(function(){
			if($("#filtroNumeroBordero").val() != ''){
				$("#selecionarTodos").removeAttr("checked");
			}
			
		});
		
		$("#filtroStatusBordero").change(function(){
			if($("#filtroStatusBordero").val() != ''){
				$("#selecionarTodos").removeAttr("checked");
			}
			
		});
		
		$("#filtroDataInicialFechamentoS").datepicker().change(function() {
			if($("#filtroDataInicialFechamentoS").val() != ''){
				$("#selecionarTodos").removeAttr("checked");
			}
		});
		
		$("#filtroDataFinalFechamentoS").datepicker().change(function() {
			if($("#filtroDataFinalFechamentoS").val() != ''){
				$("#selecionarTodos").removeAttr("checked");
			}
		});
		
		/* APENAS NUMEROS */
		$('#filtroNumeroOS').setMask({mask:'999999999999999'});
		$('#filtroNumeroBordero').setMask({mask:'9999999999'});
		
		$('#filtroDataInicialFechamentoS').limit('10');
		$('#filtroDataFinalFechamentoS').limit('10');
		
	});
	
</script>

	<div class="container2"> 
		<ol>
		</ol>
	</div>

	<div class="cabecalho3" style="padding-left: 40px; width: 920px;">
		<fmt:message key="label.borderosTramitacao" />
		<span style="font-size: 11px;"> - <fmt:message key="label.conjuntoOSAbrev" /></span>
		
		<div class="caminho" style="">
			<a class="linktres" title="<fmt:message key="label.home" />" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}"><fmt:message key="label.home" /></a>
				&gt;
			<a class="linktres" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC28/dv01"><fmt:message key="label.pagamentos" /></a>
				&gt;
			<a class="linkquatro" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC28/dv01"><fmt:message key="label.borderosTramitacao" /></a>
		</div>
	</div>


	<div class="busca_branca">
		<span class="text1">
			<fmt:message key="uc28.texto.001.aquiVcPodeSaberSituacoesBordero" />
		</span>
		
		<span class="texthelp2">
			<img hspace="5" height="16" align="absmiddle" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png">
			<fmt:message key="label.atencaoCamposAbaixoOuBuscarTodos" />
		</span>
		
	</div>
	
	<br>

	<form id="formPesquisa" 
	      method="post"
		  action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC28/dv02" >
		
		<input type="hidden" id="filtroImputNumeroOS" 			   name="filtroImputNumeroOS" 			   value="${param.filtroNumeroOS}" />
		<input type="hidden" id="filtroImputNumeroBordero" 		   name="filtroImputNumeroBordero" 		   value="${param.filtroNumeroBordero}" />
		<input type="hidden" id="filtroImputDataInicialFechamento" name="filtroImputDataInicialFechamento" value="${param.filtroDataInicialFechamentoS}" />
		<input type="hidden" id="filtroImputDataFinalFechamento"   name="filtroImputDataFinalFechamento"   value="${param.filtroDataFinalFechamentoS}" />
		<input type="hidden" id="filtroImputStatusBordero"         name="filtroImputStatusBordero"         value="${param.filtroStatusBordero}" />
		
		<div class="busca_cinza">
			<label>
				<span class="text2"><fmt:message key="label.peloNBordero" />: </span>
				<input id="filtroNumeroBordero" type="text" value="${param.filtroNumeroBordero}" maxlength="10" name="filtroNumeroBordero" />
			</label>
		</div>
	
		<div class="busca_branca">
			<span class="text2"><fmt:message key="label.peloNOSAbrev" />:</span>
			<label>
				<input id="filtroNumeroOS" class="text" type="text" maxlength="15" value="${param.filtroNumeroOS}" name="filtroNumeroOS" />
			</label>
		</div>
	
	
		<div class="busca_cinza">
			<span class="text2"><fmt:message key="uc28.texto.002.quandoFechadoLote" /></span>
			
			<span class="text3"><fmt:message key="label.periodo" />:</span>
			
			<input id="filtroDataInicialFechamentoS" 
				   type="text" 
				   name="filtroDataInicialFechamentoS" 
				   class="dateBR text data"
				   value="" />
			
			<span class="text3">a</span>
			
			<input id="filtroDataFinalFechamentoS" 
				   type="text" 
				   value="" 
				   class="dateBR text data"
				   name="filtroDataFinalFechamentoS" />
		
		</div>
		
		<!-- 
		/* 
		 * 	FILTRO STATUS BORDERO
		 *		Borderôs Pagos 			(status-bordero = PG) * NAO APARECE NESTE UC
		 * 		Borderôs Regularizados  (status-bordero = C) 
		 *		Borderôs Em Conferência (status-bordero = P) 
		 *		Borderôs Com Pendência  (status-bordero = I) 
		 **/
		 -->
		<div class="busca_branca">
			<label>
				<span class="text2"><fmt:message key="label.peloStatusBordero" />:</span>
				<select id="filtroStatusBordero" name="filtroStatusBordero" >
					<option value=""><fmt:message key="label.selecione" /></option>
					<option value="C" <c:if test="${param.filtroStatusBordero eq 'C' }">selected="selected"</c:if> ><fmt:message key="label.statusBorderoC" /></option>
					<option value="P" <c:if test="${param.filtroStatusBordero eq 'P' }">selected="selected"</c:if> ><fmt:message key="label.statusBorderoP" /></option>
					<option value="I" <c:if test="${param.filtroStatusBordero eq 'I' }">selected="selected"</c:if> ><fmt:message key="label.statusBorderoI" /></option>
				</select>
			</label>
		</div>
	
		<div class="busca_cinza">
			<label>
				<input id="selecionarTodos" class="check" type="checkbox" checked="checked" name="selecionarTodos" />
				<span class="text2"><fmt:message key="label.buscarTodos" /> </span>
			</label>
		</div>
	
		<div class="busca_branca">
			<input id="button" class="button" type="submit" value="<fmt:message key="label.buscar" />" name="button" />
			<input id="Limpar" class="button4" type="button" value="<fmt:message key="label.limpar" />" name="button2" onclick="resetForm();"/>
		</div>
	</form>

