<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/ListarAgendaInstalador/listarInstaladoresRepresentante?acao=1" context="/SascarPortalWeb"  />
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
	
	//** Utilizado para que, ao efetuar a pesquisa, o valor da combo seja recuperado;
	var nomeInstalador = "${param.nome_instalador}";
	if(nomeInstalador != ""){
		$("#codigoInstalador").val("${param.codigoInstalador}");
	}
	
	//**Validações: validando pelo formato da data e verificando se o campo está vazio
	var container = $('div.container2');
	$("#formPesquisa").validate({
		errorContainer: container,
		errorLabelContainer: $("ol", container),
		wrapper: 'li',
		rules: {
			dataInicial: {
				dateBR:  true,
				required: true
			}
		},
		messages: {
			dataInicial: {
				dateBR:  '<fmt:message key="mensagem.campo.dataInicialValida" />;',
				required: '<fmt:message key="mensagem.campoObrigatorio.agendaDoDia" />'
			}
		}
	});

		$("#dataInicial").datepicker({
			dateFormat: 'dd/mm/yy',
			changeMonth: true,
			changeYear: true
		});

		$('#dataInicial').blur(function(){
			$(this).setMask('date');
		}).focus(function(){
			$(this).unsetMask();
		});
		
	
	
	});
	
	
	function limpa_campos(){
		$("#codigoInstalador").find('option:first').attr('selected', 'selected');
		$("#dataInicial").val("");
	}
	
	function preencheNomeInstalador(){
	    var nomeInstalador =  	$("#codigoInstalador option:selected").text();	    
		$("#nome_instalador").val(nomeInstalador);
	}
</script>

<div class="container2"> 
		<ol>
		</ol>
	</div>
		
<div class="cabecalho2">
	<fmt:message key="label.agendaInstalador" />
	<div class="caminho3" style="*margin-left:140px;">
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; 
		<a href="#" class="linktres"><fmt:message key="label.servicos" /></a> &gt;
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC52/dv01" class="linkquatro"><fmt:message key="label.agendaInstalador" /></a>
	</div>
</div>
<div class="busca_branca"><span class="text1"><fmt:message key="label.informeDadosPesquisa" />:</span></div>	
<form id="formPesquisa" action="<c:url value="/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC52/dv02"/>" method="POST">
	
	<div class="busca_cinza">
	  <span class="text2"><fmt:message key="label.instalador" />: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
	    <label>
		  <select name="codigoInstalador" id="codigoInstalador" class="required" onchange="preencheNomeInstalador();">						
		    <option value="0"><fmt:message key="label.todos" /></option>					
		  	  <c:forEach var="instalador" items="${instaladores}">					
			    <option value="${instalador.codigo}">${instalador.nome}</option>				   	
			  </c:forEach>
		  </select>
	    </label>
	 </div>
	
	<div class="busca_branca">	
	  <label>
	    <span class="text2"><fmt:message key="label.agendaDoDia" />:</span>
	  	  <input type="text" name="dataInicial" id="dataInicial" readonly="readonly"  class="required" maxlength="10" value="${param.dataInicial}" />
      </label>
	</div>

	<div class="busca_cinza">
 	  <input type="submit" class="button" value="<fmt:message key="label.buscar" />"  />
	  <input type="button" class="button4" value="<fmt:message key="label.limpar" />"  onclick="limpa_campos()" />
   	</div>
   	
   	<input type="hidden" name="nome_instalador" id="nome_instalador" value="${param.nome_instalador}">
</form>

