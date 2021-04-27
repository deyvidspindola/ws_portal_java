<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>
<c:catch var="helper" >
	<c:import url="/CriarRemessaEstoque/carregarCombos?acao=12" context="/SascarPortalWeb"  />
</c:catch>

<c:if test="${not empty mensagemInventario }">
	<script type="text/javascript">
				
			$.ajax({
				url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC42/dv05",
				data: {"errosValidacao" : "erros"},
				dataType:"html",
				success: function(html){
						
					$("#popupErrosValidacao").html(html).jOverlay({
						bgClickToClose : false, 
						closeOnEsc : false
						 
					});
					
					
				}
			});
			
	
	</script>
</c:if>

 
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
function fecha() {
window.close();
}

$(document).ready(function(){	
	
	$('#obs').not("[readonly]").not("[disabled]").not('.decimal').not('.nofilter').not('.number').keyup(function() {
		$(this).val(
			$(this).val().replace(/[^a-zA-Z0-9!()\[\].,:;?<>{}_ \-+=]/g, '')
		);
	});
	
	
	if($("#consultarTipoImobilizado").val() == "24"){		
		$("#produtoTipo").attr("disabled", '');		
	}
	
	$('textarea').limit('200','#left');
	
}); 
	

function setValues_Gerar_Remessa(){
	
	$.ajax({
		url: "/SascarPortalWeb/CriarRemessaEstoque/submeterRemessa&acao=6",
		data : {"acao" : 6},
		dataType : "json",	
		success: function(json){				
			if (json.success) {
				  $("#obgNotaficais").html(json.notaObrigatoria);
				 $("#numeroRemessa").html(json.numeroRemessa);
				 $("#remessaField").val(json.numeroRemessa);
				 $("#dialog_mensagem").jOverlay();
				 
	    	} else {
				$.showMessage(json.mensagem);
			}
		}
	});	
}



//** para campos gerados nas tabelas 
function SomenteNumero(e){
    var tecla=(window.event)?event.keyCode:e.which;   
    if((tecla>47 && tecla<58)) return true;
    else{
    	if (tecla==8 || tecla==0) return true;
	else  return false;
    }
}

function get_Table_Values_Imobilizados() {
	//*
	var string = "";
	
	$('#tbodyImobilizados tr').each(function(i, linha) {
	
		//adiciona ao evento click do botao para retornar a coluna desejada		
	    string += 	$(this).find('td:eq(0)').text()+";"+ $(this).find('td:eq(1)').text()+";"+ $(this).find('td:eq(2)').text()+";"+$(this).find('td:eq(3)').text()+";"+$(this).find('td:eq(4)').text()+";"+$(this).find('td:eq(5)').text()+";"+$(this).find('td:eq(6)').text()+"@";
    });	
   return string;
}


////*** Recolhe os valores incluídos na tabela imobilizado
function get_Table_Values_Imobilizados_Incluidos() {
	//*
	var string = "";
	
	$('#tbodyImobilizadosIncluidos tr').each(function(i, linha) {
		
		if (!$(this).hasClass('ignore')) {
	      string += 	$(this).find('td:eq(0)').text()+";"+ $(this).find('td:eq(1)').text()+";"+ $(this).find('td:eq(2)').text()+";"+$(this).find('td:eq(3)').text()+";"+$(this).find('td:eq(4)').text()+";"+$(this).find('td:eq(5)').text()+";"+$(this).find('td:eq(6)').text()+";"+$(this).find('td:eq(7)').find('input').val()+"@";
		}
		 
	});	
	
   return string;	
	
}	

////*** Recolhe os valores incluídos na tabela materiais
function get_Table_Values_Materiais_Incluidos() {
	
	var string = "";
	var size = $(this).find('td[colspan]').length; 	
	
	$('#tbodyMateriais tr').each(function(i, linha) {	
		if (!$(this).hasClass('ignore')) {
	      string += 	$(this).find('td:eq(0)').text()+";"+ $(this).find('td:eq(1)').text()+";"+ $(this).find('td:eq(2)').text()+";"+$(this).find('td:eq(3)').text()+"@";
		}
	
	});	
	
   return string;	
	
}	

function limpa_asterisco_campo_obrigatorio(){
	
   	  $("#asterisco_remetente_representante").html("");			  
	  $("#asterisco_destinatario_representante").html("");			   
	  $("#asterisco_destinatario_representante_estoque").html(""); 
 	  $("#tipo_produto").html(""); 
	  $("#tipo_movimentacao").html(""); 
	  $("#quantidade_volumes").html("");
	  
}

function setValues(){	
	
	

	
	var imobilizadosIncluidos     = get_Table_Values_Imobilizados_Incluidos();
	var materiaisIncluidos        = get_Table_Values_Materiais_Incluidos();
	
	var nomeRepresentanteResp     = $("#listarRepresentanteEstoque option:selected").text();
	var nomeRepresentanteRespDest = $("#representanteResponsavelDestinatarioId option:selected").text();
	var nomeRepresentanteRespDestE= $("#representanteEstoqueDestinatario option:selected").text();
	var tipoMovimentacao          = $("#tipoMovimentacao option:selected").text();
	var tipoProduto               = $("#tipoProduto option:selected").text();
	var transportadora            = $("#transportadoras option:selected").text();
	var quantidadeVolumes         = $("#qtddeVol").val();
	var nfRemessa				  = $("#nfRemessa").val();
	var observacao                = $("#obs").val();
	var itemImobilizado           = $("#consultarTipoImobilizado option:selected").text();
	var representanteResp         = $("#representanteResp").val();
	
	//*** IDS
	var idRepresentanteResp     =  $("#listarRepresentanteEstoque").val();
	var idRepresentanteRespDest =  $("#representanteResponsavelDestinatarioId").val();
	var idRepresentanteRespDestE= $("#representanteEstoqueDestinatario").val();
	var idTipoMovimentacao          = $("#tipoMovimentacao").val();
	var idTipoProduto               = $("#tipoProduto").val();
	var idTransportadora            = $("#transportadoras").val();
	var idTipoImobilizado         =  $("#consultarTipoImobilizado").val();	
	
	
	
	
    if((imobilizadosIncluidos != "" || materiaisIncluidos != "") && idRepresentanteResp != "" && idRepresentanteRespDest != "" && idRepresentanteRespDestE != "0" && idTipoProduto  != "" && idTipoMovimentacao != "0" && quantidadeVolumes != "" && idTransportadora !="0"){
    	
    
    	var Ii = imobilizadosIncluidos.replace(";;;",";;");
	
	$.ajax({
		"url": "/SascarPortalWeb/CriarRemessaEstoque/carregarDadosTela2",
		"data" : { "imobilizadosIncluidos":Ii,
			       "materiaisIncluidos":materiaisIncluidos, 
			       "nomeRepresentanteResp":nomeRepresentanteResp,
			       "nomeRepresentanteRespDest":nomeRepresentanteRespDest,
			       "nomeRepresentanteRespDestE":nomeRepresentanteRespDestE,
			       "tipoMovimentacao":tipoMovimentacao,
			       "tipoProduto":tipoProduto,
			       "transportadora":transportadora,
			       "quantidadeVolumes":quantidadeVolumes,
			       "observacao":observacao,	
			       "idRepresentanteResp":idRepresentanteResp,	
			       "idRepresentanteRespDest":idRepresentanteRespDest,
			       "idRepresentanteRespDestE":idRepresentanteRespDestE,
			       "idTipoMovimentacao":idTipoMovimentacao,
			       "idTipoProduto":idTipoProduto,
			       "idTransportadora":idTransportadora,
			       "itemImobilizado":itemImobilizado,
			       "idTipoImobilizado":idTipoImobilizado,	
			       "representanteResp":representanteResp,
			       "nfRemessa":nfRemessa,		      
			       "acao" : 11},
		"dataType" : "json",	
		"success": function(json){				
			if (json.success) {	
				// Atribuindo valores para as divs que irão exibir o resumo
				// Remetente				
				$("#representanteResponsavel_div2").html(nomeRepresentanteResp);
				
				//Destinatário
				$("#representanteResponsavelDestinatario_div2").html(nomeRepresentanteRespDest);
				$("#representanteResponsavelDestinatarioEstoque_div2").html(nomeRepresentanteRespDestE);
				
				//// Dados Remessa
				$("#tipoMovimentacao_div2").html(tipoMovimentacao);
				$("#tipoProduto_div2").html(tipoProduto);
				$("#transportadora_div2").html(transportadora);
				$("#quantidade_div2").html(quantidadeVolumes);
				$("#quantidade_div2_nf").html(nfRemessa);
				$("#observacao_div2").html(observacao);
				
				/// Esconder ou mostrar as divs: simular mudanças entre div1 e div2
				 $("#remetente_div1").hide();
				 $("#destinatario_div1").hide();
				 $("#dados_remessa_div1").hide();
				 $("#botao_incluir_remessa_imobilizado").hide();
				 $("#button_remessa").hide();
				 $("#buttonR").hide();				 
				 
				 ///Listas imobilizados e materiais
				 $("#lista_imobilizados_div1").hide();
				 $("#selecao_materiais_div1").hide();
				
				 $("#headar_tabelaImobilizadosAdicionados th:nth-child(7)").hide();
				 $("#tbodyImobilizadosIncluidos tr td[colspan=7]").attr('colspan', 6);
				 $("#tbodyImobilizadosIncluidos tr td:nth-child(7)").hide();
				
				 $("#headar_tabelaMateriaisAdicionados th:nth-child(3)").hide();
				 $("#tbodyMateriais tr td:nth-child(3)").hide();
				 				 
				 $("#headar_tabelaMateriaisAdicionados th:nth-child(5)").hide();
				 $("#tbodyMateriais tr td[colspan=5]").attr('colspan', 4);
				 $("#tbodyMateriais tr td:nth-child(5)").hide();
				 
				 
				 $("#remetente_div2").show();
				 $("#destinatario_div2").show();
				 $("#dados_remessa_div2").show();
				 
				 $("#mensagem").html("");
				 				 
				 $("#button_limpar").hide();
				 $("#button_continuar").hide();
				 $("#botoes_div2").show();
				 
				 $("#mensagem_material").html("");
				
				 
				 //Esconde  a tabela imobilizado da div 1 com o botão excluir 
				 // e mostra a tabela da div 2 sem o botão excluir
				// $("#imobilizados_inc_div1").hide();
				// $("#imobilizados_incluidos_DIV2").show();
				 //incluirItensLista_DIV2();
				
				 
				 //Esconde  a tabela MATERIAIS da div 1 com o botão excluir 
				 // e mostra a tabela da div 2 sem o botão excluir
				//  $("#materiais_incluidos_div1").hide();
				// $("#materiais_incluidos_div2").show();
				 //materiaisIncluirRemessaDIV2();
				 
				 resizeIframeParent();
				
				
	        	//window.location.href = "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC42/dv01";		        	
	    	} else {
				$.showMessage(json.mensagem);
			}
		}
	});	
  }else{
	  
	  
	  if(materiaisIncluidos == "" && imobilizadosIncluidos == ""){
	     $("#mensagem").html('<div style="color:#C00;"><b><fmt:message key="mensagem.campoObrigatorio.deveSerIncluidoEquipamentoMaterial" /></b></div>');
      }
	  if(idRepresentanteResp == "" || idRepresentanteRespDest == "0" || idRepresentanteRespDestE == "0" || idTipoProduto  == "" || tipoMovimentacao == "0" || quantidadeVolumes == ""){
		 
          if(idRepresentanteResp == ""){
        	  $("#asterisco_remetente_representante").html("<div style='color:red;'><b>*</b></div>");			  
		  }
		  if(idRepresentanteRespDest == "0"){
			  $("#asterisco_destinatario_representante").html("<div style='color:red;'><b>*</b></div>");			   
		  }
          if(idRepresentanteRespDestE == "0"){
        	  $("#asterisco_destinatario_representante_estoque").html("<div style='color:red;'><b>*</b></div>"); 
      	  }
          if(idTipoProduto == ""){
        	  $("#tipo_produto").html("<div style='color:red;'><b>*</b></div>"); 
		  }
          if( idTipoMovimentacao == "0"){
        	  $("#tipo_movimentacao").html("<div style='color:red;'><b>*</b></div>"); 
		  }
          if(quantidadeVolumes == ""){
        	  $("#quantidade_volumes").html("<div style='color:red;'><b>*</b></div>");
		  }
		  $("#mensagem").html('<div style="color:#C00;"><b><fmt:message key="mensagem.campoObrigatorio.naoPreenchidos" /></b></div>');
	  }
	  
	      resizeIframeParent();
  }
}


