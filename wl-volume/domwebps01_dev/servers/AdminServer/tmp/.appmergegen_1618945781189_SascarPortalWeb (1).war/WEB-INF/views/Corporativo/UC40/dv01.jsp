<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

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

    function clean(){
	  $("#erro").html('');
    }

    $(function(){$("#formListaPedido").bind("submit", validar);}); 

    function validar(e){	 
	  var flag = 0;
	  
	  $("#erro").html("");
	  
	  if($("#numeroPedido").val()  == "" && 
	     $("#dataInicial").val()   == "" &&
	     $("#dataFinal").val()     == "" &&
	     $("#statusPedido").val()  == "" ){
	    $("#erro").html('<font color=#C00000>1.<b> <fmt:message key="mensagem.informacao.peloMenosUmCampo" /></b></font>');	  	  
	    flag=1;
	  }else{
		flag=0;
	  }	   
	  
	  if(flag==0){
	  	return true;
	  }else{
	  	return false;
	  }	    
	}
    
	$(document).ready(function(){	
		
		$('#numeroPedido').setMask({mask:'99999999'});
		
		$("#erro").html("");
		var container = $('div.container2');
	
		$("#formListaPedido").validate({
			rules: {
				"dataInicial": {
				required: false,
				dateBR: true
				},
			     "dataFinal": {
				required: false,
				dateBR: true
				}
				},
				messages: {
				dataInicial: {
				required: "",
				dateBR: ""
				},
				dataFinal: {
					required: "",
					dateBR: ""
					}
				},
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
	});
</script>

    <div class="container2"> 
		<ol>
			<li><label for="dataInicial" class="error"><fmt:message key="label.dataInicialInvalida" /></label></li>
			<li><label for="dataFinal" class="error"><fmt:message key="label.dataFinalInvalida" /></label></li>
		</ol>
	</div>
	

    <div id="erro"></div>


	<body>	
	
	 <div class="cabecalho2"><fmt:message key="label.consultarPedidoEstoque" />
		<div class="caminho">
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" class="linktres"><fmt:message key="label.home" /></a> &gt;  
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC40/dv01" class="linktres"><fmt:message key="label.servicos" /></a> &gt;   
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC40/dv01" class="linkquatro"><fmt:message key="label.consultarPedidoEstoque" /></a>
		</div>
	</div>		
		
		<!-- 
			<div class="cabecalho2">
			<div class="caminho" style="">
				<a class="linktres" title="Home" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}">Home</a>
				&gt;
				<a class="linktres" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC40/dv01">Serviços</a>
				&gt;
				<a class="linkquatro" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC40/dv01">
				<strong>Consultar Pedido de Estoque</strong>
				</a>
			</div>
			
			<strong>Consultar Pedido de Estoque</strong
			
		</div>
		-->
		
    <form id="formListaPedido" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC40/dv02" method="post">		
		<div class="busca_branca" >
			<span class="text1"><fmt:message key="label.escolhaTipoBusca" /></span>
			<span class="texthelp2">
			<img hspace="5" height="16" align="absmiddle" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png">
			<fmt:message key="label.buscaAvancada" />
			</span>
		</div>
		

		
		<div class="busca_cinza">
			<span class="text2"><fmt:message key="label.peloNumPedido" />: </span>
			<span class="text3"><fmt:message key="label.nAbrev" />:</span>
			<label>
			
			
			  <input id="numeroPedido" onkeyDown="clean();" type="text" value="${param.numeroPedido}" maxlength="8" name="numeroPedido" >
			
			</label>
		</div>
		
		
		<div class="busca_branca">
			<span class="text2"><fmt:message key="label.peloPeriodo" />:</span>
			<label>
				<span class="text3"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<fmt:message key="label.dataInicial" />:</span>
				<input id="dataInicial" type="text" onkeyDown="clean();" maxlength="10" value="${param.dataInicial}" name="dataInicial" readonly="readonly" />
			</label>
			<label>
				<span class="text3"><fmt:message key="label.dataFinal" />:</span>
				<input id="dataFinal" type="text" onkeyDown="clean();" maxlength="10" datehigher="#dataFinal" value="${param.dataFinal}" name="dataFinal" readonly="readonly" />
			</label>
			<span class="texthelp2" style="*margin-top:-22px;">
				<img hspace="5" height="16" align="absmiddle" width="16" alt="" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png">
				<fmt:message key="label.buscarTodosRegistroDataMesAno" />
			</span>
		</div>
		
		
		<div class="busca_cinza">		
			<span class="text2"><fmt:message key="label.peloStatusPedido" />:</span>
			<label>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
				<select id="statusPedido" name="statusPedido" onChange="clean();">
				    <option selected="selected" value=""><fmt:message key="label.selecione" /></option>
					<option <c:if test="${param.statusPedido eq 'C' }">selected="selected"</c:if> value="C"><fmt:message key="label.pedidoStatus.concluido" /></option>
					<option <c:if test="${param.statusPedido eq 'P' }">selected="selected"</c:if> value="P"><fmt:message key="label.pedidoStatus.pendente" /></option>
					<option <c:if test="${param.statusPedido eq 'A' }">selected="selected"</c:if>value="A"><fmt:message key="label.pedidoStatus.aguardandoAutorizacao" /></option>
					<option <c:if test="${param.statusPedido eq 'AA' }">selected="selected"</c:if> value="AA"><fmt:message key="label.pedidoStatus.aguardandoAutorizacaoAutomatica" /></option>
					<option <c:if test="${param.statusPedido eq 'N' }">selected="selected"</c:if> value="N"><fmt:message key="label.pedidoStatus.naoAutorizado" /></option>
					<option <c:if test="${param.statusPedido eq 'E' }">selected="selected"</c:if> value="E"><fmt:message key="label.pedidoStatus.cancelado" /></option>
				</select>
			</label>
		</div>		
		
		<div class="busca_branca">
			<input id="button" class="button" type="submit"  value="<fmt:message key="label.buscar" />" name="button" />
			<input id="Limpar" class="button4" type="button" value="<fmt:message key="label.limpar" />" name="button2" onclick="limparCampos('#formListaPedido');" />
		</div>
  </form>	
  	
	</body>
