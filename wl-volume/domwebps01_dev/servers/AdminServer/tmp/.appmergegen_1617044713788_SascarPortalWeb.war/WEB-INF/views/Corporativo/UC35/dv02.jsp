<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>
<!-- ALTERAR PARA CHAMAR ACAO 2 PARA BUSCAR TODOS OS VEICULOS -->
 <c:catch var="helper" >
	<c:import url="/DirecionarSinalGerenciadoras/consultarVeiculosRedirecionamentoSinal?acao=2" context="/SascarPortalWeb"  />
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

<jsp:include page="/WEB-INF/views/Corporativo/UC35/dv01.jsp"/>

	<script type="text/javascript">
	
		$(document).ready(function() {
			
			var stringg = "";
	        var opcoes = new Array();
	        
			$('#tbodyPlacass tr').each(function(i, linha) {

			
				//adiciona ao evento click do botao para retornar a coluna desejada
				
			    stringg += 	$(this).find('td:eq(1)').text() +";"+ $(this).find('td:eq(2)').text()+";"+ $(this).find('td:eq(3)').text();
			    
			    	   opcoes[0] += $(this).find('td:eq(1)').text();		    	   
			    	   opcoes[1] += $(this).find('td:eq(2)').text();			    	   
			    	   opcoes[2] += $(this).find('td:eq(3)').text();
			   
			});
	
			
			
			
			if ($("#opcao1").val() != null){ 
			   document.getElementById("opcao1").value=opcoes[0].replace("undefined","").replace('<fmt:message key="label.disponivelParaDirecionamento" />',"").replace('<fmt:message key="label.disponivelParaDirecionamento" />',"").replace('<fmt:message key="label.disponivelParaDirecionamento" />',"");
			}
			
			if ($("#opcao2").val() != null){
			   document.getElementById("opcao2").value=opcoes[1].replace("undefined","").replace('<fmt:message key="label.disponivelParaDirecionamento" />',"").replace('<fmt:message key="label.disponivelParaDirecionamento" />',"").replace('<fmt:message key="label.disponivelParaDirecionamento" />',"");
			}
			
			if ($("#opcao3").val() != null){
			   document.getElementById("opcao3").value=opcoes[2].replace("undefined","").replace('<fmt:message key="label.disponivelParaDirecionamento" />',"").replace('<fmt:message key="label.disponivelParaDirecionamento" />',"").replace('<fmt:message key="label.disponivelParaDirecionamento" />',"");
			}
			
			$("#checkbox").click(function(){
				if ($(this).is(':checked')){					
					$(":text").val('');
					$("select").val('0');
				}
			});	
			
		});
		
		function opcao1(){
			
			window.location.href ='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC35/dv05&numOpcao=1';
		}
	
		function opcao2(){
			
			window.location.href ='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC35/dv05&numOpcao=2';
		}
		
		function opcao3(){
			
			window.location.href ='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC35/dv05&numOpcao=3';
		}
		
	</script>
	
	
	
<!-- LEMBRAR DE VALIDAR O CORPO DA PAGINA, PARA O CASO DE O RESPONSE VIER VAZIO -->
<c:if test="${not empty veiculosLista}" >


