<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>
<c:catch var="helper" >
	<c:import url="/DirecionarSinalGerenciadoras/listarGerenciadoras?acao=3" context="/SascarPortalWeb"  />
</c:catch>

<script type="text/javascript">

    function submeterGerenciadora(){
    	
    	
    	
     var todos_veiculos          = document.getElementById("todos_veiculos").value; 
     var num_opcao               = document.getElementById("num_opcao").value;
     var idContrato              = document.getElementById("numContrato").value;
     var gerenciadoraId          = document.getElementById("idGerencia").value;
     var idVeiculo               = document.getElementById("idVeiculo").value;
     var encerramento            = document.getElementById("enc").value;
     var dataInicial             = document.getElementById("dataInicial").value;
     var horaLimite              = document.getElementById("horaLimite").value;
     var periodoIndeterminado    = document.getElementById("periodoIndeterminado").value;
     var gerenciadoraNome        = document.getElementById("nameGerenciadora").value;
     
     if (!$("#periodoIndeterminado").is(':checked')){	
    	 periodoIndeterminado = "";
     }
    			
     $.ajax({
		    "url": "/SascarPortalWeb/DirecionarSinalGerenciadoras/submeterDirecionamentoSinal?acao=4",
		    "data":  {"all" : todos_veiculos, "numOpcao" : num_opcao, "idGerenciadora" : gerenciadoraId, "idVeiculo" : idVeiculo, "contratoId" :idContrato,"encerrar": encerramento, "dataInicial" : dataInicial, "horaLimite":horaLimite, "periodoIndeterminado":periodoIndeterminado, "gerenciadoraNome": gerenciadoraNome},
		              "dataType":"json",	
		              type: "POST",
			          success: function(json){
				   
			        if (json.success) {			        	
			        	var confirm = document.getElementById("enc").value;
			        	
			        	if(confirm == "encerramento"){				        		
			        		 $("#dialog_mensagem_encerramento4").jOverlay({'onSuccess' : function(){
			        			 limpa_campos();
			        		 }});			        		
			        	}else{	
			        		 $("#dialog_mensagem_dir").jOverlay({'onSuccess' : function(){
			        			 limpa_campos();
			        		 }});
			        	
			        	 document.getElementById("msg").innerHTML="";
			        	 document.getElementById("msg1").innerHTML="";
			        	}
			        	} else {				    	
				     $.showMessage(json.mensagem);
				     document.getElementById("msg").innerHTML="";
				     document.getElementById("msg1").innerHTML="";
				    }
			}				    
       });			       
   }


   function abrirSubmeterGerenciadora(valor){
	   
	  
	   
	        //document.getElementById("gerencia").innerHTML = document.getElementById("Gn").value;
	        //document.getElementById("gerencia1").innerHTML = document.getElementById("nomeGerenc").value+"?";
	        document.getElementById("enc").value = valor;
	        var janela = valor;       
	        
	        document.getElementById("msg").innerHTML="";
	        document.getElementById("msg1").innerHTML ="";
	        
	       
	        if(valor != "encerramento"){
	        //** Melhorar Lógica  (Quando check true e campos vazios e gerenciadora preenchido, submeter; )
	        if(document.getElementById("gerenciadoraId").value == "0"  || document.getElementById("dataInicial").value =="" || document.getElementById("horaLimite").value==""){
	        	
	        	 if(document.getElementById("gerenciadoraId").value == "0" && (document.getElementById("dataInicial").value =="" || document.getElementById("horaLimite").value=="") && document.getElementById("periodoIndeterminado").checked == false){
	        	    document.getElementById("msg").innerHTML= 'Preencha os campos Data Limite/Hora Limite ou Período Indeterminado da Gerenciadora.';
	        	 }
	        	 
	        	 if(document.getElementById("gerenciadoraId").value =="0" ){
		        	    document.getElementById("msg1").innerHTML= 'Necessário selecionar uma gerenciadora.';
		         }
	        	 
	        	 if(document.getElementById("gerenciadoraId").value != "0"  && document.getElementById("periodoIndeterminado").checked == false && document.getElementById("dataInicial").value =="" && document.getElementById("horaLimite").value==""){
		        	    document.getElementById("msg").innerHTML= 'Preencha os campos Data Limite/Hora Limite ou Período Indeterminado da Gerenciadora.';
		         }
	        	 if(document.getElementById("gerenciadoraId").value != "0"  && document.getElementById("periodoIndeterminado").checked == false && (document.getElementById("dataInicial").value =="" || document.getElementById("horaLimite").value=="")){
		        	    document.getElementById("msg").innerHTML= 'Preencha os campos Data Limite/Hora Limite ou Período Indeterminado da Gerenciadora.';
		         }
	        	// if(document.getElementById("gerenciadoraId").value != "0"  && document.getElementById("periodoIndeterminado").checked == false && document.getElementById("dataInicial").value !="" && document.getElementById("horaLimite").value==""){
		       // 	    document.getElementById("msg").innerHTML= 'Preencha os campos Data Limite/Hora Limite ou Período Indeterminado da Gerenciadora.';
		        // }
	        	 
	        	// if(document.getElementById("gerenciadoraId").value != "0"  && document.getElementById("periodoIndeterminado").checked == false && document.getElementById("dataInicial").value =="" && document.getElementById("horaLimite").value!=""){
		        //	    document.getElementById("msg").innerHTML= 'Preencha os campos Data Limite/Hora Limite ou Período Indeterminado da Gerenciadora.';
		        // }
	        }else{	        	
	          if(janela != "submeter"){
    	        $("#dialog_submeter_direcionamento").jOverlay({'onSuccess' : function(){   	        		 
		        }});
	          }else{
	            $("#dialog_submeter_direcionamento1").jOverlay({'onSuccess' : function(){ 		  		 
			    }});
	          }
	        }
	        if ($("#periodoIndeterminado").is(':checked')){	
	          if ((document.getElementById("dataInicial").value =="" && document.getElementById("horaLimite").value=="" ) && document.getElementById("gerenciadoraId").value != "0" ){	        	
	        	  if(janela != "submeter"){
	    	      $("#dialog_submeter_direcionamento").jOverlay({'onSuccess' : function(){    
	              }});
		        }else{
		           $("#dialog_submeter_direcionamento1").jOverlay({'onSuccess' : function(){    
				  		 
				   }});
		        }
	          }
	        }
	        }else{
	          if(janela != "submeter"){
		    	  $("#dialog_submeter_direcionamento").jOverlay({'onSuccess' : function(){    
		          }});
			  }else{
			      $("#dialog_submeter_direcionamento1").jOverlay({'onSuccess' : function(){    
			      }});
			  }
	        	
	        }        
   }	

   
   function getValue(value){
	  
	   var id =value.split(";");	    
	   document.getElementById("idGerencia").value = id[0];
	   document.getElementById("nomeGerenc").value = id[1];  
   }

   function limpa_campos(){	   
	   document.getElementById("msg").innerHTML="";
       document.getElementById("msg1").innerHTML ="";
   }
   
   $(document).ready(function(){
	   
		$('#horaLimite').attr('alt','time');
		$('#horaLimite').setMask();
		
	   
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

		
		
		$("#periodoIndeterminado").click(function(){
			if ($(this).is(':checked')){					
				$("#dataInicial").val('');
				$("#horaLimite").val('');				
			}
		});	
		
		$("#dataInicial").click(function(){
			if ($("#periodoIndeterminado").is(':checked')){					
				$("#periodoIndeterminado").attr('checked',false);								
			}
		});	
		
		$("#horaLimite").click(function(){
			if ($("#periodoIndeterminado").is(':checked')){					
				$("#periodoIndeterminado").attr('checked',false);								
			}
		});	 
		
	   
	   $("#selecionarTodos").click(function(){
		   
			if ($(this).is(':checked')){					
				$(":text").val('');
				$("select").val('0');
			}
		});	
	   
	  
	    var container = $('div.container2');	
				
	    $("#formListaPlacasPesquisaGerenciadoras").validate({
		errorContainer: container,
		errorLabelContainer: $("ol", container),
		wrapper: 'li'
	  });
	});   
   
   
  
   function confirm_direcionamento(){		 
		 $("#dialog_confirm_direcionamento").jOverlay({'onSuccess' : function(){			 
		 }});
	   }
   
   function confirm_direcionado_4(){	  
		 $("#dialog_mensagem_encerramento4").jOverlay({'onSuccess' : function(){
			 limpa_campos();
		 }});
}
 
   //METODO REMOVIDO, POIS QUANDO O USUARIO COLOCAVA ' : ' APRESENTAVA ERRO
   /* // INTERNET EXPLORER 7
   // A MÁSCARA DE HORA GERAVA UM ERRO DE SCRIPT
   // SCRIPT FEITO PARA CORRIGIR UM PROBLEMA DE MÁSCARA NO IE7
    function hora(hora){	   
	   var horaFormat = hora.substring(0,2);
	   var minFormat  = hora.substring(2,4);
	   if(hora.length>=4){
         $("#horaLimite").val(horaFormat +":"+ minFormat);
	   }
   } */
   
