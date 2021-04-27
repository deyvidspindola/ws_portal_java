<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/DirecionarSinalGerenciadoras/submeterDirecionamentoSinal?acao=4" context="/SascarPortalWeb"  />
</c:catch>

<script type="text/javascript">

    function submeterDirecionamentoSinal(){
    	
     
     var numOpcao = $("#numOpcao").val();      	
    
       $.ajax({
		    "url": "/SascarPortalWeb/DirecionarSinalGerenciadoras/submeterDirecionamentoSinal",
		    "data":  {"numOpcao" : numOpcao, "acao" : "4", "all" : "todos", "encerrar":"encerramento"},
		              "dataType":"json",
		               type: "POST",
			          success : function(json){				   
			        if (json.success) {			        	
			        	confirm_direcionados();
			        	//window.location.href = "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC35/dv02";		        	
				    } else {				    	
				     $.showMessage(json.mensagem);
				    }
			}				    
       });			       
   }

   function abrirSubmeterDirecionamentoSinal(){ 
    		    	
    	    $("#dialog_submeter_encerramento").jOverlay({'onSuccess' : function(){    
    			  		 
		    }});
    	    
   }	
 

   function confirm_direcionados(){
		
		 $("#dialog_mensagem_encerramento3").jOverlay({'onSuccess' : function(){
			 
		 }});
 }
   
</script>


     <div id="dialog_mensagem_encerramento3" class="popup_padrao" style="display: none;">        
			<div class="popup_padrao_pergunta"><fmt:message key="mensagem.sucesso.direcionamentoEncerrado" />.</div>
		    <div class="popup_padrao_resposta">
			<input name="" type="submit" class="button close" value="OK" onclick="window.location.href ='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC35/dv02'"/>
		</div>
	</div>	

 	 <div id="dialog_submeter_encerramento" class="popup_padrao" style="display:none;">        
			<div class="popup_padrao_pergunta"><fmt:message key="mensagem.confirmacao.encerramentoSinalTodosVeiculos" /></div>
		    <div class="popup_padrao_resposta">
			<input name="" type="submit" class="button close" value="<fmt:message key="label.sim" />" onclick="javascript:submeterDirecionamentoSinal(); "/>
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
	<input type="hidden" id="numOpcao" name="numOpcao" value="${param.numOpcao}">
	<div class="principal">
	
		<!-- INICIO BLOCO 01 -->
		<div class="tarjaAzul">
			<label><fmt:message key="label.gerenciadora" /></label>
		</div>
	
		<div class="bloco">	
		
				<div class="celula">
					<div class="colunaLabel">
						<label>
							<fmt:message key="label.opcaoD">
								<fmt:param>${param.numOpcao}</fmt:param>
							</fmt:message>
						</label>						
					</div>
				<c:if test="${!empty param.opcao}">
					<div class="colulaCamposInternos" style="padding-top: 0px;">
						<input class="button tooltip" 
							   title="A ação atualizará todos os veículos." 
							   value="<fmt:message key="label.encerrarDirecionamento" />" 
							   type="button" 
							   onclick="abrirSubmeterDirecionamentoSinal();"/>
					</div>
				</c:if>	
				<c:if test="${empty param.opcao}">
				 <label class="linkazul" style="font-weight: bold !important;"><fmt:message key="label.disponivelParaGerenciamento" /></label>
				</c:if>
				</div>
				
				<span class="texthelp2" style="width:480px;">
						<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png"
						     width="16" height="16" hspace="5" align="absmiddle" />
						     
							<fmt:message key="uc35.dv04.texto.01" />
				</span>
				
				<div style="clear: both"></div>
				
				<span class="texthelp2"  style="width:480px;">
					<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png"
						 width="16" height="16" hspace="5" align="absmiddle" />
						 
						<fmt:message key="uc35.dv04.texto.02" />
				</span>
				
			<div style="clear: both"></div>
			
		</div>	
		<!-- FECHA DIV BLOCO -->
		
		<!-- INICIO BLOCO 02 -->
<form id="formListaPlacasPesquisaGerenciadoras" action="<c:url value="/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC35/dv04&placaVeiculo=${param.placaVeiculo}&chassi=${param.chassi}&idContrato=${param.idContrato}&numOpcao=${param.numOpcao}&nomeGerenciadora=${param.nomeGerenciadora}&all=todos&nomeGeree=${param.opcao}"/>" method="post">
		
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
				<span class="text2"><fmt:message key="label.buscarTodos" /> </span>
			</label>
		</div>
		
		<div class="busca_cinza">		
			<input class="button" value="<fmt:message key="label.buscar" />" type="submit" />
		</div>
</form>			
		<div class=" botaovoltar">
		    <input name="button2" type="reset" class="button3" id="" value="<fmt:message key="label.voltar" /> " onclick="window.location.href ='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC35/dv02'" /> 
		
		</div>	
		
		
		<div style="clear: both"></div>		
		
	
	</div>
	
	
 	
     
    	