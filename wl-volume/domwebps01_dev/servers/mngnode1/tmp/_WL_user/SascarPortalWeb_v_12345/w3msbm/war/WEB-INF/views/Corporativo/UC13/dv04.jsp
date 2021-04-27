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
					
						$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv09");
						
					}else if(tipoEquipamento === "S"){
					
						$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv09");
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
		
		var container = $('div.container2');
		$("#formTesteEquipamento").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler : function(form) {
				submeterDadosTeste(form, tipoEquipamento);
			}
		});

		$('input[name="confirma"]').click(function(){
			selecionar($(this).val());
		});

		selecionar('${teste.executado}');
	});
</script>

	<div class="cabecalho3">
		<fmt:message key="label.testesAtivacaoEquipamento" />
		<div class="caminho3" style="*margin-left:100px;">
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a>&gt; 
			<a href="#" class="linktres"><fmt:message key="label.informacoes" /></a> &gt; 
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC13/dv01"  class="linkquatro"><fmt:message key="label.testesAtivacaoEquipamento" /></a>
		</div>
	</div>
	
	<div class="container2"> 
		<ol>
			<li><label for="confirma" class="error"><fmt:message key="mensagem.campoObrigatorio.testeExecutadoSucesso" /></label></li>
		</ol>
	</div>

	<table cellspacing="0" class="detalhe" >
		<tr class="barraazulzinha">
			<th class="barraazulzinha"><fmt:message key="label.retornoDoTeste" /></th>
		</tr>
	</table>

	<div class="observacao">${teste.resultado }</div>

	<!-- FORM VOLTAR -->
	<form method="post" id="formVoltar" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv03">
		<input type="hidden" name="numeroCPF"       value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS"        value="${param.numeroOS }" />
		<input type="hidden" name="indiceTeste"     value="${param.indiceTeste }" />
		<input type="hidden" name="reiniciarTestes" value="${param.reiniciarTestes}" />
		<input type="hidden" name="tipoEquipamento" value="${param.tipoEquipamento}" />
		<input type="hidden" name="origem"          value="${param.origem}" />
		<input type="hidden" name="numeroPlaca" 	value="${param.numeroPlaca}" />
		<input type="hidden" name="totalTestes"     value="${param.totalTestes}" />
		<input type="hidden" name="codigoTeste"     value="${param.codigoTeste}" />
		<input type="hidden" name="motivo" value="${param.motivo}" />
		<input type="hidden" name="numeroWebService" value="${param.numeroWebService}" />
		<input type="hidden" name="idTipoTeste" value="${idTipoTeste}" />
	</form>

	<form action="" method="post" class="filtro" id="formTesteEquipamento">
	
		<input type="hidden" name="numeroCPF"       value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS"        value="${param.numeroOS }" />
		<input type="hidden" name="origem"          value="${param.origem }" />
		<input type="hidden" name="reiniciarTestes" value="${param.reiniciarTestes}" />
		<input type="hidden" name="testeExecutado"  id="testeExecutado" value="${teste.executado }" />
		<input type="hidden" name="indiceTeste"     value="${empty param.indiceTeste ? 1 : param.indiceTeste }" />
		<input type="hidden" name="totalTestes"     value="${param.totalTestes}" />
		<input type="hidden" name="codigoTeste"     value="${param.codigoTeste}" />
		<input type="hidden" name="tipoEquipamento" value="${param.tipoEquipamento}" />
		<input type="hidden" name="numeroPlaca" 	value="${param.numeroPlaca}" />
		<input type="hidden" name="numeroWebService" value="${param.numeroWebService}" />
	
		<table width="900" cellspacing="3" class="detalhe2">
			<tr>
				<th width="200px" class="barracinza"><fmt:message key="mensagem.confirmacao.testeExecutado" /></th>
				<td width="350px" class="camposinternos">
			        <label> 
						<input type="radio" name="confirma" value="true" class="required" <c:if test="${not teste.executado }">disabled="disabled"</c:if> />&nbsp;&nbsp;<fmt:message key="label.sim" />
				    </label>
			        <label>
						<input type="radio" name="confirma" value="false" <c:if test="${not teste.executado }">disabled="disabled"</c:if> />&nbsp;&nbsp;<fmt:message key="label.nao" />
				    </label>
		        </td>
			</tr>
	    </table>
	
	
	    <div id="pgstabela">
	        <input type="button" onclick="$('#formVoltar').submit();" value="<fmt:message key="label.voltar" />" class="button4" />
	        <input type="submit" id="btnContinuar" class="button" value="<fmt:message key="label.continuar" />" <c:if test="${not teste.executado }">disabled="disabled"</c:if>/>
	    </div>
	</form>
