<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<!--[if IE]>
	<style type="text/css">
		.margin-data {
			margin-right: 36px !important;
		}
	</style>
<![endif]-->

<script type="text/javascript">
	
	$(document).ready(function(){

		$("div.breadcrumb").html('<fmt:message key="uc10.dv01.informacaoEquipamento" />');
		
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

		$('#dataInicial, #dataFinal').click(function(){
			$('input[name="tipoDataPesquisa"]').toggleClass('required', $(this).val() ? true : false);
		}).blur(function(){
			$(this).setMask('date');
			
			$('input[name="tipoDataPesquisa"]').toggleClass('required', $(this).val() ? true : false);
		}).focus(function(){
			$(this).unsetMask();
			$(this).setMask({mask:'9', type:'repeat'});
		});

		$('#numeroOS').setMask({mask:'9999999999'});
		
		habilitarRodapeLinkVersaoMobile();

	});
</script>

<jsp:useBean id="dataAtual" class="java.util.Date" scope="request" />
<fmt:formatDate value="${dataAtual}" pattern="dd/MM/yyyy" var="dataFinal"/>

<div class="container2">
	<ol>
		<li><label for="dataInicial" class="error"><fmt:message key="mensagem.campo.dataInicialValida" /></label></li>
		<li><label for="dataFinal" class="error"><fmt:message key="mensagem.campo.dataFinalValidaMaiorOuIgualInicial" /></label></li>
		<li><label for="tipoDataPesquisa" class="error"><fmt:message key="mensagem.campo.DataCadastroAgendamentoSelecionado" /></label></li>
	</ol>
</div>
<div class="cabecalho"><fmt:message key="label.ativacaoEquipamento" />
	<div class="caminho" style="*margin-left:220px;">
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; 
		<a href="#" class="linktres"><fmt:message key="label.servicos" /></a> &gt; 
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv01"  class="linkquatro"><fmt:message key="label.ativacaoEquipamento" /></a>
	</div>
</div>

<form id="formPesquisa"
		action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv02"
		method="post"
		class="filtro">
		
	<div class="busca_branca" style="padding-left:50px; width: 900px;">
		<span class="text1"><fmt:message key="label.escolhaTipoBusca" /></span> 
		<span class="texthelp2">
			<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" /><fmt:message key="label.buscaAvancada" />
		</span> 
	</div>
		
	<div class="busca_cinza" style="padding-left:50px; width: 900px;" id="teste">
		<span class="text2"><fmt:message key="label.peloPeriodo" />:</span>
		<label>
     			<span class="text3"><fmt:message key="label.dataInicial" />:</span>
     			<input tabindex="1" type="text" maxlength="10" name="dataInicial" id="dataInicial" value="${param.dataInicial}" class="dateBR text data" readonly="readonly" />
     	</label>
     	<label>
			<c:if test="${not empty param.dataFinal}">
				<c:set var="dataFinal" value="${param.dataFinal }" />
			</c:if>
			<span class="text3"><fmt:message key="label.dataFinal" />:</span>
			<input tabindex="2" type="text" maxlength="10" name="dataFinal" id="dataFinal" dateHigher="#dataInicial"  class="dateBR text data"  value="${dataFinal}" readonly="readonly" />
		</label>
			<input tabindex="3" type="radio" name="tipoDataPesquisa" value="C" <c:if test="${param.tipoDataPesquisa eq 'C' }">checked="checked"</c:if> id="dataTipoCadastro" style="margin-right: 5px;" /><span class="text3"><fmt:message key="label.dataCadastro" />
</span>
     		<input tabindex="4" type="radio" name="tipoDataPesquisa" value="I" <c:if test="${param.tipoDataPesquisa eq 'I' }">checked="checked"</c:if> id="dataTipoAgendamento" style="margin-right: 5px;" /><span class="text3"><fmt:message key="label.dataAgendamento" /></span>
	</div>
	
	<div class="busca_branca" style="padding-left:50px;">
	  <span class="text2"><fmt:message key="label.buscaPelaOrdemServico" />:</span>
	  	<label>
	    	<span class="text3"><fmt:message key="label.nAbrev" />:</span>
	    	<input tabindex="5" type="text" name="numeroOS" id="numeroOS"  value="${param.numeroOS}" maxlength="10"  />
	    </label>
	</div>	
	
	<div class="busca_cinza" style="padding-left:50px; width: 900px;">
		<span class="text2"><fmt:message key="label.pelaPlaca" />:</span>  
	    <label>
	    	<span class="text3"><fmt:message key="label.nAbrev" />:</span>
	    	<input tabindex="6" type="text" name="numeroPlaca" maxlength="10" value="${param.numeroPlaca}"/>
	    </label>
	</div>	
	
	<div class="busca_branca" style="padding-left:50px;">
	 	<span class="text2"><fmt:message key="label.peloChassi" />:</span>
	    <label>
	    	<span class="text3"><fmt:message key="label.nAbrev" />:</span>
	    	<input tabindex="8" type="text" name="numeroChassi" id="numeroChassi" maxlength="20" value="${param.numeroChassi}"/>
	    </label>
	</div>
	
	<div class="busca_cinza" style="padding-left:50px; width: 900px;">
	 	<span class="text2"><fmt:message key="label.buscaNomeCliente" />:</span>  
	    <label>
	    	<span class="text3"><fmt:message key="label.nome" />:</span>
	    	<input tabindex="9" type="text" class="text" name="nomeCliente" value="${param.nomeCliente}" maxlength="40" />
	    </label>
	</div>
	
	<div class="busca_branca" style="padding-left:50px;">
		<input type="submit" class="button" value="<fmt:message key="label.buscar" />" />
		<input type="button" class="button4" value="<fmt:message key="label.limpar" />" onclick="limparCampos('#formPesquisa');" />
	</div>
</form>
