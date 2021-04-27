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

	$(document).ready(function(){
	
		var container = $('div.container2');
		
		$("#formUC32DV02").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler : function(form){
				var tipoPessoa = $(":checked", form).val();
				var action = (tipoPessoa == 'N') ?
				  "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC32/dv03"
				: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC32/dv06"; 
				$(form).unbind('submit').attr("action", action).submit();
			}
		});
		
	});
	
</script>

<jsp:include page="/WEB-INF/views/Corporativo/UC32/dv01.jsp">
	<jsp:param name="ativo" value="dv02" />
</jsp:include>

<body>

	<div class="container2">
		<ol>
			<li><label for="tipoContato" class="error"><fmt:message key="mensagem.campo.tipoBusca" /></label></li>
		</ol>
	</div>

	<table class="detalhe" cellspacing="0">
		<tbody>
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.excluirContato" /></th>
			</tr>
		</tbody>
	</table>
	
	
	<div class="busca_branca">
		<span class="text1"><fmt:message key="uc32.dv02.subTitulo.paraExcluirContato" /></span>
	</div>
	
	<form action="" method="post" id="formUC32DV02">
	
		<div class="busca_cinza">
		
			<span class="text2"><fmt:message key="label.tipoBusca" />:</span>
			
			<input tabindex="3" type="radio" name="tipoContato" value="N" id="pessoaAutorizada" class="required"/>
			<span class="text3"><fmt:message key="label.nomeContato" /></span>
			
			<input tabindex="3" type="radio" name="tipoContato" value="P" id="pessoasEmergencia" class="required"/>
			<span class="text3"><fmt:message key="label.placaVeiculo" /></span>
			
			<input class="button" type="submit" value="<fmt:message key="label.continuar" />">
			
		</div>
		
		<p></p>
	</form>

</body>

<br clear="all"/>
	
<div class="clear:both"></div>