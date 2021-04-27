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

    function submeterGerenciadora(){	 		
	
     var gerenciadoraNome = ""; 
     var idContrato       = document.getElementById("numContrato").value;
     var numOpcao         = document.getElementById("numOpcao").value;
     var idGerenciadora   = document.getElementById("idGerenciadora").value;
     var idVeiculo        = document.getElementById("idVeiculo").value;
    			
       $.ajax({
		    "url": "/SascarPortalWeb/DirecionarSinalGerenciadoras/submeterDirecionamentoSinal?acao=4",
		    "data":  {"gerenciadoraNome" : gerenciadoraNome,"numOpcao" : numOpcao, "idGerenciadora" : idGerenciadora, "idVeiculo" : idVeiculo, "contratoId" :idContrato, "encerrar": "encerramento"},
		              "dataType":"json",
		               type: "POST",
			          success: function(json){				   
			        if (json.success) {	
			        	confirm_direcionamento();
			        	//window.location.href = "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC35/dv02";		        	
				    } else {				    	
				     $.showMessage(json.mensagem);
				    }
			}				    
       });			       
   }


   function abrirSubmeterGerenciadora(){
	  
	  // document.getElementById("gerencia").innerHTML = document.getElementById("gerenciadora").value+"?";
    		    	
    	    $("#dialog_submeter_direcionamento").jOverlay({'onSuccess' : function(){    
    			  		 
		    }});
   }	

   
   function getValue(value){
	   document.getElementById("gerNome").value = value;
   }

   
   
   function confirm_direcionado(){
		 
		 $("#dialog_mensagem_encerramento").jOverlay({'onSuccess' : function(){
			
		 }});
   }
   
   function confirm_direcionamento(){
		 
		 $("#dialog_confirm_direcionamento").jOverlay({'onSuccess' : function(){
			
		 }});
	   }
   
</script>

   <script type="text/javascript">
	
		$(document).ready(function() {
			
			$("#selecionarTodos").click(function(){
				if ($(this).is(':checked')){
					$(":text").val('');
					$("select").val('0');
				}
			});		
	
		});
	
	</script>
	
	 <div id="dialog_confirm_direcionamento" class="popup_padrao" style="display: none;">        
			<div class="popup_padrao_pergunta"><fmt:message key="mensagem.sucesso.direcionamentoEncerrado" />.</div>
		    <div class="popup_padrao_resposta">
			<input name="" type="submit" class="button close" value="OK" onclick="window.location.href ='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC35/dv02'"/>
		</div>
	</div>
	
	
    	
     <div id="dialog_submeter_direcionamento" class="popup_padrao" style="display: none;">        
			<div class="popup_padrao_pergunta" style="height: 10px;"><fmt:message key="mensagem.confirmacao.encerramentoSinalGerenciadora" /> <div id="gerencia"></div></div>
		    <div class="popup_padrao_resposta" style="height: 10px;">
			<input name="" type="submit" class="button close" value="<fmt:message key="label.sim" />" onclick="submeterGerenciadora(); "/>
			<input type="button" class="button4 close" value="<fmt:message key="label.nao" />" onclick="$.closeOverlay();" />
	</div>
	</div>
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
			
			<div class="colunaEsquerdaDirecionamentoSinal">
			
				<!-- A DIV CELULA ENGLOBA A LABEL ( BARRA CINZA ) E O CAMPO DE APRESENTÇÃO DE DADOS DA SERVLET OU DE PARAMETROS DO FORM DA PAGINA ANTERIOR -->
				<div class="celula">
					<div class="colunaLabel">
						<label><fmt:message key="label.opcao" /></label>
					</div>						
					<div class="colulaCamposInternos">
						<label>${param.numOpcao }</label>
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
					<input type="hidden" value="${param.idGerenciadora}" id="idGerenciadora" name="idGerenciadora">
					<input type="hidden" value="${param.idVeiculo}" id="idVeiculo" name="idVeiculo">
					<input type="hidden" value="${param.numOpcao}" id="numOpcao" name="numOpcao">
					<label class="linkazul" style="font-weight: bold !important;">${param.nomeGerenciadora}</label><br>
					    <input class="button" value="<fmt:message key="label.encerrarDirecionamento" />" type="submit" onclick="abrirSubmeterGerenciadora();" />
	    			 
	    			</c:if>
					</div>
				</div>
				
   
			</div>
			
			<div style="clear: both"></div>
			
		</div>
		<!-- FECHA DIV BLOCO -->
		
		<!-- INICIO BLOCO 02 -->
<form id="formListaPlacasPesquisaGerenciadoras" action="<c:url value="/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC35/dv04&placaVeiculo=${param.placaVeiculo}&chassi=${param.chassi}&idContrato=${param.idContrato}&numOpcao=${param.numOpcao}&nomeGerenciadora=${param.nomeGerenciadora}&idVeiculo=${param.idVeiculo}&idGerenciadora=${param.idGerenciadora}"/>" method="post">
		
		<div class="tarjaBuscaCinza">
			<label><fmt:message key="label.busqueGerenciadoraDesejada" /></label>
		</div>
		
		<div class="busca_cinza">
			<div class="colunaLabelBusca" style="width: 150px;">
				<label><fmt:message key="label.nomeGerenciadora" />:</label>
			</div> 
				
			<div class="colunaInputBusca" style="width: 300px;">
				<input type="text" name="nameGerenciadora" id="nameGerenciadora" maxlength="30" />
			</div>
		</div>
		
		<div class="busca_branca">
			<label>
				<input name="selecionarTodas" type="checkbox" class="check" id="selecionarTodos" />
				<span class="text2"><fmt:message key="label.buscarTodos" /></span>
			</label>
		</div>

		<div class="busca_cinza">
			<input class="button" value="<fmt:message key="label.buscar" />" type="submit" onclick="abrirSubmeterGerenciadora()" />
		</div>
</form>				
		<div class=" botaovoltar">
			<input name="button2" type="reset" class="button3" id="" value="<fmt:message key="label.voltar" /> " onclick="window.location.href ='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC35/dv02'"/>
		</div>	
		
		<div style="clear: both"></div>			
		
	</div>


