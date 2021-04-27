<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>


<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>  
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

function setValues(){
	
	
	$.ajax({
		"url": "/SascarPortalWeb/CriarRemessaEstoque/ submeterRemessa",
		"data" : { "imobilizadosIncluidos":"3", "acao" : 6},
		"dataType" : "json",	
		"success": function(json){				
			if (json.success) {
				 $("#numeroRemessa").html(json.numeroRemessa);
				 $("#remessaField").val(json.numeroRemessa);
				 $("#dialog_mensagem").jOverlay({'onSuccess' : function(){
        			
        		 }});
	    	} else {
				$.showMessage(json.mensagem);
			}
		}
	});	
  
}

function redirect(){
	window.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC42/dv02&numRemessa=' + $("#remessaField").val();
}

		
</script>

 

	<div class="cabecalho">
		<div class="caminho" style="">
			<a class="linktres" title="<fmt:message key="label.home" />" href=""${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}""><fmt:message key="label.home" /></a>
			&gt;
			<a class="linktres" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC42/dv01"><fmt:message key="label.servicos" /></a>
			&gt;
			<a class="linkquatro" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC42/dv01">
			<strong><fmt:message key="label.criarRemessaDeEstoque" /></strong>
			</a>
		</div>
		
		<strong><fmt:message key="label.criarRemessaDeEstoque" /></strong>
		
	</div>


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
				<th class="barracinza" width="209"><fmt:message key="label.representanteResponsavel" /></th>
				<td class="camposinternos" width="358">${SascarUser.nome }</td>
				<th class="barracinza" width="200"><fmt:message key="label.representanteEstoque" /></th>				
				<td class="camposinternos" width="350">${nomeRepresentanteResp}</td>
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
				<th class="barracinza" width="185"><fmt:message key="label.representanteResponsavel" /></th>
				<td class="camposinternos" width="310">${nomeRepresentanteRespDest}</td>
				<th class="barracinza" width="183"><fmt:message key="label.representanteEstoque" /></th>
				<td class="camposinternos" width="300">${nomeRepresentanteRespDestE}</td>
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
				<th class="barracinza" width="105"><fmt:message key="label.tipoMovimentacao" /></th>
				<td class="camposinternos" width="300">${tipoMovimentacao}</td>
				<th class="barracinza" width="105"><fmt:message key="label.tipoProduto" /></th>
				<td class="camposinternos" width="300">${tipoProduto}</td>				
			</tr>
			<tr>
				<th class="barracinza" width="183"><fmt:message key="label.transportadora" /></th>
				<td class="camposinternos" width="300">${transportadora}</td>
			    <th class="barracinza" width="183"><fmt:message key="label.quantidadeVolumes" /></th>
				<td class="camposinternos" width="300">${quantidadeVolumes}</td>		
			</tr>
			<tr>
				<th class="barracinza" width="185"><fmt:message key="label.observacao" /></th>
				<td class="camposinternos" width="285">${observacao}</td>
			</tr>
		</tbody>
	</table>

<c:if test="${not empty listaImobilizados}">	
	<table class="detalhe" cellspacing="0">
		<tbody>
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.selecaoEquipamentosAcessorios" /></th>
			</tr>
		</tbody>
	</table>
	<table class="detalhe2" cellspacing="3" width="100%">
		<tbody>
			<tr>
				<th class="barracinza" width="209"><fmt:message key="label.imobilizado" /></th>
				<td class="camposinternos" width="358">${itemImobilizado}</td>
				<th class="camposinternos" width="200">&nbsp;</th>
				<td class="camposinternos" width="350"></td>
			</tr>
		</tbody>
	</table>


	<h1 style="margin-left: 0pt;"><fmt:message key="label.equipamentoAcessorioIncluido" />:</h1>

	<table id="alter" cellspacing="0" width="850">
		<tbody>
			<tr>
				<th class="texttable_cinza" width="13%"><fmt:message key="label.serie" /></th>
				<th class="texttable_cinza" width="11%"><fmt:message key="label.codigoProduto" /></th>
				<th class="texttable_cinza" width="26%"><fmt:message key="label.produto" /></th>
				<th class="texttable_cinza" width="9%"><fmt:message key="label.versao" /></th>
				<th class="texttable_cinza" width="24%"><fmt:message key="label.modelo" /></th>
				<th class="texttable_cinza" width="14%"><fmt:message key="label.Status" /></th>
			</tr>
		<%int countImobilizado =0; %>	
		   <c:forEach var="imobilizado" items="${listaImobilizados}">
    		<tr class="dif">
				<td class="camposinternos">${imobilizado.serieImobilizado}</td>
				<td class="camposinternos">${imobilizado.codigo}</td>
				<td class="camposinternos">${imobilizado.descricaoItemImobilizado}</td>
				<td class="camposinternos">${imobilizado.versaoImobilizado}</td>
				<td class="camposinternos">${imobilizado.modeloImobilizado}</td>
				<td class="camposinternos">${imobilizado.statusImobilizado}</td>
			</tr>
			<%countImobilizado ++; %>
			  </c:forEach>
		</tbody>
	</table>
	
	
	<table class="detalhe2" cellspacing="3" width="100%">
		<tbody>
			<tr>
				<th class="barracinza" width="175"><fmt:message key="label.quantidadeValvulas" /></th>
				<td class="camposinternos" width="197"><%=countImobilizado %></td>
				<td class="camposinternos" width="278">&nbsp;</td>
				<td class="camposinternos" width="285">&nbsp;</td>
			</tr>
		</tbody>
	</table>