/////******************       ITENS IMOBILIZADOS   ***********************************************///

///////////    Consultar a lista Imobilizados retornando numa lista
function carregarListaImobilizado(codigoImobilizado, representanteEstDestinatario){	
	
	var tipoProduto = "";	
	//produto: Quando é selecionado o item "Outros (Código 24)", é habilitada a combobox produtos
	var produto ="";
	//código Imobilizado: é o código do imobilizado da primeira combobox Imobilizado.
	var codImobilizado="";
	
	//código representante
	var representanteEstoque =   $("#listarRepresentanteEstoque").val();
	
	var  tipoImobilizado = $("#consultarTipoImobilizado").val();	
		
	//tipo Imobilizado
	tipoProduto =  $("#tipoProduto").val();
	
	if($("#consultarTipoImobilizado").val() == "24" && representanteEstDestinatario != "procurar"){
		$("#produtoTipo").attr("disabled", '');	
		
		
		if (codigoImobilizado == '') {
			$("option[value!='']","#produtoTipo").remove();
			return;
		}

		var selectImobilizado = $('#produtoTipo')[0];
	
		
		 $.ajax({
				"url": "/SascarPortalWeb/CriarRemessaEstoque/consultarImobilizadoOutros",
				"data" : { "codigoImobilizado": codImobilizado,"tipoProduto": tipoProduto,"representanteEstoque":representanteEstoque,"produto" : produto, "acao" : 13 },
				"dataType" : "json",
				"beforeSend": function(){
					$("option[value!='']","#produtoTipo").remove();
				},
				"success": function(json){				
					if (json.success) {
						$.each(json.produtoTipo, function(i, produtoTipos){
							var option = new Option(produtoTipos.value, produtoTipos.id);									
							if ($.browser.msie) {
								selectImobilizado.add(option);
							} else {
								selectImobilizado.add(option,null);
							}
						});					
					} else {
						remover_linhas_tabela_imobilizados_itens("#tbodyImobilizados tr"); 
						resizeIframeParent();
						$.showMessage(json.mensagem);
					}
				}
			  });		
	}else{		
		produto = $("#produtoTipo").val();
		codImobilizado = $("#consultarTipoImobilizado").val();
		
		
		if($("#consultarTipoImobilizado").val() != "24"){
		  $('#produtoTipo option:first-child').attr("selected", "selected");
		}
		$("#produtoTipo").attr("disabled", 'disabled');	
		
	
	  $.ajax({
		"url": "/SascarPortalWeb/CriarRemessaEstoque/consultarImobilizadoRepresentante",
		"data" : { "codigoImobilizado": codImobilizado,"tipoProduto": tipoProduto,"representanteEstoque":representanteEstoque,"produto" : produto, "acao" : 7 },
		"dataType" : "json",	
		"success": function(json){				
			if (json.success) {		
				  //esta função atualiza a tabela para que sejam exibidos apenas os resultados da consulta pelo combobox
				  remover_linhas_tabela_imobilizados('#tbodyImobilizados tr');
				  $("#headar_tabelaImobilizados").removeClass("invisivel").addClass("visivel");
				  $("#tbodyImobilizados").removeClass("invisivel").addClass("visivel");
				  
				  if($("#consultarTipoImobilizado").val() == "24" ){
				     $("#produtoTipo").attr("disabled", '');
				     codigoImobilizado = 24;
				  }
				  
				  $.each(json.listaProdutos,function(i, listaProduto) {						 
					  listaImobilizadosRepresentante_tabela(listaProduto.codigo,listaProduto.serieImobilizado, listaProduto.descricaoItemImobilizado, listaProduto.codigoModeloImobilzado, listaProduto.versaoImobilizado, listaProduto.modeloImobilizado, listaProduto.statusImobilizado,codigoImobilizado);
				  });		  

				  resizeIframeParent();
				  
			} else {
				remover_linhas_tabela_imobilizados_itens("#tbodyImobilizados tr"); 		
				$.showMessage(json.mensagem);
			}
		}
	  });
   }
}


////   Esta função inclui os itens correspondentes selecionados do combobox na tabela 
function listaImobilizadosRepresentante_tabela(codigo, serie, descricao, codigoModeloImobilizado, versao, modeloImobilizado, statusImobilizado, codigoImobilizado) {	

	$("#checkbox_m").attr('checked','');

	$("#headar_tabelaImobilizados").removeClass("invisivel").addClass("visivel");
	
    var diffClass = $("#tbodyImobilizados tr:last").hasClass("dif") ? '' : 'dif';
			
	  var html = "<tr class='"+diffClass+"'>"
	                + "<td class='camposinternos'>"+ "<input id='checkbox' type='checkbox'  name='checkbox1[]'>" + "</td>"
	             	+ "<td class='camposinternos'>"+ serie + "</td>"
					+ "<td class='camposinternos'>"+ codigo +"</td>"
					+ "<td class='camposinternos'>"+ descricao+ "</td>"
					+ "<td class='camposinternos'>"+ versao + "</td>"
					+ "<td class='camposinternos'>"+  modeloImobilizado + "</td>"
					+ "<td class='camposinternos'>"+  statusImobilizado + "</td>"
					+ "<td class='camposinternos' style='display:none' ><input type='hidden' value="+  codigoImobilizado + "></td>"
				+ "</tr> <div style='clear:both'>";
				

	$("#tbodyImobilizados").append(html);
	
	 resizeIframeParent();

}


