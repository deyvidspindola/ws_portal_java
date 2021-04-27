<jsp:directive.include file="/WEB-INF/views/includes.jsp" />

<script type="text/javascript">

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
		
		if($("#filtroImputDataInicialPagamento").val() != ''){
			filtroSelecionado = true;
			$("#filtroDataInicialPagamentoS").val($("#filtroImputDataInicialPagamento").val());
		}else{
			$("#filtroDataInicialPagamentoS").val('');
		}
		
		if($("#filtroImputDataFinalPagamento").val() != ''){
			filtroSelecionado = true;
			$("#filtroDataFinalPagamentoS").val($("#filtroImputDataFinalPagamento").val());
		}else{
			$("#filtroDataFinalPagamentoS").val('');
		}
		
		if(filtroSelecionado == true){
			$("#selecionarTodos").removeAttr("checked");
			$("#selecionarTodos").removeClass("required");
		}
		
	}

	function resetForm(){
		
		$("#filtroNumeroBordero").val('');
		$("#filtroImputNumeroBordero").val('');
	
		$("#filtroNumeroOS").val('');
		$("#filtroImputNumeroOS").val('');
	
		$("#filtroDataInicialFechamentoS").val('');
		$("#filtroImputDataInicialFechamento").val('');
			
		$("#filtroDataFinalFechamentoS").val('');
		$("#filtroImputDataFinalFechamento").val('');
	
		$("#filtroDataInicialPagamentoS").val('');
		$("#filtroImputDataInicialPagamento").val('');
	
		$("#filtroDataFinalPagamentoS").val('');
		$("#filtroImputDataFinalPagamento").val('');
		
		$("#selecionarTodos").attr("checked", "checked");
	}
	
	function submeterPesquisa(form){
		
		// PEGANDO A REFERENCIA DA DIV DE MENSAGENS DE VALIDACAO
		var conteinerValidacao = $(".conteinerValidacao");
		
		// LIMPANDO AS MENSAGENS DE ERRO
		conteinerValidacao.find('li').remove();
		
		var filtroSelecionado = false;
		
		if($("#filtroNumeroBordero").val() != '' 		 ||
		   $("#filtroNumeroOS").val() != '' 			 ||
		   $("#filtroDataInicialFechamentoS").val() != '' ||
		   $("#filtroDataFinalFechamentoS").val() != ''	 ||
		   $("#filtroDataInicialPagamentoS").val() != ''  ||
		   $("#filtroDataFinalPagamentoS").val() != '' )
		{
			filtroSelecionado = true;
		}else{
			if($('#selecionarTodos').attr('checked') == true){
				filtroSelecionado = true;
			}else{
				filtroSelecionado = false;
			}
		}
		
		if(filtroSelecionado){
			$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC27/dv02");
			$(form).unbind('submit').submit();
		}else{
			html = '<li><label><fmt:message key="mensagem.selecione.aoMenos1Filtro" /></label></li>';
			conteinerValidacao.find('ol').append(html);
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
				filtroDataInicialPagamentoS: {
					dateBR:  true,
					required: false
				},
				filtroDataFinalPagamentoS: {
					dateHigher: "#filtroDataInicialPagamentoS",
					dateBR:  true,
					required: false
				},
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
				filtroDataInicialPagamentoS: {
					dateBR:  '<fmt:message key="mensagem.informacao.dataInicialPagamentoValida" />',
					required: ""
				},
				filtroDataFinalPagamentoS: {
					dateHigher: '<fmt:message key="mensagem.informacao.dataFinalPagamentoMaiorDataInicial" />',
					dateBR:  '<fmt:message key="mensagem.informacao.dataFinalPagamentoValida" />',
					required: ""
				},
				filtroDataInicialFechamentoS: {
					dateBR:  '<fmt:message key="mensagem.informacao.dataInicialFechamentoValida" />',
					required: ""
				},
				filtroDataFinalFechamentoS: {
					dateHigher: '<fmt:message key="mensagem.informacao.dataFinalFechamentoMaiorInicial" />',
					dateBR:  '<fmt:message key="mensagem.informacao.dataFinalFechamentoValida" />',
					required: ""
				}
			}
		});

		$('#filtroDataInicialFechamentoS, #filtroDataFinalFechamentoS, #filtroDataInicialPagamentoS, #filtroDataFinalPagamentoS').blur(function(){
			$(this).setMask('date');
		}).focus(function(){
			$(this).unsetMask();
		});
		
		
		/* DATA DE FECHAMENTO */
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
		
		/* DATA DE PAGAMENTO */
		$("#filtroDataInicialPagamentoS").datepicker({
			dateFormat: 'dd/mm/yy',
			changeMonth: true,
			changeYear: true,
			onClose: function( selectedDate ) {
				$( "#filtroDataFinalPagamentoS" ).datepicker( "option", "minDate", selectedDate );
			  }
		});
		
		$("#filtroDataFinalPagamentoS").datepicker({
			dateFormat: 'dd/mm/yy',
			changeMonth: true,
			changeYear: true,
			onClose: function( selectedDate ) {
				$( "#filtroDataInicialPagamentoS" ).datepicker( "option", "maxDate", selectedDate );
			  }
		});
		
		$("#selecionarTodos").click(function(){
			if ($(this).is(':checked')){
				$("#filtroNumeroBordero").val('');
				$("#filtroNumeroOS").val('');
				$("#filtroDataInicialFechamentoS").val('');
				$("#filtroDataFinalFechamentoS").val('');
				$("#filtroDataInicialPagamentoS").val('');
				$("#filtroDataFinalPagamentoS").val('');
			}
		});
		
		$("#filtroNumeroBordero").keypress(function(){
			if($("#filtroNumeroBordero").val() != ''){
				$("#selecionarTodos").removeAttr("checked");
			}
			
		});
	   
	   $("#filtroNumeroOS").keypress(function(){
			if($("#filtroNumeroOS").val() != ''){
				$("#selecionarTodos").removeAttr("checked");
			}
			
		});
	   
	   $("#filtroDataInicialFechamentoS").datepicker().change(function() {
			if($("#filtroDataInicialFechamento").val() != ''){
				$("#selecionarTodos").removeAttr("checked");
			}
		});
	   
	   $("#filtroDataFinalFechamentoS").datepicker().change(function() {
			if($("#filtroDataFinalFechamento").val() != ''){
				$("#selecionarTodos").removeAttr("checked");
			}
		});
	   
	   $("#filtroDataInicialPagamentoS").datepicker().change(function() {
			if($("#filtroDataInicialPagamento").val() != ''){
				$("#selecionarTodos").removeAttr("checked");
			}
		});
	   
	   $("#filtroDataFinalPagamentoS").datepicker().change(function() {
			if($("#filtroDataFinalPagamento").val() != ''){
				$("#selecionarTodos").removeAttr("checked");
			}
		});
		
		$('#filtroNumeroOS').setMask({mask:'999999999999999'});
		$('#filtroNumeroBordero').setMask({mask:'9999999999'});
		
		$('#filtroDataInicialPagamentoS').limit('10');
		$('#filtroDataFinalPagamentoS').limit('10');
		
		$('#filtroDataInicialFechamentoS').limit('10');
		$('#filtroDataFinalFechamentoS').limit('10');

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

