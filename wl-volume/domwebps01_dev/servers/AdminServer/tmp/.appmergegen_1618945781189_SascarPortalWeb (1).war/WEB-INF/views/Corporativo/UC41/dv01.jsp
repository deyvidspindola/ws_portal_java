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

   $(function(){$("#formPesquisa").bind("submit", validar);}); 
    
   function validar(e){	
	   
	   var flag = 0;
	   
	   var conteinerValidacao = $(".conteinerValidacao");
	   conteinerValidacao.find('li').remove();
	  
	   
	    if($("#numeroRemessaField").val() == "" && $("#dataInicialPesquisa").val() == "" && $("#dataFinalPesquisa").val() =="" && $("#status").val() =="" ){
		   $("#erro").html('<b><fmt:message key="mensagem.informacao.preenchimentoUmCampoConsulta" /></b>');		  
	      flag=1;
	   }else{
		   flag=0;
	   }	   
	    
	    if(flag==0){
	    	return true;
	    }else{
	    	return false;
	    }
	    
	    
	}
	
   $(document).ready(function(){	
		
		var container = $('div.container2');
		$("#formPesquisa").validate({
			
			rules: {
				"dataInicialPesquisa": {
				required: false,
				dateBR: true
				},
			     "dataFinalPesquisa": {
				required: false,
				dateBR: true
				}
				},
				messages: {
				
				},
			errorContainer: container,
			errorLabelContainer: $(container),
			submitHandler : function(form) {
			    submeterExtratoSintetico(form);
			    return false;
			}
		   
		});
			
	
    $("#numeroRemessaField").setMask({mask:'99999999'});
	     
	$("#dataInicialPesquisa").datepicker({
		dateFormat: 'dd/mm/yy',
		changeMonth: true,
        changeYear: true,
        onClose: function( selectedDate ) {
            $( "#dataFinalPesquisa" ).datepicker( "option", "minDate", selectedDate );
          }
	});
	
	$("#dataFinalPesquisa").datepicker({
		dateFormat: 'dd/mm/yy',
		changeMonth: true,
        changeYear: true,
        onClose: function( selectedDate ) {
            $( "#dataInicialPesquisa" ).datepicker( "option", "maxDate", selectedDate );
          }
	});

	$('#dataInicialPesquisa, #dataFinalPesquisa').blur(function(){
      $(this).setMask('date');
	    }).focus(function(){
			$(this).unsetMask();
		});	
	});
</script>

<div class="conteinerValidacao">
		<ol style="color: #C00;">
		</ol>
	</div>
  
    <div id="erro" style="color:#CC3333;" class="error"></div>
    <div class="container2">
	
		<label for="dataInicialPesquisa" class="error"><fmt:message key="mensagem.campo.dataInicialValida" /><br></label>
		<label for="dataFinalPesquisa" class="error"><fmt:message key="mensagem.campo.dataFinallValida" /></label>
	
	
</div>
    
 	<form id="formPesquisa"  method="post"  action="<c:url value="/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC41/dv02"/>">
		
		 <div class="cabecalho2"><fmt:message key="label.consultarRemessaDeEstoque" />
			<div class="caminho">
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" class="linktres"><fmt:message key="label.home" /></a> &gt;  
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC41/dv01" class="linktres"><fmt:message key="label.servicos" /></a> &gt;   
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC41/dv01" class="linkquatro"><fmt:message key="label.consultarRemessaEstoque" /></a>
			</div>
		</div>	
		
		<div class="busca_branca">
		
			<span class="text1"><fmt:message key="label.escolhaTipoBusca" /></span>
			<span class="texthelp2">
				<img hspace="5" height="16" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png">
				<fmt:message key="label.buscaAvancada" />
			</span>
		</div>
		
		
		<div class="busca_cinza">
			<span class="text2"><fmt:message key="label.numeroDaRemessa" />: </span>
			<span class="text3"><fmt:message key="label.nAbrev" />:</span>
			<label>
				<input id="numeroRemessaField" type="text"  maxlength="8" name="numeroRemessaField" value="${param.numeroRemessaField}">
			</label>
		</div>

		
		<div class="busca_branca">
		
			<span class="text2"><fmt:message key="label.periodo" />:</span>
			<label style="margin-left:52px;">
				<span class="text3"><fmt:message key="label.dataInicial" />:</span>
				<input id="dataInicialPesquisa" type="text" value="${param.dataInicialPesquisa}" maxlength="10" name="dataInicialPesquisa" readonly="readonly" />
			</label>
			<label>
				<span class="text3"><fmt:message key="label.dataFinal" />:</span>
				
				<input id="dataFinalPesquisa" type="text" value="${param.dataFinalPesquisa}" maxlength="10" name="dataFinalPesquisa" readonly="readonly" />
			</label>
			<span class="texthelp2" style="*margin-top:-22px;">
				<img hspace="5" height="16" width="16" alt="" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png">
				<fmt:message key="label.buscarTodosRegistroDataMesAno" />
			</span>
			
		</div>
		<br>
		
		<div class="busca_cinza">
			<span class="text2"><fmt:message key="label.Status" />:</span>
			<label>
				<select id="status" name="statusRemessaField"  style="margin-left: 110px;">
				    <option selected="selected" value="${statusRemessaField}"><fmt:message key="label.selecione" /></option>
					<option value="E"   <c:if test="${param.statusRemessaField eq 'E' }">selected="selected"</c:if> >Enviado</option>
					<option value="R"   <c:if test="${param.statusRemessaField eq 'R'}">selected="selected"</c:if> >Recebido</option>
					<option value="C"   <c:if test="${param.statusRemessaField eq 'C'}">selected="selected"</c:if> >Cancelado</option>			
    			</select>
			</label>
		</div>
		
		
		<div class="busca_branca">
			<input id="button" class="button" type="submit"  value="<fmt:message key="label.buscar" />">
			 <input name="button2" type="button" class="button4"  id="button" value="<fmt:message key="label.limpar" />" onclick="limparCampos('#formPesquisa');" />
		</div>
	</form>
	