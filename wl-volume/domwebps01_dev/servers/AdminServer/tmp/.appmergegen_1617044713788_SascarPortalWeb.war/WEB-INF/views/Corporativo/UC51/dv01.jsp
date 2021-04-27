<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/EnviarSolicitacaoLoteServlet/consultarListaSeguradoras?acao=1" context="/SascarPortalWeb"  />
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
	$(document).ready(function(){
		
		var container = $('div.container2');
		$("#formPesquisa").validate({
			rules: {
				dataInicial: "dateBR",
				dataFinal: {
					dateHigher: "#dataInicial",
					dateBR:  true
				},
				tiposContrato: "required"
			},
			messages: {
				dataInicial: '<fmt:message key="label.dataInicialInvalida" />',
				dataFinal: {
					dateHigher: '<fmt:message key="mensagem.informacao.dataFinalMaiorInicial" />',
					dateBR: '<fmt:message key="label.dataFinalInvalida" />'
				},
				tiposContrato: '<fmt:message key="mensagem.informacao.dataFinalFechamentoValida" />'
			},
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
			$(this).setMask('date');
		}).focus(function(){
			$(this).unsetMask();
		});
		
		$("#nrLote").setMask({mask:'999999999999999'});
	});
</script>

<div class="container2"> 
	<ol>
	</ol>
</div>
		
<div class="cabecalho3">
	<fmt:message key="mensagem.informacao.consultarSolicitacaoLote" />
	<div class="caminho3" style="*margin-left:140px;">
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; 
		<a href="#" class="linktres"><fmt:message key="label.servicos" /></a> &gt;
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC51/dv01" class="linkquatro"><fmt:message key="mensagem.informacao.consultarSolicitacaoLote" /></a>
	</div>
</div>

<form id="formPesquisa" action="<c:url value="/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC51/dv02"/>" method="POST">
	<div class="busca_branca">
		<span class="text2"><fmt:message key="label.periodo" />:</span>  
		<label>
			<span class="text3"><fmt:message key="label.dataInicial" />:</span>
			<input type="text" name="dataInicial" readonly="readonly" id="dataInicial" class="dateBR" maxlength="10" value="${param.dataInicial}" />
		</label>

		<label>
			<span class="text3"><fmt:message key="label.dataFinal" />:</span>
			<input type="text" name="dataFinal" id="dataFinal" readonly="readonly" class="dateBR" maxlength="10" value="${param.dataFinal }" />
		</label>
	</div>

	<div class="busca_cinza">
		<span class="text2"><fmt:message key="label.tipoDeContrato" />:</span>
		<select id="tiposContrato" name="tiposContrato" class="required" >
			<c:if test="${fn:length(listaSeguradora) > 1}">
				<option value=""><fmt:message key="label.selecione" /></option>
			</c:if>
			<c:forEach  var="seguradora" items="${listaSeguradora}">
				<c:if test="${not empty seguradora.identifier and not empty seguradora.value}">
					<option value="${seguradora.identifier}">${seguradora.value}</option>
				</c:if>
			</c:forEach>
		</select>
	</div>
	
	<div class="busca_branca">
		<span class="text2"><fmt:message key="label.nLote" />: </span>
		<label>
			<input type="text" name="nrLote" id="nrLote" class="text number" maxlength="15" value="${param.nrLote }"/>
    	</label>
	</div>

	<div class="busca_cinza">
		<input type="submit" class="button" value="<fmt:message key="label.buscar" />" />
		<input id="Limpar" class="button4" type="button" value="<fmt:message key="label.limpar" />" name="limpar" onclick="limparCampos('#formPesquisa');">
   	</div>
</form>
