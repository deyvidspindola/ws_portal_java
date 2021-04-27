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
	
	//Recupera os valores dos campos ao trocar a tela
	setarCampos();	

	//**Validações: validando pelo formato da data e verificando se o campo está vazio
	var container = $('div.container2');
	$("#formPesquisa").validate({
		
		rules: {
			dataInicial: {
				dateBR:  true,
				dateHigher :true,
				required: true
			},
			dataFinal: {
				dateBR:  true,
				required: true
			},
			
			horarioContinuo: {				
				required: true
			},
			horarioInicial: {				
				required: true
			},
			horarioFinal: {				
				required: true
			},
			codigoInstalador: {				
				required: true
			}
		},
		messages: {
			dataInicial: {
				dateBR:  '<fmt:message key="mensagem.campo.dataInicialValida" />',
				required: '<fmt:message key="mensagem.campoObrigatorio.dataInicial" />'
			},
		    dataFinal: {
			    dateBR:  '<fmt:message key="mensagem.campo.dataFinallValida" />',
			    dateHigher:  '<fmt:message key="mensagem.informacao.dataFinalMaiorInicial" />',
			    required: '<fmt:message key="mensagem.campoObrigatorio.dataFinal" />'
		    },
		    horarioContinuo: {				 
				required: '<fmt:message key="uc53.texto.006.selecioneDisponibilizarOuContinuo" />'
		    },
		    horarioInicial: {				 
				required: '<fmt:message key="mensagem.campoObrigatorio.horarioInicial" />'
		    },
		    horarioFinal: {				 
				required: '<fmt:message key="mensagem.campoObrigatorio.horarioFinal" />'
		    },
		    codigoInstalador: {				 
				required: '<fmt:message key="mensagem.campoObrigatorio.instalador" />'
		    }
		},
		  errorContainer: container,
		  errorLabelContainer: $("ol", container),
		  wrapper: 'li',
		  submitHandler : function(form) {
			 confirm_indisponibilizar();
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
		
		$('#dataInicial,  #dataFinal').blur(function(){			
			$(this).setMask('date');		
		}).focus(function(){
			$(this).unsetMask();
		});
		
		
	});	
	
    function atualizarAgendaInstalador(){
       
       var codigoInstalador = $("#codigoInstalador").val();	
       var dataInicial	     = $("#dataInicial").val();
       var dataFinal	     = $("#dataFinal").val();
       var horarioInicial   = $("#horarioInicial").val();
       var horarioFinal     = $("#horarioFinal").val();
       var horarioContinuo  = $("#horarioContinuo").val();
       
       var acao = "1";
       var disponibilizaIndisponibiliza = "D";
    
    
       $('input:radio[name=horarioContinuo]').each(function() {
		//Verifica qual está selecionado do grupo e atribui valor do item selecionado
		if ($(this).is(':checked'))
			horarioContinuo = $(this).val();
	   }); 
      
 	   $.ajax({
		    "url": "/SascarPortalWeb/AtualizarAgendaInstalador/atualizarAgendaInstalador",
		    "data":  {"acao"                                : acao,
	    	          "disponibilizaIndisponibiliza"        : disponibilizaIndisponibiliza,
		    	      "codigoInstalador"                    : codigoInstalador,
	    	          "dataInicial"                         : dataInicial,
	    	          "dataFinal"                           : dataFinal,
	    	          "horarioInicial"                      : horarioInicial,
	    	          "horarioFinal"                        : horarioFinal,
	    	          "horarioContinuo"                     : horarioContinuo},
	    	      	  dataType : "json",
	    	      	  type: "POST",
			          success: function(json){
				          if (json.success) {
					         $("#dialog_mensagem_indisponibilizado").jOverlay({'onSuccess' : function(){    			   
				           }});		         					  
				} else {
					$.showMessage(json.mensagem);					
				}
			}			   
	     });
    }

    function confirm_indisponibilizar(){		
      $("#dialog_mensagem_confirm_disponibilizar").jOverlay({'onSuccess' : function(){    	 
      }});
    }
	
	
	function redireciona_para_div1(){
		
		var dataInicial       = $("#dataInicial").val();
		var dataFinal         = $("#dataFinal").val();
		var horarioInicial    = $("#horarioInicial").val();
		var horarioFinal      = $("#horarioFinal").val();
		var codigoInstalador  = $("#codigoInstalador").val();
		var horarioContinuo   = $("#horarioContinuo").val();
		
		$('input:radio[name=horarioContinuo]').each(function() {
			//Verifica qual está selecionado do grupo
			if ($(this).is(':checked'))
				horarioContinuo = $(this).val();
		}); 

		window.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC53/dv01&dataInicial='+dataInicial+'&dataFinal='+dataFinal+'&codigoInstalador='+codigoInstalador+'&horarioInicial='+horarioInicial+'&horarioFinal='+horarioFinal+'&horarioContinuo='+horarioContinuo;
	}
	
	function setarCampos(){
		//** Utilizado para que, ao efetuar a troca de tela, os valores sejam recuperados;
		var codigoInstalador = "${param.codigoInstalador}";
		var horarioInicial   = "${param.horarioInicial}";
		var horarioFinal     = "${param.horarioFinal}";
	    var horarioContinuo  = "${param.horarioContinuo}";
		
		if(codigoInstalador != ""){
			$("#codigoInstalador").val("${param.codigoInstalador}");
		}
		
		if(horarioInicial != ""){
			$("#horarioInicial").val("${param.horarioInicial}");
		}
		
		if(horarioFinal != ""){
			$("#horarioFinal").val("${param.horarioFinal}");
		}
		
		if(horarioContinuo != ""){	
			$("input[name=horarioContinuo][value=" + horarioContinuo + "]").attr('checked', 'checked');	   
		}
	}
</script>

<div class="container2"> 
		<ol>
		</ol>
	</div>
		
<div class="cabecalho2" style="padding-left: 160px; width: 795px;">
	<div class="caminho" style="width: auto;">
		<a class="linktres" title="<fmt:message key="label.home" />" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}"><fmt:message key="label.home" /></a>
		&gt;
		<a class="linktres" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC53/dv01"><fmt:message key="label.servicos" /></a>
		<!-- 
		&gt;
		<a class="linkquatro" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC53/dv01">
		<strong><fmt:message key="label.indisponibilizarDisponibilizarAgenda" /></strong>
		</a>
		 -->
	</div>
	
	<strong><fmt:message key="label.indisponibilizarDisponibilizarAgenda" /></strong>