/////*****   inclui os itens  selecionados na lista
function  incluirItensLista(){	
	
	  var found="";
	  var codigoProduto="";
	  var codigo ="";
	  var html ="";
	  var html1 ="";
      var flag="S";               
	            
                $('#tbodyImobilizados tr').each(function(i, linha) {             	
	            	
    			     var diffClass = $("#tbodyImobilizadosIncluidos tr:last").hasClass("dif") ? '' : 'dif';
    			     
    			     codigo      =    $(this).find('td:eq(1)').text();
    			        
    			     $('#tbodyImobilizadosIncluidos tr').each(function(i, linha) {   			    	 
         			     codigoProduto = $(this).find('td:eq(0)').text();         			    
         			     if (codigoProduto == codigo){
         			    	 found ="sim";
         			    	$("#mensagem_imobilizado").html("<p style='color:red;'>Item já incluído</p>");
         			     }         			     
         			 });    			       
    			       
    			     var chkbox = $(this).find("td:eq(0) input[type='checkbox']"); 
     			     
    			     if (chkbox.is(':checked') == true &&  found != "sim"){   
    			    	 
    			    	var consultarTipoImobilizadoS = $("#produtoTipo option:selected").text();
    			    	var consultarTipoImobilizadoId = $("#produtoTipo").val();
    			    	var consultarTipoImobilizadoId2 = $("#consultarTipoImobilizado").val();
    			    	var rel = consultarTipoImobilizadoId2 + '-' + consultarTipoImobilizadoId;
    		          if(flag=="S"){
    		        	if(consultarTipoImobilizadoS!="<fmt:message key="label.selecione" />" ){  
    		           	  html1="<tr rel='" + rel + "' class='ignore'><td colspan='7' style='background-color:#cdcdcd; border:1px;' class='"+diffClass+"'><b>"+ $("#consultarTipoImobilizado option:selected").text()+" - "+$("#produtoTipo option:selected").text()+"</b></td></tr>"; 
    		        	  }else{
    		        		  html1="<tr rel='" + rel + "' class='ignore'><td colspan='7' style='background-color:#cdcdcd; border:1px;' class='"+diffClass+"'><b>"+ $("#consultarTipoImobilizado option:selected").text()+"</b></td></tr>";   
    		        	  }
    		        	}else{
    		           	  html1="<tr rel='" + rel + "' class='ignore'><td colspan='7' style='background-color:white; border:0px;' class='"+diffClass+"'></td></tr>"; 
    		          } 		            	
    		          flag = "N";
    		          if ($("#tbodyImobilizadosIncluidos tr[rel=" + rel + "]").length == 0) {
    		          	$("#tbodyImobilizadosIncluidos").append(html1);
    		          }
    		          
    			 	   html = "<tr class='"+diffClass+"' rel='" + rel + "'>"    			 	           
    			 	                //+  html1
    								+ "<td class='camposinternos'>"+ $(this).find('td:eq(1)').text() +"</td>"
    								+ "<td class='camposinternos'>"+ $(this).find('td:eq(2)').text()+ "</td>"
    								+ "<td class='camposinternos'>"+ $(this).find('td:eq(3)').text()+ "</td>"
    								+ "<td class='camposinternos'>"+ $(this).find('td:eq(4)').text()+ "</td>"
    								+ "<td class='camposinternos'>"+ $(this).find('td:eq(5)').text()+ "</td>"
    								+ "<td class='camposinternos'>"+ $(this).find('td:eq(6)').text()+ "</td>"
    								+ "<td class='camposinternos'>"
									+ "<a href='#tbodyImobilizadosIncluidos' onclick='removerItem(this);'>"
										+ "<img src='${pageContext.request.contextPath}/sascar/images/corporativo_new/excluir16-10.png' width='16' height='16' border='0' align='absmiddle' />"
									+ "</a>"
									+ "</ttbodyImobilizadosIncluidosd>"
									+ "<td class='camposinternos' style='background-color:white;border:1px white;'><input type='hidden' value='" + $(this).find('td:eq(7)').find('input').val()+ "'></td>"
    								
								//+ "</td>"
    							+ "</tr>";
    							if(codigo !=""){	
    							   $("#headar_tabelaImobilizadosAdicionados").removeClass("invisivel").addClass("visivel");
    			    			   $("#headar_tituloImobilizadosAdicionados").removeClass("invisivel").addClass("visivel");
    			                   $("#tbodyImobilizadosIncluidos tr[rel=" + rel + "]").last().after(html);
    							} 
    				     remover_linhas_tabela_imobilizados_itens("tbodyImobilizadosIncluidos tr");		
    			     }
    			html1="";     
    			found=""; 
    			codigoProduto="";
    			codigo="";
   	  	});	 
	            resizeIframeParent();          
}

////////////////////////////////////////////////////////////

///******  FUNÇÕES DE MANUTENÇÃO DAS TABELAS ///////
  function refreshClassDif() {
	
	// VARIAVEL USADA PARA CONTROLAR SE A TABELA DE PLACAS PARA PESQUISA POSSUI VALORES.
	var numLinhasTabela = 0;
	
	$("#tbodyMateriais tr").each(function(i){
		
		numLinhasTabela  = numLinhasTabela + 1; 
		
		if ((i % 2 == 0)) {
			$(this).addClass('dif');
		} else {
			$(this).removeClass('dif');
		}
	});
	
	// SE NÃO POSSUIR VALORES NA TABELA, REMOVER O CABEÇALHO E BLOQUEAR SUBMIT.
	// EXCETO SE O CHECKBOX 'BUSCAR TODOS'  NÃO ESTIVER SELECIONADO.
	if(numLinhasTabela == 0){
		$("#headar_tabelaMateriaisAdicionados").removeClass("visivel").addClass("invisivel");
	}
  }


 function enable(elemen){	
	 
	 var elem = $(elemen);
		elem.parents('tr').find("td:eq(0) input[type='checkbox']");
		if(elem.parents('tr').find("input[type='text']").attr('disabled')){
			
		  elem.parents('tr').find("input[type='text']").attr("disabled", '');
        }else{
          elem.parents('tr').find("input[type='text']").val('0');	
          elem.parents('tr').find("input[type='text']").attr("disabled", 'disabled');
        }
		refreshClassDif();
 }
 
 
 
 
  function remover_cabecalhos(){
	  
	  var string ="";
	  var stringMateriais="";
		$('#tbodyImobilizadosIncluidos tr').each(function(i, linha) {				
		    string += 	$(this).find('td:eq(0)').text()+";"+ $(this).find('td:eq(1)').text()+";"+ $(this).find('td:eq(2)').text()+";"+$(this).find('td:eq(3)').text()+";"+$(this).find('td:eq(4)').text()+";"+$(this).find('td:eq(5)').text()+";"+$(this).find('td:eq(6)').text()+";"+$(this).find('td:eq(7)').find('input').val()+"@";
	    });
		
	   
		if(string ==""){
			  $("#headar_tituloImobilizadosAdicionados").removeClass("visivel").addClass("invisivel");
			  $("#headar_tabelaImobilizadosAdicionados").removeClass("visivel").addClass("invisivel");
		}
		
		
		$('#tbodyMateriais tr').each(function(i, linha) {				
			stringMateriais += 	$(this).find('td:eq(0)').text()+";"+ $(this).find('td:eq(1)').text()+";"+ $(this).find('td:eq(2)').text()+";"+$(this).find('td:eq(3)').text()+";"+$(this).find('td:eq(4)').text()+";"+$(this).find('td:eq(5)').text()+";"+$(this).find('td:eq(6)').text()+";"+$(this).find('td:eq(7)').find('input').val()+"@";
	    });
		
	   
		if(stringMateriais ==""){
			  $("#headar_tituloMateriaisAdicionados").removeClass("visivel").addClass("invisivel");
			  $("#headar_tabelaMateriaisAdicionados").removeClass("visivel").addClass("invisivel");
		}
	  
  }


  function removerItem(element){
	    var elem = $(element);
	    var table = elem.parents('table');
	    var id = elem.parents('tr').attr('rel');
	    
		elem.parents('tr').remove();
		
		if ($('tr[rel=' + id + ']', table).length == 1) {
			$('tr[rel=' + id + ']', table).remove();
		}
		
		refreshClassDif();
		//Caso não haja mais nenhum item, o cabeçalho e título são removidos.
		remover_cabecalhos();
		
  }
  
  function remover_linhas_tabela_imobilizados(tabela){		
	 
		$(tabela).each(function(i, linha) {			 
			 $(this).find('td:eq(6)').remove();
			 $(this).find('td:eq(5)').remove();
			 $(this).find('td:eq(4)').remove();	    			    
			 $(this).find('td:eq(3)').remove();
			 $(this).find('td:eq(2)').remove();	    			    
			 $(this).find('td:eq(1)').remove();
			 $(this).find("td:eq(0)").remove(); 
		   
    	});	  
  } 
  

  function remover_linhas_tabela_materiais(tabela){		
		
		$(tabela).each(function(i, linha) {			 
			 $(this).find('td:eq(4)').remove();	    			    
			 $(this).find('td:eq(3)').remove();
			 $(this).find('td:eq(2)').remove();	    			    
			 $(this).find('td:eq(1)').remove();
			 $(this).find("td:eq(0)").remove(); 
		   
  	});
} 

  
  function remover_linhas_tabela_materiais_itens(tabela){		
		
		$(tabela).each(function(i, linha) {			 
			 $(this).find('td:eq(4)').remove();	    			    
			 $(this).find('td:eq(3)').remove();
			 $(this).find('td:eq(2)').remove();	    			    
			 $(this).find('td:eq(1)').remove();
			 $(this).find("td:eq(0)").remove(); 
		   
 	});	 
		
	 $("#headar_tabelaPlacasAdicionadas").removeClass("visivel").addClass("invisivel");
	 $("#tbodyPlacas").removeClass("visivel").addClass("invisivel");	
} 
 
  function remover_linhas_tabela_imobilizados_itens(tabela){		
		 
		$(tabela).each(function(i, linha) {			 
			 $(this).find('td:eq(6)').remove();
			 $(this).find('td:eq(5)').remove();
			 $(this).find('td:eq(4)').remove();	    			    
			 $(this).find('td:eq(3)').remove();
			 $(this).find('td:eq(2)').remove();	    			    
			 $(this).find('td:eq(1)').remove();
			 $(this).find("td:eq(0)").remove(); 
		   
  	});	 
		
		 $("#headar_tabelaImobilizados").removeClass("visivel").addClass("invisivel");
		 $("#tbodyImobilizados").removeClass("visivel").addClass("invisivel");		
}  
 
  
  
  
  function MarcarTodosCheckbox(){	 
	  
	if (jQuery('#checkbox_m').attr('checked')==true){
		
		$("input[name='checkbox1[]']").each(function(){			
				$(this).attr("checked", "checked");			
		});
		
	}else{
		$("input[name='checkbox1[]']").each(function(){			
				$(this).removeAttr("checked");					
		});
	}  
	
  }
  
  function  MarcarTodosCheckbox_materiais(){ 
	  
	  if (jQuery('#checkbox_n').attr('checked')==true){
			
			$("input[name='checkbox[]']").each(function(){	
				
				    $(this).parents('tr').find('td:eq(4)').find('input').attr('disabled', '');				    
					$(this).attr("checked", "checked");			
			});
			
		}else{
			
			$("input[name='checkbox[]']").each(function(){	
				    $(this).parents('tr').find('td:eq(4)').find('input').val('0');	
				    $(this).parents('tr').find('td:eq(4)').find('input').attr('disabled', 'disabled');				    
					$(this).removeAttr("checked");					
			});
		}	
  }  
  
