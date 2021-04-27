<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/DirecionarSinalGerenciadoras/consultarInadimplencia?acao=5" context="/SascarPortalWeb"  />
</c:catch>

	<script type="text/javascript">
		
		function validaInadimplencia(){
			
			 <c:if test="${inadimplente}">
             
             var numeroDias = '${dias}';
     
               $.ajax({
                     url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC35/dv06",
                     data: {"dias" : numeroDias},
                     dataType:"html",
                     success: function(html){
                             $("#popupMensagemPendenciaFinanceira").html(html).jOverlay({
                                     bgClickToClose : false,
                                     closeOnEsc : false
                             });
                     }
               });
                     
              </c:if>
			
		}
	
		$(document).ready(function() {
			
			/*
				R14. O Sistema deve validar se o usuário está inadimplente a mais de 15 dias e se possui
				bloqueio web e se estiver não permitir acesso a funcionalidade de direcionamento, e apresentar
				mensagem com o número de dias que está inadimplente o título mais antigo
			*/
			validaInadimplencia();
			
			
			$("#selecionarTodos").attr('checked',true);
			
			
			$("#selecionarTodos").click(function(){
				if ($(this).is(':checked')){
					$(":text").val('');
					$("select").val('0');
				}
			});		
			
			
			//*** Limpa o checkBox caso o usuário digite algum texto 
			$('#numeroPlaca , #numeroChassi').keyup(function() {
				if ($("#selecionarTodos").is(':checked')){
					$("#selecionarTodos").attr('checked', false);
				}
			//** Retorna o check selecionado, caso o campo esteja vazio	
				if($('#numeroPlaca').val() == "" && $('#numeroChassi').val() == "")  {
					$("#selecionarTodos").attr('checked','checked');	
				}
				
			});			
					
			
			$("#selecionarTodos").click(function(){
				if ($(this).is(':checked')){
					$(":text").val('');
					$("select").val('0');
				}
			});		
			
			
			var container = $('div.container2');
			
		     //$("#numeroPlaca").setMask({mask:'aaaaaaaaaaaa'});
		     $("#numeroChassi").setMask({mask:'*******************'});
			
		     $("#formListaPlacasPesquisaGerenciadoras").validate({
				//errorContainer: container,
				//errorLabelContainer: $("ol", container),
				//wrapper: 'li'
			    //submitHandler : function(form) {
				 // 	 //submeterPlacas(form);
				//	 return false;
				//}
			});
	
		});
		
	
		function desmarcar(input) {
			var valor = $.trim($(input).val());
	
			if (valor && valor != 0 && valor.length > 0) {
				$("#selecionarTodos").removeAttr("checked");
			}
		}
		
		
		function submeterPlacas(form) {			
		
	      var data = $(form).serialize();
	      var placaChassi   = get_Table_Values();
		  
	      $(':disabled').each( function() {
		    data += '&' + this.name + '=' + $(this).val();
		  });                
	           
	      var chassi = document.getElementById("numeroChassi").value;
	    
	      $.ajax({
	  	    "url": "/SascarPortalWeb/DirecionarSinalGerenciadoras/consultarVeiculosRedirerionamentoSinalFiltro?acao=2",
	  	    "data" : {"placaChassis"   : chassi, "acao" : 2 },	  	   
		    "dataType":"json",
		    "success": function(json){
		     
		      if (json.success) {
		    	  window.location.href="/WEB-INF/views/Corporativo/UC35/dv02.jsp";//redirection  
		    	  
		 	  } else {
		   	    $.showMessage(json.mensagem);					
		 	  }
			}			   
	      });       
	    }		
		
		function get_Table_Values() {
			
			var string = "";
			
			$('#tbodyPlacas tr').each(function(i, linha) {

			
				//adiciona ao evento click do botao para retornar a coluna desejada
				
			    string += 	$(this).find('td:eq(0)').text() +";"+ $(this).find('td:eq(1)').text()+";";
		    });
			document.getElementById("placaChassis").value = string;
		   return true;	
			
		}	
		
		function refreshClassDif() {
		
			// VARIAVEL USADA PARA CONTROLAR SE A TABELA DE PLACAS PARA PESQUISA POSSUI VALORES.
			var numLinhasTabela = 0;
			
			$("#tbodyPlacas tr").each(function(i){
				
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
				$("#headar_tabelaPlacasAdicionadas").removeClass("visivel").addClass("invisivel");
			}
			
			return numLinhasTabela ;
		}

		function removerPlacaPesquisa(element) {
			var elem = $(element);
			elem.parents('tr').remove();
			if (refreshClassDif()==0){
				$("#tabelaPlacasAdicionadas").hide();
				$("#selecionarTodos").attr('checked',true);				
			}
		}

		function adicionarPlacaPesquisaGerenciadoras() {
			
		  var numeroChassi = $("#numeroChassi").val();	
	      var numeroPlaca =  $("#numeroPlaca").val();
	      var placaChassi   = get_Table_Values();
	      
	     
			
	      $.ajax({
		    "url": "/SascarPortalWeb/DirecionarSinalGerenciadoras/consultarVeiculosRedirerionamentoSinalFiltro?acao=1",
			"data":  {"numeroChassi" : numeroChassi,
			"placaChassi"   : placaChassi,	
			"numeroPlaca"   : numeroPlaca},
			"dataType":"json",				   
			success: function(json){
			  if (json.success) { 
				  $("#tabelaPlacasAdicionadas").show();
				  $.each(json.veiculos,function(i, veiculos) {
						adicionarPlacaPesquisaGerenciadoras_tabela(veiculos.placa,veiculos.chassi);						
				  });				
				 refreshClassDif();				  
			  } else {	
				     $("#tabelaPlacasAdicionadas").hide();
				     $.showMessage(json.mensagem);
			  }
			}				    
	     });			       
	}	
		
	
		
    function adicionarPlacaPesquisaGerenciadoras_tabela(placa, chassi) {	
			
			$("#headar_tabelaPlacasAdicionadas").removeClass("invisivel").addClass("visivel");
		
			var numeroChassi = $.trim(chassi);//$.trim($("#numeroChassi").val());
			var numeroPlaca =  $.trim(placa);//$.trim($("#numeroPlaca").val());
			var diffClass = $("#tbodyPlacas tr:last").hasClass("dif") ? '' : 'dif';

			if (numeroChassi || numeroPlaca) {
				
				var input = "<input type='hidden' name='veiculos' value='"+numeroPlaca + ";" + numeroChassi +"'>";
				var placa ="";
				var chassi="";
				var achou ="";
				
				$("#repeat_recados").html("");
				
				$('#tbodyPlacas tr').each(function(i, linha) {				
					
			       placa = 	$(this).find('td:eq(0)').text();
				   chassi =    $(this).find('td:eq(1)').text();
			
	   			   if ((numeroChassi == chassi)||(numeroPlaca == placa)){					   
				      achou ="sim";				
				   }				
					
		        });
				
				if (achou!="sim"){
			 	  var html = "<tr class='"+diffClass+"'>"
								+ "<td class='camposinternos'>"+ input + numeroPlaca+"</td>"
								+ "<td class='camposinternos'>"+numeroChassi+"</td>"
								+ "<td class='camposinternos'>"
									+ "<a href='#' onclick='removerPlacaPesquisa(this);'>"
										+ "<img src='${pageContext.request.contextPath}/sascar/images/corporativo_new/excluir16-10.png' width='16' height='16' border='0' align='absmiddle' />"
									+ "</a>"
								+ "</td>"
							+ "</tr>";

				$("#tbodyPlacas").append(html);
				}else{
					$("#repeat_recados").html('<fmt:message key="mensagem.informacao.placaChassiJaAdicionado" />.');
				}
				achou="";
				// Limpando os inputs
				$("#numeroChassi").val('');
				$("#numeroPlaca").val('');
			}
		}	
		
		
	function campo_vazio(){
		if($("#numeroPlaca").val() != ""){			
			$("#numeroPlaca").css( 'border-color','gray');	
		}
	}	
		
		
	function validar_placa(){
		
		if(retira_caracteres($("#numeroPlaca").val()) == true){
			 $.showMessage('<fmt:message key="mensagem.informacao.vcDigitouCaracteresInvalidos" />.');
		}else{
		$("#selecionarTodos").removeAttr("checked");
		
		if($("#numeroPlaca").val() == ""){
			//$("#numeroPlaca").css( 'border-color','#FF0000');
			adicionarPlacaPesquisaGerenciadoras();
		}else{
			if($("#numeroPlaca").val().length < 7){
				//$("#numeroPlaca").css( 'border-color','#FF0000');
			}else{
				adicionarPlacaPesquisaGerenciadoras();
			}			
		}
		
		}
	} 
	
	function retira_caracteres(texto){
		
		var Caracteres = "!@#$%¨&¹²³£¢¬ªº°*()_+='´`^~<>,.:;?/\\|ª";
		var isSpecial = false;
		for (var i=0; i < texto.length; i++){
		  var caracter =   texto.charAt(i);
		  Caracteres.indexOf(caracter);		  
		 if (Caracteres.indexOf(caracter) !== -1){
			 isSpecial = true;		 	  
		 }
		} 			
		return isSpecial;		
	}
	</script>	
	
	
	
	
	
	<!-- MENSAGENS  -->
	<div class="container2">
	  <ol>
	    <li><div id="placa_vazio"></div><label for="placa" class="error"><fmt:message key="label.campoObrigatorio.placa" /></label></div></li>
	  </ol>
	</div>

	<div class="cabecalho3">
			<div class="caminho3" style="*margin-left:350px;">
				<a href="#" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; 
				<a href="#" class="linktres"><fmt:message key="label.pagamentos" /></a> &gt; 
				<a href="${pageContext.request.contextPath}/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC35/dv01"  class="linkquatro"><fmt:message key="label.direcionamentoSinal" /></a>
			</div>
		<fmt:message key="label.direcionamentoSinal" />
	</div>

	
	<div class="busca_branca">
		<span class="text1"><fmt:message key="uc35.dv01.texto.01" />:</span>
		<span class="texthelp2" style="*width:380px;">
			<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" />
			<fmt:message key="label.buscaAvancada" />
		</span>
	</div>
		
	<form id="formListaPlacasPesquisaGerenciadoras" action="<c:url value="/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC35/dv02"/>" method="post" onSubmit="get_Table_Values()" >
		<div class="busca_cinza">
			<div class="colunaLabelBusca">
				<label><fmt:message key="label.peloChassi" />:</label>
			</div> 
			
			<div class="colunaInputBusca">
				<span class="text3"><fmt:message key="label.nAbrev" />:</span>
				<input type="text" name="numeroChassi" id="numeroChassi" maxlength="20" value="${param.numeroChassi}" />
			</div>
		</div>
		
		<div class="busca_branca">
			<div class="colunaLabelBusca">
				<label><fmt:message key="label.pelaPlaca" />:</label>
			</div> 
			
			<div class="colunaInputBusca" style="width: 300px;">
				<span class="text3"><fmt:message key="label.nAbrev" />:</span>
				<input type="text" name="numeroPlaca" id="numeroPlaca" maxlength="9" value="${param.numeroPlaca}" >
				<a href="#add" class="linkazul" onclick="validar_placa();"><fmt:message key="label.adicionarPlca" /></a>
			</div>
		</div>
		
		<div id="tabelaPlacasAdicionadas" class="tabelaGerenciadorasemOperacao" style="display:none;">
		<div id="repeat_recados" style="color:red;"></div>
			<table style="margin:10px 10px 10px 0px;" cellspacing="0" width="300px" ID="alter">
	
				<tr class="invisivel" id="headar_tabelaPlacasAdicionadas">
					<th class="texttable_azul" width="32%" ><fmt:message key="label.placa" /></th>
					<th class="texttable_azul" width="51%" ><fmt:message key="label.chassi" /></th>
					<th class="texttable_cinza" width="17%"><fmt:message key="label.excluir" /></th>
				</tr>
				<!-- falta fazer logica do diff, zebrado -->
				<tbody id="tbodyPlacas">
					<c:forEach items="${veiculos}" var="veiculo" varStatus="numLinha">
     					<c:choose>  
							<c:when test="${numLinha.count % 2 == 0}">
								<tr>
							</c:when>  
							<c:otherwise>
								<tr class="dif">
							</c:otherwise>  
						</c:choose>
							
							<td class="camposinternos">
								<input type="hidden" name="veiculos" value="${veiculo.placa};${veiculo.chassi}">
								${veiculo.placa }
							</td>
							<td class="camposinternos">${veiculo.chassi}</td>
							<td class="camposinternos">
								<a href="#" onclick="removerPlacaPesquisa(this);">
									<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/excluir16-10.png" width="16" height="16" border="0" align="absmiddle" />
								</a>
							</td>	
						</tr>
	
					</c:forEach>
				</tbody>
			
			</table>
		</div>
		<!-- FECHA DIV tabelaPlacasAdicionadas -->
			<input type="hidden" name="placaChassis" id="placaChassis">
		<div style="clear: both"></div>		
		<div class="busca_cinza"> 
			<label>
				<input name="selecionarTodos" type="checkbox" class="check" id="selecionarTodos" />
				<span class="text2"><fmt:message key="label.buscarTodos" /></span>
			</label>
		</div>
		
		<div class="busca_branca">
			<input type="submit" class="button" value="<fmt:message key="label.buscar" />" />
			<input type="reset" class="button4" value="<fmt:message key="label.limpar" />" />
		</div>
		
	</form>
	
	<!-- DIV MODAL DV05 - TELA CONFIRMACAO RETIRADA EQUIPAMENTO -->
	<div id="popupMensagemPendenciaFinanceira" style="display: none;"></div>
	