</div>

<div class="busca_branca"><span class="text1"><fmt:message key="label.informeDadosIndisponibilizarDisponibilizarAgenda" />:</span></div>	

<form id="formPesquisa" action="" method="POST">
<div class="busca_cinza">            
			<input tabindex="1"  type="radio" name="disponibilizaIndisponibiliza" value="I"  onclick="redireciona_para_div1();" id="indisponibilizarAgenda" style="margin-right: 5px;" /><span class="text3"><fmt:message key="label.indisponibilizarAgenda" /></span>
     		<input tabindex="2" type="radio" name="disponibilizaIndisponibiliza" value="D"   checked="checked"   id="disponibilizarAgenda" style="margin-right: 5px;" /><span class="text3"><fmt:message key="label.disponibilizarAgenda" /></span>
	</div>
	
	<div class="busca_branca">
	  <span class="text2"><fmt:message key="label.instalador" />: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
	    <label>
		  <select name="codigoInstalador" id="codigoInstalador" tabindex="3" class="required">						
		   	 <option value=""><fmt:message key="label.selecione" /></option>				
		  	  <c:forEach var="instalador" items="${instaladores}">					
			    <option value="${instalador.codigo}">${instalador.nome}</option>				   	
			  </c:forEach>
		  </select>
	    </label>
	 </div>
	
	<div class="busca_cinza">
		<span class="text2"><fmt:message key="label.periodo" />: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
		<label>
     			
     			<input tabindex="4" type="text" maxlength="10" name="dataInicial" readonly="readonly" id="dataInicial" value="${param.dataInicial}" class="dateBR text data" />
     	</label>
     	<span class="text3">a</span>
     	<label>     			
			<input tabindex="5" type="text" maxlength="10" name="dataFinal" id="dataFinal" readonly="readonly" class="dateBR text data"  value="${param.dataFinal}" />
		</label>
	</div>
	
	
	<div class="busca_branca">
	  <span class="text2"><fmt:message key="label.horarioInicial" />: </span>
	    <label>
		   <select name="horarioInicial" id="horarioInicial" tabindex="6" class="required">						
		    <option value=""><fmt:message key="label.selecioneHorarioInicial" /></option>
		    <option value="07:00">07:00</option>					
		  	<option value="07:30">07:30</option>					
		  	<option value="08:00">08:00</option>					
		  	<option value="08:30">08:30</option>					
		  	<option value="09:00">09:00</option>					
		  	<option value="09:30">09:30</option>					
		  	<option value="10:00">10:00</option>					
		  	<option value="10:30">10:30</option>					
		  	<option value="11:00">11:00</option>					
		  	<option value="11:30">11:30</option>					
		  	<option value="12:00">12:00</option>		  	
		  	<option value="12:30">12:30</option>		  						
		  	<option value="13:00">13:00</option>					
		  	<option value="13:30">13:30</option>					
		  	<option value="14:00">14:00</option>					
		  	<option value="14:30">14:30</option>					
		  	<option value="15:00">15:00</option>					
		  	<option value="15:30">15:30</option>					
		  	<option value="16:00">16:00</option>					
		  	<option value="16:30">16:30</option>					
		  	<option value="17:00">17:00</option>
		  	<option value="17:30">17:30</option>
		  	<option value="18:00">18:00</option>
			<option value="18:30">18:30</option>
		  	<option value="19:00">19:00</option>
		  	<option value="19:30">19:30</option>
		  	<option value="20:00">20:00</option>
		  	<option value="20:30">20:30</option>
		  	<option value="21:00">21:00</option>
		  	<option value="21:30">21:30</option>
		  	<option value="22:00">22:00</option>	  	
		  </select>
	    </label>
	    &nbsp;&nbsp;&nbsp;
	    <span class="text2"><fmt:message key="label.horarioFinal" />:</span>
	    <label>
		  <select name="horarioFinal" id="horarioFinal" tabindex="7" class="required">
		    <option value=""><fmt:message key="label.selecioneHorarioFinal" /></option>						
		    <option value="07:00">07:00</option>					
		  	<option value="07:30">07:30</option>					
		  	<option value="08:00">08:00</option>					
		  	<option value="08:30">08:30</option>					
		  	<option value="09:00">09:00</option>					
		  	<option value="09:30">09:30</option>					
		  	<option value="10:00">10:00</option>					
		  	<option value="10:30">10:30</option>					
		  	<option value="11:00">11:00</option>					
		  	<option value="11:30">11:30</option>					
		  	<option value="12:00">12:00</option>		  	
		  	<option value="12:30">12:30</option>		  						
		  	<option value="13:00">13:00</option>					
		  	<option value="13:30">13:30</option>					
		  	<option value="14:00">14:00</option>					
		  	<option value="14:30">14:30</option>					
		  	<option value="15:00">15:00</option>					
		  	<option value="15:30">15:30</option>					
		  	<option value="16:00">16:00</option>					
		  	<option value="16:30">16:30</option>					
		  	<option value="17:00">17:00</option>
		  	<option value="17:30">17:30</option>
		  	<option value="18:00">18:00</option>
		  	<option value="18:30">18:30</option>
		  	<option value="19:00">19:00</option>
		  	<option value="19:30">19:30</option>
		  	<option value="20:00">20:00</option>
		  	<option value="20:30">20:30</option>
		  	<option value="21:00">21:00</option>
		  	<option value="21:30">21:30</option>
		  	<option value="22:00">22:00</option>	  	
		  </select>
	    </label>
	 </div>
    <div class="busca_branca" style="width:820px;">            
			<input tabindex="8"  type="radio" name="horarioContinuo" value="N"  id="indisponibilizarHorario" style="margin-right: 5px;" /><span class="text3"><fmt:message key="label.disponibilizaraHorario" /></span><span class="texthelp2" style="*position:absolute;*margin-left:355px;*margin-top:0px;">
					<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" alt="" width="16" height="16"  hspace="5" align="absmiddle"/><fmt:message key="uc53.texto.003.disponibilizarHorario" /><br />
				</span><br><br><br>
     		<input tabindex="9" type="radio" name="horarioContinuo" value="C"  id="indisponibilizarHorario" style="margin-right: 5px;" /><span class="text3"><fmt:message key="label.disponibilizarHorarioContinuo" /></span><span class="texthelp2" style="*position:absolute;*margin-left:310px;*margin-top:0px">
					<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" alt="" width="16" height="16"  hspace="5" align="absmiddle"/><fmt:message key="uc53.texto.004.disponibilizarHorarioContinuo" /><br />
				</span>
	</div>

		<div class="busca_branca" align="center">
		</div>
		<div class="busca_branca" align="center">
		</div>
	    <div class="busca_cinza" align="center">
 	     <input type="submit" class="button" tabindex="10"  value="<fmt:message key="label.disponibilizar" />" />	
   	    </div>
   	
  
</form>

    <div id="dialog_mensagem_confirm_disponibilizar" class="popup_padrao" style="display: none;">        
			<div class="popup_padrao_pergunta"><fmt:message key="mensagem.confirmacao.disponibilizacaoAgenda" /></div>
		    <div class="popup_padrao_resposta">
			<input name="" type="submit" class="button close" value="<fmt:message key="label.confirmar" />" onclick="atualizarAgendaInstalador(); "/>
			<input type="button" class="button4 close" value="<fmt:message key="label.fechar" />" onclick="$.closeOverlay();" />
		</div>
	</div>	


	 <div id="dialog_mensagem_indisponibilizado" class="popup_padrao" style="display: none;">        
			<div class="popup_padrao_pergunta"><fmt:message key="mensagem.sucesso.disponibilizacaoAgenda" /></div>
		    <div class="popup_padrao_resposta">
			<input name="" type="submit" class="button close" value="OK" onclick="window.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC53/dv02'"/>
			
		</div>
	</div>	

