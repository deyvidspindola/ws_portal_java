<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/AtivarEquipamentoTestes/recuperarExecucaoTeste?acao=4" context="/SascarPortalWeb"  />
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
	function selecionar(value) {
		if (value == "true") {
			$("#btnContinuar").removeAttr("disabled");
			$("#testeExecutado").val("true");
			$('input[name="confirma"]').get(0).checked = true;
		} else {
			$("#btnContinuar").attr("disabled", true);
			$("#testeExecutado").val("false");
			$('input[name="confirma"]').get(1).checked = true;
		}
	}

	function submeterDadosTeste(form, tipoEquipamento) {
	
		var data = $(form).serialize();
		//configuracoes para tirar os caches - IE
		$.support.cors = true; //  cross-site scripting
        $.ajaxSetup({ cache: false }); 
		
		//Recupera defeitos conforme OS
		$.ajax({
			type: "POST",
			sync: false,
			crossDomain: true,
			url: "/SascarPortalWeb/AtivarEquipamentoTestes/submeterExecucaoTeste?acao=7",
			data: data || {},
			dataType:"json",
			success: function(json){
				if (json.success) {
				
					if(tipoEquipamento === "C"){
					
						$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC13/dv09");
						
					}else if(tipoEquipamento === "S"){
					
						$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC13/dv09");
					}
						
					$(form).unbind('submit').submit();
					
				} else {
					$(form).attr("action", "");
					$.showMessage(json.mensagem);
				}
			}
		});
	}

	$(document).ready(function(){
	
		var tipoEquipamento = "${param.tipoEquipamento}";

		$('#ativar_equipamento').addClass('active');

		selecionar('${teste.executado}');

		$('input[name="confirma"]').click(function(){
			selecionar($(this).val());
		}).jqTransRadioCheck();
		
		var container = $('div.container-error');
		$("#formPesquisa").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler : function(form) {
				submeterDadosTeste(form, tipoEquipamento);
			}
		});
		
		//Cache
		if (document.images) {
			var tick = new Image();
			tick.src = "${pageContext.request.contextPath}/sascar/images/mobile/tick.png";
		}
		
	});
</script>

	<!-- MSG ERRO VALIDACAO -->
	<div class="container-error"> 
		<ol>
			<li><label for="confirma" class="error"><fmt:message key="mensagem.campoObrigatorio.testeExecutadoSucesso" /></label></li>
		</ol>
	</div>
	<!-- CACHE  -->
	<img src="${pageContext.request.contextPath}/sascar/images/mobile/tick.png" alt="" style="display: none;"/>

	<h1><fmt:message key="label.testesAtivacaoEquipamento" /></h1>
	<br/>

	<form action="" method="post" id="formPesquisa">
	
		<input type="hidden" name="numeroCPF" 	    value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS" 	    value="${param.numeroOS }" />
		<input type="hidden" name="origem"          value="${param.origem }" />
		<input type="hidden" name="reiniciarTestes" value="${param.reiniciarTestes}" />
		<input type="hidden" name="testeExecutado"  id="testeExecutado" value="${teste.executado }" />
		<input type="hidden" name="indiceTeste"     value="${param.indiceTeste}" />
		<input type="hidden" name="totalTestes"     value="${param.totalTestes}" />
		<input type="hidden" name="codigoTeste"     value="${param.codigoTeste}" />
		<input type="hidden" name="tipoEquipamento" value="${param.tipoEquipamento}" />
		<input type="hidden" name="numeroPlaca" 	value="${param.numeroPlaca}" />
		<input type="hidden" name="numeroWebService" value="${param.numeroWebService}" />	
	
		<fieldset>
			<legend style="font-size: 120%;"><strong><fmt:message key="label.retornoDoTeste" /></strong></legend>
			
			<p style="font-size: 120%;" class="input">${teste.resultado }</p>
			
			<br />
			
			<h4><fmt:message key="mensagem.confirmacao.testeExecutado" /></h4>
			
			<p class="input">
				<input type="radio" id="radio0" name="confirma" value="true" class="required" <c:if test="${not teste.executado }">disabled="disabled"</c:if> /><label for="radio0"><fmt:message key="label.sim" /></label>
				<input type="radio" id="radio1" name="confirma" value="false" <c:if test="${not teste.executado }">disabled="disabled"</c:if> /><label for="radio1"><fmt:message key="label.nao" /></label>
			</p>
			
			<p class="input" style="padding:10px; margin-top:10px; text-align: center;">
				<input type="submit" id="btnContinuar" class="aButton ui-state-default ui-corner-all" value="<fmt:message key="label.continuar" />" <c:if test="${not teste.executado }">disabled="disabled"</c:if>/>
			</p>
	
		</fieldset>
		
	</form>

	<jsp:include page="/WEB-INF/views/Corporativo/Mobile/icones.jsp">
		<jsp:param name="voltar" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC13/dv03&numeroCPF=${param.numeroCPF}&numeroOS=${param.numeroOS}&indiceTeste=${param.indiceTeste}&reiniciarTestes=${param.reiniciarTestes}&tipoEquipamento=${param.tipoEquipamento}&origem=${param.origem}&numeroPlaca=${param.numeroPlaca}&totalTestes=${param.totalTestes}&codigoTeste=${param.codigoTeste}"/>
	</jsp:include>