<div class="cabecalho3" style="padding-left: 90px; width: 870px;">
	<fmt:message key="label.borderosPagos" />
	<span style="font-size: 11px;"> - <fmt:message key="label.conjuntoOSAbrev" /></span>
	
	<div class="caminho">
		<a class="linktres" title="<fmt:message key="label.home" />" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}"><fmt:message key="label.home" /></a>
			&gt;
		<a class="linktres" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC27/dv01"><fmt:message key="label.pagamentos" /></a>
			&gt;
		<a class="linkquatro" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC27/dv01"><fmt:message key="label.borderosPagos" /></a>
	</div>
</div>


<div class="busca_branca">
	<span class="text1"><fmt:message key="uc27.texto.001.aquiVcVerificaBorderosPagos" />:</span>
	<span class="texthelp2" style="">
		<img hspace="5" height="16" align="absmiddle" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png">
		<fmt:message key="label.buscaAvancada" />
	</span>
</div>

<form id="formPesquisa" 
 	  method="post"
 	  class="filtro"
	  action="" >
	
	<input type="hidden" id="filtroImputNumeroOS" 			   name="filtroImputNumeroOS" 			    value="${param.filtroNumeroOS}" />
	<input type="hidden" id="filtroImputDataInicialFechamento" name="filtroImputDataInicialFechamentoS" value="${param.filtroDataInicialFechamentoS}" />
	<input type="hidden" id="filtroImputDataFinalFechamento"   name="filtroImputDataFinalFechamentoS"   value="${param.filtroDataFinalFechamentoS}" />
	<input type="hidden" id="filtroImputDataInicialPagamento"  name="filtroImputDataInicialPagamentoS"  value="${param.filtroDataInicialPagamentoS}" />
	<input type="hidden" id="filtroImputDataFinalPagamento"    name="filtroImputDataFinalPagamentoS"    value="${param.filtroDataFinalPagamentoS}" />
	<input type="hidden" id="filtroImputNumeroBordero" 		   name="filtroImputNumeroBordero" 		    value="${param.filtroNumeroBordero}" />
	
	<!-- CONSULTAR BORDEROS PAGOS -->
	<input type="hidden" name="filtroStatusBordero" value="PG"/>
	
	<div class="busca_cinza">
		<label>
			<span class="text2"><fmt:message key="label.peloNBordero" />:</span>
			<input id="filtroNumeroBordero" type="text" value="" maxlength="10" name="filtroNumeroBordero" />
		</label>
	</div>


	<div class="busca_branca">
		<span class="text2"><fmt:message key="label.peloNOSAbrev" />:</span>
		<label>
			<input type="text" name="filtroNumeroOS" id="filtroNumeroOS" value="" maxlength="15" />
		</label>
	</div>


	<div class="busca_cinza">
		<span class="text2"><fmt:message key="uc28.texto.002.quandoFechadoLote" /></span>
		
		<span class="text3"><fmt:message key="label.periodo" />:</span>
		
		<input id="filtroDataInicialFechamentoS" 
			   name="filtroDataInicialFechamentoS" 
			   type="text" 
			   value=""  
			   readonly="readonly"
			   class="dateBR text data" />
		
		<span class="text3">&ensp;a&ensp;</span>
		
		<input id="filtroDataFinalFechamentoS" 
			   name="filtroDataFinalFechamentoS" 
			   type="text" 
			   value="" 
			   readonly="readonly"
			   class="dateBR text data" />
	
	</div>

	<div class="busca_branca">
	
		<span class="text2"><fmt:message key="uc27.texto.002.quandoFoiPago" /></span>
		<span class="text3"><fmt:message key="label.periodo" />:</span>

		<input id="filtroDataInicialPagamentoS" 
			   type="text" 
			   value="" 
			   readonly="readonly"
			   name="filtroDataInicialPagamentoS" 
			   class="dateBR text data" />
		
		<span class="text3">&ensp;a&ensp;</span>
		
		<input id="filtroDataFinalPagamentoS" 
			   type="text" 
			   value="" 
			   readonly="readonly"
			   name="filtroDataFinalPagamentoS" 
			   class="dateBR text data" />
	
	</div>

	<div class="busca_cinza">
		<label>
			<input id="selecionarTodos" class="check required" type="checkbox" checked="checked" name="selecionarTodos" />
			<span class="text2"><fmt:message key="label.buscarTodos" /> </span>
		</label>
	</div>

	<div class="busca_branca">
		<input id="button" class="button" type="button" value="<fmt:message key="label.buscar" />" name="button" onclick="submeterPesquisa('#formPesquisa');"/>
		<input id="Limpar" class="button4" type="button" value="<fmt:message key="label.limpar" />" name="button2" onclick="resetForm();"/>
	</div>
</form>
