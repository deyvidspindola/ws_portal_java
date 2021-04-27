<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/VerificarPermissao" context="/SascarPortalWeb"  />
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
	
	function desmarcar(input) {
		var valor = $.trim($(input).val());

		if (valor && valor.length > 0) {
			$("#selecionarTodos").removeAttr("checked");
		}
	}
	
	$(document).ready(function(){
		
		
		$("#selecionarTodos").click(function(){
			if ($(this).is(':checked')){
				$(":text").val('');
			}
		});

		$(":text").each(function(){
			desmarcar(this);
		}).keypress(function(){
			desmarcar(this);
		}).keyup(function(){
			desmarcar(this);
		}).blur(function(){
			desmarcar(this);
		});
		
		$("#placa").setMask({mask:'aaa9999'});
		
		
	});
	
</script>


<jsp:include page="/WEB-INF/views/Corporativo/UC30/dv01.jsp">
	<jsp:param name="ativo" value="dv02" />
</jsp:include>


<table width="1026" cellspacing="0" class="tbatualizacao" >
	<tr class="tbatualizacao">
		<th class="barraazulzinha"><fmt:message key="label.pesquisaDeVeiculos" /></th>
	</tr>
</table>


<div class="busca_cinza2">
	<form id="formUC30DV02" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC30/dv03" name ="formPesquisa" id="formPesquisa" method="post">
		<label>
			<span class="text3"><fmt:message key="label.pelaPlaca" />:</span>
			<input type="text" name="numeroPlaca" class="text" id="numeroPlaca" value="${param.placa}" maxlength="10"/>
		</label>
		<label>
			<input name="selecionarTodos" type="checkbox" class="check" id="selecionarTodos"/>
			<span class="text3"><fmt:message key="label.buscarTodos" /></span>
		</label>
		<input type="submit" class="button" value="<fmt:message key="label.buscar" />" />
	    <input type="hidden" name="valida_contrato" value="false" id="valida_contrato" />
	</form>
</div>

<br clear="all"/>
	
<div class="clear:both"></div>