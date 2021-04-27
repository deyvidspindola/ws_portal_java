<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/AgendarOrdemServico/iniciarBuscaAgenda?acao=7" context="/SascarPortalWeb"  />
</c:catch>


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
	function listarHorarios(form) {
		var data = $(form).serialize();
		var dataInicial = form.dataInicial.value;
		var dataFinal = form.dataFinal.value;
		
		$.ajax({
			url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC11/dv03",
			data: data || {},
			dataType:"html",
			beforeSend: function(){
				$("#ajaxList").html('');
				$("#ajaxList").hide();
			},
			success: function(html){
				$("#ajaxList").show().html(html);
				$("#dialogBuscarAgenda").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
				
				// TODO: REVER
				form.dataInicial.value = dataInicial;
				form.dataFinal.value = dataFinal;
			}
		});
	}

	$(document).ready(function(){
		
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

		var container = $('#msgErrorFormBuscaAgendamento');
		$("#formPesquisa").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler : function(form){
				listarHorarios(form);
			}
		});
	});
</script>


<div class="rbroundbox" id="popupArquivo" style="width: 100%; *width: 80%;">
	<div class="rbtop"><div></div></div>
			
	<div class="rbcontent">
		
			<h3><fmt:message key="uc11.dv02.texto.01" />:</h3>
	  	
			<div class="container2" id="msgErrorFormBuscaAgendamento"> 
				<ol>
					<li>
						<label for="dataInicial" class="error"><fmt:message key="mensagem.informacao.dataMaiorQAtual" /></label>
					</li>
					<li>
						<label for="dataFinal" class="error"><fmt:message key="mensagem.informacao.dataFinalMaiorIgualInicial" /></label>
					</li>
					<li>
						<label for="horario" class="error"><fmt:message key="mensagem.selecione.horarioPAgendamento" /></label>
					</li>
				</ol>
			</div>
	  
	  
			<form action="" method="post" id="formPesquisa">
				<input type="hidden" name="numeroOS" value="${param.numeroOS }" />
				<input type="hidden" name="siglaUF" value="${param.siglaUF }" />
				<input type="hidden" name="codigoCidade" value="${param.codigoCidade }" />
				<input type="hidden" name="codigoZona" value="${param.codigoZona }" />
				<input type="hidden" name="codigoBairro" value="${param.codigoBairro }" />
				<input type="hidden" name="localidadeInstalacao" value="${param.localInstalacao }" />
				<div id="ajaxList" style="display: none; overflow: auto;"></div>
		    	<span class="text2"><fmt:message key="label.periodo" />:</span>
				<label> 
					<fmt:message key="label.dataInicial" />:
		  			<input type="text" name="dataInicial" id="dataInicial" readonly="readonly" class="text data required dateHigherNow" />
		  		</label>
		  		<label>
		  			<fmt:message key="label.dataFinal" />:
		      		<input type="text" name="dataFinal" id="dataFinal" readonly="readonly" class="text data required" />
		    	</label>
		    	
		    	
				<div class="botoeslimparbuscar">
				    <label>
				    	<input name="button" type="submit" class="button" value="<fmt:message key="label.buscar" />" />
				    	<input name="button" type="button" class="button4" value="<fmt:message key="label.limpar" />" onclick="limparCampos('#formPesquisa');" />
				    </label>
				</div>
			</form>
			
			<div>
		       	<label>
		       		<input name="button2" type="button" class="button2 close" id="button2" value="<fmt:message key="label.voltar" />" onclick="$.closeOverlay();"/>
		   		</label>
		   	</div>

</div>
	
	<div class="rbbot"><div></div></div>
</div>

