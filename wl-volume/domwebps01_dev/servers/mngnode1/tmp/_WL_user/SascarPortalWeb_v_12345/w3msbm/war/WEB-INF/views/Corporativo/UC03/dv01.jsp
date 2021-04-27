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
	});
</script>


<div class="cabecalho2">
	<fmt:message key="label.solicitarRetiradaReinstalacao" />
	<div class="caminho">
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> 
		<a href="#" class="linktres">&gt; <fmt:message key="label.servicos" /> &gt;
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC03/dv01" class="linkquatro"><fmt:message key="label.solicitarRetiradaReinstalacao" /></a>
	</div>
</div>


	<form action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC03/dv02" method="post" id="formPesquisa">
		
		<div class="busca_branca">
			<span class="text1"><fmt:message key="label.escolhaTipoBusca" /></span> 
			<span class="texthelp2">
				<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" />
				<fmt:message key="label.buscaAvancada" />
			</span>
		</div>
		
		
		<div class="busca_cinza">
			<label>
				<span class="text2"> <fmt:message key="label.pelaPlaca" />: </span>
				<span class="text3"><fmt:message key="label.nAbrev" />:</span>
		      	<input type="text" name="numeroPlaca" value="${param.numeroPlaca }" maxlength="7"/>
		    </label>
		</div>
		
		
		<div class="busca_branca">
		    <label>
		    	<span class="text2"> <fmt:message key="label.peloChassi" />: </span>
				<span class="text3"><fmt:message key="label.nAbrev" />:</span>
		      	<input type="text" name="numeroChassi" value="${param.numeroChassi }" class="text" maxlength="17"/>
		    </label>
		</div>
		
		
		<div class="busca_cinza">
		    <label>
				<input name="selecionarTodos" type="checkbox" class="check" id="selecionarTodos" checked="checked"/>
				<span class="text2"><fmt:message key="label.buscarTodos" /> </span>
			</label>
		</div>
		
		<input type="hidden" name="valida_contrato" value="true" id="valida_contrato" />
		<div class="busca_branca">
			<input type="submit" class="button" value="<fmt:message key="label.buscar" />" />
			<input type="button" class="button4" value="<fmt:message key="label.limpar" />" onclick="limparCampos('#formPesquisa');"/>
			<input type="button" class="button" style="float:right;*margin-top:-30px;" value="<fmt:message key="label.contratosPendentesReinstalacao" />" onclick='window.location="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC57/dv01&fromUC03=sim"'/>
		</div>
	</form>

