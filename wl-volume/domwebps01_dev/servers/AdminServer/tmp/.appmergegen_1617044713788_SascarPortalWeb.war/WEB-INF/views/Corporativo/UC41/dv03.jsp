<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>
<c:catch var="helper" >
	<c:import url="/ConsultarRemessaEstoque/consultarDadosPrincipaisRemessa?acao=2" context="/SascarPortalWeb"  />
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
 
 function submeterCancelamentoRemessa(){
	 
    var remessaId = $("#numRemessa").val();
    			
   $.ajax({
       "url": "/SascarPortalWeb/ConsultarRemessaEstoque/submeterCancelamentoRemessa?acao=5",
	   "data":  {"numeroRemessa" : remessaId},
	   "dataType":"json",				   
	   success: function(json){				   
	   if (json.success) {			        	
	     confirm_cancelamento_remessa();
	   }else{
	     $.showMessage(json.mensagem);
	   }
	 }				    
   });		
 }
 
 function submeterRecebimentoRemessa(){	
	 
   var remessaId = $("#numRemessa").val();
    			
   $.ajax({
	 "url": "/SascarPortalWeb/ConsultarRemessaEstoque/submeterRecebimentoRemessa?acao=6",
     "data":  {"numeroRemessa" : remessaId},
     "dataType":"json",				   

     success: function(json){				   
       if (json.success) {			        	
	     confirm_recebimento_remessa();
	   }else{
	     $.showMessage(json.mensagem);
	   }
 	 }				    
   
   });		
 }
 
 //* diálogo para submeter
 function abrirCancelamentoRemessa(){   
     $("#dialog_submeter_cancelamento_remessa").jOverlay({'onSuccess' : function(){    
     }});  		             
 }

  function abrirRecebimentoRemessa(){   
    $("#dialog_submeter_recebimento_remessa").jOverlay({'onSuccess' : function(){    
    }});  		             
  }
 
  //*Confirmações
 function confirm_cancelamento_remessa(){		 
	 $("#dialog_mensagem_confirmacao_cancelamento").jOverlay({'onSuccess' : function(){			 
	 }});
 } 
 
 function confirm_recebimento_remessa(){		 
	 $("#dialog_mensagem_confirmacao_recebimento").jOverlay({'onSuccess' : function(){			 
	 }});
 } 