//************************////
  
  function materiaisIncluirRemessa(){ 
      var found="";
	  var codigoProduto="";
	  var codigo ="";
	  var html1="";
	  var flag="S";
	         
	  $("#mensagem_material").html("");
	  
     		  $('#tbodyPlacas tr').each(function(i, linha) {     			    
     			 
     	     		
     			     var diffClass = $("#tbodyMateriais tr:last").hasClass("dif") ? '' : 'dif';
     			     
     			        codigo      =    $(this).find('td:eq(1)').text();
     			 
     			      
     			     $('#tbodyMateriais tr').each(function(i, linha) {           				  
          			     codigoProduto = $(this).find('td:eq(0)').text();           			    
          			  
          			     if (codigoProduto == codigo){
          			    	 found ="sim";         			    	 
          			     }
          			     
          			 });    			       
     			       
     			     var chkbox = $(this).find("td:eq(0) input[type='checkbox']");      			          			      
     			      
     			     if (chkbox.is(':checked') == true &&  found != "sim"){
     			     
     			   //Regra adicionada por causa do mantis 7322
     			     if($(this).find('td:eq(4)').find('input').val() != ''){
     			     	if($(this).find('td:eq(3)').text() != ''){
     			     	var qtdaRemetente = parseInt($(this).find('td:eq(3)').text());
     			     	var qtdaEnvio = parseInt($(this).find('td:eq(4)').find('input').val());
     			     	  if(qtdaRemetente < qtdaEnvio){
     			     	  	alert("A Qtde de Envio \u00e9 maior que a Qtde em Estoque.");
     			     	  	return false;
     			     	  }
     			     	}
     			     }
     			 
     			     
     			    	 var consultarSubGrupoMaterialId = $("#consultarSubGrupoMaterial").val();
     			    	 
     			    	 
     			    	 
     			          if(flag=="S"){
     			        	
        		           	  html1="<tr rel='" + consultarSubGrupoMaterialId + "' class='ignore'><td colspan='5' style='background-color:#cdcdcd; border:0px;' class='"+diffClass+"'><b>"+  $("#consultarSubGrupoMaterial option:selected").text()  +"</b></td></tr>"; 
     			            
     			         }else{
     			           	    html1="<tr rel='" + consultarSubGrupoMaterialId + "' class='ignore'><td colspan='5' style='background-color:white; border:0px;' class='"+diffClass+"'></td><tr>"; 
        		        	 
        		       	 } 		            	
        		         
     			         if($(this).find('td:eq(4)').find('input').val() == "0"  || $(this).find('td:eq(4)').find('input').val() == ""){
     			        	html1="";
     			         }
     			          
     			          flag = "N";  			    	 
 
        		          if ($("#tbodyMateriais tr[rel=" + consultarSubGrupoMaterialId + "]").length == 0) {
          		          	$("#tbodyMateriais").append(html1);
          		          }
    			    	 
     			    	 
     			 	  var html = "<tr class='"+diffClass+"' rel='" + consultarSubGrupoMaterialId + "'>" 
     			 	                //+ html1
     								+ "<td class='camposinternos'>"+ $(this).find('td:eq(1)').text() +"</td>"
     								+ "<td class='camposinternos'>"+ $(this).find('td:eq(2)').text()+ "</td>"
     								+ "<td class='camposinternos'>"+ $(this).find('td:eq(3)').text()+ "</td>"
     								+ "<td class='camposinternos'>"+ $(this).find('td:eq(4)').find('input').val()+ "</td>"
     								+ "<td class='camposinternos'>"
									+ "<a href='#headar_tabelaMateriaisAdicionados' onclick='removerItem(this);'>"
										+ "<img src='${pageContext.request.contextPath}/sascar/images/corporativo_new/excluir16-10.png' width='16' height='16' border='0' align='absmiddle' />"
									+ "</a>"
								+ "</td>"
     							+ "</tr></div>";
     							
     			 	       if($(this).find('td:eq(4)').find('input').val() == "0"  || $(this).find('td:eq(4)').find('input').val() == ""){
     			 	    	   //$(this).find(' td:eq(0)').remove();
     			 	    	   $("#mensagem_material").html('<font color=red><fmt:message key="mensagem.informacao.quantidadeMaterialInvalida" /></font>');
						    }else{ 
     							if(codigo !=""){
     							  $("#headar_tabelaMateriaisAdicionados").removeClass("invisivel").addClass("visivel");
     			     			  $("#headar_tituloMateriaisAdicionados").removeClass("invisivel").addClass("visivel");     			     			 
     			     			  $("#tbodyMateriais tr[rel=" + consultarSubGrupoMaterialId + "]").last().after(html);
     			     			  
     							}
     							  
     							     							
						    }    
     			 	   //  remover_linhas_tabela_materiais_itens("#tbodyPlacas tr"); 
     			     }
     			      
     			html1="";    
     			found=""; 
     			codigoProduto="";
     			codigo="";
    	  	});	
     		
     		 resizeIframeParent();
     		 
  }
 
 function carregarConsultarEstoqueMateriais(codigoMaterial, representanteEstDestinatario) {		
	var tipoProduto =  $("#tipoProduto").val();
	var representanteEstoque =   $("#representanteEstoqueDestinatario").val();
	
	$.ajax({
		"url": "/SascarPortalWeb/CriarRemessaEstoque/consultarEstoqueMateriais",
		"data" : { "codigoMaterial": codigoMaterial,"tipoProduto": tipoProduto,"representanteEstoque":representanteEstoque, "acao" : 2 },
		"dataType" : "json",	
		"success": function(json){				
			if (json.success) {
				
				//atualiza a tabela de materiais, preprarando para receber novos valores conforme selecionado na combo
				remover_linhas_tabela_materiais("#tbodyPlacas tr"); 
				 
				 $("#headar_tabelaPlacasAdicionadas").removeClass("invisivel").addClass("visivel");
				 $("#tbodyPlacas").removeClass("invisivel").addClass("visivel");	
				
				  $.each(json.listaEstoqueMateriaisRepr,function(i, listaEstoqueMateriaisRep) {
					  listaEstoqueMateriais_tabela(listaEstoqueMateriaisRep.codigo,listaEstoqueMateriaisRep.descricao, listaEstoqueMateriaisRep.quantidadeEstoque, listaEstoqueMateriaisRep.quantidadeStatusTransito);						
				  });	
				  
				  resizeIframeParent();
				  
			} else {
				remover_linhas_tabela_materiais_itens("#tbodyPlacas tr"); 				
				$.showMessage(json.mensagem);
			}
		}
	});
}


 function listaEstoqueMateriais_tabela(codigo, descricao, quantidadeEstoque, quantidadeStatusTransito) {
	 
	 $("#checkbox_n").attr('checked','');
	
	$("#headar_tabelaPlacasAdicionadas").removeClass("invisivel").addClass("visivel");
	
	     var diffClass = $("#tbodyPlacas tr:last").hasClass("dif") ? '' : 'dif';
				
	 	  var html = "<tr class='"+diffClass+"'>"
	 	                + "<td class='camposinternos'>"+ "<input id='checkbox' type='checkbox' onclick='enable(this)' name='checkbox[]'>" + "</td>"
	 	             	+ "<td class='camposinternos'>"+ codigo + "</td>"
						+ "<td class='camposinternos'>"+ descricao +"</td>"
						+ "<td class='camposinternos'>"+ quantidadeEstoque+ "</td>"
						+ "<td class='camposinternos'><div style='display:none;'>"+ quantidadeStatusTransito + "</div><input id='' class='quantidade' disabled='disabled' onkeypress='return SomenteNumero(event)' class='required number' type='text' maxlength='5' value='"+0+"' name='' style='width: 220px;'>"+"</td>"
					+ "</tr>  <div style='clear:both'></div>";

		$("#tbodyPlacas").append(html);
}	

 function carregarConsultarImobilizadoRepresentante(codigoImobilizado, representanteEstDestinatario) {	
		
		if (codigoImobilizado == '') {
			$("option[value!='']","#consultarTipoImobilizado").remove();
			return;
		}

		var selectImobilizado = $('#consultarTipoImobilizado')[0];
		
		$.ajax({
			"url": "/SascarPortalWeb/CriarRemessaEstoque/consultarImobilizadoRepresentante",
			"data" : { "codigoImobilizado": codigoImobilizado, "acao" : 7 },
			"dataType" : "json",
			"beforeSend": function(){
				$("option[value!='']","#consultarTipoImobilizado").remove();
			},
			"success": function(json){				
				if (json.success) {
					$.each(json.listaRepresentanteEstoqueDestinatarios, function(i, listaRepresentanteEstoqueDestinatario){
						var option = new Option(listaRepresentanteEstoqueDestinatario.value, listaRepresentanteEstoqueDestinatario.id);
						
						if ($.browser.msie) {
							selectImobilizado.add(option);
						} else {
							selectImobilizado.add(option,null);
						}
					});					
				} else {
					$.showMessage(json.mensagem);
				}
			}
		});
	}	

