<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

  <c:catch var="helper" >
 		<c:import url="/VeiculoAtualizacao/consultarVeiculosDesatualizados?acao=1&periodo=0" context="/SascarPortalWeb"  />
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

<script type="text/javascript">

 // ESTA TELA UTILIZA OS SEGUINTES WS :
 // WS198_submeterMotivoVeiculoDesatualizado     (Ao clicar no botão 'Atualizar');
 // WS197_consultarMotivosVeiculosDesatualizados (Ao preencher a combobox );
 // WS196_consultarVeiculosDesatualizados        (Ao listar todos os veículos que possuem atualização pendente)
 
 function submeterVeiculosDesatualizados(form){
	
	  var data = $(form).serialize();
	   $(':disabled').each( function() {
	     data += '&' + this.name + '=' + $(this).val();
	   });                

	 //UTILIZANDO A FUNÇÃO QUE PEGA OS VALORES DAS LINHAS DA TABELA 
	 var veiculo = pegarValoresLinhasTabela();
     
	 var dataInicial = $("#dataInicial").val(); 
	     $.ajax({
		    url: "/SascarPortalWeb/VeiculoAtualizacao/atualizarVeiculosDesatualizados",
		    data: {"acao" : 3, "dataInicial" : dataInicial, "listaVeiculos" : veiculo},
		    dataType:"json",
		    type :"POST",
		    success: function(json){
		      if (json.success) {							
		        confirma_mensagem_atualizado();		
			    resizeIframeParent();
			  } else {
			    $.showMessage(json.mensagem);					
			  }
		  }			   
	   });
  }

  function  confirma_mensagem_atualizado(){	 
	 $("#dialog_mensagem_atualizado").jOverlay({'onSuccess' : function(){
	 }});
  }
 
  function alternarMensagens(valor){

	// MOSTRA AS MENSAGENS
	$("#lampada").show();
	$("#mensagem_motivo").show();
	$("#mensagem_motivo_escolhido").show();	
	
	/// NÃO PODE SUBMETER SEM SELECIONAR UM ITEM
	if($(":checkbox:checked").length > 0){
	  $("#buttonAtualizar").attr('disabled', false);	
	   // A VARIÁVEL VALOR VEM DO COMBOBOX
	   // ESTE VALOR ESTÁ CONCATENANDO: 
	   // 1- O CÓDIGO DO MOTIVO SELECIONADO;
	   // 2- A FLAG SOLICITA PREVISÃO, QUE INDICA SE HÁ A NECESSIDADE DE SOLICITAR UMA PREVISÃO
	   var value = valor.split(";");	    
	   var codigoMotivo     = value[0];
	   
	   // O CAMPO 'SOLICITA PREVISÃO' É RETORNADO PARA INDICAR SE HÁ A NECESSIDADE
	   // DE MOSTRAR O CAMPO SOLICITA PREVISÃO.
	   // O WS 197 (consultarMotivosVeiculosDesatualizados), RETORNA, ALÉM DO CAMPO
	   // CHAVE VALOR, O CAMPO SOLICITA PREVISÃO
	   var solicitaPrevisao = value[1];  

	  /// PARA CADA MOTIVO SELECIONADO, SERÁ EXIBIDA UMA MENSAGEM DIFERENTE
	  /// VERIFICAR ÍNDICE DE MENSAGENS AO FINAL DO SCRIPT
	 
	  if(codigoMotivo.toUpperCase() == "VEICULO EM MANUTENCAO"){
		  $("#mensagem_motivo").html(mensagem[9]); 
		  // MOSTRA O CAMPO PREVISÃO SAÍDA(ELE SÓ SERÁ EXIBIDO PARA OS ITENS MANUNTENÇÃO E VEÍCULO SINISTRADO)
		   showHidePrevisao(solicitaPrevisao);
	      // DEPENDENDO DO TIPO DE CONTRATO SELECIONADO, SERÁ EXIBIDA UMA MENSAGEM DIFERENTE
		  valida_mensagem("manutenção");
		  resizeIframeParent();
	  }
	  
	  if(codigoMotivo.toUpperCase() == "VEICULO VENDIDO"){
	
	  	  $("#mensagem_motivo").html(mensagem[10]); 
		  // ESCONDE O CAMPO PREVISÃO SAÍDA(ELE SÓ SERÁ EXIBIDO PARA OS ITENS MANUNTENÇÃO E VEÍCULO SINISTRADO)
		   showHidePrevisao(solicitaPrevisao);
		  // DEPENDENDO DO TIPO DE CONTRATO SELECIONADO, SERÁ EXIBIDA UMA MENSAGEM DIFERENTE
		  valida_mensagem("vendido");
		  resizeIframeParent();
	  }
	  
	  
	  if(codigoMotivo.toUpperCase() == "VEICULO PARADO"){
		  $("#mensagem_motivo").html(mensagem[11]); 
		  showHidePrevisao(solicitaPrevisao);
	  	  // DEPENDENDO DO TIPO DE CONTRATO SELECIONADO, SERÁ EXIBIDA UMA MENSAGEM DIFERENTE
		  valida_mensagem("veiculo_parado");
		  resizeIframeParent();
	  }
	  
	  if(codigoMotivo.toUpperCase() == "VEICULO SINISTRADO"){
		  $("#mensagem_motivo").html(mensagem[12]); 
		  // ESCONDE O CAMPO PREVISÃO SAÍDA(ELE SÓ SERÁ EXIBIDO PARA OS ITENS MANUNTENÇÃO E VEÍCULO SINISTRADO)
		  showHidePrevisao(solicitaPrevisao);
	 	  // DEPENDENDO DO TIPO DE CONTRATO SELECIONADO, SERÁ EXIBIDA UMA MENSAGEM DIFERENTE
		  valida_mensagem("sinistrado");
		  resizeIframeParent();
	  }
	  
	  if(codigoMotivo.toUpperCase() == "SEGURO CANCELADO"){	  
		  $("#mensagem_motivo").html(mensagem[13]); 
		  // ESCONDE O CAMPO PREVISÃO SAÍDA(ELE SÓ SERÁ EXIBIDO PARA OS ITENS MANUNTENÇÃO E VEÍCULO SINISTRADO)
		  showHidePrevisao(solicitaPrevisao);
		  // DEPENDENDO DO TIPO DE CONTRATO SELECIONADO, SERÁ EXIBIDA UMA MENSAGEM DIFERENTE
		  valida_mensagem("cancelado");
     	  resizeIframeParent();
	  }
	  
	  if(codigoMotivo.toUpperCase() == "VEICULO TRAFEGANDO EM REGIAO SEM SINAL"){
		  $("#mensagem_motivo").html(mensagem[14]); 
		  // ESCONDE O CAMPO PREVISÃO SAÍDA(ELE SÓ SERÁ EXIBIDO PARA OS ITENS MANUNTENÇÃO E VEÍCULO SINISTRADO)
		  showHidePrevisao(solicitaPrevisao);
		  // DEPENDENDO DO TIPO DE CONTRATO SELECIONADO, SERÁ EXIBIDA UMA MENSAGEM DIFERENTE
		  valida_mensagem("sem_sinal");
		  resizeIframeParent();
	  }
	  
	  if(codigoMotivo.toUpperCase() == "VEICULO ROUBADO"){
	  
		  $("#mensagem_motivo").html(mensagem[15]); 
		  // ESCONDE O CAMPO PREVISÃO SAÍDA(ELE SÓ SERÁ EXIBIDO PARA OS ITENS MANUNTENÇÃO E VEÍCULO SINISTRADO)
		  showHidePrevisao(solicitaPrevisao);
		  // DEPENDENDO DO TIPO DE CONTRATO SELECIONADO, SERÁ EXIBIDA UMA MENSAGEM DIFERENTE
		  valida_mensagem("roubado");
		  resizeIframeParent();
	  }
  
	  if(codigoMotivo.toUpperCase() == "VEICULO TRAFEGANDO"){
		  $("#mensagem_motivo").html(mensagem[16]); 
		  // ESCONDE O CAMPO PREVISÃO SAÍDA(ELE SÓ SERÁ EXIBIDO PARA OS ITENS MANUNTENÇÃO E VEÍCULO SINISTRADO)
		  showHidePrevisao(solicitaPrevisao);
		  // DEPENDENDO DO TIPO DE CONTRATO SELECIONADO, SERÁ EXIBIDA UMA MENSAGEM DIFERENTE
		  valida_mensagem("trafegando");
		  resizeIframeParent();
	  } 
	 
	  if(codigoMotivo.toUpperCase() == ""){
		  valida_mensagem("");
		  resizeIframeParent();
	  } 
	 	
	}else{
		  $.showMessage('<fmt:message key="mensagem.selecione.umVeiculo" />'); 
		  resetFields();
	}
  }
  
  $(document).ready(function(){
	  
	   // SUBMETER A FORM VEÍCULOS DESATUALIZADOS  
	   var container = $('div.container2');
	   $("#formVeiculosDesatualizados").validate({	
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			rules: {
				codigoMotivo: {					
				   required: true
				},
	             "checkAtualizar[]": {					
			       required: true
		       },
		       dataInicial:{
		    	   required: {
		    		    // NESTE CASO, O CAMPO PREVISÃO SAÍDA SÓ 
		    		    // SERÁ VALIDADO QUANDO ELE ESTIVER VISÍVEL.
		                depends: function () {		                	       
		                    return !$("#dataInicial").is(':hidden');
		                }
		            }
		       }		       
			},
			messages: {
				codigoMotivo: {					
				   required: '<fmt:message key="mensagem.campoObrigatorio.motivo" />'
				},
			    "checkAtualizar[]": {					
				   required: '<fmt:message key="mensagem.selecione.umOuMaisVeiculos" />'
			    },
			    dataInicial: {					
				   required: '<fmt:message key="mensagem.campoObrigatorio.previsao" />'
			    }
			},
	   	   submitHandler : function(form) {
	         submeterVeiculosDesatualizados(form);
		     return false;
	       }
		});
	  
	  // QUANDO A TELA É CARREGADA, 
	  // TODAS AS CHECKS SÃO LIMPAS E AS COMBOS TAMBÉM
	  resetFields();	 
	  
	  var dateToday = new Date();
	  
	  $("#dataInicial").datepicker({
			dateFormat: 'dd/mm/yy',
			changeMonth: true,
	        changeYear: true,
	        minDate: dateToday
		});
   });
  
  
  function habilitarComboMotivos(){
	  
	var tipoUsuario  = "";
	var isCliente    = false;
	var isSeguradora = false;
	
	//SE NÃO HOUVER CHECK SELECIONADO TRAVA COMBOBOX 	
	if($(":checkbox:checked").length < 1){			
		 resetFields();
	}else{
		$("#buttonAtualizar").attr('disabled', '');
	}   
	  
	// ITERANDO TODOS checkbox
   $("input[type='checkbox']").each( function() {
	// VALIDA SE O checked ESTÁ SELECIONADO
     if($(this).is(':checked')){				
	   //PEGA O TEXTO DO CAMPO TIPO CONTRATO
	   tipoUsuario =  $(this).parents('tr').find('td:eq(4)').text();				
	   //QUANDO O CHECKBOX É SELECIONADO ELE ALTERA A COR
	    trocaCorLinhaTabela(this, "checked", "#FFFF99");	 				
	   //VALIDA SE O USUÁRIO EM QUESTÃO É UM CLIENTE. SE
	   //FOR RECEBE A FLAG TRUE, SENÃO SERÁ UMA SEGURADORA
	   if(tipoUsuario == "Cliente" || tipoUsuario == "cliente"){
	     isCliente = true;
	   }else{
	   	 isSeguradora = true;
	   }	 
	}else{
	     //CASO O CHECKBOX NÃO ESTEJA SELECIONADO ELE VOLTA À COR ORIGINAL
	     trocaCorLinhaTabela(this, "unchecked", "white");	 
	}
  }); 
	
  // NÃO É PERMITIDO SELECIONAR DOIS PERFIS DIFERENTES DE CLIENTES AO MESMO TEMPO
    if(isCliente == true && isSeguradora == true){
      $.showMessage('<fmt:message key="uc56.dv01.texto.22" />');
	  $("#codigoMotivo").attr('disabled', 'disabled');	 
	  $('#codigoMotivo option:first-child').attr("selected", "selected");
	  $('#buttonAtualizar').attr('disabled', 'true');
    }else{       	
      // PARA HABILITAR O CAMPO É NECESSÁRIO TER, PELO MENOS, UM ITEM SELECIONADO 
      // SE HOUVER COMBINAÇÃO TIPO CONTRATO = CLIENTE E MOTIVO = CANCELADO MANTÉM O BOTÃO DESABILITADO
      if ($(":checkbox:checked").length > 0){
    	  var cod  = $("#codigoMotivo").val().split(";");
          if(isCliente == true && cod[0].toUpperCase() == "SEGURO CANCELADO"){
   		    $('#buttonAtualizar').attr('disabled', 'disabled');
 	      }
            $("#codigoMotivo").attr('disabled', ''); 
     }
    }
 }
  
  // QUANDO É ALTERADO O MOTIVO DA COMBOBOX, ESTA FUNÇÃO
  // É CHAMADA PARA QUE, DEPENDENDO DO TIPO DE CONTRATO
  // SELECIONADO, SE MOSTRE UMA MENSAGEM DIFERENTE.
  function valida_mensagem(tipo_motivo){
	  
	  var tipoUsuario  = "";
	  var isCliente    = false;
	  var isSeguradora = false;
	 
	// ITERANDO TODOS checkbox
		$("input[type='checkbox']").each( function() {
			
			// VALIDA SE O checked ESTÁ SELECIONADO
			if($(this).is(':checked')){
				tipoUsuario =  $(this).parents('tr').find('td:eq(4)').text();
				//VALIDA SE O USUÁRIO EM QUESTÃO É UM CLIENTE. SE
				//FOR RECEBE A FLAG TRUE, SENÃO SERÁ UMA SEGURADORA
				 if(tipoUsuario == "Cliente" || tipoUsuario == "cliente"){
			    	  isCliente = true;
			     }else{
			    	 isSeguradora = true;
			     }
			}
	   }); 
		
	   // SE A COMBO SELECIONADA FOR MANUTENÇÃO, AS MENSAGENS PARA CLIENTE E SEGURADORA SERÃO IGUAIS
	   // VERIFICAR ÍNDICE DE MENSAGENS NO FINAL DOS SCRIPTS
	   if(tipo_motivo == "manutenção"){
		   if (isCliente == true || isSeguradora == true){
			 $("#mensagem_motivo_escolhido").hide();
			 $("#mensagem_motivo_escolhido_manutencao_parado").show();
		     $("#mensagem_motivo_escolhido_manutencao_parado").html(mensagem[18]);	
           }
	   }
	   
	   // SE A COMBO SELECIONADA FOR VENDIDO, CLIENTE E SEGURANDORA TERÃO MENSAGENS DIFERENTES.
	   if(tipo_motivo == "vendido"){
		 if (isCliente == true){	
	       $("#mensagem_motivo_escolhido").html(mensagem[1]);
	       $("#mensagem_motivo_escolhido_manutencao_parado").hide();
	     }else{
	       $("#mensagem_motivo_escolhido").html(mensagem[2]);
	       $("#mensagem_motivo_escolhido_manutencao_parado").hide();
	     }
	   }	 
	   
	   // SE A COMBO SELECIONADA FOR VEÍCULO PARADO, AS MENSAGENS PARA CLIENTE E SEGURADORA SERÃO IGUAIS
	   if(tipo_motivo == "veiculo_parado"){
		  if (isCliente == true || isSeguradora == true){
			$("#mensagem_motivo_escolhido").hide();
			$("#mensagem_motivo_escolhido_manutencao_parado").show();
		    $("#mensagem_motivo_escolhido_manutencao_parado").html(mensagem[19]);			 
	      }
	   }
	   
	   // SE A COMBO SELECIONADA FOR SINISTRADO, CLIENTE E SEGURADORA TERÃO MENSAGENS DIFERENTES.
	   if(tipo_motivo == "sinistrado"){
		   if(isCliente == true){			
		     $("#mensagem_motivo_escolhido").html(mensagem[4]);
		     $("#mensagem_motivo_escolhido_manutencao_parado").hide();
           }else{
		     $("#mensagem_motivo_escolhido").html(mensagem[5]);
		     $("#mensagem_motivo_escolhido_manutencao_parado").hide();
	       }
	   }	   
	   
	   // SE A COMBO SELECIONADA FOR CANCELADO, CLIENTE E SEGURADORA TERÃO MENSAGENS DIFERENTES.
	   if(tipo_motivo == "cancelado"){
		  if (isCliente == true){
			$("#buttonAtualizar").attr('disabled', 'disabled');  
	        $("#mensagem_motivo_escolhido").html(mensagem[6]);
	        $("#mensagem_motivo_escolhido_manutencao_parado").hide();
	      }else{
	    	$("#buttonAtualizar").attr('disabled', '');
	    	$("#mensagem_motivo_escolhido").html(mensagem[2]);
	    	 $("#mensagem_motivo_escolhido_manutencao_parado").hide();
	      }
	   } 
	   
	   // SE A COMBO SELECIONADA FOR SEM SINAL PARADO, AS MENSAGENS PARA CLIENTE E SEGURADORA SERÃO IGUAIS 
	   if(tipo_motivo == "sem_sinal" ){
		   if(isCliente == true || isSeguradora == true){			  
			       $("#mensagem_motivo_escolhido").html(mensagem[7]);
			       $("#mensagem_motivo_escolhido_manutencao_parado").hide();
		   }
	   }
	   
	   // SE A COMBO SELECIONADA FOR ROUBADO, AS MENSAGENS PARA CLIENTE E SEGURADORA SERÃO IGUAIS
	   if(tipo_motivo == "roubado"){
		   if (isCliente == true || isSeguradora == true){
			       $("#mensagem_motivo_escolhido").html(mensagem[8]);
			       $("#mensagem_motivo_escolhido_manutencao_parado").hide();
	      }
	   }
	
	   // SE A COMBO SELECIONADA FOR TRAFEGANDO, AS MENSAGENS PARA CLIENTE E SEGURADORA SERÃO IGUAIS
	   if(tipo_motivo == "trafegando"){
		   if (isCliente == true || isSeguradora == true){
			       $("#mensagem_motivo_escolhido").html(mensagem[7]);
			       $("#mensagem_motivo_escolhido_manutencao_parado").hide();
 	       }
	   }
	   
	   if(tipo_motivo.toUpperCase() == ""){
			  resetFields();
	   }

  }

 //DEPENDENDO DA FLAG RETORNADA ELE MOSTRA O CAMPO PREVISÃO
  function showHidePrevisao(solicitaPrevisao){
	  if(solicitaPrevisao == "true"){
		  $("#previsao_saida").show();
		  $("#dataInicial").show();
		}else{
		  $("#dataInicial").val("");	
		  $("#previsao_saida").hide();
		  $("#dataInicial").hide();
		}  
  }
  
  // FUNÇÃO PARA LIMPAR TODOS OS CHECKBOXES E,
  // CONSEQUENTEMENTE, RETORNA AS CORES DAS LINHAS 
  // SELECIONADAS AO NORMAL.
  function limpar_checkboxes(){
	$("input[type='checkbox']").each( function() {		  
	  if($(this).is(':checked')){
		//VOLTA À COR ORIGINAL
		 trocaCorLinhaTabela(this, "unchecked","white");
		$("#previsao_saida").hide();
	    // TIRA AS CHECKS SELECIONADAS
		$(this).attr('checked', false);
	  }
    });
  }
  
  
  function resetFields(){
	  //QUANDO SE CLICA EM LIMPAR ELE DEVE RESETAR TODOS OS CAMPOS	  
	  $("input.group1").attr("disabled", false);	  
	  $("#lampada").hide();
	  $("#mensagem_motivo").hide();
	  $("#mensagem_motivo_escolhido").hide();
	  $("#previsao_saida").hide();
	  $("#previsao_saida").val("");
	  $("#dataInicial").val("");
	  $("#dataInicial").hide();
	  // REMOVER A MENSAGEM DE VALIDAÇÃO
	  $("div.container2").find('li').remove();
	  $('#codigoMotivo option:first-child').attr("selected", "selected");
	  $('#codigoMotivo').attr('disabled', 'true');		 
	  limpar_checkboxes();
  }
  
  // ESTA FUNÇÃO PODE SER CHAMADA PARA ALTERNAR A COR DA LINHA DA TABELA
  // QUANDO A CHECKBOX É SELECIONADA. 
  // SÃO PASSADOS OS PARÂMETROS: O ELEMENTO EM QUESTÃO, FLAG E A COR, PARA SABER SE ESTÁ 
  // SELECIONADA.
  function trocaCorLinhaTabela(elemento, flagCor, corEscolhida){
	  
	  if(flagCor == "checked"){
	    $(elemento).parents('tr').find('td').css("background-color", corEscolhida);
	  }else{
	    $(elemento).parents('tr').find('td').css("background-color", corEscolhida);
	  }	  
  }  
  
  function pegarValoresLinhasTabela(){
   
	  var veiculo ="";
	
      // ITERANDO TODOS checkbox
	  $("input[type='checkbox']").each( function() {
	       // VALIDA SE O checked ESTÁ SELECIONADO
	       if($(this).is(':checked')){	
	         var codigoMotivoSolicitaPrevisao = $("#codigoMotivo").val();
		     var codigoMotivo = codigoMotivoSolicitaPrevisao.split(";");
	         //PEGA O TEXTO  E CONCATENA                                                                                                     
		     veiculo     += $(this).parents('tr').find('td:eq(1)').text()+";"  // 1- PLACA ; 
		                 +  $(this).parents('tr').find('td:eq(5)').text()+";"  // 2- CÓDIGO VEÍCULO ; 
		                 +  $(this).parents('tr').find('td:eq(6)').text()+";"  // 3- NÚMERO CONTRATO ;
		                 +  codigoMotivo[2]+";"                                // 4 -CÓDIGO MOTIVO      
		                 +  $(this).parents('tr').find('td:eq(2)').text()+"#"; // 5 - DATA PREVISÃO SAÍDA   # é o divisor de itens
	       }
	   });  
    
    return veiculo;
  }
 

  //  LISTA DE MENSAGENS A SEREM EXIBIDAS DE ACORDO COM AS OPÇÕES SELECIONADAS (UTILIZADA NA FUNÇÃO valida_mensagem)
  var mensagem = new Array();
  
  mensagem[0] = '<fmt:message key="uc56.dv01.texto.10" /> <br><br>' ;
  mensagem[1] = '<fmt:message key="uc56.dv01.texto.11" /><br><br>';
  mensagem[2] = '<fmt:message key="uc56.dv01.texto.12" /> <br><br>';
  mensagem[3] = '<fmt:message key="uc56.dv01.texto.13" /> <br><br>';
  mensagem[4] = '<fmt:message key="uc56.dv01.texto.14" /> <br><br>';
  mensagem[5] = '<fmt:message key="uc56.dv01.texto.15" /> <br><br>';
  mensagem[6] = '<fmt:message key="uc56.dv01.texto.16" /> <br><br>';
  mensagem[7] = '<fmt:message key="uc56.dv01.texto.17" /> <br><br>';
  mensagem[8] = '<fmt:message key="uc56.dv01.texto.18" /> <br><br>';
  mensagem[17] = '<fmt:message key="uc56.dv01.texto.19" /> <br><br>';
  
  // Mensagens alteradas por solicitação do email da Isabel
  // Manutenção:
  mensagem[18] = '<fmt:message key="uc56.dv01.texto.20" />';
  // Parado:
  mensagem[19] = '<fmt:message key="uc56.dv01.texto.21" />';

	 
  
  //MENSAGENS PARA A LAMPADINHA
  var htmlImage= "<img hspace='5' height='16'  width='16' src='${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png' />";
  
  mensagem[9]  = htmlImage + '<fmt:message key="uc56.dv01.texto.02" />';
  mensagem[10] = htmlImage + '<fmt:message key="uc56.dv01.texto.03" />';
  mensagem[11] = htmlImage + '<fmt:message key="uc56.dv01.texto.04" />';
  mensagem[12] = htmlImage + '<fmt:message key="uc56.dv01.texto.05" />';
  mensagem[13] = htmlImage + '<fmt:message key="uc56.dv01.texto.06" />';
  mensagem[14] = htmlImage + '<fmt:message key="uc56.dv01.texto.07" />';
  mensagem[15] = htmlImage + '<fmt:message key="uc56.dv01.texto.08" />';
  mensagem[16] = htmlImage + '<fmt:message key="uc56.dv01.texto.09" />';
  
  
