<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>
 <c:catch var="helper" >
	<c:import url="/ConsultarEstoqueSintetico/consultarEstoqueMateriais?acao=3" context="/SascarPortalWeb"  />
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

		
</script>


	<!-- >div class="cabecalho">
	
		<div class="caminho" style="">
			<a class="linktres" title="Home" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}">Home</a>
			&gt;
			<a class="linktres" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv01">Serviços</a>
			&gt;
			<a class="linkquatro" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv01">Consultar Estoque Sintético</a>
		</div>
		
		Consultar Estoque Sintético
		
	</div-->
<div class="cabecalho2"><fmt:message key="label.consultarEstoqueSintetico" />
			<div class="caminho">
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" class="linktres"><fmt:message key="label.home" /></a> &gt;  
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv01" class="linktres"><fmt:message key="label.servicos" /></a> &gt;   
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv01" class="linkquatro"><fmt:message key="label.consultarEstoqueSintetico" /></a>
			</div>
		</div>

	<div class="barraatualizacao2_antiga">
	
		<div class="titleatualizacao_4_antiga">
         <a class="link_titleatualizacao tooltip" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv02&tipoProduto=${tipoProduto}&listarRepresentanteEstoque=${codigoRepresentante}" title="Consultar Imobilizados"><fmt:message key="label.imobilizados" /></a>
       </div>
		
		<div class="titleatualizacao_3_antiga">
			<a class="link_titleatualizacao tooltip" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv04" title="Consultar Materiais"><fmt:message key="label.materiais" /></a>
		</div>
	</div>


	<table class="detalhe" cellspacing="0">
		<tbody>
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.materiais" /></th>
			</tr>
		</tbody>
	</table>


	<table id="alter" cellspacing="0" cellpadding="1" width="850">
		<tbody>
			<tr>
				<th class="texttable_azul" width="34%" title="Data da abertura do serviço" scope="col"><fmt:message key="label.material" /></th>
				<th class="texttable_cinza" width="12%" scope="col"><fmt:message key="label.qtdeDisponivel" /></th>
				<th class="texttable_cinza" width="15%" scope="col"><fmt:message key="label.qtdeEmTransito" /></th>
			</tr>
			<c:set var="TotalMateriais" value="0"></c:set>	 
			<c:forEach  items="${listarEstoqueMateriais}" var="material" varStatus="contador">
			<tr class="dif">
				<td class="linkazulescuro">${material.descricao} </td>
				<td>${material.quantidadeEstoque} </td>
				<td>${material.quantidadeStatusTransito} </td>
			</tr>
			<c:set var="TotalMateriais" value="${TotalMateriais+1}"></c:set>			
			</c:forEach>
		</tbody>
	</table>

	
	<table id="alter" cellspacing="0" cellpadding="1" width="850">
		<tbody>
			<tr class="dif">
				<td class="linkazulescuro" width="35%" style="font-weight: bold; background-color: rgb(215, 215, 215); text-align: right;"><fmt:message key="label.quantidadeTotal" />:</td>
				<td width="65%" style="text-align: left; background-color: rgb(215, 215, 215); font-weight: bold;">${TotalMateriais}</td>
			</tr>
		</tbody>
	</table>

<input id="" class="button3" type="reset" onclick="window.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv02&tipoProduto=${tipoProduto}&listarRepresentanteEstoque=${codigoRepresentante}'" value="<fmt:message key="label.voltar" /> " name="button2">

	<div class="pgstabela" style="">
	</div>