</script>

 <div class="cabecalho2"><fmt:message key="label.consultarRemessaDeEstoque" />
			<div class="caminho">
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" class="linktres"><fmt:message key="label.home" /></a> &gt;  
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC41/dv01" class="linktres"><fmt:message key="label.servicos" /></a> &gt;   
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC41/dv01" class="linkquatro"><fmt:message key="label.consultarRemessaEstoque" /></a>
			</div>
		</div>	 
	<form action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Imprimir&page=Corporativo/UC41/dv04&numeroRemessa=${detalheRemessa.numeroRemessa}" onsubmit="openPopupPrint(this);" method="post">
	
		<table class="detalhe2" cellspacing="3" width="100%">
			<tbody>
				<tr>
					<th class="barracinza" width="200"><fmt:message key="label.numeroDaRemessa" /></th>
					<td class="camposinternos" width="350">${detalheRemessa.numeroRemessa}</td>					
					<th>&nbsp;</th>
					<td class="camposinternos" width="350">&nbsp;</td>
				</tr>
				<tr>
					<th class="barracinza" width="200"><fmt:message key="label.data" /></th>
					<td class="camposinternos" width="350">
					   <c:if test="${not empty detalheRemessa.dataRemessa}">
					      ${detalheRemessa.dataRemessa}
					   </c:if>
					    </td>
					<th>&nbsp;</th>
					<td class="camposinternos" width="350">&nbsp;</td>
				</tr>
			</tbody>
		</table>
	
	
		<table class="detalhe" cellspacing="0">
			<tbody>
				<tr class="barraazulzinha">
					<th class="barraazulzinha"><fmt:message key="label.remetente" /></th>
				</tr>
			</tbody>
		</table>	
	
		<table class="detalhe2" cellspacing="3" width="100%">
			<tbody>
				<tr>
					<th class="barracinza" width="239"><fmt:message key="label.representanteResponsavel" /></th>
					<td class="camposinternos" width="358">
					      ${detalheRemessa.representante.remetenteReprResponsavel} 					
					 </td>
					<th class="barracinza" width="200"><fmt:message key="label.representanteEstoque" /></th>
					<td class="camposinternos" width="350">					 
					    ${detalheRemessa.representante.remetenteReprEstoque}					 
					</td>
					
				</tr>
			</tbody>
		</table>	
	
		<table class="detalhe" cellspacing="0">
			<tbody>
				<tr class="barraazulzinha">
					<th class="barraazulzinha"><fmt:message key="label.destinatario" /></th>
				</tr>
			</tbody>
		</table>
	
	
		<table class="detalhe2" cellspacing="3" width="100%">
			<tbody>
				<tr>
					<th class="barracinza" width="239"><fmt:message key="label.representanteResponsavel" /></th>
					<td class="camposinternos" width="358">					     
					       ${detalheRemessa.representante.destinatarioReprResponsavel}					     
					</td>
					<th class="barracinza" width="200"><fmt:message key="label.representanteEstoque" /></th>
					<td class="camposinternos" width="350">					  
					    ${detalheRemessa.representante.destinatarioReprEstoque}					  
					</td>
				</tr>
			</tbody>
		</table>
	
	   
		<table class="detalhe" cellspacing="0">
			<tbody>
				<tr class="barraazulzinha">
					<th class="barraazulzinha"><fmt:message key="label.dadosDaRemessa" /></th>
				</tr>
			</tbody>
		</table>
	
	
		<table class="detalhe2" cellspacing="3" width="100%">
			<tbody>
				<tr>
					<th class="barracinza" width="239"><fmt:message key="label.tipoMovimentacao" /></th>
					<td class="camposinternos" width="350">					 
					    ${detalheRemessa.tipoMovimentacaoRemessa}					 
					 </td>		
					  <th class="barracinza" width="200"><fmt:message key="label.tipoProduto" /></th>
					<td class="camposinternos" width="350">	
					<c:if test="${detalheRemessa.produto.tipoProduto == 'L'}">				 
					    <fmt:message key="label.locacao" />	
					</c:if>   
					<c:if test="${detalheRemessa.produto.tipoProduto == 'R'}">				 
					   <fmt:message key="label.revenda" />
					</c:if> 				 
					</td>
				
					
					<th class="barracinza" width="239"><fmt:message key="label.Status" /></th>
					<td class="camposinternos" width="350">					 
					   ${detalheRemessa.statusRemessa}					 
					 </td>			
								
				</tr>
				<tr>
				   <th class="barracinza" width="200"><fmt:message key="label.quantidadeVolumes" /></th>
					<td class="camposinternos" width="350">					 
					   ${detalheRemessa.quantidadeVolumes} 					   
					</td>
					<th class="barracinza" width="200"><fmt:message key="label.transportadora" /></th>					
					<td class="camposinternos" width="358">					 
					    ${detalheRemessa.transportadoraRemessa.nomeEmpresa} 					  
					</td>
						<th class="barracinza" width="200">NF Remessa</th>					
					<td class="camposinternos" width="358">					 
					    ${detalheRemessa.nfRemessa} 					  
					</td>
				</tr>
							<tr>
				
					<td class="camposinternos" width="350">					 
				   
					</td>
			
					<td class="camposinternos" width="358">					 
					  					  
					</td>
						<td class="camposinternos" width="358">					 
					  					  
					</td>
						<td class="camposinternos" width="358">					 
					  					  
					</td>
						<c:choose>
  				<c:when test="${not empty detalheRemessa.imprimirNF}">
			  		 <td><a href="${detalheRemessa.imprimirNF}" target="_blank">Imprimir NF</a></td>
			   	 </c:when>
				  <c:otherwise>
				    <td></td>
				 </c:otherwise>
				</c:choose>
	
				
				</tr>
			</tbody>
		</table>
	
		<table class="detalhe2" cellspacing="3" width="100%">
			<tbody>
				<tr>
					<th class="barracinza" width="200"><fmt:message key="label.observacao" /></th>
					<td class="camposinternos" width="780">					 
					  ${detalheRemessa.observacaoRemessa}					 					
					</td>
				</tr>
			</tbody>
		</table>
	
	
		<table class="detalhe" cellspacing="0">
			<tbody>
				<tr class="barraazulzinha">
					<th class="barraazulzinha"><fmt:message key="label.itensControladosPorSerial" /></th>
				</tr>
			</tbody>
		</table>  
	 <c:if test="${empty detalheImobilizadoRemessas}">
      <fmt:message key="mensagem.informacao.naoHaImobilizadosCadastrados" />
    </c:if>	   
	<c:forEach items="${detalheImobilizadoRemessas}" var="grupoItemImobilizado">
		<table class="detalhe2" cellspacing="3" width="100%">
			<tbody>
				<tr>
					<th class="barracinza" width="209"><fmt:message key="label.itemImobilizado" /></th>
					<td class="camposinternos" width="358">${grupoItemImobilizado.descricao}</td>
					<th class="camposinternos" width="200">&nbsp;</th>
					<td class="camposinternos" width="350">&nbsp;</td>
				</tr>
			</tbody>
		</table>
	

		<table id="alter" cellspacing="0" cellpadding="8" width="850" style="">
			<tbody>
				<tr>
					<th class="linkazulescuro" width="11%" title="Data da abertura do serviço" scope="col"><fmt:message key="label.serie" /></th>
					<th class="texttable_cinza" width="11%" scope="col"><fmt:message key="label.codigoProduto" /></th>
					<th class="texttable_cinza" width="27%" scope="col"><fmt:message key="label.produto" /></th>
					<th class="texttable_cinza" width="11%" scope="col"><fmt:message key="label.versao" /></th>
					<th class="texttable_cinza" width="27%" scope="col"><fmt:message key="label.modelo" /></th>
					<th class="texttable_cinza" width="13%" scope="col"><fmt:message key="label.Status" /></th>
				</tr>
			<%int countItensImobilizados=0; %>				
		     <c:forEach  items="${grupoItemImobilizado.produtos}" var="itemImobilizado" varStatus="contador">		
				<tr class="dif">
					<td class="linkazulescuro">					   
					     ${itemImobilizado.serieImobilizado}					
					</td>
					<td>					  
					     ${itemImobilizado.codigo} 					  
					</td>
					 
					<td>					  
					    ${itemImobilizado.descricaoItemImobilizado}					
					</td>				
					<td>					  
					    ${itemImobilizado.versaoImobilizado} 					 
					</td>
					<td>					  
					    ${itemImobilizado.modeloImobilizado}					  
					</td>					
					<td>
					   ${itemImobilizado.statusImobilizado}  
				    </td>
				</tr>
					<%countItensImobilizados++; %>								
			 </c:forEach>		
			</tbody>			
		</table>
		<table class="detalhe2" cellspacing="3" width="100%">
			<tbody>
				<tr>
					<th class="barracinza" width="209"><fmt:message key="label.quantidadeItemImobilizado" /></th>
					<td class="camposinternos" width="358"><b><%=countItensImobilizados %></b></td>
					<th class="camposinternos" width="200">&nbsp;</th>
					<td class="camposinternos" width="350">&nbsp;</td>				
				</tr>				
			</tbody>				
		</table>	
  </c:forEach>	  
		<table class="detalhe" cellspacing="0">
			<tbody>
				<tr class="barraazulzinha">
					<th class="barraazulzinha"><fmt:message key="label.materiais" /></th>
				</tr>
			</tbody>

		</table>
	   <c:if test="${empty detalheMaterialRemessas}">
        <fmt:message key="mensagem.informacao.naoHaMateriaisCadastrados" />
       </c:if>
       
	 <c:forEach  items="${detalheMaterialRemessas}" var="detalheMaterialRemessa" varStatus="contador">
		<%int countItensMateriais =0; %>
		<table class="detalhe2" cellspacing="3" width="100%">
			<tbody>
				<tr>
					<th class="barracinza" width="209"><fmt:message key="label.material" /></th>
					<td class="camposinternos" width="358">${detalheMaterialRemessa.descricao }</td>
					<th class="camposinternos" width="200">&nbsp;</th>
					<td class="camposinternos" width="350">&nbsp;</td>
				</tr>
			</tbody>
		</table>
		 <table id="alter" cellspacing="0" cellpadding="1" width="850" style="">
			<tbody>
				<tr>
					<th class="linkazulescuro" width="11%" title="Data da abertura do serviço" scope="col"><fmt:message key="label.codigoDoProduto" /></th>
					<th class="texttable_cinza" width="27%" scope="col"><fmt:message key="label.produto" /></th>
					<th class="texttable_cinza" width="11%" scope="col"><fmt:message key="label.quantidadeDeEnvio" /></th>
				</tr>
		     <c:forEach  items="${detalheMaterialRemessa.produtos}" var="itemMaterial" varStatus="count">		
				<tr class="dif">
					<td>${itemMaterial.codigo}</td>
					<td>${itemMaterial. descricaoProduto} </td>
					<td>${itemMaterial.quantidade}</td>
				</tr>
			   <%countItensMateriais++;%>	
			</c:forEach>									
			</tbody>			
		</table>    	
		<table class="detalhe2" cellspacing="3" width="100%">
			<tbody>
				<tr>
					<th class="barracinza" width="209"><fmt:message key="label.quantidadeDeMateriais" /></th>
					<td class="camposinternos" width="358"><b><%=countItensMateriais%></b></td>
					<th class="camposinternos" width="200">&nbsp;</th>
					<td class="camposinternos" width="350">&nbsp;</td>
				</tr>
			</tbody>
		</table>
   </c:forEach>	
	
		<div class="pgstabela" style="">
			
			<input class="button" type="submit" style="" onclick="" tabindex="10" value="<fmt:message key="label.imprimir" />">
			<c:if test="${detalheRemessa.statusRemessa eq  'Enviado' and detalheRemessa.indicadorPermissaoCancelamento eq 'S'}">
			  <input class="button" type="button" style="" onclick="abrirRecebimentoRemessa()" tabindex="10" value="<fmt:message key="label.confirmarRecebimento" />">
		    </c:if>
		</div>
	</form>