</script>

	 <div id="dialog_mensagem_encerramento4" class="popup_padrao" style="display: none;">        
			<div class="popup_padrao_pergunta"><fmt:message key="mensagem.sucesso.direcionamentoEncerrado" />!</div>
		    <div class="popup_padrao_resposta">
			<input name="" type="submit" class="button close" value="OK" onclick="window.location.href ='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC35/dv02'"/>
		</div>
	</div>	
	 <div id="dialog_mensagem_dir" class="popup_padrao" style="display: none;">        
			<div class="popup_padrao_pergunta"><fmt:message key="mensagem.sucesso.direcionamentoRealizado" />!</div>
		    <div class="popup_padrao_resposta">
			<input name="" type="submit" class="button close" value="OK" onclick="window.location.href ='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC35/dv02'"/>
		</div>
	</div>		
	

 <div id="dialog_submeter_direcionamento1" class="popup_padrao" style="display: none;">        
			
			<div class="popup_padrao_pergunta"><fmt:message key="mensagem.confirmacao.direcionamentoSinalGerenciadora" /></div>
 
		    <div class="popup_padrao_resposta" >
			<input name="" type="submit" class="button close" value="<fmt:message key="label.sim" />" onclick="submeterGerenciadora(); "/>
			
			 <input type="button" class="button4 close" value="<fmt:message key="label.nao" />" onclick="window.location.reload()" />
	        
	 </div>
