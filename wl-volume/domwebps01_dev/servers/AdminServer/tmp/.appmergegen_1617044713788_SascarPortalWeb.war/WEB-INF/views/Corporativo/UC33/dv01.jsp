<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

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
	
	function desabilitarBtnBuscarTodos(){
		$("#selecionarTodos").removeAttr("checked");
	}

	$(document).ready(function(){

		var container = $('div.container2');
		$("#formPesquisa").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li'
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
					
			desabilitarBtnBuscarTodos();
			
			$(this).setMask('date');
		}).focus(function(){
			$(this).unsetMask();
		});
				
		
		$("#selecionarTodos").click(function(){
			if ($(this).is(':checked')){
				$("#nomeCliente").val('');
				$("#dataInicial").val('');
				$("#dataFinal").val('');
				$("#checkboxServicosPendentes").val('');
				$("#checkboxServicosPagos").val('');
			}
		});

		$(".desabilitarBtnBuscarTodos").keypress(function(){
			$("#selecionarTodos").removeAttr("checked");
		});
		
		$(".desabilitarBtnBuscarTodos").focusout(function(){
			$("#selecionarTodos").removeAttr("checked");
		});
		
	});
</script>

	<div class="container2">
		<ol>
			<li><label for="dataInicial" class="error"><fmt:message key="mensagem.campo.dataInicialValida" /></label></li>
			<li><label for="dataFinal" class="error"><fmt:message key="mensagem.campo.dataFinalValidaMaiorOuIgualInicial" /></label></li>
		</ol>
	</div>

	<div class="cabecalho">
		<fmt:message key="label.contaDeIndicador" />
		<div class="caminho">
			<a class="linktres" title="<fmt:message key="label.home" />" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}"><fmt:message key="label.home" /></a>
			&gt;
			<a class="linktres" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC33/dv01"><fmt:message key="label.pagamentos" /></a>
			&gt;
			<a class="linkquatro" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC33/dv01"><fmt:message key="label.contaDeIndicador" /></a>
		</div>
	</div>
	
	<div class="busca_branca">
		<span class="text1"><fmt:message key="uc33.texto.001.pesquiseIndicacoesServicos" />:</span>
		
		<span class="texthelp2" style="*margin-top:0">
			<img hspace="5" height="16" width="16" align="absmiddle" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png">
			<fmt:message key="label.buscaAvancadaBreak" />
		</span>
	</div>
		
	<form id="formPesquisa" method="post" class="filtro"
		  action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC33/dv02" >	
 		  
		<!-- FILTRO 01 -->
		<div class="busca_cinza">
			<label>
				<span class="text2"><fmt:message key="label.peloNomeCliente" />: </span>
				<input id="nomeCliente" 
					   name="nomeCliente" 
					   value="${param.nomeCliente}"
					   type="text" 
					   maxlength="30" 
					   class="desabilitarBtnBuscarTodos" >
			</label>
		</div>
		
		<!-- FILTRO 02 -->
		<div class="busca_branca">
			<span class="text2"><fmt:message key="label.peloPeriodo" />:</span>
			
			<label>
     			<span class="text3"><fmt:message key="label.dataInicial" />:</span>
     			<input type="text" 
     				   maxlength="10" 
     				   name="dataInicial" 
     				   id="dataInicial" 
     				   readonly="readonly"
     				   value="${param.dataInicial}" 
     				   class="dateBR text data desabilitarBtnBuscarTodos" />
	     	</label>
	     	<label>
				<span class="text3"><fmt:message key="label.dataFinal" />:</span>
				<input type="text" 
					   maxlength="10" 
					   name="dataFinal" 
					   id="dataFinal" 
					   value="${param.dataFinal}" 
					   readonly="readonly"
					   class="dateBR text data desabilitarBtnBuscarTodos" />
			</label>
			
			<span class="texthelp2" style="*position:absolute;*margin-left:60px;*margin-top:0px">
				<img hspace="5" height="16" width="16" align="absmiddle" alt="" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png">
				<fmt:message key="label.buscarTodosRegistroDataMesAno" />
			</span>
		</div>
		
		<!-- FILTRO 03 -->
		<div class="busca_cinza">
			<span class="text2"><fmt:message key="label.peloStatusServico" />:</span>
			
			<input id="filtroStatusServicosPendentes" 
				   value="PE"
				   name="filtroStatus" 
				   type="radio" 
				   <c:if test="${param.filtroStatus eq 'PE'}">checked="checked"</c:if>
				   onclick="desabilitarBtnBuscarTodos()" />
			<span class="text3"><fmt:message key="label.servicosPendentes" /> </span>
			
			<input id="filtroStatusServicosPagos" 
				   value="PG"
				   name="filtroStatus" 
				   type="radio" 
				   <c:if test="${param.filtroStatus eq 'PG'}">checked="checked"</c:if>
				   onclick="desabilitarBtnBuscarTodos()" />
			<span class="text3"> <fmt:message key="label.servicosPagos" /></span>
		</div>
		
		<!-- FILTRO 04 -->
		<div class="busca_branca">
			<label>
				<input id="selecionarTodos" 
					   class="check" 
					   type="checkbox" 
					   checked="checked" 
					   name="selecionarTodos">
				<span class="text2"><fmt:message key="label.buscarTodos" /> </span>
			</label>
		</div>
		
		<div class="busca_cinza">
			<input id="btnBuscar" class="button"  type="submit" value="<fmt:message key="label.buscar" />" name="btnBuscar" />
			<input id="btnLimpar" class="button4" type="button"  value="<fmt:message key="label.limpar" />" name="btnLimpar" onclick="limparCampos('#formPesquisa');"/>
		</div>
		
		<div class="busca_branca"></div>

	</form>
