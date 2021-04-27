<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>


	<c:catch var="helper" >
		<c:import url="/VisualizarExtratoServicosExecutadosServlet/listarInstaladoresRepresentante?acao=1" context="/SascarPortalWeb"  />
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

/////// Obs.: O WS esta retornando status OK quando nao encontra nenhum item. 
//////  A chamada esta agora sendo realizada via Ajax, falta apenas alterar o retorno do WS. 
function submeterExtratoSintetico(form) { 
	
	var flag = 0;
    var data = $(form).serialize();
    $(':disabled').each( function() {
    data += '&' + this.name + '=' + $(this).val();
    });  
  
    
    if($("#dataInicial").val() == ""){
		   $("#erro").html('<b><font color=#C00000>  <fmt:message key="mensagem.campoObrigatorio.dataInicial" /></font></b><br>');		  
	     flag =  1;
	}     
	if($("#dataFinal").val() == ""){
			   $("#erro1").html('<b><font color=#C00000>  <fmt:message key="mensagem.campoObrigatorio.dataFinal" /></font></b><br>');		  
	     flag =  1;
    }
    if($("#tipo-pesquisa").val() == ""){
			   $("#erro1").html('<b><font color=#C00000>  <fmt:message key="mensagem.campoObrigatorio.buscarPor" /></font></b><br>');		  
	     flag =  1;
    } 
    
   if(flag==0){ 
   $.ajax({
		    "url": "/SascarPortalWeb/VisualizarExtratoServicosExecutadosServlet/recuperarExtratoSintetico?acao=2",
		    "data": data || {},
		    "dataType":"json",
		    "success": function(json){
				if (json.success) {	
					
					var dataInicial      =    $("#dataInicial").val();
					var dataFinal        =    $("#dataFinal").val();
					var numOS            =    $("#numeroOS").val();
					var codInstal        =    $("#codigoInstalador").val();
					var codigoStatus     =    $("#codigoStatus").val();
					window.location.href =    "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC19/dv02&valorTotalOrdemServico="+json.valorTotalOrdemServico+"&valorTotalPendencias="+json.valorTotalPendencias+"&valorTotalTestes="+json.valorTotalTestes+"&valorTotalOutrosCreditos="+json.valorTotalOutrosCreditos+"&valorTotalDescontos="+json.valorTotalDescontos+"&valorTotalLiquido="+json.valorTotalLiquido+"&valorTotalNotaFiscal="+json.valorTotalNotaFiscal+"&dataInicial="+dataInicial+"&dataFinal="+dataFinal+"&numeroOS="+numOS+"&codigoInstalador="+codInstal+"&codigoStatus="+codigoStatus+"&valorCustoEficiencia="+json.valorCustoEficiencia+"&tipoPesquisa="+$("#tipo-pesquisa").val();						  
				} else {
				   $.showMessage(json.mensagem);
				}						
			}			   
	     });
   }
}

    function clean(){
	  $("#erro").html("");
	  $("#erro1").html("");
    }

	$(document).ready(function(){	
			
		var container = $('div.container2');
		$("#formPesquisa").validate({
			
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
				required: false,
				dateBR: true
				},
				dataFinal: {
					required: "",
					dateBR: ""
					}
				},
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler : function(form) {
			    submeterExtratoSintetico(form);
			    return false;
			}
		   
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

		});
</script>

	<jsp:useBean id="dataAtual" class="java.util.Date" scope="request" />
	<fmt:formatDate value="${dataAtual}" pattern="dd/MM/yyyy" var="dataFinal"/>

	<div id="erro"></div>		
	<div id="erro1"></div>
	
	<form id="formPesquisa" action="#" method="post" class="filtro">
				
		<div class="container2">			
				<label for="dataInicial" id="dataInicialL" class="error"><fmt:message key="label.dataInicialInvalida" /><br></label>
				<label for="dataFinal" class="error"><fmt:message key="mensagem.campo.dataFinalValidaMaiorOuIgualInicial" /><br></label>
    	</div>		
		<div class="cabecalho2"><fmt:message key="label.extratoServicosExecutados" />
			<div class="caminho">
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" class="linktres"><fmt:message key="label.home" /></a> &gt;  
				<a href="#" class="linktres"><fmt:message key="label.pagamentos" /></a> &gt;   
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC19/dv01" class="linkquatro"><fmt:message key="label.extratoServicosExecutados" /></a>
			</div>
		</div>				 
		<div class="busca_branca"><span class="text1"><fmt:message key="label.escolhaTipoBusca" /></span> 
			<span class="texthelp2">
				<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" alt="" width="16" height="16"  hspace="5" align="absmiddle"/><fmt:message key="label.buscaAvancada" />
			</span> 
		</div>		
		<div class="busca_cinza">
				<span class="text2"><fmt:message key="label.servicosExecutadosPeriodoDe" /><span class="asterisco">*</span>: 
				</span>  
			<label>
				<input tabindex="1" type="text" maxlength="10" name="dataInicial" readonly="readonly" id="dataInicial" value="${param.dataInicial}"  style="*width:50px;width:110px;" onBlur="clean()"/>
			</label>
			<label>a
				<input tabindex="2" type="text" maxlength="10" name="dataFinal" readonly="readonly" id="dataFinal" dateHigher="#dataInicial"   style="*width:50px;width:110px;" value="${dataFinal}" />
			</label>
			<!-- STI 85173 -->
			<span class="text2"><fmt:message key="label.buscarPor" /><span class="asterisco">*</span>: 
			</span>
			<span>
				<select name="tipo-pesquisa" id="tipo-pesquisa" >
					<option value=""><fmt:message key="label.selecione" /></option>
					<option value="C" selected="selected" ><fmt:message key="label.dataCadastro" /></option>
					<option value="P"><fmt:message key="label.dataDePagamento" /></option>
				</select>
			</span> 
							
		</div>		
		<div class="busca_branca">
				<span class="text2"><fmt:message key="label.instalador" />:</span>
			<label>
				<select name="codigoInstalador" id="codigoInstalador" tabindex="3">
						<option value=""><fmt:message key="label.selecione" /></option>
						<option value=""><fmt:message key="label.todos" /></option>
					<c:forEach var="instalador" items="${instaladores}">
						<option value="${instalador.codigo}">${instalador.nome}</option>
					</c:forEach>
				</select>
			</label>
		</div>			
		<div class="busca_cinza">
				<span class="text2"><fmt:message key="label.statusServico" />:</span>
			<label>
				<select name="codigoStatus" id="codigoStatus" tabindex="4" >
					<option value=""><fmt:message key="label.selecione" /></option>
					<option value="01"><fmt:message key="label.todos" /></option>
					<option value="02"><fmt:message key="label.pagos" /></option>
					<option value="03"><fmt:message key="label.pendentes" /></option>
				</select>
			</label>
		</div>		
		<div class="busca_branca">
			<span class="text2"><fmt:message key="label.numeroOs" />:</span>
			<label>
				<span class="text3"><fmt:message key="label.nAbrev" />:</span>
				<input tabindex="5" type="text" name="numeroOS" id="numeroOS" class="text" maxlength="10" value="${ordemServico.numero}" style="width: 150px;"/>
			</label>
		</div>			
		<div class="busca_cinza">
			<input type="submit" class="button" value="<fmt:message key="label.buscar" />"  tabindex="6"/>
			<input type="button" class="button4" value="<fmt:message key="label.limpar" />" tabindex="7" onclick="limparCampos('#formPesquisa');"/>
		</div> 
	</form>
