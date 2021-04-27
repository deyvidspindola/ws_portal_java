<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<script type="text/javascript">



    function verificaData() {
    	
    	var data = new Date();  
    	var dia = data.getDate();  
    	var mes = data.getMonth()+1;  
    	var ano = data.getFullYear();  
    	
    	
    	if(dia < 10){
    		dia = "0"+dia;
    	}
    	
    	if(mes<10){
    		mes = "0"+mes;
    	}
    	
    	var dataDoDia = dia+ '/'+ mes + '/' + ano  ;  
    	
    	if($("#dataVencimentoInicial").val() < dataDoDia && $("#dataVencimentoInicial").val() != ""){
    		$("#aVencer").attr('disabled','disabled');
    		$("#aVencer").attr('checked','');
    	}else{
    		$("#aVencer").attr('disabled','');
    	}
    	
    }

    
    function resetSelTodos(){
    	$("#selecionarTodos").attr('checked', 'checked');
    }

	function desmarcar(input) {
		var valor = $.trim($(input).val());

		if (valor && valor != 0 && valor.length > 0) {
			$("#selecionarTodos").removeAttr("checked");
		}
	}
	

	/* QUANDO É FEITO UM REFRESH NA TELA, O ESTADO DO CHECKBOX É MANTIDO */
	function desmarcarCheck(input) {
		var check1 = $("input[type=checkbox][name='opcaoBoleto1']:checked");
		var check2 = $("input[type=checkbox][name='opcaoBoleto2']:checked");
		var check3 = $("input[type=checkbox][name='opcaoBoleto3']:checked");
	
		if (check1.is(':checked') || check2.is(':checked') || check3.is(':checked')) {
			$("#selecionarTodos").removeAttr("checked");
		}
	}
	
    
    
	$(document).ready(function(){
		
		/* FAZ A VERIFICAÇÃO DE DATA MENOR QUE A ATUAL 
		   PARA QUE A CHECK SEJA HABILITADO OU DESABILITADO*/
		verificaData();
		
		
		//*** Limpa o checkBox caso o usuário digite algum texto 
		$('#numeroPlaca').keyup(function() {
			if ($("#selecionarTodos").is(':checked')){
				$("#selecionarTodos").attr('checked', false);
			}
		//** Retorna o check selecionado, caso o campo esteja vazio	
			if($('#numeroPlaca').val() == "" && $('#dataVencimentoInicial').val() == "" && $('#dataVencimentoFinal').val() == "")  {
				$("#selecionarTodos").attr('checked','checked');	
			}
			
		});	
		
		
		//*** Limpa o checkBox caso o usuário digite algum texto 
		$('#dataVencimentoInicial, #dataVencimentoFinal').change(function() {
			if ($("#selecionarTodos").is(':checked')){
				$("#selecionarTodos").attr('checked', false);
			}
		
			
		});	
		
		$(':checkbox').live('click', function () {
		  if ($(this).attr("id") != "selecionarTodos") {
			if ($("#selecionarTodos").is(':checked')){
				$("#selecionarTodos").attr('checked', false);
			}
			
			if ($(':checkbox:checked').length == 0 && !$("#selecionarTodos").is(':checked')){
				$("#selecionarTodos").attr('checked', 'checked');
			}
		  }		  
	    });
	
		
		
		$("#clean").click(function(){
			$("#aVencer").attr('disabled','');
			$("#vencido").attr('disabled','');
			$("#pago").attr('disabled','');
			
		});

		
		/* DATA DE VENCIMENTO */
		$("#dataVencimentoInicial").datepicker({
			dateFormat: 'dd/mm/yy',
			changeMonth: true,
	        changeYear: true,
	        onClose: function( selectedDate ) {
	            $( "#dataVencimentoFinal" ).datepicker( "option", "minDate", selectedDate );
	            verificaData();
              
	          }
		});
		
		$("#dataVencimentoFinal").datepicker({
			dateFormat: 'dd/mm/yy',
			changeMonth: true,
	        changeYear: true,
	        onClose: function( selectedDate ) {
	            $( "#dataVencimentoInicial" ).datepicker( "option", "maxDate", selectedDate );
	            verificaData();
	          }
		});
		
		/* DATA DE EMISSAO */
		$("#dataEmissaoInicial").datepicker({
			dateFormat: 'dd/mm/yy',
			changeMonth: true,
	        changeYear: true,
	        onClose: function( selectedDate ) {
	            $( "#dataEmissaoFinal" ).datepicker( "option", "minDate", selectedDate );
            }
		});
		
		$("#dataEmissaoFinal").datepicker({
			dateFormat: 'dd/mm/yy',
			changeMonth: true,
	        changeYear: true,
	        onClose: function( selectedDate ) {
	            $( "#dataEmissaoInicial" ).datepicker( "option", "maxDate", selectedDate );
	          }
		});

		$('#dataVencimentoInicial, #dataVencimentoFinal, #dataEmissaoInicial, #dataEmissaoFinal').blur(function(){
			$(this).setMask('date');
		}).focus(function(){
			$(this).unsetMask();
		});
		
		
		$("#selecionarTodos").click(function(){
			if ($(this).is(':checked')){
				$(":text").val('');
				$("input[type=checkbox][name='opcaoBoleto1']").attr('checked','');
				$("input[type=checkbox][name='opcaoBoleto2']").attr('checked','');
				$("input[type=checkbox][name='opcaoBoleto3']").attr('checked','');
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
		
		$(":checkbox").each(function(){
			desmarcarCheck(this);
		});
		
	});
</script>

		<div class="container2"> 
			<ol>
				<li>
					<label for="data" class="error"><fmt:message key="mensagem.campo.minimoUmaData" /></label>
				</li>
			</ol>
		</div>


		<c:choose>
			<c:when test="${param.menu eq 1}">
				<c:set var="titulo"><fmt:message key="label.titulo.emissao2ViaBoleto" /></c:set>
				<c:set var="subTitulo"><fmt:message key="uc16.dv01.label.para2ViaBoleto" />:</c:set>
				<c:set var="labelDescricao"><fmt:message key="uc16.label.selecioneOpcaoDesejada" />: &nbsp;&nbsp;&nbsp;</c:set>
			</c:when>
			<c:when test="${param.menu eq 2}">
				<c:set var="titulo"><fmt:message key="label.titulo.emissao2ViaNF" /></c:set>
				<c:set var="subTitulo"><fmt:message key="uc16.dv01.label.para2ViaNF" />:</c:set>
			    <c:set var="labelDescricao"><fmt:message key="uc16.dv01.buscarNF" />: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</c:set>
			</c:when>
			<c:otherwise>
				<c:set var="titulo"><fmt:message key="label.consultas" /> </c:set>
				<c:set var="subTitulo"><fmt:message key="uc16.label.consultarFaturasPor" />:</c:set>
				<c:set var="labelDescricao"><fmt:message key="label.selecioneOpcaoDesejada" />:</c:set>
			</c:otherwise>
		</c:choose>


		<div class="cabecalho2">
			<div class="caminho3" style="*margin-left:280px;">
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> 
				<a href="#" class="linktres">&gt;<fmt:message key="label.pagamentos" />&gt;</a>
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC16/dv01&menu=${param.menu}" class="linkquatro">${titulo}</a>
			</div>
			 ${titulo}
		</div>


		<div class="busca_branca" style="padding-left:50px; width:900px;">
			<span class="text1">${subTitulo}</span> 
			<span class="texthelp2"  style="float:right;">
				<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" />
				<fmt:message key="label.buscaAvancada" />
			</span> 
		</div>


	<form id="formPesquisa" 
		  action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC16/dv02" 
		  method="post">
		
		<input type="hidden" value="${param.menu}" name="menu" />
		
			<div class="busca_cinza" style="padding-left:50px; width:900px;">
			<label for="vencido">
			    <span class="text2">${labelDescricao}</span>
		    		<input type="checkbox" 
		    			   class=""  		    			 
		    			   name="opcaoBoleto1" 
		    			   id="vencido" 
		    			   <c:if test="${param.opcaoBoleto1 eq 'V' }">checked="checked"</c:if>		    			   
		    			   value="V"/>
		    			   <fmt:message key="label.vencido" />
		    </label>
		    <label for="aVencer">
		    
		    		<input type="checkbox" 
		    			   class=""  		    			 
		    			   name="opcaoBoleto2" 
		    			   id="aVencer" 
		    			   <c:if test="${param.opcaoBoleto2 eq 'A' }">checked="checked"</c:if>
		    			   value="A"  />
		    			   <fmt:message key="label.aVencer" />
		    </label>
		     <label for="pago">
		    		<input type="checkbox" 
		    			   class=""  		    			 
		    			   name="opcaoBoleto3" 
		    			   id="pago" 
		    			   <c:if test="${param.opcaoBoleto3 eq 'P' }">checked="checked"</c:if>
		    			   value="P" />
		    			   <fmt:message key="label.pago" />
		    </label>
		    
		    <span class="texthelp2" style="float:right;*margin-top:-20px;">
				<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" />
					<fmt:message key="uc16.visualizarFaturas" />
			</span> 
		</div>
		
		
		
		<div class="busca_branca" style="padding-left:50px; width:900px;">
			<label for="numeroPlaca">
				<span class="text2"><fmt:message key="label.pelaPlaca" />:</span>
				<span class="text3"><fmt:message key="label.nAbrev" />:</span>
				<input type="text" id="numeroPlaca" name="numeroPlaca" maxlength="7" value="${param.numeroPlaca}" />
			</label>
		</div>
		
		
		<div class="busca_cinza" style="padding-left:50px; width:900px;">
		   	<label for="dataVencimentoInicial">
			    <span class="text2"><fmt:message key="label.periodoVencimentoFaturas" />:</span>
		    		<input type="text" 
		    			   class=" dataintervalo data" 
		    			   style="width:80px;" 
		    			   name="dataVencimentoInicial" 
		    			   id="dataVencimentoInicial" 
		    			   value="${param.dataVencimentoInicial}" 
		    			   maxlength="10" 
		    			   readonly="readonly" /> 
		    </label>
		    <label>
		      <span class="text3">a </span>
		    	  <input type="text" 
		    	  		 class=" dataintervalo data" 
		    	  		 style="width:80px;" 
		    	  		 name="dataVencimentoFinal" 
		    	  		 id="dataVencimentoFinal" 
		    	  		 value="${param.dataVencimentoFinal}" 
		    	  		 maxlength="10" 
		    	  		 readonly="readonly" />
		    </label>
		   <span class="texthelp2" style="position:absolute;margin-left:140px;margin-top:0px">
				<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" />
					<fmt:message key="uc16.visualizarFaturas2" />
			</span> 	    
		</div>
		
		<!--div class="busca_cinza" style="padding-left:50px; width:900px;">
			<label for="dataEmissaoInicial">
			    <span class="text2">Período em que foi emitida a fatura:</span>
		    		<input type="text" 
		    			   class=" dataintervalo data"  
		    			   style="width:80px;" 
		    			   name="dataEmissaoInicial" 
		    			   id="dataEmissaoInicial" 
		    			   value="${param.dataEmissaoInicial}" 
		    			   maxlength="10" 
		    			   readonly="readonly" />
		    </label>
		    <label>
		    	<span class="text3">a </span>
		    		<input type="text" 
		    			   class=" dataintervalo data" 
		    			   style="width:80px;" 
		    			   name="dataEmissaoFinal" 
		    			   id="dataEmissaoFinal" 
		    			   value="${param.dataEmissaoFinal}" 
		    			   maxlength="10" 
		    			   readonly="readonly" />
		    </label>
		    <span class="texthelp2" style="position:absolute;margin-left:140px;margin-top:0px">
				<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" />
					Esta busca permite visualizar as faturas que foram <br/> emitidas pela Sascar, dentro do período solicitado.
			</span> 
		</div-->
		<div class="busca_branca">
		    <label>
				<input name="selecionarTodos" type="checkbox" class="check" id="selecionarTodos" checked="checked"/>
				<span class="text2"><fmt:message key="label.buscarTodos" /></span>
			</label>
		</div>	
			
		<div class="busca_cinza" style="padding-left:50px; width:900px;">
	    	<input type="submit" class="button" id="buscar" value="<fmt:message key="label.buscar" />" />
	    	<input type="button" class="button4" value="<fmt:message key="label.limpar" />" id="clean" onclick="limparCampos('#formPesquisa'); resetSelTodos();"/>
		</div>
		
		
		
	</form>