function carregarRepresentanteEstoque(codigoRepreRespDest, representanteEstDestinatario) {	
	
		if (codigoRepreRespDest == '') {
			$("option[value!='']","#representanteEstoqueDestinatario").remove();
			return;
		}

		var selectrepresentanteEstoqueDestinatario = $('#representanteEstoqueDestinatario')[0];

		$.ajax({
			"url": "/SascarPortalWeb/CriarRemessaEstoque/listarRepresentanteEstoqueDestinatario",
			"data" : { "codigoRepresentanteRespDestinatario": codigoRepreRespDest, "acao" : 4 },
			"dataType" : "json",
			"beforeSend": function(){
				$("option[value!='']","#representanteEstoqueDestinatario").remove();
			},
			"success": function(json){				
				if (json.success) {
					$.each(json.listaRepresentanteEstoqueDestinatarios, function(i, listaRepresentanteEstoqueDestinatario){
						var option = new Option(listaRepresentanteEstoqueDestinatario.value, listaRepresentanteEstoqueDestinatario.id);
						
						if ($.browser.msie) {
							selectrepresentanteEstoqueDestinatario.add(option);
						} else {
							selectrepresentanteEstoqueDestinatario.add(option,null);
						}
					});					
				} else {
					$.showMessage(json.mensagem);
				}
			}
		});
	}
	

//** Habilita os combos equipamentos e materiais e desabilita o tipo produto, não permitndo que se crie
//** remessa de tipo locação e revenda. Só poderá ser criado com um dos dois tipos.
function atualiza_campos(){
	$("#tipoProduto").attr('disabled','disabled');
	$("#consultarSubGrupoMaterial").attr('disabled','');
	$("#consultarTipoImobilizado").attr('disabled','');
}

//** Limpa todos os campos da tela atualizando, caso o usuário queira iniciar novamente
function clean_all(){
	window.location.href = "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC42/dv01";	
}

//Monta a tabela imobilizados da div 2 
function  incluirItensLista_DIV2(){
	$("#tbodyImobilizadosIncluidosDIV2 tr td:last-child").hide();
	
	//$("#tbodyImobilizadosIncluidosDIV2 tr").remove();
    //$("#tbodyImobilizadosIncluidos tr").clone().appendTo("#tbodyImobilizadosIncluidosDIV2");
    //$("#tbodyImobilizadosIncluidos tr").each(function() {
    //	$(this).clone().appendTo("#tbodyImobilizadosIncluidosDIV2");	
    //});
    //remover_linhas_tabela_imobilizados_itens("tbodyImobilizadosIncluidos tr");	
	resizeIframeParent();         
}



function materiaisIncluirRemessaDIV2(){ 
	$("#tbodyMateriaisDIV2 tr").remove();
    $("#tbodyPlacas tr").each(function() {
    	$(this).clone().appendTo("#tbodyMateriaisDIV2");	
    });
    //$("#tbodyPlacas tr").clone().appendTo("#tbodyMateriaisDIV2");
	//remover_linhas_tabela_materiais_itens("#tbodyPlacas tr"); 
   	resizeIframeParent();
}


function voltar_div1(){
	
	/// Esconder ou mostrar as divs: simular mudanças entre div1 e div2
	 $("#remetente_div1").show();
	 $("#destinatario_div1").show();
	 $("#dados_remessa_div1").show();
	 $("#botao_incluir_remessa_imobilizado").show();
	 $("#button_remessa").show();
	 $("#buttonR").show();				 
	 
	 ///Listas imobilizados e materiais
	 $("#lista_imobilizados_div1").show();
	 $("#selecao_materiais_div1").show();
	 
	 $("#remetente_div2").hide();
	 $("#destinatario_div2").hide();
	 $("#dados_remessa_div2").hide();
	 
	 
	 $("#button_limpar").show();
	 $("#button_continuar").show();
	 $("#botoes_div2").hide();
	 
	 
	 $("#headar_tabelaImobilizadosAdicionados th:nth-child(7)").show();
	 $("#tbodyImobilizadosIncluidos tr td[colspan=7]").attr('colspan', 7);
	 $("#tbodyImobilizadosIncluidos tr td:nth-child(7)").show();
	
	 $("#headar_tabelaMateriaisAdicionados th:nth-child(3)").show();
	 $("#tbodyMateriais tr td:nth-child(3)").show();
	 				 
	 $("#headar_tabelaMateriaisAdicionados th:nth-child(5)").show();
	 $("#tbodyMateriais tr td[colspan=5]").attr('colspan', 5);
	 $("#tbodyMateriais tr td:nth-child(5)").show();
	 
	 //Esconde  a tabela imobilizado da div 1 com o botão excluir 
	 // e mostra a tabela da div 2 sem o botão excluir
	 $("#imobilizados_inc_div1").show();
	 $("#imobilizados_incluidos_DIV2").hide();
	 
	 //Esconde  a tabela MATERIAIS da div 1 com o botão excluir 
	 // e mostra a tabela da div 2 sem o botão excluir
	 $("#materiais_incluidos_div1").show();
	 $("#materiais_incluidos_div2").hide();
	 
	 
	// remover_linhas_tabela_materiais_itens_DIV2("#tbodyMateriaisDIV2 tr");
	 resizeIframeParent();
    //remover_linhas_tabela_imobilizados_itens_DIV2("#tbodyImobilizadosIncluidosDIV2 tr");
     resizeIframeParent();
}

function remover_linhas_tabela_materiais_itens_DIV2(tabela){		
	
	$(tabela).each(function(i, linha) {			 
		 $(this).find('td:eq(4)').remove();	    			    
		 $(this).find('td:eq(3)').remove();
		 $(this).find('td:eq(2)').remove();	    			    
		 $(this).find('td:eq(1)').remove();
		 $(this).find("td:eq(0)").remove(); 
	   
	});	 
	
 $("#headar_tabelaPlacasAdicionadasDIV2").removeClass("visivel").addClass("invisivel");
 $("#tbodyPlacas").removeClass("visivel").addClass("invisivel");	
} 

