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

<c:if test="${not empty helper}" >
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>

<script type="text/javascript">
  $(document).ready(function(){
	// SUBMETER A FORM
	   var container = $('div.container2');
	   $("#formPesquisarHistorico").validate({	
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			rules: {
				codigoMes: {					
					required: true
				}
			},
			messages: {
				codigoMes: {					
					required: '<fmt:message key="mensagem.selecione.algumPeriodo" />'
				}
			},
	   	   submitHandler : function(form) {
	   	     var periodo = $("#codigoMes").val();
	   	       window.location.href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC56/dv03&periodo="+periodo;
		     return false;
	       }
		});
	});
</script>

	<div class="container2"> 
	      <ol>
	      </ol>
    </div>
    			
	<div class="cabecalho5" style="padding-left: 100px;">
      <a class="link_titleatualizacao tooltip" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC56/dv01"  title="Veículos sem atualização"><fmt:message key="label.veiculosSemAtualizacao" /></a>
	  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <a class="link_titleatualizacao tooltip" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC56/dv02" title="Histórico de Veículos sem Atualização"><fmt:message key="label.historicoVeiculosSemAtualizacao" /></a>
	  <div class="caminho" style="*margin-left:10px;"><a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a>&gt; <a href="#" class="linktres"><fmt:message key="label.servicos" /></a> &gt; 
	    <a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC56/dv01"  class="linkquatro"><fmt:message key="label.veiculosSemAtualizacao" /></a>
      </div>
	</div>

    <div class="busca_branca">
	  <span class="text1"> <fmt:message key="mensagem.selecione.periodoConsultaParaBuscar" />:</span> 
    </div>
    
	<div class="busca_cinza">
      <form id="formPesquisarHistorico" action=""  method="post">
		<label>
		 <fmt:message key="label.selecionePeriodo" />:
		   <select name="codigoMes" id="codigoMes" class="required">		  
		     <option value=""><fmt:message key="label.selecione" /></option>
   	 	     <option  value="3" <c:if test="${param.periodo eq '3' }"> selected="selected"</c:if>>3 meses</option>
		     <option  value="6" <c:if test="${param.periodo eq '6' }"> selected="selected"</c:if>>6 meses</option>
	 	     <option  value="9" <c:if test="${param.periodo eq '9' }"> selected="selected"</c:if>>9 meses</option>
	 	     <option  value="12"<c:if test="${param.periodo eq '12' }"> selected="selected"</c:if>>12 meses</option>
		   </select>	 	
		</label>		
		  <input id="button" class="button" type="submit"  value="<fmt:message key="label.buscar" />" name="button">      
      </form>
    </div>