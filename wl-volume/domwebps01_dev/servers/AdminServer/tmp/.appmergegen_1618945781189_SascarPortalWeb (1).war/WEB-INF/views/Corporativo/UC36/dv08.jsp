<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/ConsultarPendenciasUsuario/relatorioDirecionamento?acao=4" context="/SascarPortalWeb"  />
	<c:import url="/DirecionarSinalGerenciadoras/listarGerenciadoras?acao=3" context="/SascarPortalWeb"  />
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
	<style type="text/css">
		table {
		    margin: 0px 20px !important;
		}
	</style>

	<script type="text/javascript">
	var limiteDias = 30;
	function limitaPeriodoEntreDatas() {
        var parts = $( "#dataInicial" ).val().split('/');
		var mydate = new Date(parts[2],parts[1]-1,parts[0]);
        mydate.setDate(mydate.getDate() + limiteDias);
        var datalimite = mydate.getDate() + "/" + (mydate.getMonth() + 1) + "/" + mydate.getFullYear();
        $( "#dataFinal" ).datepicker( "option", "maxDate", datalimite);
	
		$("#dataInicial").datepicker({
			dateFormat: 'dd/mm/yy',
			changeMonth: true,
	        changeYear: true,
	        onClose: function( selectedDate ) {
	            $( "#dataFinal" ).datepicker( "option", "minDate", selectedDate );
	            var parts = selectedDate.split('/');
				var mydate = new Date(parts[2],parts[1]-1,parts[0]);
	            mydate.setDate(mydate.getDate() + limiteDias);
	            var datalimite = mydate.getDate() + "/" + (mydate.getMonth() + 1) + "/" + mydate.getFullYear();
	            $( "#dataFinal" ).datepicker( "option", "maxDate", datalimite);
	       	}
		});
				
	}
	
	function atualizarLimitePeriodo() {
		if ($("#numeroPlaca").val().length > 0 || $("#veiculoId").val().length > 0) {
			limiteDias = 90;
		} else {
			limiteDias = 30;
		}
		limitaPeriodoEntreDatas();
	}
	
	$(document).ready(function(){
	
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
			            var parts = selectedDate.split('/');
						var mydate = new Date(parts[2],parts[1]-1,parts[0]);
			            mydate.setDate(mydate.getDate() + limiteDias);
			            var datalimite = mydate.getDate() + "/" + (mydate.getMonth() + 1) + "/" + mydate.getFullYear();
			            $( "#dataFinal" ).datepicker( "option", "maxDate", datalimite);
			    }
			});
			
			$("#dataFinal").datepicker({
				dateFormat: 'dd/mm/yy',
				changeMonth: true,
		        changeYear: true,
		    });
	
			$('#dataInicial, #dataFinal').blur(function(){
				$(this).setMask('date');
			}).focus(function(){
				$(this).unsetMask();
			});
	
		});
		
		function getValue(value){
	  
		   var id =value.split(";");	    
		   document.getElementById("idGerencia").value = id[0];
		   document.getElementById("nomeGerenc").value = id[1];  
	   }
	   
	   <%
	   		String environment = System.getProperty("SascarEnvironment");
	   		String vmArgumentsPropertiesPath = System.getProperty("SascarProperties");
	  		String propertiesName = vmArgumentsPropertiesPath + "/web-services-sascar.properties";
			java.io.File file = new java.io.File(propertiesName);
			java.util.Properties props = new java.util.Properties();
			props.load(new java.io.FileInputStream(file));
			String linkExportado = props.getProperty(environment + "_relatorio_direcionamento_exportado");
	   
	   %>
	   
	   var linkExportado = '<% out.print(linkExportado); %>';
	   
	   function exportarExcel(){
	   		var count = 0;
	   		var link = linkExportado + "?formato=excel";
	   		var dataInicial = $("#dataInicial").val().split("/");
	   		var dataFinal = $("#dataFinal").val().split("/");
	   		var veiculo = $("#numeroPlaca").val();
	   		var veiculoId = $("#veiculoId").val();
	   		var gerenciadora = $("#gerenciadoraId").val().split(";")[0];
	   		var cliente = $(".cliente").first().html();
	   		
	   		if(dataInicial != undefined && dataInicial != null && dataInicial.length > 0 ){
	   			link += "&periodo_data_inicial=" + dataInicial[2] + "-" + dataInicial[1] + "-" + dataInicial[0];
	   		}
	   		
	   		if(dataFinal != undefined && dataFinal != null && dataFinal.length > 0 ){
	   			link += "&periodo_data_final=" + dataFinal[2] + "-" + dataFinal[1] + "-" + dataFinal[0];
	   		}
	   		
	   		if(veiculo != undefined && veiculo != null && veiculo.trim() != "" ){
	   			link += "&veiculo=" + veiculo;
	   		}
	   		
	   		if(veiculoId != undefined && veiculoId != null && veiculoId.trim() != "" ){
	   			link += "&veiculoId=" + veiculoId;
	   		}
	   		
	   		if(gerenciadora != undefined && gerenciadora != null && gerenciadora.trim() != "" && gerenciadora != "0"){
	   			link += "&gerenciadora=" + gerenciadora;
	   		}
	   		
	   		if(cliente != undefined && cliente != null && cliente.trim() != "" ){
	   			link += "&cliente=" + cliente;
	   		}
	   		console.log("Link exportação excel : " + link);
	   		window.open(link, '_blank');
	   }
	   
	   function exportarPdf(){	   
	   		var count = 0;
	   		var link = linkExportado + "?formato=pdf";
	   		var dataInicial = $("#dataInicial").val().split("/");
	   		var dataFinal = $("#dataFinal").val().split("/");
	   		var veiculo = $("#numeroPlaca").val();
	   		var veiculoId = $("#veiculoId").val();
	   		var gerenciadora = $("#gerenciadoraId").val().split(";")[0];
	   		var cliente = $(".cliente").first().html();
	   		
	   		if(dataInicial != undefined && dataInicial != null && dataInicial.length > 0 ){
	   			link += "&periodo_data_inicial=" + dataInicial[2] + "-" + dataInicial[1] + "-" + dataInicial[0];
	   		}
	   		
	   		if(dataFinal != undefined && dataFinal != null && dataFinal.length > 0 ){
	   			link += "&periodo_data_final=" + dataFinal[2] + "-" + dataFinal[1] + "-" + dataFinal[0];
	   		}
	   		
	   		if(veiculo != undefined && veiculo != null && veiculo.trim() != "" ){
	   			link += "&veiculo=" + veiculo;
	   		}
	   		
	   		if(veiculoId != undefined && veiculoId != null && veiculoId.trim() != "" ){
	   			link += "&veiculoId=" + veiculoId;
	   		}
	   		
	   		if(gerenciadora != undefined && gerenciadora != null && gerenciadora.trim() != "" && gerenciadora != "0"){
	   			link += "&gerenciadora=" + gerenciadora;
	   		}
	   		
	   		if(cliente != undefined && cliente != null && cliente.trim() != "" ){
	   			link += "&cliente=" + cliente;
	   		}
	   		console.log("Link exportação pdf : " + link);
	   		window.open(link, '_blank');
	   }
	   
	   function validateForm() {
	   		if ($("#dataInicial").val().length == 0 || $("#dataFinal").val().length == 0) {
		   		$.showMessage("Campo Per\u00edodo \u00e9 obrigat\u00f3rio! Favor preencher ambas as datas Inicial e Final");
		   		return false;
		   	}
		   	return true;
	   }
			
	</script>

	<div class="container2">
		<ol>
			<li><label for="dataInicial" class="error"><fmt:message key="mensagem.campo.dataInicialValida" /></label></li>
			<li><label for="dataFinal" class="error"><fmt:message key="mensagem.campo.dataFinalValidaMaiorOuIgualInicial" /></label></li>
		</ol>
	</div>
	
	<div class="cabecalho">
		<fmt:message key="label.verHistoricoPendencias" />
		<div class="caminho" style="width: 400px;">
			<a class="linktres" title="<fmt:message key="label.home" />" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}"><fmt:message key="label.home" /></a>
			&gt;
			<a class="linkquatro" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC36/dv01"><fmt:message key="label.verHistoricoPendencias" /></a>
			&gt;
			<a class="linkquatro" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC36/dv08"><fmt:message key="label.relatorioDirecionamento" /></a>
		</div>
	</div>

	<table class="detalhe" cellspacing="0">
		<tbody>
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.relatorioDirecionamento" /></th>
			</tr>
		</tbody>
	</table>

	<div class="busca_branca">
		<span style="float:left;">
			<fmt:message key="label.escolhaUmTipoDeBusca" />
		</span>
		<span class="texthelp2" style="float:right;">
			<img hspace="5" height="16" align="absmiddle" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" />
			<fmt:message key="label.buscaAvancada" />
		</span>
	</div>

	<form id="formPesquisa" 
		  method="post" 
		  action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC36/dv08" 
		  onsubmit="return validateForm()">
		<input type="hidden" name="tipoConsulta" value="${param.tipoConsulta}" />
	
		<div class="busca_cinza">
			<span class="text2"><fmt:message key="label.peloPeriodo" />:</span>
			
			<label>
				<span class="text3"><fmt:message key="label.dataInicial" />:</span>
				<input type="text" name="dataInicial" id="dataInicial" value="${param.dataInicial}" class="text dateBR" maxlength="10" readonly="readonly" />
			</label>
			
			<label>
				<span class="text3"><fmt:message key="label.dataFinal" />:</span>
				<input type="text" name="dataFinal" id="dataFinal" value="${param.dataFinal}" dateHigher="#dataInicial" class="text dateBR" maxlength="10" readonly="readonly" />
			</label>
			
			<div style="width:255px;float:right;margin-top:-10px;">
				<span class="texthelp2">
					<img hspace="5" height="16" align="absmiddle" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" />
					<fmt:message key="label.vocePodeBuscarTodosOsRegistros30" />
				</span>
			</div>
			
		</div>
		<div class="busca_branca">
			<span class="text2"><fmt:message key="label.peloVeiculo" /></span>
			<input type="text" name="numeroPlaca" id="numeroPlaca" maxlength="12" value="${param.numeroPlaca}" onchange="atualizarLimitePeriodo();">
			<div style="width:255px;float:right;margin-top:-10px;">
				<span class="texthelp2">
					<img hspace="5" height="16" align="absmiddle" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" />
					<fmt:message key="label.vocePodeBuscarTodosOsRegistros90" />
				</span>
			</div>
		</div>
		<div class="busca_cinza">
			<span class="text2"><fmt:message key="label.peloID" />:</span>
			<input type="text" name="veiculoId" id="veiculoId" maxlength="15" value="${param.veiculoId}" onchange="atualizarLimitePeriodo();">
		</div>
		<div class="busca_branca" style="height:65px;">
			<span class="text2"><fmt:message key="label.peloGerenciadora" /></span>
			
			<select name="gerenciadoraId" id="gerenciadoraId"  class="required"  onchange="getValue(this.value)">
				<option value="0"><fmt:message key="label.selecione" /></option>
				<c:if test="${!empty gerenciadoras}">
					<c:forEach var="gerenciadora" items="${gerenciadoras}">
						<option  value="${gerenciadora.codigo};${gerenciadora.nome}">${gerenciadora.nome}</option>
					</c:forEach>
				</c:if>  
			</select>	
			
			<br/>
			<br/>
		
			<input class="button" type="submit" tabindex="10" value="<fmt:message key="label.buscar" />" />
			<input class="button4" type="button" tabindex="10" id="Limpar" value="<fmt:message key="label.limpar" />" onclick="limparCampos('#formPesquisa');"/>
		
		</div>
	</form>
	
	<br/>
	<br/>
	
	<form method="post" onsubmit="openPopupPrint(this);" 
		  action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Imprimir&page=Corporativo/UC36/dv07">
		
		<c:if test="${not empty listaDirecionamento}">
		<table id="alter" cellspacing="0" width="900">
			<tbody>
				<tr>
					<th class="texttable_cinza" width="9%" scope="col"><fmt:message key="label.dataSolicitacao" /></th>
					<th class="texttable_cinza" width="9%" scope="col"><fmt:message key="label.acao" /></th>
					<th class="texttable_cinza" width="9%" scope="col"><fmt:message key="label.layout" /></th>
					<th class="texttable_cinza" width="9%" scope="col"><fmt:message key="label.dataExecucao" /></th>
					<th class="texttable_cinza" width="9%" scope="col"><fmt:message key="label.Status" /></th>
					<th class="texttable_cinza" width="9%" scope="col"><fmt:message key="label.validade" /></th>
					<th class="texttable_cinza" width="9%" scope="col"><fmt:message key="label.id" /></th>
					<th class="texttable_cinza" width="9%" scope="col"><fmt:message key="label.veiculo" /></th>
					<th class="texttable_cinza" width="9%" scope="col"><fmt:message key="label.gerenciadora" /></th>
					<th class="texttable_cinza" width="9%" scope="col"><fmt:message key="label.prazoDirecionamento" /></th>
					<th class="texttable_cinza" width="9%" scope="col"><fmt:message key="label.usuario" /></th>
					<th class="texttable_cinza" width="9%" scope="col"style="display:none"></th>
				</tr>
				
				<c:forEach var="listaDirecionamento" items="${listaDirecionamento}">
					<tr>
						<c:if test="${listaDirecionamento.numeroComandos ne '0'}">
							<td class="camposinternos" rowspan="${listaDirecionamento.numeroComandos}">
								<fmt:formatDate value="${listaDirecionamento.dataSolicitacao}" pattern="dd/MM/yyyy HH:mm"/>
							</td>
							<td class="camposinternos" rowspan="${listaDirecionamento.numeroComandos}">${listaDirecionamento.acao}</td>
						</c:if>
						<td class="camposinternos">${listaDirecionamento.layout}</td>
						<td class="camposinternos"><fmt:formatDate value="${listaDirecionamento.dataExecucao}" pattern="dd/MM/yyyy HH:mm"/></td>
						<td class="camposinternos">${listaDirecionamento.status}</td>
						<td class="camposinternos"><fmt:formatDate value="${listaDirecionamento.validade}" pattern="dd/MM/yyyy HH:mm"/></td>
						<c:if test="${listaDirecionamento.numeroComandos ne '0'}">
							<td class="camposinternos" rowspan="${listaDirecionamento.numeroComandos}">${listaDirecionamento.veiculoId}</td>
							<td class="camposinternos" rowspan="${listaDirecionamento.numeroComandos}">${listaDirecionamento.veiculo}</td>
							<td class="camposinternos" rowspan="${listaDirecionamento.numeroComandos}">${listaDirecionamento.gerenciadora}</td>
							<td class="camposinternos" rowspan="${listaDirecionamento.numeroComandos}">${listaDirecionamento.prazoDirecionamentoString}</td>
							<td class="camposinternos" rowspan="${listaDirecionamento.numeroComandos}">${listaDirecionamento.usuario}</td>
						</c:if>
						<td class="camposinternos cliente" rowspan="${listaDirecionamento.numeroComandos}" style="display:none">${listaDirecionamento.codigoCliente}</td>
					</tr>
				</c:forEach>
				
			</tbody>
		</table>
		
		<div style="width: 64%;">
			<input class="button4" 
					style="float: right;"
					type="button" 
					tabindex="10" 
					id="exportar-excel" 
					value="<fmt:message key="label.exportarExcel" />" 
					onclick="exportarExcel();"/>
					
			
			<input class="button4" 
					style="float: right;"
					type="button" 
					tabindex="10" 
					id="exportar-pdf" 
					value="<fmt:message key="label.exportarPDF" />" 
					onclick="exportarPdf();"/>
		</div>
		
		</c:if>
	
		<div class="pgstabela">
			<input class="button3" type="button" value="<fmt:message key="label.voltar" />" onclick="window.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC36/dv01'">
		</div>
		
	</form>