function remover_linhas_tabela_imobilizados_itens_DIV2(tabela){		
	 
	$(tabela).each(function(i, linha) {
		 $(this).find('td:eq(7)').remove();
		 $(this).find('td:eq(6)').remove();
		 $(this).find('td:eq(5)').remove();
		 $(this).find('td:eq(4)').remove();	    			    
		 $(this).find('td:eq(3)').remove();
		 $(this).find('td:eq(2)').remove();	    			    
		 $(this).find('td:eq(1)').remove();
		 $(this).find("td:eq(0)").remove(); 
	   
	});	 
	
	 $("#headar_tabelaImobilizados").removeClass("visivel").addClass("invisivel");
	 $("#tbodyImobilizados").removeClass("visivel").addClass("invisivel");		
}  

</script>

 <div id="mensagem" style="color:red;"></div>
 
 		 <div class="cabecalho2"><fmt:message key="label.criarRemessaDeEstoque" />
			<div class="caminho">
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" class="linktres"><fmt:message key="label.home" /></a> &gt;  
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC42/dv01" class="linktres"><fmt:message key="label.servicos" /></a> &gt;   
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC42/dv01" class="linkquatro"><fmt:message key="label.criarRemessaEstoque" /></a>
			</div>
		</div>	
	 <!-- div class="cabecalho2">
		<div class="caminho" style="">
			<a class="linktres" title="Home" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}">Home</a>
			&gt;
			<a class="linktres" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC42/dv01">Serviços</a>
			&gt;
			<a class="linkquatro" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC42/dv01">
			<strong>Criar Remessa de Estoque</strong>
			</a>
		</div>
	</div-->
<div id="remetente_div2" style="display:none;">	
  <table class="detalhe2" cellspacing="3" width="100%">
		<tbody>
			<tr>
				<th class="barracinza" width="209"><fmt:message key="label.representanteResponsavel" /> </th>
				<td class="camposinternos" width="358">${SascarUser.nome}</td>
				 <input type="hidden" id="representanteResp" name="representanteResp" value="${SascarUser.nome}">
				<th class="barracinza" width="200"><fmt:message key="label.representanteEstoque" /></th>				
				<td class="camposinternos" width="350"><div id="representanteResponsavel_div2"></div></td>
			</tr>
		</tbody>
	</table>	
</div>	
<div id="remetente_div1">	
	<table class="detalhe" cellspacing="0" >
		<tbody>
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.remetente" /></th>
			</tr>
		</tbody>
	</table>
	<table class="detalhe2" cellspacing="3" width="100%">
		<tbody>
			<tr>
				<th class="barracinza" width="220"><fmt:message key="label.representanteResponsavel" />  <span class="asterisco">*</span></th>
				<td class="camposinternos" width="460">${SascarUser.nome}</td>
				<th class="barracinza" width="200"><fmt:message key="label.representanteEstoque" />  <span class="asterisco">*</span></th>
				<td class="camposinternos" width="350">
					<select name="listarRepresentanteEstoque" id="listarRepresentanteEstoque"   class="required">
			        <option value=""><fmt:message key="label.selecione" /></option>
				      <c:if test="${not empty listarRepresentanteEstoque}">
				        <c:forEach var="listarRepresentanteEstoque" items="${listarRepresentanteEstoque}">
		        	 	   <option  value="${listarRepresentanteEstoque.identifier}">${listarRepresentanteEstoque.value}</option>
				        </c:forEach>
				      </c:if>  
		  	      </select>	
				</td>
			</tr>
		</tbody>
	</table>
</div>

	<table class="detalhe" cellspacing="0">
		<tbody>
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.destinatario" /></th>
			</tr>
		</tbody>
	</table>
	
<div id="destinatario_div2" style="display:none">
  <table class="detalhe2" cellspacing="3" width="100%">
		<tbody>
			<tr>
				<th class="barracinza" width="185"><fmt:message key="label.representanteResponsavel" /></th>
				<td class="camposinternos" width="310"><div id="representanteResponsavelDestinatario_div2"></div></td>
				<th class="barracinza" width="183"><fmt:message key="label.representanteEstoque" /></th>
				<td class="camposinternos" width="300"><div id="representanteResponsavelDestinatarioEstoque_div2"></div></td>
			</tr>
		</tbody>
	</table>
</div>	

<div id="destinatario_div1">
	<table class="detalhe2" cellspacing="3" width="100%">
		<tbody>
			<tr>
				<th class="barracinza" width="180"><fmt:message key="label.representanteResponsavel" /> <span class="asterisco">*</span></th>
				<td class="camposinternos" width="315">
				 <select name="representanteResponsavelDestinatarioId" id="representanteResponsavelDestinatarioId"  class="required"  onchange="carregarRepresentanteEstoque(this.value, null);" class="required">
			        <option value="0"><fmt:message key="label.selecione" /></option>
				      <c:if test="${not empty representanteResponsavelDestinatario}">
				        <c:forEach var="representanteResponsavelDestinatario" items="${representanteResponsavelDestinatario}">
		        	 	   <option  value="${representanteResponsavelDestinatario.identifier}">${representanteResponsavelDestinatario.value}</option>
				        </c:forEach>
				      </c:if>  
		  	      </select>		
				</td>
				<th class="barracinza" width="170"><fmt:message key="label.representanteEstoque" /><span class="asterisco">*</span></th>
				<td class="camposinternos" width="300">
					 <select name="representanteEstoqueDestinatario" id="representanteEstoqueDestinatario"  class="required"  onchange="getValue(this.value)">
			             <option value="0"><fmt:message key="label.selecione" /></option>				       
		  	      </select>	
				</td>
			</tr>
		</tbody>
	</table>
</div>

	<table class="detalhe" cellspacing="0">
		<tbody>
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.dadosDaRemessa" /></th>
			</tr>
		</tbody>
	</table>
	
<div id="dados_remessa_div2" style="display:none;">
 <table class="detalhe2" cellspacing="3" width="100%">
		<tbody>
			<tr>
				<th class="barracinza" width="105"><fmt:message key="label.tipoMovimentacao" /></th>
				<td class="camposinternos" width="300"><div id="tipoMovimentacao_div2"></div></td>
				<th class="barracinza" width="105"><fmt:message key="label.tipoProduto" /></th>
				<td class="camposinternos" width="300"><div id="tipoProduto_div2"></div></td>	
			    <th class="barracinza" width="183"><fmt:message key="label.Status" /></th>
				<td class="camposinternos" width="300"><div id="status_div2"></div></td>
				
							
			</tr>
			<tr>
				<th class="barracinza" width="183"><fmt:message key="label.transportadora" /></th>
				<td class="camposinternos" width="300"><div id="transportadora_div2"></div></td>
			    <th class="barracinza" width="183"><fmt:message key="label.quantidadeVolumes" /></th>
				<td class="camposinternos" width="300"><div id="quantidade_div2"></div></td>	
				  <th class="barracinza" width="183"><fmt:message key="label.nfRemessa" /> </th>
				<td class="camposinternos" width="300"><div id="quantidade_div2_nf"></div></td>		
			</tr>
		
			<tr>
				<th class="barracinza" width="185"><fmt:message key="label.observacao" /></th>
				<td class="camposinternos" width="285"><div id="observacao_div2"></div></td>
			</tr>
		</tbody>
	</table>
</div>	

