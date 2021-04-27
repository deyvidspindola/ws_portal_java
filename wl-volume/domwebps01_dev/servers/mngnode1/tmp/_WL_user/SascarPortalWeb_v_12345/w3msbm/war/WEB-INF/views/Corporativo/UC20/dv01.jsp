<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<script type="text/javascript">
		$(document).ready(function(){
	
			$("div.breadcrumb").html('<fmt:message key="uc20.texto.001.atendimentoVisualizarPagamentos" />');
			
			var container = $('div.container2');
			$("#formPesquisa").validate({
				errorContainer: container,
				errorLabelContainer: $("ol", container),
				wrapper: 'li'
			});

			$("#dataInicial").datepicker({
				dateFormat: 'dd/mm/yy',
				changeMonth: true,
				changeYear: true,
				onClose: function( selectedDate ) {
					$( "#dataFinal" ).datepicker( "option", "minDate", selectedDate );
				  }
			});

			$("#dataFinal").datepicker({
				dateFormat: 'dd/mm/yy',
				changeMonth: true,
				changeYear: true,
				onClose: function( selectedDate ) {
					$( "#dataInicial" ).datepicker( "option", "maxDate", selectedDate );
				  }
			});

			$('#dataInicial, #dataFinal').blur(function(){
				$(this).setMask('date');
			}).focus(function(){
				$(this).unsetMask();
			});

		});
	</script>
	
	
	<div class="container2">
		<ol>
			<li><label for="dataInicial" class="error"><fmt:message key="mensagem.campo.dataInicialValida" /></label></li>
			<li><label for="dataFinal" class="error"><fmt:message key="mensagem.campo.dataFinalValidaMaiorOuIgualInicial" /></label></li>
		</ol>
	</div>
	
	
	<div class="cabecalho3"><fmt:message key="label.historicoPrevisaoPagamentos" />
		<div class="caminho3" style="*margin-left:100px;">
	  		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" class="linktres"><fmt:message key="label.home" /></a> &gt;  
	  		<a href="#" class="linktres"><fmt:message key="label.pagamentos" /></a> &gt;   
	  		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC20/dv01" class="linkquatro"><fmt:message key="label.historicoPrevisaoPagamentos" /></a>
	  	</div>
 	</div>	   
	
	
	<form id="formPesquisa" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC20/dv02"method="post"class="filtro">
		
		<div class="busca_branca">
			<span class="text1"><fmt:message key="label.buscarPor" />:</span>
		</div>
		
		
		<div class="busca_cinza">
			<span class="text2">
				<fmt:message key="label.pagamentosVencimentoPeriodo" />
				<span class="asterisco">*
				</span>:
			</span>  
			<label>
				<input type="text" name="dataInicial" id="dataInicial" readonly="readonly" class="required text data" maxlength="10" value="${param.dataInicial }" />
			</label>  
			<label>
				<span class="text3">a</span>
					<input type="text" name="dataFinal" id="dataFinal" readonly="readonly" class="required text data" maxlength="10" value="${param.dataFinal }"  />
			</label>
		</div>
			
			
		<div class="busca_branca">
			<label>
				<input type="submit" class="button" value="<fmt:message key="label.buscar" />"/>
				<input name="button2" type="button" class="button4" id="button2" value="<fmt:message key="label.limpar" />" onclick="limparCampos('#formPesquisa');"/>
			</label>
		</div>
		
		
		<div class="busca_cinza">
		</div>
	</form>
	
