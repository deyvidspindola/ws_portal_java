<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/EfetuarTrocaVeiculoRetirada/pesquisarContratos?acao=1" context="/SascarPortalWeb"  />
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
	$(document).ready(function() {
		var container = $('div.container2');
		$("#formLista").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler : function(form) {
			  abrirPopupConfirmar(form);
			 // return false;
			}
		});
		
		
		$("#prosseguir").attr('disabled','disabled');
		
		$("#concordar").click(function() {
			if($("#prosseguir").is(':disabled')){
			  $("#prosseguir").attr('disabled','');
			}else{
		  	  $("#prosseguir").attr('disabled','disabled');	
			}		
		});	
		
	});
	
	function abrirPopupConfirmar(form){
		$("input[type='checkbox']").removeAttr('checked'); 
		 $("#dialog_mensagem").jOverlay({'onSuccess' : function(){
			
		 }});
	}
	
	
	function submeterFormLista(){
		var contratoNumero = $("#numeroCont").val();
		window.location="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC03/dv03&numeroContrato="+ contratoNumero;
	}
	
	function preencheContrato(valor){
		$("#numeroCont").val(valor);
	}
	
</script>

<jsp:include page="/WEB-INF/views/Corporativo/UC03/dv01.jsp"/>

<c:if test="${not empty contratos}">

<h1><fmt:message key="label.resultadoDaBusca" /></h1>

<div class="container2">
	<ol>
		<li><label for="numeroCont" class="error"><fmt:message key="mensagem.selecione.paraContinuar" /></label></li>
	</ol>
</div>


	<form action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC03/dv03" id="formLista" name="formLista" method="post">
		<input type="hidden" name="numeroPlaca" value="${param.numeroPlaca }" />
		<input type="hidden" name="numeroChassi" value="${param.numeroChassi }" />
		<input type="hidden" name="pagina" value="${param.pagina }" />
		
		<table width="750" cellpadding="1" id="alter" cellspacing="0">
			<tr>
			    <th width="5%" class="texttable_azul" scope="col">&nbsp;</th>
			    <th width="20%" class="texttable_cinza" scope="col"><fmt:message key="label.placa" /></th>
			    <th width="20%" class="texttable_cinza" scope="col"><fmt:message key="label.chassi" /></th>
			    <th width="20%" class="texttable_azul" scope="col"><fmt:message key="label.marcaModelo" /></th>
			    <th width="15%" class="texttable_azul" scope="col"><fmt:message key="label.ano" /></th>
			    <th width="25%" class="texttable_azul" scope="col"><fmt:message key="label.cor" /></th>
			</tr>
			<c:forEach var="contrato" items="${contratos}" varStatus="status">
				<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if>>
				    <td class="linkazul"><input type="radio" id="numeroContrato" name="numeroContrato" onclick="preencheContrato(this.value);" class="required" value="${contrato.numeroContrato }" /></td>
					<td>${contrato.veiculo.placa }</td>
					<td>${contrato.veiculo.chassi }</td>
					<td>${contrato.veiculo.descricaoMarca } / ${contrato.veiculo.descricaoModelo }</td>
					<td>${contrato.veiculo.anoFabricacao }</td>
					<td>${contrato.veiculo.cor }</td>
				</tr>
			</c:forEach>
		</table>

<input type="hidden"  id="numeroCont">

		<jsp:include page="/WEB-INF/views/paginacao.jsp">
			<jsp:param name="pagina" value="${numeroPagina}"/>
			<jsp:param name="totalPaginas" value="${totalPaginas}"/>
			<jsp:param name="formName" value="formLista"/>
			<jsp:param name="url" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC03/dv02&valida_contrato=true"/>
		</jsp:include>
		
		
		<div class="botoesatualizacao">
			<input type="submit" class="button" value="<fmt:message key="label.continuar" />" />
		</div>	
	</form>

</c:if>

<div class="rbroundbox" id="dialog_mensagem" style="width: 65%; *width: 60%; display:none; margin-top:10px;">
	<div class="rbtop"><div></div></div>
	
	<div class="rbcontent" >
		<b><fmt:message key="label.termosCondicoesTrocaVeiculo" />:</b>
		<hr size=3 style="background-color:white;">		
		<p>
		  <fmt:message key="uc03.dv02.text.01" /> <br>
			 <br>
			<fmt:message key="uc03.dv02.text.02" /><br>			<br>
			   <b><fmt:message key="label.duvidasEntrarContatoCentral" />
                <br>
                <fmt:message key="label.telGrandesCentros" /> <br>
                <fmt:message key="label.telDemaisLocalidades" /><br>		 
			    </b>
			 
				<p>
				  <input type="checkBox" id="concordar"/> <fmt:message key="label.concordoTermoCondicoes" />
			    </p>
		
        <div id="buttonPopUp">
			<input type="button" 
						class="button"
						id="prosseguir" 
						value="<fmt:message key="label.continuar" />"
						onclick="submeterFormLista();">
			<input type="button" 
						class="button" 
						value="<fmt:message key="label.cancelar" />"
						onclick="window.location='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC03/dv01'">


	  	</div>
	</div>
	
	<div class="rbbot"><div></div></div>
</div>