</div>

<div id="dialog_submeter_direcionamento" class="popup_padrao" style="display: none;">        
			<c:if test="${empty param.idContrato}">
			 <div class="popup_padrao_pergunta"><fmt:message key="mensagem.confirmacao.encerramentoSinalTodosVeiculos" /> <div id="gerencia"></div></div>		     
		    </c:if>
		    <c:if test="${!empty param.idContrato}">
		      <div class="popup_padrao_pergunta"><fmt:message key="mensagem.confirmacao.encerramentoSinalGerenciadora" /> <div id="gerencia"></div></div>
		    </c:if>
		    <div class="popup_padrao_resposta">
			<input name="" type="submit" class="button close" value="<fmt:message key="label.sim" />" onclick="submeterGerenciadora();">
			<input type="button" class="button4 close" value="<fmt:message key="label.nao" />" onclick="window.location.reload()" />
          </div>	
	</div>
<input type="hidden" value="${param.all}" id="todos_veiculos" name="todos_veiculos">
<input type="hidden" value="${param.numOpcao}" id="num_opcao" name="num_opcao">
<input type="hidden" value="" id="nomeGerenciadora" name="nomeGerenciadora">
<input type="hidden" value="" id="idGerencia" name="idGerencia">
<input type="hidden" value="" id="nomeGerenc" name="nomeGerenc">
<input type="hidden" value="${param.nomeGerenciadora}" id="Gn" name="Gn">
<input type="hidden"  value=""  id="enc" name="enc">
	<div class="cabecalho3">
		<div class="caminho3" style="*margin-left:350px;">
			<a href="#" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; 
			<a href="#" class="linktres"><fmt:message key="label.pagamentos" /></a> &gt; 
			<a href="${pageContext.request.contextPath}/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC35/dv01"  class="linkquatro"><fmt:message key="label.direcionamentoSinal" /></a>
		</div>		
		
		
		
	<fmt:message key="label.direcionamentoSinal" />
	</div>
	<div class="principal">
	
		<!-- INICIO BLOCO 01 -->
		<div class="tarjaAzul">
			<label><fmt:message key="label.gerenciadora" /></label>
		</div>
			
		<!-- A DIV BLOCO ENGLOBA OS CAMPOS DO FORMULARIO ( LABEL E INPUT  ) -->		
		<div class="bloco">	
		<c:if test="${empty param.idContrato && !empty param.nomeGeree}">
			<div class="celula">
					<div class="colunaLabel">
						<label>
							<fmt:message key="label.opcaoD">
								<fmt:param>${param.numOpcao}</fmt:param>
							</fmt:message>
						</label>						
					</div>
				
					<c:if test="${empty param.nomeGerenciadora}">
					  <input type="hidden" value="${param.nomeGerenciadora}" id="gerenciadora" name="gerenciadora"> 
					  <input type="hidden" value="${param.idContrato}" id="numContrato" name="numContrato">
					  <input type="hidden" value="${param.gerenciadoraId}" id="idGerenciadora" name="idGerenciadora">
					  <input type="hidden" value="${param.idVeiculo}" id="idVeiculo" name="idVeiculo">
					  <input type="hidden" value="${param.numOpcao}" id="numOpcao" name="numOpcao">
					  <label class="linkazul" style="font-weight: bold !important;">${param.nomeGerenciadora}</label>
					  <input class="button" value="<fmt:message key="label.encerrarDirecionamento" />" type="submit" onclick="abrirSubmeterGerenciadora('encerramento');" />
	    			 
	    			</c:if>
				</div>
				
				<span class="texthelp2" style="width:480px;">
						<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png"
						     width="16" height="16" hspace="5"/>
						     
							<fmt:message key="uc35.dv04.texto.01" />
				</span>
				
				<div style="clear: both"></div>
				
				<span class="texthelp2"  style="width:480px;">
					<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png"
						 width="16" height="16" hspace="5" />
						 
						<fmt:message key="uc35.dv04.texto.02" />
				</span>
				
		</c:if>
		
		<c:if test="${empty param.idContrato && empty param.nomeGeree}">
				<div class="colunaLabel">
						<label>
							<fmt:message key="label.opcaoD">
								<fmt:param>${param.numOpcao}</fmt:param>
							</fmt:message>
						</label>						
					</div>				
				    <label class="linkazul" style="font-weight: bold !important;"><fmt:message key="label.disponivelParaGerenciamento" /></label>
		<span class="texthelp2" style="width:480px;">
						<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png"
						     width="16" height="16" hspace="5" />
						     
							<fmt:message key="uc35.dv04.texto.01" />
				</span>
				
				<div style="clear: both"></div>
				
				<span class="texthelp2"  style="width:480px;">
					<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png"
						 width="16" height="16" hspace="5" />
						 
						<fmt:message key="uc35.dv04.texto.02" />
				</span>	
				
		</c:if>
		
		
		 <c:if test="${!empty param.idContrato}">
			<div class="colunaEsquerdaDirecionamentoSinal">
			
				<!-- A DIV CELULA ENGLOBA A LABEL ( BARRA CINZA ) E O CAMPO DE APRESENTÇÃO DE DADOS DA SERVLET OU DE PARAMETROS DO FORM DA PAGINA ANTERIOR -->
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.opcao" /></label>
					</div>
				
					<div class="colulaCamposInternos">
						<label>${param.numOpcao}</label>
					</div>
				</div>
				
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.placa" /></label>
					</div>
				
					<div class="colulaCamposInternos">
						<label>${param.placaVeiculo}</label>
					</div>
				</div>
				
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.chassi" /></label>
					</div>
				
					<div class="colulaCamposInternos">
						<label>${param.chassi}</label>
					</div>
				</div>
				
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.id" /></label>
					</div>
				
					<div class="colulaCamposInternos">
						<label>${param.idVeiculo}</label>
					</div>
				</div>
				
			</div>
			
			<div class="colunaDireitaDirecionamentoSinal">
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.nomeGerenciadora" /></label>
					</div>
				
					<!-- CONTROLAR RENDERIZACAO DE LABEL E BOTAO PARA ENCERRAR DIRECIONAMENTO -->
					<div class="colulaCamposInternos">
					<c:if test="${empty param.nomeGerenciadora}">					
					  <label class="linkazul" style="font-weight: bold !important;"><fmt:message key="label.disponivelParaGerenciamento" /></label>
					</c:if>
					<c:if test="${!empty param.nomeGerenciadora}">
					<input type="hidden" value="${param.nomeGerenciadora}" id="gerenciadora" name="gerenciadora"> 
					<input type="hidden" value="${param.idContrato}" id="numContrato" name="numContrato">
					<input type="hidden" value="${param.gerenciadoraId}" id="idGerenciadora" name="idGerenciadora">
					<input type="hidden" value="${param.idVeiculo}" id="idVeiculo" name="idVeiculo">
					<input type="hidden" value="${param.numOpcao}" id="numOpcao" name="numOpcao">
					<label class="linkazul" style="font-weight: bold !important;">${param.nomeGerenciadora}</label><br>
					 <input class="button" value="<fmt:message key="label.encerrarDirecionamento" />" type="submit" onclick="abrirSubmeterGerenciadora('encerramento' );" />
	    			 
	    			</c:if>
					</div>
				</div>
			</div>
			</c:if>
			<div style="clear: both"></div>
			
		</div>
		<!-- FECHA DIV BLOCO -->
		<!-- MENSAGENS  -->

		<!-- INICIO BLOCO 02 -->
