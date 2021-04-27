<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

  <c:catch var="helper" >
 		<c:import url="/CadastrarVeiculosReinstalacao/listarVeiculosReinstalacao?acao=2" context="/SascarPortalWeb"  />
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
	
	
	   function limpa_campos(){
		   $("#chassi").val("");
           $("#placa").val("");
           $("#codigoModelo").val("");
           $("#modelos").val("");
           $("#renavam").val("");
           $("#cor").val("");
           $("#ano").val("");
           $("#codigoVeiculo").val("");
           $("#Okm").attr('checked', false); 
           $('#placa').attr("disabled", '');
	   }
	
	
	   function confirm_excluir(){
		 
		 $("#dialog_mensagem_excluir").jOverlay({'onSuccess' : function(){
			 limpa_campos();
		 }});
	   }
		   
	   function confirm_inserido(){
		
		 $("#dialog_mensagem_inserido").jOverlay({'onSuccess' : function(){    			   
			 limpa_campos();  
		 }});
	   }
			
	   function confirm_atualizado(){
		 
		   $("#dialog_mensagem_atualizado").jOverlay({'onSuccess' : function(){    			   
			  limpa_campos();
		   }});
	   }
	
	
	
    	function abrirExcluirVeiculo(placa, chassi, marca, modelo, renavam, cor, ano, codigoVeiculo){ 		
    		    	
    		$("#chassis").val(chassi);
            $("#placas").val(placa);
            $("#marcas").val(marca);
            $("#model").val(modelo);
            $("#renavans").val(renavam);
            $("#cores").val(cor);
            $("#anos").val(ano);
            $("#codigoVeiculos").val(codigoVeiculo);  
             
    		    		
    		   $("#dialog_excluir").jOverlay({'onSuccess' : function(){    			   
    			   $("#codigoVeiculo").val(codigoVeiculo);			 
		    }});
	    }	    
	    	
		function excluirVeiculo(){	 		
			
		    var codigoVeiculo = $("#codigoVeiculos").val();	
		    var chassi =        $("#chassis").val();
            var placa =         $("#placas").val();
            var marca =         $("#marcas").val();
            var modelo =        $("#model").val();
            var renavam =       $("#renavans").val();
            var cor =           $("#cores").val();
            var ano =           $("#anos").val();	           
           
		    			
		       $.ajax({
				    "url": "/SascarPortalWeb/CadastrarVeiculosReinstalacao/submeterVeiculosReinstalacao?acao=1&type=D",
				    "data":  {"codigoVeiculo" : codigoVeiculo,
				    	    "chassi"        : chassi,
				    	    "placa"         : placa,
				    	    "codigoModelo"  : modelo,
				    	    "renavam"       : renavam,
				    	    "codigoMarca"   : marca,
				    	    "cor"           : cor,
				    	    "ano"           : ano },
				            "dataType":"json",				   
					        success: function(json){
						   
					        if (json.success) {					        	
					        	confirm_excluir();					        	
						    } else {						
						     $.showMessage(json.mensagem);
						    }
					}				    
		       });			       
	    }
	
		function showButton(placa, chassi, marca, modelo, renavam, cor, ano,  codigoVeiculo) {			
			
	       $("#chassi").val(chassi);
           $("#placa").val(placa);
           $("#marca").val(marca);
           $("#modelos").val(modelo);
           $("#renavam").val(renavam);
           $("#cor").val(cor);
           $("#ano").val(ano);
           $("#codigoVeiculo").val(codigoVeiculo);
           
           $("#button1").css({visibility: "visible", display: ""});
           $("#button2").css("visibility","hidden");
           $("#button").css("visibility","hidden");    

		   $("#codigoMarca").val(marca);
		     carregarModelos(marca, modelo);

        }
	
		function attribute(element){
	
		  if ($(element).is(':checked')){
			$("#placa").val(""); 
			$('#placa').attr("disabled", true);  
		    $("#placa").removeClass("required");
		  }else{
			$('#placa').attr("disabled", '');  
		    $("#placa").addClass("required");		   
		  }
	
		}	
		
	function carregarModelos(codigoMarca, modelo) {

		if (codigoMarca == '') {
			$("option[value!='']","#modelos").remove();
			return;
		}

		var selectModelos = $('#modelos')[0];

		$.ajax({
			"url": "/SascarPortalWeb/CadastrarVeiculosReinstalacao/listarModeloPorMarca",
			"data" : { "codigoMarca": codigoMarca, "acao" : 4 },
			"dataType" : "json",
			"beforeSend": function(){
				$("option[value!='']","#modelos").remove();
			},
			"success": function(json){
				if (json.success) {
					$.each(json.modelos, function(i, modelo){
						var option = new Option(modelo.value, modelo.id);
						if ($.browser.msie) {
							selectModelos.add(option);
						} else {
							selectModelos.add(option,null);
						}
					});
					if (modelo) {
						$("#modelos").val(modelo);
					}
				} else {
					$.showMessage(json.mensagem);
				}
			}
		});
	}
	
	
		function desmarcar(input) {
	
			var valor = $.trim($(input).val());
	
			if (valor && valor != 0 && valor.length > 0) {
				$("#selecionarTodos").removeAttr("checked");
			}	
		}
		
		
		function submeterVeiculo(form) { 
			
			
			 
		   var data = $(form).serialize();
		   $(':disabled').each( function() {
			data += '&' + this.name + '=' + $(this).val();
		   });                
           
           if($("#atualiza").val()  != "a"){
          
             $.ajax({
			    "url": "/SascarPortalWeb/CadastrarVeiculosReinstalacao/submeterVeiculosReinstalacao?acao=1&type=I",
			    "data": data || {},
			    "dataType":"json",
				"success": function(json){
					if (json.success) {							
			         	confirm_inserido();					  
					} else {
						$.showMessage(json.mensagem);					
					}
				}			   
		     });       
            
		   }else{
		  			        
		     $.ajax({
				    "url": "/SascarPortalWeb/CadastrarVeiculosReinstalacao/submeterVeiculosReinstalacao?acao=1&type=U",
				    "data": data || {},
				    "dataType":"json",
				    "success": function(json){
						if (json.success) {	
				       	   confirm_atualizado();						  
						} else {
						   $.showMessage(json.mensagem);
						}						
					}			   
			     });          
		   }		   

		
		    $("#atualiza").val(""); 
       }
		
		
	   $(document).ready(function(){ 
		
	        $("#button1").click(function () {	   
	          $("#atualiza").val("a");	       
            });
	    	         
	        $("#selecionarTodos").click(function(){
				if ($(this).is(':checked')){
					$(":text").val('');
					$("select").val('0');
				}
			});
	    		
					
		    $("select, :text").each(function(){
				desmarcar(this);
			}).keypress(function(){
				desmarcar(this);
			}).keyup(function(){
				desmarcar(this);
			}).blur(function(){
				desmarcar(this);
			});			
	
		
			$("#codigoMarca").val('${param.codigoMarca}');
			var codigoMarca = '${param.codigoMarca}';
			if (codigoMarca != '' && parseInt(codigoMarca, 10) > 0) {
				$("#codigoMarca").change();
			}				
			     $("#ano").setMask({mask:'9999'});
			     $("#renavam").setMask({mask:'99999999999999999999'});
			
				 var container = $('div.container2');
		         $("#formCadastro").validate({
			     errorContainer: container,
			     errorLabelContainer: $("ol", container),
			     wrapper: 'li',
			     submitHandler : function(form) {
			  	 submeterVeiculo(form);
				 return false;
			}
		  });
		});
		
	</script>

	<div class="cabecalho3">
	    <fmt:message key="label.cadastrarVeiculosReinstalacao" />
	    		<!--  
		<div class="caminho"><a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a>&gt; 

		<a href="#" class="linktres"><fmt:message key="label.servicos" /></a> &gt; 
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC02/dv01"  class="linkquatro"><fmt:message key="label.agendarAtendimento" /></a>
		</div>-->
	</div>
			   <input type="hidden" id="model" value="" name="model">
			   <input type="hidden" id="chassis" value="" name="chassis">
			   <input type="hidden" id="placas" value="" name="placas">
			   <input type="hidden" id="marcas" value="" name="marcas">
			   <input type="hidden" id="codigoVeiculos" value="" name="codigoVeiculos">
			   <input type="hidden" id="renavans" value="" name="renavans">
			   <input type="hidden" id="cores" value="" name="cores">
			   <input type="hidden" id="anos" value="" name="anos">

   <div class="container2"> 
	  <ol>
		<li><label for="placa" class="error"><fmt:message key="label.campoObrigatorio.placa" />;</label></li>
		<li><label for="chassi" class="error"><fmt:message key="label.campoObrigatorio.chassi" />;</label></li>
		<li><label for="codigoMarca" class="error"><fmt:message key="label.campoObrigatorio.marca" />;</label></li>
		<li><label for="modelos" class="error"><fmt:message key="label.campoObrigatorio.modelo" />;</label></li>
		<li><label for="cor" class="error"><fmt:message key="label.campoObrigatorio.cor" />;</label></li>
		<li><label for="ano" class="error"><fmt:message key="label.campoObrigatorio.ano" />;</label></li>
		<li><label for="renavam" class="error"><fmt:message key="label.campoObrigatorio.renavam" />;</label></li>
	  </ol>
    </div>
	 
    <div id="cadastro">	 
  	
  		<div class="container2">
			<ol></ol>
		</div>
     
     <table cellspacing="0" class="detalhe" >
	   <tr class="barraazulzinha">
	     <th class="barraazulzinha"><fmt:message key="uc46.dv01.texto.01" /></th>
	   </tr>
	 </table>
	 
	 <form id="formCadastro" action="" method="post">
	
	  <input type="hidden" name="codigoVeiculo" id="codigoVeiculo">
	
	   <table width="100%" cellspacing="3" class="detalhe2">	    
	     <tr>
		   <th width="100" class="barracinza"><fmt:message key="label.placa" /></th>
	 	     <td width="350" class="camposinternos"><input type="text" value=""  id="placa" name="placa" class="required" maxlength="7">	 	    
		       <label>
			     <input name="Okm" type="checkbox" class="check" id="Okm"  onclick="attribute(this);" />
			  	   <fmt:message key="label.veiculo0km" />
			   </label> 	     
	 	     </td>
	       <th width="100" class="barracinza"><fmt:message key="label.chassi" /></th>
	 	     <td width="350" class="camposinternos"><input type="text"  value="" name="chassi" id="chassi" class="required" maxlength="17"> </td>	
  		 </tr>
	     
	     <tr>			
	       <th width="100" class="barracinza"><fmt:message key="label.marcaModelo" /></th>
		     <td width="350" class="camposinternos">
               <select name="codigoMarca" id="codigoMarca"  onchange="carregarModelos(this.value, null);" class="required" >
			     <option value=""><fmt:message key="label.selecione" /></option>
				   <c:forEach var="marca" items="${marcas}">
				     <c:if test="${not empty marca.identifier && not empty marca.value}">
				 	   <option value="${marca.identifier}">${marca.value}</option>
					 </c:if>
				   </c:forEach>
		  	   </select>
			   <br>
			    
			   <select name="codigoModelo" id="modelos" class="required">
					<option value=""><fmt:message key="label.selecione" /></option>					
			   </select>               
             </td>
           <th width="100" class="barracinza"><fmt:message key="label.renavam" /></th>
	 	     <td width="350" class="camposinternos"><input type="text" value="" id="renavam" name="renavam" class="required"  maxlength="20"></td>
         <tr>
           <th  width="100" class="barracinza"><fmt:message key="label.cor" /></th>
		     <td width="350" class="camposinternos"><input type="text" value=""  id="cor" name="cor" class="required"  maxlength="20"></td>
		   <th width="100" class="barracinza"><fmt:message key="label.ano" /></th>
	 	     <td width="350" class="camposinternos"><input type="text" value="" id="ano" name="ano" class="required" maxlength="4"></td>
         </tr>                    
       </table>
       
      <div class="botoesatualizacao1" id="botoesatualizacao1" style="display:none;" ></div>
      <input type="hidden" name="atualiza" id="atualiza" value="">
         <div class="botoesatualizacao" >  
           <input name="button1" type="submit" class="button" id="button1"  style="margin-left: 0px !important;display:none;" id="button3" value="<fmt:message key="label.atualizar" />"   />     
           <input name="button2" type="submit" class="button" style="margin-left: 0px !important;" id="button2" value="<fmt:message key="label.cadastrar" />" />
           <input name="button" type="reset" class="button4" style="margin-left: 20px !important;"  id="button" value="<fmt:message key="label.limpar" />" />
         </div>		
	  </form>
	  
    </div>
     <div id="dialog_excluir" class="popup_padrao" style="display: none;">        
			<div class="popup_padrao_pergunta"><fmt:message key="mensagem.confirmacao.desejaExcluirReviculoReinstalacao" /></div>
		    <div class="popup_padrao_resposta">
			<input name="" type="submit" class="button close" value="<fmt:message key="label.sim" />" onclick="excluirVeiculo(); "/>
			<input type="button" class="button4 close" value="<fmt:message key="label.nao" />" onclick="$.closeOverlay();" />
		</div>
	</div>	
		
	 <div id="dialog_mensagem_excluir" class="popup_padrao" style="display: none;">        
			<div class="popup_padrao_pergunta"><fmt:message key="mensagem.sucesso.veiculoExcluido" /></div>
		    <div class="popup_padrao_resposta">
			<input name="" type="submit" class="button close" value="OK" onclick="window.location.reload();"/>
		</div>
	</div>	
		
	 <div id="dialog_mensagem_inserido" class="popup_padrao" style="display: none;">        
			<div class="popup_padrao_pergunta"><fmt:message key="mensagem.sucesso.veiculoInserido" /></div>
		    <div class="popup_padrao_resposta">
			<input name="" type="submit" class="button close" value="OK" onclick="window.location.reload();"/>
			
		</div>
	</div>		
	
	 <div id="dialog_mensagem_atualizado" class="popup_padrao" style="display: none;">        
			<div class="popup_padrao_pergunta"><fmt:message key="mensagem.sucesso.veiculoAtualizado" /></div>
		    <div class="popup_padrao_resposta">
			<input name="" type="submit" class="button close" value="OK" onclick="window.location.reload();"/>
			
		</div>
	</div>	
		
	 <table cellspacing="0" class="detalhe" >
	   <tr class="barraazulzinha">
	     <th class="barraazulzinha"><fmt:message key="uc46.dv01.texto.02" /></th>
	   </tr>
	 </table>		
		<table width="750" cellpadding="1px" id="alter" cellspacing="0px">
		  	<tr>
				<th width="17%" class="texttable_azul" scope="col"><fmt:message key="label.placa" /></th>
				<th width="18%" class="texttable_azul" scope="col"><fmt:message key="label.chassi" /></th>
				<th width="10%" class="texttable_azul"  scope="col"><fmt:message key="label.marca" /></th>
				<th width="11%" class="texttable_azul" scope="col"><fmt:message key="label.modelo" /></th>
				<th width="15%" class="texttable_azul" scope="col"><fmt:message key="label.renavam" /></th>
				<th width="19%" class="texttable_azul" scope="col"><fmt:message key="label.cor" /></th>
				<th width="19%" class="texttable_azul" scope="col"><fmt:message key="label.ano" /></th>
				<th width="19%" class="texttable_azul" scope="col"><fmt:message key="label.atualizar" /></th>
				<th width="19%" class="texttable_azul" scope="col"><fmt:message key="label.excluir" /></th> 
			</tr>
			<c:forEach var="veiculo" items="${listaVeiculosReinstalacao}" >
			  <tr>			
			    <td><input type="hidden" value="${veiculo.codigo}" id="codigoVeiculo"><input type="hidden" value="API2250X" id="placa">${veiculo.placa}</td>
			    <td><input type="hidden" value="${veiculo.chassi}" id="chassi">${veiculo.chassi}</td>
			    <td><input type="hidden" value="${veiculo.codigoMarca}" id="marca">${veiculo.descricaoMarca}</td>
			    <td><input type="hidden" value="${veiculo.codigoModelo}" id="modelo">${veiculo.descricaoModelo}</td>
		        <td><input type="hidden" value="${veiculo.renavan}" id="renavam">${veiculo.renavan}</td>
			    <td><input type="hidden" value="${veiculo.cor}" id="cor">${veiculo.cor}</td>
			    <td><input type="hidden" value="${veiculo.anoFabricacao}" id="ano">${veiculo.anoFabricacao}</td>
		        <td><a href="#atualizar" onclick="showButton('${veiculo.placa}', '${veiculo.chassi}','${veiculo.codigoMarca}','${veiculo.codigoModelo}',  '${veiculo.renavan}', '${veiculo.cor}', '${veiculo.anoFabricacao}','${veiculo.codigo}')" title="Atualizar"><img border="0" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/editar16-12.png" alt="<fmt:message key="label.editar" />" /></a></td>
			    <td><a href="#remover" onclick="abrirExcluirVeiculo('${veiculo.placa}', '${veiculo.chassi}','${veiculo.codigoMarca}','${veiculo.codigoModelo}',  '${veiculo.renavan}', '${veiculo.cor}', '${veiculo.anoFabricacao}', '${veiculo.codigo}');" title="<fmt:message key="label.excluir" />"><img height="16" border="0" align="absmiddle" width="16" src="/SascarPortalWeb/sascar/images/corporativo_new/excluir16-10.png" /></a> </td> 
		    </tr>
		    </c:forEach>			
	</table> 
	
  <c:if test="${param.fromUC57 eq 'sim'}">
		   <input class="button3" type="button" onclick="window.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC57/dv01'" tabindex="10" value="<fmt:message key="label.voltar" />" style="margin: 10px 0px; margin-left:0px;">    
		    
   </c:if>	