<input type="hidden" id="opcao1" value="" name="opcao1"> 
<input type="hidden" id="opcao2" value="" name="opcao2"> 
<input type="hidden" id="opcao3" value="" name="opcao3"> 

	<form action="" id="formResultadoBusca">	
		
		<div class="principal">				
			
			<h1><fmt:message key="label.resultadoDaBusca" /></h1>	
			  <span class="texthelp2" style="width:480px; position: relative; float: right; margin-top: -60px">
			    <img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" />
				<fmt:message key="uc35.dv02.texto.01" />
			  </span>
			
			<div style="clear: both"></div>
			  <span class="texthelp2"  style="width:480px; position: relative; float: right; margin-top: -10px">
				<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" />
				<fmt:message key="uc35.dv02.texto.02" />
			  </span>				
			<div style="clear: both"></div>
			
			
			
			  <span class="text1" style="margin-left:5px;*margin-left:65px; width:850px; position: relative; float: left; margin-top: 40px"">
				<fmt:message key="uc35.dv02.texto.03" />
			  </span>			  
			
			<div id="tabelaGerenciadorasemOperacao"  style="*margin-left:65px;  class="tabelaGerenciadorasemOperacao"  style="margin-left:35px;">
		 	  <table width="860" cellpadding="1px" ID="alter" cellspacing="0px" style="float: left; position: relative; margin: 0px 0px 0px 0px;">
			    <!--  CABECALHO DA TABELA -->
				<tr>
				  <td width="172" height="26" class="texttable_azul" style="background-color: #d7d7d7" scope="col" >&nbsp;</td>
				  <td colspan="6" class="texttable_cinza"  style="background-color: #d7d7d7; font-size:14px;" scope="col" ><fmt:message key="label.gerenciadorasEmOperacao" /></td>
				</tr>
			
				<tr>
				  <td class="texttable_azul" style="background-color: #ebebeb" ><fmt:message key="label.dadosVeiculo" /></td>
			
				  <td width="250" class="texttable_cinza" style="background-color: #ebebeb" >
				    <label>
				      <fmt:message key="label.opcaoD">
				      	<fmt:param>1 </fmt:param>
				      </fmt:message>
				      <input type="checkbox" name="checkbox"   id="checkbox" onclick="opcao1();"/>
				               
				    </label>
			 	  </td>
			
				  <td width="250" class="texttable_cinza" style="background-color: #ebebeb" >
				    <label>
					  <fmt:message key="label.opcaoD">
				      	<fmt:param>2 </fmt:param>
				      </fmt:message><input type="checkbox" name="checkbox" id="checkbox" onclick="opcao2();"/>
					</label>
				  </td>
				  <td width="250" class="texttable_cinza" style="background-color: #ebebeb" >
				    <label><fmt:message key="label.opcaoD">
				      	<fmt:param>3 </fmt:param>
				      </fmt:message><input type="checkbox" name="checkbox" id="checkbox" onclick="opcao3();"/>
				    </label>
				  </td>
			   </tr>
			   <tbody id="tbodyPlacass"> 
			 <c:forEach  items="${veiculosLista}" var="veiculo" varStatus="contador">
		  	  
		  	   <tr>
				 <td class="linkazulescuro">
							<fmt:message key="label.placa" />: ${veiculo.placa}<br />
							<fmt:message key="label.chassi" />: ${veiculo.chassi}<br />
							<fmt:message key="label.id" />: ${veiculo.contrato.equipamento.codigo}
			 	 </td>
			 <c:forEach var="gerenciadora" items="${veiculo.contrato.gerenciadora}" varStatus="numLinha">											
			   <c:if test="${!empty gerenciadora.nome}">
			     <td>			       
				   <a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC35/dv03&placaVeiculo=${veiculo.placa}&chassi=${veiculo.chassi}&idContrato=${veiculo.contrato.numeroContrato}&numOpcao=${numLinha.index + 1}&nomeGerenciadora=${gerenciadora.nome}&idGerenciadora=${gerenciadora.codigo}&idVeiculo=${veiculo.contrato.equipamento.codigo}" class="linkazul">${gerenciadora.nome}</a>
				 </td>	
			   </c:if>
			   <c:if test="${empty gerenciadora.nome}">					
                 <td>
                                 			
				   <img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/arrowright.png" width="16" height="16" hspace="5" border="0" align="absmiddle" />
				   <a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC35/dv03&placaVeiculo=${veiculo.placa}&chassi=${veiculo.chassi}&idContrato=${veiculo.contrato.numeroContrato}&numOpcao=${numLinha.index + 1}&nomeGerenciadora=${gerenciadora.nome}&idGerenciadora=${gerenciadora.codigo}&idVeiculo=${veiculo.contrato.equipamento.codigo}" class="linkazul"><fmt:message key="label.disponivelParaDirecionamento" /></a>
			 	 </td>
			   </c:if>
			 </c:forEach>
					</tr>	
					  
		    </c:forEach>
		    	</tbody>	
		</table>
	</div>					
		<div style="clear: both"></div>		
  </div>
		
</form>
</c:if> 