<form id="formListaPlacasPesquisaGerenciadoras"  action="<c:url value="/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC35/dv04&placaVeiculo=${param.placaVeiculo}&chassi=${param.chassi}&idContrato=${param.idContrato}&numOpcao=${param.numOpcao}&nomeGerenciadora=${param.nomeGerenciadora}"/>" method="post">
		
		<div class="tarjaBuscaCinza">
			<label><fmt:message key="label.busqueGerenciadoraDesejada" /></label>
		</div>
		<input type="hidden" value="${param.nomeGerenciadora}" id="gerenciadora" name="gerenciadora"> 
		<input type="hidden" value="${param.idContrato}" id="numContrato" name="numContrato">
		<input type="hidden" value="${param.idGerenciadora}" id="idGerenciadora" name="idGerenciadora">
		<input type="hidden" value="${param.idVeiculo}" id="idVeiculo" name="idVeiculo">
		<input type="hidden" value="${param.numOpcao}" id="numOpcao" name="numOpcao">
					
		<div class="busca_cinza">
			<div class="colunaLabelBusca" style="width: 150px;">
				<label><fmt:message key="label.nomeGerenciadora" />:</label>
			</div> 
 			
			<input type="hidden" value="" id="gerNome"> 
			<div class="colunaInputBusca" style="width: 300px;">
				<input type="text" name="nameGerenciadora" id="nameGerenciadora" maxlength="30" value="${param.nomeGerenciadora}"/>
			</div>
		</div>
		
		<div class="busca_branca">
			<label>
				<input name="selecionarTodas" type="checkbox" class="check" id="selecionarTodos" />
				<span class="text2"><fmt:message key="label.buscarTodos" /></span>
			</label>
		</div>
		
		<div class="busca_cinza">
			<input class="button" value="<fmt:message key="label.buscar" />" type="submit" />
		</div>