</script>

        <c:if test="${not empty helper}" >
	      <script type="text/javascript">
		    openDefaultErroPage('${helper}');
	      </script>
        </c:if>
        
        <div class="container2"> 
	      <ol>
	      </ol>
        </div>	

        <div class="cabecalho4" style="padding-left: 100px;">
	      <a class="link_titleatualizacao tooltip" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC56/dv01"  title="Veículos sem atualização"><fmt:message key="label.veiculosSemAtualizacao" /></a>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  <a class="link_titleatualizacao tooltip" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC56/dv02" title="Histórico de Veículos sem Atualização"><fmt:message key="label.historicoVeiculosSemAtualizacao" /></a>
		  <div class="caminho" style="*margin-left:10px;" ><a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a>&gt; <a href="#" class="linktres"><fmt:message key="label.servicos" /></a> &gt; 
		    <a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC56/dv01"  class="linkquatro"><fmt:message key="label.veiculosSemAtualizacao" /></a>
		  </div>
	    </div>
        
        <c:if test="${not empty listaVeiculosDesatualizados}">
          <div class="busca_branca">
	        <span class="text1"><fmt:message key="uc56.dv01.texto.01" /></span> 
	      </div>

        <form id="formVeiculosDesatualizados" action="" method="post">
		  <table cellspacing="0" width="850" id="alter"  style="margin-left: 15px;">
			<tr>	
			    <th width="0" class="texttable_cinza"></th>		
				<th width="0" class="texttable_cinza"><fmt:message key="label.placa" /></th>				
				<th width="0" class="texttable_cinza"><fmt:message key="label.dataHoraUltimaAtualizacao" /></th>				
				<th width="0" class="texttable_cinza"><fmt:message key="label.enderecoUltimaAtualizacao" /></th>
				<th width="0" class="texttable_cinza"><fmt:message key="label.tipoContrato" /></th>				
			</tr>
			<tbody id="listaVeiculosAtualizacao">	
			  <c:forEach var="veiculo" items="${listaVeiculosDesatualizados}" >
			    <tr>			
			      <td><input type="checkBox" class="required" name="checkAtualizar[]" class="group1" onclick="habilitarComboMotivos();"></td>
			      <td>${veiculo.placa}</td>
			      <td><fmt:formatDate value="${veiculo.dataUltimaAtualizacao}" pattern="dd/MM/yyyy HH:mm"/></td>
			      <td>${veiculo.contrato.contratante.endereco.descricaoLogradouro}</td>
			      <td>${veiculo.contrato.tipoContrato }</td>
			      <td style="display:none;">${veiculo.codigo}</td>
			      <td style="display:none;">${veiculo.contrato.numeroContrato}</td>
		        </tr>		       
		     </c:forEach>		   		    
			</tbody>			
		</table>    
		<label>
		  <fmt:message key="label.Motivo" />:
		   <select name="codigoMotivo" id="codigoMotivo"  onChange="alternarMensagens(this.value)" class="required">
		   <option value=""><fmt:message key="label.selecione" /></option>
		   <c:if test="${not empty listaMotivosVeiculosDesatualizados}">
				   <c:forEach var="motivosVeiculosDesatualizados" items="${listaMotivosVeiculosDesatualizados}">
		        	 	   <option  value="${motivosVeiculosDesatualizados.descricaoMotivo};${motivosVeiculosDesatualizados.solicitaPrevisao};${motivosVeiculosDesatualizados.codigoMotivo}">${motivosVeiculosDesatualizados.descricaoMotivo}</option>
				   </c:forEach>
		   </c:if>  
		   </select>		  	
		</label>	
		
		<br><br>  
	   
	     <!-- MENSAGEM PARA MOTIVO -->
	     <span class="texthelp2" style="float:right; color:red;" id="mensagem_motivo"></span>
	     
	   
     
        <!-- COMBINAÇÃO DO MOTIVO ESCOLHIDO COM O TIPO DE CONTRATO -->  
	    <span class=""  style="margin-left:15px;color:red; float:left; width:350px;cdcdcd;font-size:11px; line-height:18px;background-color: FFFF99;" id="mensagem_motivo_escolhido"></span>
     
     
       
        
        <label id="previsao_saida" style="display:none;">
	       <span class="text2"><fmt:message key="label.previsaoDeSaida" />:</span>
	  	
	  	   <input type="text" name="dataInicial" id="dataInicial" readonly="readonly"  maxlength="10" value="${param.dataInicial}" />
           <br><br>
    
        </label>
          <span class=""  style="margin-left:15px;color: red;float:left; text-align:justify; width:350px;cdcdcd;font-size:11px;line-height:18px;background-color: FFFF99" id="mensagem_motivo_escolhido_manutencao_parado"></span>
   
      
        <br><br>
       <div style="clear: both; *margin-top: 50px;" >
	 	<div class="botoesatualizacao" style="margin-top:-65px;">  
          <input name="button1" type="submit" class="button" id="buttonAtualizar"  style="margin-left: 0px !important; " id="button3" value="<fmt:message key="label.atualizar" />"   />     
          <input name="button" type="button" class="button4" style="margin-left: 20px !important;"  id="buttonLimpar" value="<fmt:message key="label.limpar" />" onclick="resetFields();"/>
        </div>		
        </div>  
    </form>
 </c:if>    	
 <c:if test="${not empty mensagem}">
   <br>   
   <div class="busca_cinza" align="center"><b><fmt:message key="mensagem.informacao.naoHaVeiculosDesatualizados" /></b></div>
 </c:if>   
 
  <div id="dialog_mensagem_atualizado" class="popup_padrao" style="display: none;">        
			<div class="popup_padrao_pergunta"><fmt:message key="mensagem.sucesso.veiculosAtualizados" /></div>
		    <div class="popup_padrao_resposta">
			  <input name="" type="submit" class="button close" value="OK" onclick="window.location.reload();"/>
		    </div>
	</div>	
 