<div id="dados_remessa_div1">
	<table class="detalhe2" cellspacing="3" width="100%">
		<tbody>
			<tr>
				<th class="barracinza" width="209"><fmt:message key="label.tipoMovimentacao" />  <span class="asterisco">*</span></th>
				<td class="camposinternos" width="358">
				  <select name="tipoMovimentacao" id="tipoMovimentacao"  class="required">
			        <option value="0"><fmt:message key="label.selecione" /></option>
				      <c:if test="${not empty tipoMovimentacao}">
				        <c:forEach var="tipoMovimentacao" items="${tipoMovimentacao}">
		        	 	   <option  value="${tipoMovimentacao.identifier}">${tipoMovimentacao.value}</option>
				        </c:forEach>
				      </c:if>  
		  	      </select>			
				</td>
				
					<th class="barracinza" width="200"><fmt:message key="label.Status" /></th>
				<td class="camposinternos" width="350">
					<input class="required number" type="text" maxlength="5" disabled   name="status" id="status" style="width: 220px;">
				</td>
				
							
			</tr>
			<tr>
			   <th class="barracinza" width="209"><fmt:message key="label.transportadora" />  <span class="asterisco">*</span></th>
				<td class="camposinternos" width="358">
					<select name="transportadoras" id="transportadoras"  class="required"   class="required">
			        <option value="0"><fmt:message key="label.selecione" /></option>
				      <c:if test="${not empty transportadoras}">
				        <c:forEach var="transportadoras" items="${transportadoras}">
		        	 	   <option  value="${transportadoras.identifier}">${transportadoras.value}</option>
				        </c:forEach>
				      </c:if>  
		  	      </select>
				</td>
					<th class="barracinza" width="209"><fmt:message key="label.tipoProduto" />  <span class="asterisco">*</span></th>
				<td class="camposinternos" width="358">
					<select id="tipoProduto" class="required" onchange="atualiza_campos();" name="tipoProduto" style="width: 220px;">
						<option value=""><fmt:message key="label.selecione" /></option>
						<option value="L"><fmt:message key="label.locacao" /></option>
						<option value="R"><fmt:message key="label.revenda" /></option>
					</select>
				</td>
			   			
			</tr>
			<tr>			  
				<th class="barracinza" width="209"><fmt:message key="label.observacao"/></th>
				<td class="camposinternos" width="358">				
					<textarea style="resize:none" cols="40" rows="3" id="obs" name="obs"  class="text" ></textarea>
					<div style="font-size: 11px;"><fmt:message key="label.restamCaracteresSeremDigitados"><fmt:param><span id="left"></span></fmt:param></fmt:message></div>					
				</td>
				 <th class="barracinza" width="200"><fmt:message key="label.quantidadeVolumes" /> <span class="asterisco">*</span></th>
				<td class="camposinternos" width="350">
					<input class="required number" type="text" maxlength="5"  onkeypress="return SomenteNumero(event)" name="qtddeVol" id="qtddeVol" style="width: 220px;">
				</td>	
			
			</tr>
			
			<tr>
				<th  width="209"></th>
				<td  width="358">				
					
				</td>
					<th class="barracinza" width="200"><fmt:message key="label.nfRemessa"/></th>
				<td class="camposinternos" width="350">
					<input class="required number" type="text"   onkeypress="return SomenteNumero(event)" name="nfRemessa" id="nfRemessa" style="width: 220px;">
				</td>
			</tr>
			
			
				
			
		</tbody>
	</table>
</div>

	<table class="detalhe" cellspacing="0">
	<tbody>
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.selecaoEquipamentosAcessorios" /></th>
			</tr>
		</tbody>
	</table>
	
	


<div id="lista_imobilizados_div1">
	<table class="detalhe2" cellspacing="3" width="100%">
		<tbody>		  		
			<tr>
				<th class="barracinza" width="209"><fmt:message key="label.imobilizado" /></th>
				<td class="camposinternos" width="358">
					<select name="consultarTipoImobilizado" id="consultarTipoImobilizado" disabled="disabled"  class="required"  onchange="carregarListaImobilizado(this.value, null);">
			        <option value=""><fmt:message key="label.selecione" /></option>
				      <c:if test="${not empty consultarTipoImobilizado}">
				        <c:forEach var="consultarTipoImobilizado" items="${consultarTipoImobilizado}">
		        	 	   <option  value="${consultarTipoImobilizado.identifier}">${consultarTipoImobilizado.value}</option>
				        </c:forEach>
				      </c:if>  
		  	      </select>	
				</td>
				<th class="camposinternos" width="200">&nbsp;</th>
				<td class="camposinternos" width="350"></td>
			</tr>	
				<tr>
				<th class="barracinza" width="290"><fmt:message key="label.produto" /></th>
				<td class="camposinternos" width="358">
					<select name="produtoTipo" id="produtoTipo"  class="required" disabled="disabled"  onchange="carregarListaImobilizado(this.value, 'procurar');">
			        <option value=""><fmt:message key="label.selecione" /></option>
				      <c:if test="${not empty produtoTipo}">
				        <c:forEach var="produtoTipo" items="${produtoTipo}">
		        	 	   <option  value="${produtoTipo.identifier}">${produtoTipo.value}</option>
				        </c:forEach>
				      </c:if>  
		  	      </select>	
				</td>
				<th class="camposinternos" width="200">&nbsp;</th>
				<td class="camposinternos" width="350"></td>
				<th class="camposinternos" width="200">&nbsp;</th>
				<td class="camposinternos" width="350"></td>
			</tr>
						
		</tbody>
	</table>




<h1 style="margin-left: 0pt;"><fmt:message key="mensagem.informacao.equipamentoAcessosrioIncluirRemessa" />:</h1>

	<table id="alter" cellspacing="0" width="850">
			<tr class="invisivel" id="headar_tabelaImobilizados">
				<th class="texttable_cinza" width="3%">
					<input id="checkbox_m" type="checkbox" name="checkbox_m" onClick="MarcarTodosCheckbox()">
				</th>
				<th class="texttable_cinza" width="13%"><fmt:message key="label.serie" /></th>
				<th class="texttable_cinza" width="11%"><fmt:message key="label.codigoProduto" /></th>
				<th class="texttable_cinza" width="26%"><fmt:message key="label.produto" /></th>
				<th class="texttable_cinza" width="9%"><fmt:message key="label.versao" /></th>
				<th class="texttable_cinza" width="24%"><fmt:message key="label.modelo" /></th>
				<th class="texttable_cinza" width="14%"><fmt:message key="label.Status" /></th>
			</tr>
			<tbody id="tbodyImobilizados">
			<!-- tr class="dif">
				<td class="camposinternos">
					<input id="checkbox" type="checkbox" name="checkbox">
				</td>
				<td class="camposinternos">4191919191</td>
				<td class="camposinternos">4191919191</td>
				<td class="camposinternos">haismenagendlamentnenansucnega</td>
				<td class="camposinternos">4191919191</td>
				<td class="camposinternos">haismenagendlamentnenansucnega</td>
				<td class="camposinternos">4191919191</td>
			</tr-->
			</tbody>
	</table>
</div>
<div class="busca_cinza" id="botao_incluir_remessa_imobilizado" style="text-align: center; padding: 10px 0px 0px; width: 960px; height: 35px;">
		<input id="button_remessa" class="button" type="button" style="" onclick="incluirItensLista()" value="<fmt:message key="label.incluirNaRemessa" />" name="button">
</div>
<div id="imobilizados_inc_div1">	
	    <h1 style="margin-left: 0pt;"    class="invisivel" id="headar_tituloImobilizadosAdicionados"><fmt:message key="label.equipamentosAcessoriosIncluidos" />:</h1>
		<table id="alter" cellspacing="0" width="830">
				<tr class="invisivel" id="headar_tabelaImobilizadosAdicionados">				    				
					<th class="texttable_cinza" width="10%"><fmt:message key="label.serie" /></th>
					<th class="texttable_cinza" width="10%"><fmt:message key="label.codigoProduto" /></th>
					<th class="texttable_cinza" width="26%"><fmt:message key="label.produto" /></th>
					<th class="texttable_cinza" width="10%"><fmt:message key="label.versao" /></th>
					<th class="texttable_cinza" width="26%"><fmt:message key="label.modelo" /></th>
					<th class="texttable_cinza" width="12%"><fmt:message key="label.Status" /></th>
					<th class="texttable_cinza" width="6%"><fmt:message key="label.excluir" /></th>
				</tr>
			    <tbody id="tbodyImobilizadosIncluidos">				
					<!-- td class="camposinternos">4191919191</td>
					<td class="camposinternos">4191919191</td>
					<td class="camposinternos">haismenagendlamentnenansucnega</td>
					<td class="camposinternos">4191919191</td>
					<td class="camposinternos">haismenagendlamentnenansucnega</td>
					<td class="camposinternos">4191919191</td>
					<td class="camposinternos">
						<a href="#">
							<img height="16" border="0" align="absmiddle" width="16" alt="" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/excluir16-10.png">
						</a>
					</td-->
				
				</tbody>				
		</table>
</div>		
	
 <h1 style="margin-left: 0pt;"    class="invisivel" id="headar_tituloImobilizadosAdicionadosDIV2"><fmt:message key="label.equipamentosAcessoriosIncluidos" />:</h1>
	 
 <div id="imobilizados_incluidos_DIV2" style="display:none;">
		<table id="alter" cellspacing="0" width="830">
				<tr class="invisivel" id="headar_tabelaImobilizadosAdicionadosDIV2">				    				
					<th class="texttable_cinza" width="10%"><fmt:message key="label.serie" /></th>
					<th class="texttable_cinza" width="10%"><fmt:message key="label.codigoProduto" /></th>
					<th class="texttable_cinza" width="26%"><fmt:message key="label.produto" /></th>
					<th class="texttable_cinza" width="10%"><fmt:message key="label.versao" /></th>
					<th class="texttable_cinza" width="26%"><fmt:message key="label.modelo" /></th>
					<th class="texttable_cinza" width="12%"><fmt:message key="label.Status" /></th>
					
				</tr>
			    <tbody id="tbodyImobilizadosIncluidosDIV2">				
					<!-- td class="camposinternos">4191919191</td>
					<td class="camposinternos">4191919191</td>
					<td class="camposinternos">haismenagendlamentnenansucnega</td>
					<td class="camposinternos">4191919191</td>
					<td class="camposinternos">haismenagendlamentnenansucnega</td>
					<td class="camposinternos">4191919191</td>
					<td class="camposinternos">
						<a href="#">
							<img height="16" border="0" align="absmiddle" width="16" alt="" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/excluir16-10.png">
						</a>
					</td-->
				
				</tbody>				
		</table>
