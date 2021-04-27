<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<script type="text/javascript">
	$(document).ready(function(){
		$("#selecionarTodosContratos").click(function(){
			if ($(this).is(':checked')){
				$("#numeroPlaca").val('');
				$("#numeroChassi").val('');
			}
		});

		$("#numeroPlaca, #numeroChassi").keypress(function(){
			$("#selecionarTodosContratos").removeAttr("checked");
		});
	});
</script>

<div class="cabecalho3"><span class="tooltip" title="<fmt:message key="uc14.dv01.tooltip.001" />"><fmt:message key="label.declaracaoVeiculosMonitorados" /></span>
	<div class="caminho3">
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> 
		<a href="#" class="linktres">&gt; <fmt:message key="label.informacoes" /> &gt;</a>
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC14/dv01" class="linkquatro"><fmt:message key="label.declaracaoVeiculosMonitorados" /></a>
	</div>
	
</div>

<div class="busca_branca">
	<span class="text1"><fmt:message key="label.escolhaTipoBusca" /></span> 
	<span class="texthelp2">
		<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" />
		<fmt:message key="label.buscaAvancada" />
	</span>
</div>
	
<form action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC14/dv02" method="post">	
	<div class="busca_cinza">
		<label> 
	    	<span class="text2"> <fmt:message key="label.pelaPlaca" />: </span>
	    	<span class="text3"><fmt:message key="label.nAbrev" />:</span>
	      	<input type="text" name="numeroPlaca" id="numeroPlaca" value="${param.numeroPlaca}" maxlength="7"/>
	    </label>
	</div>
	<div class="busca_branca">
	    <label>
		    <span class="text2"> <fmt:message key="label.peloChassi" />: </span>
	    	<span class="text3"><fmt:message key="label.nAbrev" />:</span>
	      	<input type="text" name="numeroChassi" id="numeroChassi" value="${param.numeroChassi }" maxlength="17"/>
	    </label>
	</div>
	<div class="busca_cinza">
		<label>
	    	<input 
	    		type="checkbox" 
	    		class="check" 
	    		name="selecionarTodosContratos" 
	    		id="selecionarTodosContratos" 
	    		<c:if test="${empty param.numeroPlaca and empty param.numeroChassi }">checked="checked"</c:if> />
	    </label>
	    <span class="text2">
	    	<label for="selecionarTodosContratos"><fmt:message key="label.buscarTodos" /></label> 
	    </span>
	</div>
	<div class="busca_branca">
    	<input name="button5" type="submit" class="button" id="button6" value="<fmt:message key="label.buscar" />" />
    	<input name="button5" type="reset" class="button4" id="button5" value="<fmt:message key="label.limpar" />" />
    </div>

</form>
