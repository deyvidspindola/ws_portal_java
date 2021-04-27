<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>
<!-- Utilizando o WS 128 já criado em Remessa -->
 <c:catch var="helper" >
	<c:import url="/CriarRemessaEstoque/listarRepresentanteEstoque?acao=1" context="/SascarPortalWeb"  />
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
<script>

$(function(){$("#formPesquisa").bind("submit", validar);}); 

function validar(e){
	
	$("#erro").html("");
	$("#erro1").html("");
	
	var flag = 0;
	
	    if($("#listarRepresentanteEstoque").val() ==""){
		   $("#erro").html('<b><fmt:message key="mensagem.campoObrigatorio.representante" /></b>');		  
	      flag = 1;
	   }	
	    
	    if($("#tipoProduto").val() ==""){
			   $("#erro1").html('<b><fmt:message key="mensagem.campoObrigatorio.tipoProduto" /></b>');		  
		      flag = 1;
		   }
	    
	    if(flag==1){
	    	return false;
	    }else{
	        return true;
	    }
	   
}
</script>
 <div id="erro" style="color:#CC3333;" class="error"></div>
 <div id="erro1" style="color:#CC3333;" class="error"></div>
 <div class="cabecalho2"><fmt:message key="label.consultarEstoqueSintetico" />
			<div class="caminho">
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" class="linktres"><fmt:message key="label.home" /></a> &gt;  
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv01" class="linktres"><fmt:message key="label.servicos" /></a> &gt;   
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv01" class="linkquatro"><fmt:message key="label.consultarEstoqueSintetico" /></a>
			</div>
		</div>	
		<!-- div class="cabecalho">
			<div class="caminho" style="">
				<a class="linktres" title="Home" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}">Home</a>
				&gt;
				<a class="linktres" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv01">Serviços</a>
				&gt;
				<a class="linkquatro" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv01">Consultar Estoque Sintético</a>
			</div>
			
			Consultar Estoque Sintético
			
		</div-->	
  <form id="formPesquisa"  method="post"  action="<c:url value="/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC37/dv02"/>">
		
		<div class="busca_branca">
			<span class="text1"><fmt:message key="label.selecioneRepresentanteEstoque" />:</span>
		</div>	
		<div class="busca_cinza" >
			<label style="margin-left:-20px;">
				<span class="text2"><fmt:message key="label.representanteEstoque" />:</span>
                <select name="listarRepresentanteEstoque" id="listarRepresentanteEstoque"   class="required">
			        <option value=""><fmt:message key="label.selecione" /></option>
				      <c:if test="${not empty listarRepresentanteEstoque}">
				        <c:forEach var="listarRepresentanteEstoque" items="${listarRepresentanteEstoque}">
		        	 	   <option  value="${listarRepresentanteEstoque.identifier}">${listarRepresentanteEstoque.value}</option>
				        </c:forEach>
				      </c:if>  
		  	      </select>	
			</label>
		
			<label>
				<span class="text2"><fmt:message key="label.tipoProduto" />:</span>
					<select id="tipoProduto" class="required" name="tipoProduto" style="width: 220px;">
						<option value=""><fmt:message key="label.selecione" /></option>
						<option value="L"><fmt:message key="label.locacao" /></option>
						<option value="R"><fmt:message key="label.revenda" /></option>
					</select>
			</label>
			<label>
			
			<input id="button" class="button" type="submit"  value="<fmt:message key="label.buscar" />" name="button">
		
			</label>		
		</div>	
	
  </form>		