</c:if>
	<table class="detalhe" cellspacing="0">
		<tbody>
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.selecaoDeMateriais" /></th>
			</tr>
		</tbody>
	</table>


	<table class="detalhe2" cellspacing="3" width="100%">
		<tbody>
			<tr>
				<th class="barracinza" width="209"><fmt:message key="label.grupoMaterial" /></th>
				<td class="camposinternos" width="358"><fmt:message key="label.materialDeInstalacao" /></td>
				<th class="camposinternos" width="200">&nbsp;</th>
				<td class="camposinternos" width="350"></td>
			</tr>		
		</tbody>
	</table>

  
	<h1 style="margin-left: 0pt;"><fmt:message key="label.materialIncluido" />:</h1>

	<table id="alter" cellspacing="0" width="850">
		<tbody>
			<tr>
				<th class="texttable_cinza" width="22%"><fmt:message key="label.codigoProduto" /></th>
				<th class="texttable_cinza" width="26%"><fmt:message key="label.produto" /></th>				
				<th class="texttable_cinza" width="29%"><fmt:message key="label.quantidadeEnvio" /></th>
			</tr>
			<%int countMateriais = 0; %>
		 <c:forEach var="materiais" items="${listaMateriais}">
			<tr class="dif">
				<td class="camposinternos">${materiais.codigo}</td>
				<td class="camposinternos">${materiais.descricao}</td>				
				<td class="camposinternos">${materiais.quantidadeStatusTransito}</td>
			</tr>
			<%countMateriais++; %>
		</c:forEach>
		</tbody>
	</table>	
	<table class="detalhe2" cellspacing="3" width="100%">
		<tbody>
			<tr>
				<th class="barracinza" width="175"><fmt:message key="label.quantidadeMaterial" /></th>
				<td class="camposinternos" width="197"><%=countMateriais %></td>
				<td class="camposinternos" width="278">&nbsp;</td>
				<td class="camposinternos" width="285">&nbsp;</td>
			</tr>
		</tbody>
	</table>

<input id="button" class="button3" type="button" onclick="history.go(-1)" value="<fmt:message key="label.voltar" />" name="button">
	<div class="pgstabela" style="">
	    <!-- input class="button3" type="button" onclick="window.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC42/dv01&listaImobilizados=${listaImobilizados}&listaMateriais=${listaMateriais}&listaImobilizadosTabela=${listaImobilizadosTabela}'" tabindex="10" value="Voltatr"-->
		
		<input id="button" class="button" type="button" style="" onclick="setValues()" value="<fmt:message key="label.criarRemessa" />" name="button">
	</div>

	<div id="dialog_submeter_direcionamento" class="popup_padrao" style="display: none;">        
			 <div class="popup_padrao_pergunta"><div id="gerencia"></div></div>
		    <div class="popup_padrao_resposta">
			<input name="" type="submit" class="button close" value="<fmt:message key="label.sim" />" onclick="submeterGerenciadora();">
			<input type="button" class="button4 close" value="<fmt:message key="label.nao" />" onclick="window.location.reload()" />
          </div>	
	</div>
       
     <input type="hidden" id="idRepresentanteResp"       value="${idRepresentanteResp}"> 
     <input type="hidden" id="idRepresentanteRespDest"   value="${idRepresentanteRespDest}">
     <input type="hidden" id="idRepresentanteRespDestE"  value="${idRepresentanteRespDestE}">  
     <input type="hidden" id="idTipoMovimentacao"        value="${idTipoMovimentacao}">  
     <input type="hidden" id="idTipoProduto"             value="${idTipoProduto}">  
     <input type="hidden" id="idTransportadora"          value="${idTransportadora}">  
     <input type="hidden" id="quantidadeVolumes"         value="${quantidadeVolumes}"> 
     <input type="hidden" id="observacao"                value="${observacao}">  
          
    <div id="dialog_mensagem" class="popup_padrao" style="display: none;">   
    	<form action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Imprimir&page=Corporativo/UC42/dv04" onsubmit="openPopupPrint(this);" method="post">
         	<div class="popup_padrao_pergunta">
			
				<fmt:message key="mensagem.sucesso.remessaGerada" />
					<br>
					<fmt:message key="label.numeroDaRemessa" />:
					<span id="numeroRemessa" style="color: rgb(204, 0, 0);"></span>
					 <input type="hidden" id="remessaField" name="remessaField">
					<br>
			</div>	
				
				<div class="popup_padrao_resposta">
					<input class="button close" type="submit" value="<fmt:message key="label.imprimir" />">
					<input class="button4" type="button" value="<fmt:message key="label.fechar" />" onclick="redirect()">
				</div>
		</form>			
        
    </div>
     
    <div style="clear:both"></div> 
    <br />    