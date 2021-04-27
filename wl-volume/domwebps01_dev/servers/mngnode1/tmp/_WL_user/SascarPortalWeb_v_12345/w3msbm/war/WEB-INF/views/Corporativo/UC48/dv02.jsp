<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:if test="${not empty mensagem }">
	<script type="text/javascript">
		$.showMessage("${mensagem }");
	</script>
</c:if>

<c:if test="${not empty helper}" >
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>

	<script type="text/javascript">

	   function resetAll(){
		   $("#numeroProtocolo").val("");
		   $("#dataInicial").val("");
		   $("#dataFinal").val("");
		   $("#selecionarTodos").attr('checked','checked');		
		   $("#mensagem").html("");
	   }
	
	
		function desmarcar(input) {
			var valor = $.trim($(input).val());
	
			if (valor && valor != 0 && valor.length > 0) {
				$("#selecionarTodos").removeAttr("checked");
			}
		}
		
		function verificarCampos(){
			if($("#dataInicial").val() == "" && $("#dataFinal").val() == "" && $("#numeroProtocolo").val() == ""){
				$("#selecionarTodos").attr('checked','checked');
			}else{
				$("#selecionarTodos").attr('checked','');
			}
		}
		
		$(document).ready(function(){
			
			$(function () {
		        $('#formPesquisa').bind('submit', function (e) {
		        	  var html=""; 
		    		  var isOkSubmit = true;
		    		  
		    		  if(($("#dataInicial").val()  != "" && $("#dataFinal").val()== "")){
		    			  html +='<font color=CC0000><ol><li><label><fmt:message key="mensagem.campoObrigatorio.dataFinal" /><br></label></li></ol></font>';
		    			  $("#mensagem").html(html);
		    			  isOkSubmit = false; 
		    		  } 
		    	      if(($("#dataFinal").val()    != "" && $("#dataInicial").val()== "")){
		    	    	  html+='<font color=CC0000><ol><li><label><fmt:message key="mensagem.campoObrigatorio.dataInicial" /><br></label></li></ol></font>';
		    			  $("#mensagem").html(html);
		    			  isOkSubmit = false;
		    	      }
		    	      
		    	      return isOkSubmit;
		        });
		    });
			
			
		    $("#numeroProtocolo").setMask({mask:'99999999999'});
		
			$("#dataInicial").datepicker({
				maxDate: new Date(),
				dateFormat: 'dd/mm/yy',
				changeMonth: true,
		        changeYear: true,
		        onClose: function( selectedDate ) {
		            $( "#dataFinal" ).datepicker( "option", "minDate", selectedDate );
		            verificarCampos();
		          }
			});
			
			$("#dataFinal").datepicker({
				dateFormat: 'dd/mm/yy',
				changeMonth: true,
		        changeYear: true,
		        onClose: function( selectedDate ) {
		            $( "#dataInicial" ).datepicker( "option", "maxDate", selectedDate );
		            verificarCampos();
		          }
			});
			
			$('#dataInicial, #dataFinal').blur(function(){
				$(this).setMask('date');
			}).focus(function(){
				$(this).unsetMask();
			});
	
			$("#selecionarTodos").click(function(){
				if ($(this).is(':checked')){
					$(":text").val('');
					$("select").val('0');
				}
			});
	
			$("select, :text").each(function(){
				desmarcar(this);
			}).keypress(function(){
				desmarcar(this);
			}).keyup(function(){
				desmarcar(this);
			}).blur(function(){
				desmarcar(this);
			});
				
	
	});
		
	</script>
	
	<div id="mensagem"></div>

    <div class="cabecalho5">
       <a class="link_titleatualizacao tooltip" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC48/dv01"  title="<fmt:message key="label.faleConosco" />"><fmt:message key="label.faleConosco" /></a>
	     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <a class="link_titleatualizacao tooltip" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC48/dv02" title="<fmt:message key="label.historicoDeContato" />"><fmt:message key="label.historicoDeContato" /></a>
	
	   <div class="caminho" style="*margin-left: 120px;">
	     <a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres" ><fmt:message key="label.home" /></a> 
	   </div>
    </div>
    
    <div class="busca_branca">
	  <span class="text1"><fmt:message key="label.informeCampoCliqueBuscar" />:</span>
	  <span class="texthelp2">
	    <img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" /><fmt:message key="label.buscaAvancadaInformando" /> 
	  </span>
	</div>
		
	<form id="formPesquisa" action="<c:url value="/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC48/dv03"/>" method="post" onSubmit="return  validaCamposDeData();">

	  <div class="busca_cinza">
	    <label>
		  <span class="text2"><fmt:message key="label.numeroProtocolo" />: </span>
	      <input type="text" name="numeroProtocolo" id="numeroProtocolo" maxlength="7" value="${param.numeroProtocolo}" onkeyUp="verificarCampos()">
	    </label>
	  </div>

	  <div class="busca_branca">
	    <span class="text2"><fmt:message key="label.periodo" />:</span>  
	   	<label>
	      <span class="text3"><fmt:message key="label.dataInicial" />:</span>
	      <input type="text" name="dataInicial" id="dataInicial" value="${param.dataInicial}" class="text dateBR" onkeyUp="verificarCampos()" maxlength="10" readonly="readonly"/>
	    </label>
	      	
	    <label>
	      <span class="text3"><fmt:message key="label.dataFinal" />:</span>
	      <input type="text" name="dataFinal" id="dataFinal" value="${param.dataFinal}" dateHigher="#dataInicial" class="text dateBR" onkeyUp="verificarCampos()" maxlength="10" readonly="readonly" />
	    </label>     
	  </div>

	  <div class="busca_cinza"> 
	    <label>
	   	  <input name="selecionarTodos" type="checkbox" class="check" id="selecionarTodos" checked="checked"/>
		  <span class="text2"><fmt:message key="label.buscarTodos" /> </span>
	    </label>
	  </div>
		
	  <div class="busca_branca">
	    <input name="button" type="submit" class="button" id="button" value="<fmt:message key="label.buscar" />"  />
	   	<input name="button2" type="button" class="button4" id="Limpar" value="<fmt:message key="label.limpar" />" onclick="resetAll()" />
	  </div>
   </form>