</div>  
<table class="detalhe" cellspacing="0">
		<tbody>
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.selecaoDeMateriais" /></th>
			</tr>
		</tbody>
	</table>
<div id="selecao_materiais_div1">
	


	<table class="detalhe2" cellspacing="3" width="100%">
		<tbody>
			<tr>
				<th class="barracinza" width="232"><fmt:message key="label.grupoMaterial" /></th>
				<td class="camposinternos" width="358"><fmt:message key="label.materialDeInstalacao" /></td>
				<th class="camposinternos" width="200">&nbsp;</th>
				<td class="camposinternos" width="350"></td>
			</tr>
			<tr>
				<th class="barracinza" width="209"><fmt:message key="label.subgrupoMaterial" /></th>
				<td class="camposinternos" width="358">
					<select name="consultarSubGrupoMaterial" disabled="disabled" id="consultarSubGrupoMaterial"  class="required"  onchange="carregarConsultarEstoqueMateriais(this.value, null);" class="required">
			        <option value="99999"><fmt:message key="label.selecione" /></option>
				      <c:if test="${not empty subGrupoMaterialRepresentante}">
				        <c:forEach var="subGrupoMaterialRepresentante" items="${subGrupoMaterialRepresentante}">
		        	 	   <option  value="${subGrupoMaterialRepresentante.identifier}">${subGrupoMaterialRepresentante.value}</option>
				        </c:forEach>
				      </c:if>  
		  	      </select>	
				</td>
				<th class="camposinternos" width="200">&nbsp;</th>
				<td class="camposinternos" width="350"></td>
				<th class="camposinternos" width="200">&nbsp;</th>				
			</tr>
		</tbody>
	</table>


<h1 style="margin-left: 0pt;"><fmt:message key="mensagem.informacao.materiaisIncluirRemessa" />:</h1>

		
	<table id="alter" cellspacing="0" width="850">		 
			<tr class="invisivel" id="headar_tabelaPlacasAdicionadas">		
				<th class="texttable_cinza" width="3%">
				<input id="checkbox_n" type="checkbox" name="checkbox" onClick="MarcarTodosCheckbox_materiais()">
				</th>
				<th class="texttable_cinza" width="22%"><fmt:message key="label.codigoProduto" /></th>
				<th class="texttable_cinza" width="26%"><fmt:message key="label.produto" /></th>
				<th class="texttable_cinza" width="20%"><fmt:message key="label.quantidadeRemetente" /></th>
				<th class="texttable_cinza" width="29%"><fmt:message key="label.quantidadeEnvio" /></th>
			</tr>
		  <tbody id="tbodyPlacas">	
		 	<tr class="dif">	
		 	
		 	  
		 			
				<!--td class="camposinternos">
					<input id="checkbox" type="checkbox"  name="checkbox">
				</td>
				< td class="camposinternos">${listaEstoqueMateriaisRep.codigo}</td>
				<td class="camposinternos">${listaEstoqueMateriaisRep.descricao}</td>
				<td class="camposinternos">${listaEstoqueMateriaisRep.quantidadeEstoque}</td>
				<td class="camposinternos">
					<input id="" class="required number" type="text" maxlength="7" value="${listaEstoqueMateriaisRep.quantidadeStatusTransito}" name="" style="width: 220px;">
				</td-->
			</tr>
		</tbody>
	</table>
</div>	
<div id="mensagem_material" style="color:red;"></div>
<div class="remessa_inc">
	


<div id="materiais_incluidos_div1">	
	<div class="busca_cinza" style="text-align: center; padding: 10px 0px 0px; width: 960px; height: 35px;">
		<input id="buttonR" class="button" type="button" style="" onclick="materiaisIncluirRemessa()" value="<fmt:message key="label.incluirNaRemessa" />" name="button">
	</div>
	<h1 style="margin-left: 0pt;" class="invisivel" id="headar_tituloMateriaisAdicionados"><fmt:message key="label.materiaisIncluidos" />:</h1>
		<table id="alter" cellspacing="0" width="830">
		  <tr class="invisivel" id="headar_tabelaMateriaisAdicionados">		  		 						
				 <th class="texttable_cinza" width="22%"><fmt:message key="label.codigoProduto" /></th>
				 <th class="texttable_cinza" width="26%"><fmt:message key="label.produto" /></th>
				 <th class="texttable_cinza" width="20%"><fmt:message key="label.quantidadeRemetente" /></th>
				 <th class="texttable_cinza" width="29%"><fmt:message key="label.quantidadeEnvio" /></th>
				 <th class="texttable_cinza" width="6%"><fmt:message key="label.excluir" /></th>
				</tr>
				<tbody id="tbodyMateriais">
				
				    <!-- td class="camposinternos">4191919191</td>
					<td class="camposinternos">4191919191</td>
					<td class="camposinternos">haismenagendlamentnenansucnega</td>
					<td class="camposinternos">4191919191</td>
					<td class="camposinternos">haismenagendlamentnenansucnega</td>
					<td class="camposinternos">4191919191</td>
					<td class="camposinternos">
						<a href="#">
							<img height="16" border="0" align="absmiddle" width="16" alt="" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/excluir16-10.png">
						</a>
					</td-->				
				</tbody>				
		</table>		
	</div>
</div>	
<div id="materiais_incluidos_div2">
		<h1 style="margin-left: 0pt;" class="invisivel" id="headar_tituloMateriaisAdicionadosDIV2"><fmt:message key="label.materiaisIncluidos" />:</h1>
	
		<table id="alter" cellspacing="0" width="830">
		  <tr class="invisivel" id="headar_tabelaMateriaisAdicionadosDIV2">		  		 				
				 <th class="texttable_cinza" width="22%"><fmt:message key="label.codigoProduto" /></th>
				 <th class="texttable_cinza" width="26%"><fmt:message key="label.produto" /></th>				 
				 <th class="texttable_cinza" width="29%"><fmt:message key="label.quantidadeEnvio" /></th>				 
				</tr>
				<tbody id="tbodyMateriaisDIV2">
				
				    <!-- td class="camposinternos">4191919191</td>
					<td class="camposinternos">4191919191</td>
					<td class="camposinternos">haismenagendlamentnenansucnega</td>
					<td class="camposinternos">4191919191</td>
					<td class="camposinternos">haismenagendlamentnenansucnega</td>
					<td class="camposinternos">4191919191</td>
					<td class="camposinternos">
						<a href="#">
							<img height="16" border="0" align="absmiddle" width="16" alt="" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/excluir16-10.png">
						</a>
					</td-->				
				</tbody>				
		</table>
</div>
<div align="center">
		 <input id="button_continuar" class="button" type="submit" style="" onclick="setValues()" value="<fmt:message key="label.continuar" />" name="button2">
		 <input id="button_limpar"  style="background: #E4E4E4;	color: #333; height: 25px;" class="button" type="button" onclick="clean_all();" value="<fmt:message key="label.limpar" />" name="<fmt:message key="label.limpar" />">
</div>
	
	<div id="botoes_div2" style="display:none;">
	  <input id="button" class="button3" type="button" onclick="voltar_div1();" value="<fmt:message key="label.voltar" />" name="button">
	  <div class="pgstabela" style="">
	    <input id="button2" class="button" type="button" onclick="setValues_Gerar_Remessa();" value="<fmt:message key="label.criarRemessa" />" name="button">
	  </div>
    </div>
    
    
     <div id="dialog_mensagem" class="popup_padrao_remessa" style="display: none;">   
     
    	<form action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Imprimir&page=Corporativo/UC42/dv04" onsubmit="openPopupPrint(this);" method="post">
         	<div class="popup_padrao_pergunta_remessa">
			
				<fmt:message key="mensagem.sucesso.remessaGerada" />
					<br>
					<fmt:message key="label.numeroDaRemessa" />:
					<span id="numeroRemessa" style="color: rgb(204, 0, 0);"></span>
					 <input type="hidden" id="remessaField" name="remessaField">
					<br>
					<span id="obgNotaficais"></span>
			</div>	
				
				<div class="popup_padrao_resposta" style="margin-top: 10px">
					<input class="button close" type="submit" value="<fmt:message key="label.imprimir" />">
					<input class="button4" type="button" value="<fmt:message key="label.fechar" />" onclick="window.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC42/dv01'">
				</div>
		</form>			
        
    </div>

     <div id="popupErrosValidacao" style="display: none;"></div>
<br clear="all"/>       
<div class="clear:both"></div>