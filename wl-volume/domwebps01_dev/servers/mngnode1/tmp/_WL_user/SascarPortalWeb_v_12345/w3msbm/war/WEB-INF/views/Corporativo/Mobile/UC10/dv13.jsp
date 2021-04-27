<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/AtivarEquipamentoVinculo/listarMotivoRetirada?acao=12" context="/SascarPortalWeb"  />
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

	function submterEquipamento(form) {
		var data = $(form).serialize();
		$.ajax({
			url: "/SascarPortalWeb/AtivarEquipamentoVinculo/submeterEquipamento?acao=5",
			data: data || {},
			dataType:"json",
			success: function(json){
				if (json.success) {
					$("#formAtualizar").submit();
				} else {
					$.showMessage(json.mensagem);
				}
			}
		});
	}
	
	$(document).ready(function(){
		var container = $('div.container-error');
		$("#formPesquisa").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler : function(form) {
				submterEquipamento(form);
			}
		});
	});
</script>

<div class="container-error"> 
	<ol>
		<li><label for="codigoMotivo" class="error"><fmt:message key="uc10.dv13.selecioneMotivoRetirada" /></label></li>
	</ol>
</div>

<h2><fmt:message key="uc10.dv06.vinculacaoEquipamento" /></h2>

<form action=""	method="post" id="formPesquisa">
	<input type="hidden" name="numeroCPF" value="${param.numeroCPF }" />
	<input type="hidden" name="numeroOS" value="${param.numeroOS }" />
	<input type="hidden" name="numeroSerial" value="${param.numeroSerial }" />
	<input type="hidden" name=tipoSubmeter value="R" />

	<fieldset>
			
		<legend><strong><fmt:message key="mensagem.confirmacao.retiradaEquipamento" />?</strong></legend>
			
			<p class="input" style="text-align: center;">
				
				<label for="codigoMotivo">
					<span><fmt:message key="label.selecioneMotivo" /></span><br />
					<select name="codigoMotivo" id="codigoMotivo" class="required">
						<option value=""><fmt:message key="label.selecione" /></option>
						
						<c:forEach var="motivo" items="${motivosRetirada}">
							<option value="${motivo.identifier}">${motivo.value}</option>
						</c:forEach>
					</select>
				</label>
				
			</p>
			
			<p class="input" style="padding:10px; margin-top:10px; text-align: center;">
				<input type="submit" class="aButton ui-state-default ui-corner-all" value="<fmt:message key="label.sim" />" />
				<input type="button" onclick="$('#formAtualizar').submit();" class="aButton ui-state-default ui-corner-all" value="<fmt:message key="label.nao" />" />
			</p>
			
	</fieldset>
</form>

<form action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv05" method="post" id="formAtualizar">
	<input type="hidden" name="numeroCPF" value="${param.numeroCPF }" />
	<input type="hidden" name="numeroOS" value="${param.numeroOS }" />
</form>

<jsp:include page="/WEB-INF/views/Corporativo/Mobile/icones.jsp">
	<jsp:param name="voltar" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv05&numeroOS=${param.numeroOS }&numeroCPF=${param.numeroCPF}"/>
</jsp:include>