<input class="button3" type="button" onclick="window.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC41/dv02&numeroRemessaField=${param.numeroRemessaField}&numeroRemessa=${param.numeroRemessaField}&statusRemessa=${param.statusRemessa}&dataInicialPesquisa=${param.dataInicialPesquisa}&dataFinalPesquisa=${param.dataFinalPesquisa}&statusRemessaField=${param.statusRemessaField}'" tabindex="10" value="<fmt:message key="label.voltar" />">
<!-- popups -->
 <div id="dialog_mensagem_confirmacao_cancelamento" class="popup_padrao" style="display: none;">        
			<div class="popup_padrao_pergunta"><fmt:message key="mensagem.sucesso.cancelamento" /></div>
		    <div class="popup_padrao_resposta">
			<input name="" type="submit" class="button close" value="OK" onclick="window.location.href ='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC41/dv02&numeroRemessa=${param.numeroRemessa}'"/>
            </div>
 </div>  

 <div id="dialog_mensagem_confirmacao_recebimento" class="popup_padrao" style="display: none;">        
			<div class="popup_padrao_pergunta"><fmt:message key="mensagem.sucesso.recebimentoRemessaConfirmado" /></div>
		    <div class="popup_padrao_resposta">
			<input name="" type="submit" class="button close" value="OK" onclick="window.location.href ='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC41/dv01'"/>
            </div>
 </div> 
 	
 <div id="dialog_submeter_cancelamento_remessa" class="popup_padrao" style="display: none;">        
			
			<div class="popup_padrao_pergunta"><fmt:message key="mensagem.confirmacao.cancelamentoRemessa" /></div>
 
		    <div class="popup_padrao_resposta" >
			<input name="" type="submit" class="button close" value="<fmt:message key="label.sim" />" onclick="submeterCancelamentoRemessa(); "/>
			
			 <input type="button" class="button4 close" value="<fmt:message key="label.nao" />" onclick="javascript:$.closeOverlay();" />
	        
	 </div>
</div>

<div id="dialog_submeter_recebimento_remessa" class="popup_padrao" style="display: none;">        
			
			<div class="popup_padrao_pergunta"><fmt:message key="mensagem.confirmacao.recebimentoRemessa" /></div>
 
		    <div class="popup_padrao_resposta" >
			<input name="" type="submit" class="button close" value="<fmt:message key="label.sim" />" onclick="submeterRecebimentoRemessa(); "/>
			
			 <input type="button" class="button4 close" value="<fmt:message key="label.nao" />" onclick="javascript:$.closeOverlay();" />
	        
	 </div>
</div>
<input type="hidden" id="numRemessa" value="${detalheRemessa.numeroRemessa}"/>	