</form>	
<div id="msg" style="color:red;"></div>	
<div id="msg1" style="color:red;"></div>
		
		<h1><fmt:message key="label.buscaResultado" /></h1>
		
		<span class="text1" style="margin-left:100px;">
			<fmt:message key="mensagem.selecione.nomeSubstituirDirecionamento" />:
		</span>
		
		
		<div id="tabelaResultadoGerenciadoras" class="tabelaResultadoGerenciadoras">
		
			<table width="850" cellpadding="1" id="alter" cellspacing="0" style="float: left; position: relative; margin: 0px 0px 0px 0px;">
		
				<tr>
					<td width="37" height="26" class="texttable_azul" style="background-color: #d7d7d7" scope="col" >&nbsp;</td>
					<td width="507" colspan="6" class="texttable_cinza"  style="background-color: #d7d7d7; font-size:14px;" scope="col" ><fmt:message key="label.gerenciadoras" /></td>
				</tr>			  	
				<tr class="dif">
					<td class="linkazul">		
					</td>
					<!-- Retirado o onclick="changeValues()"  -->
					<td><select name="gerenciadoraId" id="gerenciadoraId"  class="required"  onchange="getValue(this.value)">
			     <option value="0"><fmt:message key="label.selecione" /></option>
				 <c:if test="${!empty gerenciadoras}">
				   <c:forEach var="gerenciadora" items="${gerenciadoras}">
		        	 	   <option  value="${gerenciadora.codigo};${gerenciadora.nome}">${gerenciadora.nome}</option>
				   </c:forEach>
				 </c:if>  
		  	   </select>		  	  
		  	   </td>
				</tr>
					<tr>
					<td>
					</td>
				 <td>
	     		   <span class="text3"><fmt:message key="label.dataLimite" />:</span>
	      		  <input type="text" name="dataInicial" readonly="readonly" id="dataInicial" value="" class="text dateBR" maxlength="10">
                
	     		   <span class="text3"><fmt:message key="label.horaLimite" />:</span>
	      		  <input type="text" name="horaLimite" maxlength ="5" class="horaLimite" id="horaLimite" value="">
                  <input name="periodoIndeterminado" type="checkbox" class="check" id="periodoIndeterminado" />
				  <span class="text2"><fmt:message key="label.periodoIndeterminado" /> </span>                 
                 </td>                 
				</tr>		
					
			</table>
			
		</div>
		<!-- FECHA DIV tabelaResultadoGerenciadoras -->
		
		<div style="clear: both"></div>
		
		<div class="pgstabela" style="*text-align:left;">
		<c:if test="${!empty param.idContrato}">
			<input name="button2" type="reset" class="button3" id="" value="<fmt:message key="label.voltar" /> " onclick="window.location.href ='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC35/dv03&placaVeiculo=${param.placaVeiculo}&chassi=${param.chassi}&idContrato=${param.idContrato}&numOpcao=${param.numOpcao}&nomeGerenciadora=${param.nomeGerenciadora}&idVeiculo=${param.veiculoId}&idGerenciadora=${param.gerenciadoraId}&opcao=${param.nomeGeree}'" /> 
		</c:if>
		<c:if test="${empty param.idContrato}">
		  <input name="button2" type="reset" class="button3" id="" value="<fmt:message key="label.voltar" /> " onclick="window.location.href ='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC35/dv05&placaVeiculo=${param.placaVeiculo}&chassi=${param.chassi}&idContrato=${param.idContrato}&numOpcao=${param.numOpcao}&nomeGerenciadora=${param.nomeGerenciadora}&idVeiculo=${param.veiculoId}&idGerenciadora=${param.gerenciadoraId}&opcao=${param.nomeGeree}'" /> 
		</c:if>
			<input type="submit" class="button" value="<fmt:message key="label.confirmar" />" style="*margin-left:350px;" onclick="abrirSubmeterGerenciadora('submeter')" />
		</div>
		
		
				
	</div>
	
