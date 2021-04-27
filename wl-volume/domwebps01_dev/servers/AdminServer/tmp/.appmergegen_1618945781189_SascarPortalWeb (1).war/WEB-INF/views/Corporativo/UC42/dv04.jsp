<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>
<c:catch var="helper" >
	<c:import url="/ConsultarRemessaEstoque/consultarDadosPrincipaisRemessa?acao=2&numeroRemessa=${param.remessaField}" context="/SascarPortalWeb"  />
</c:catch>
 


<c:if test="${not empty helper}" >
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>


<script type="text/javascript">
	$(document).ready(function(){
		window.print();
	});
	
</script>

	<body>

<table border="1"  class="detalhe2">
<tr>
	<td colspan="2">
	    <p><img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/logo-sascar.jpg" alt="SASCAR" /></p>
			Sascar Tecnologia e Seguran&ccedil;a Automotiva S/A.<br>
			Rua Tenente Djalma Dutra, 800 Centro<br>
			S&atilde;o Jos&eacute; dos Pinhais &ndash; PR CEP 83.005-360<br>
			Telefone: 41-3299-6000
		</td>	
		<td colspan="2" style="text-align:center;">
		  Recibo <br> de <br> remessa <br> de <br> Estoque		
		</td> 
		<td style="text-align:center;">
		  N&uacute;mero <br> ${detalheRemessa.numeroRemessa}
		</td> 
</tr>	
<tr>
   <td colspan="4"><fmt:message key="label.remetentes" />: <br>  
      ${detalheRemessa.representante.remetenteReprResponsavel}<br>
      ${detalheRemessa.enderecoRemetente.descricaoLogradouro}
   </td>
   <td>
      <fmt:message key="label.dataDeEmissao" />: <br> ${detalheRemessa.dataRemessa}
   </td>
</tr>	
<tr>
  <td  colspan="5"><fmt:message key="label.destinatario" />:
       <br>
        ${detalheRemessa.representante.destinatarioReprEstoque}
       <br>
        ${detalheRemessa.enderecoDestinatario.descricaoLogradouro}     
  </td>
</tr>
<tr>
  <td colspan="5">
     <fmt:message key="label.quantidadeVolumes" />:<br>
     ${detalheRemessa.quantidadeVolumes}<br>
     Peso<br>
     ${detalheRemessa.pesoRemessa} Kg.        
  </td>
</tr>
<tr>
  <td colspan="5"></td>
</tr>
 <c:if test="${not empty detalheImobilizadoRemessas}">
<tr>
  <td colspan="5" style="text-align:center;"> <fmt:message key="label.controleSerial" /> </td> 
</tr>
<tr>

	   <%int countTotal = 0; %>	
    
    <c:forEach items="${detalheImobilizadoRemessas}" var="grupoItemImobilizado">       
        <td colspan="5"><div align="left"><h3 style="color:black">${grupoItemImobilizado.descricao}</h3></div></td>	  
	     <tbody>
		   <tr>
			 <th class="texttable_cinza" width="12%" title="<fmt:message key="label.dataAberturaServico" />" scope="col"><fmt:message key="label.serie" /></th>
		  	 <th class="texttable_cinza" width="29%" scope="col"><fmt:message key="label.produto" /></th>
		  	 <th class="texttable_cinza" width="12%" scope="col"><fmt:message key="label.versao" /></th>
		  	 <th class="texttable_cinza" width="32%" scope="col"><fmt:message key="label.modelo" /></th>
		  	 <th class="texttable_cinza" width="15%" scope="col"><fmt:message key="label.valorUnitario" /></th>
		   </tr>
		   <%int countItensImobilizados=0; %>
		   <c:forEach  items="${grupoItemImobilizado.produtos}" var="itemImobilizado" varStatus="contador">		
			 <tr class="dif">
			   <td>${itemImobilizado.serieImobilizado}</td>
			   <td>${itemImobilizado.descricaoItemImobilizado}</td>
			   <td>${itemImobilizado.versaoImobilizado} </td>
			   <td>${itemImobilizado.modeloImobilizado} </td>
			   <td><fmt:formatNumber value="${itemImobilizado.valorUnitario}" type="currency"/></td>
			</tr>
			<%countItensImobilizados++; %>	
			<%countTotal++; %>
			</c:forEach>					
			</tbody>	
		  <tbody>
		    <tr>		  
			  <td class="camposinternos" width="358" colspan="5"><b>Total ${grupoItemImobilizado.descricao} =  <%= countItensImobilizados%></b></td>			  
			</tr>
		  </tbody>
   </c:forEach>				
</tr>
</c:if>
<tr>


 <c:if test="${not empty detalheMaterialRemessas}">  
 <tr>
  <td colspan="5" style="text-align:center;"> <fmt:message key="label.materiais" /></td> 
</tr>     
       <%int countItensMateriais =0; %>
	 <c:forEach  items="${detalheMaterialRemessas}" var="detalheMaterialRemessa" varStatus="contador">	 
	 	<tbody>
				<tr>
					<th class="barracinza" width="209"><fmt:message key="label.material" /></th>
					<td class="camposinternos" width="358" colspan="4"> ${detalheMaterialRemessa.descricao }</td>					
				</tr>
			</tbody>
			<tbody>
				<tr>
					<th class="texttable_cinza" width="11%" title="<fmt:message key="label.dataAberturaServico" />" scope="col"><fmt:message key="label.codigoProduto" /></th>
					<th class="texttable_cinza" width="27%" scope="col" colspan="3"><fmt:message key="label.produto" /></th>
					<th class="texttable_cinza" width="11%" scope="col"><fmt:message key="label.quantidadeDeEnvio" /></th>
				</tr>
		     <c:forEach  items="${detalheMaterialRemessa.produtos}" var="itemMaterial" varStatus="count">		
				<tr class="dif">
					<td>${itemMaterial.codigo}</td>
					<td colspan="3">${itemMaterial. descricaoProduto} </td>
					<td>${itemMaterial.quantidade}</td>
				</tr>
			   <%countItensMateriais++;%>	
			</c:forEach>									
			</tbody>			
			<tbody>
				<tr>					
					<td class="camposinternos" width="358" colspan="5">Total ${detalheMaterialRemessa.descricao } =<b><%=countItensMateriais%></b></td>
				</tr>
			</tbody>		
   </c:forEach>	
</c:if>   
</tr>
<tr>
  <td colspan="5">
 	 <fmt:message key="label.observacao" /><br>
	${detalheRemessa.observacaoRemessa}
  </td>
</tr>
<tr>
<td colspan="5">  
     <div class="remessa2">
		Recebemos os equipamentos de seguran&ccedil;a de ve&iacute;culos, contidos neste recibo,
	<br>
	    e confirmo que s&atilde;o de propriedade da Sascar Tecnologia e Seguran&ccedil;a Automotiva Ltda. SASCAR S&Atilde;O JOS&Eacute; DOS PINHAIS.
	</div> </td>
</tr>
</table>
		
