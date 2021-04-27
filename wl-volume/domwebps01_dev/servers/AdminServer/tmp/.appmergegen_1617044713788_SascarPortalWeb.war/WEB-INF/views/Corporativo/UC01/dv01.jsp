<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/PesquisarContratos/listarServicosContratados?acao=1" context="/SascarPortalWeb"  />
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

	$(document).ready(function(){
		
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

		$('#numeroCpfCnpj').blur(function(){
			if(this.value.length <= 11) {
				$(this).setMask('cpf');
			} else {
				$(this).setMask('cnpj');
			}
		}).focus(function(){
			$(this).unsetMask();
		});
		
		
		$('#codigoServicoContratado').val('${param.codigoServicocontratado}');
		$('#statusContrato').val('${param.statusContrato}');
	});
</script>

<div class="cabecalho">
	<fmt:message key="label.servicosContratados" />
	<div class="caminho">
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; <a href="#" class="linktres"><fmt:message key="label.informacoes" /></a> &gt;
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC01/dv01"  class="linkquatro"><fmt:message key="label.servicosContratados" /></a>
	</div>
</div>

<div class="container2"> 
	<ol>
		<li><label for="dataInicial" class="error"><fmt:message key="mensagem.campo.dataInicialValida" /></label></li>
		<li><label for="dataFinal" class="error"><fmt:message key="mensagem.campo.dataFinalValidaMaiorOuIgualInicial" /></label></li>
	</ol>
</div>

<div class="busca_branca">
	<span class="text1"><fmt:message key="label.escolhaTipoBusca" /></span> 
	<span class="texthelp2">
		<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="3" align="absmiddle" />
		<fmt:message key="label.buscaAvancada" />
	</span>
</div>

<form id="formPesquisa" action="<c:url value="/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC01/dv02"/>" method="post">

	<div class="busca_cinza">
			
		<span class="text2"> <fmt:message key="label.peloPeriodo" /><span class="asterisco">*</span>: </span>
		
		<label>
			<span class="text3"><fmt:message key="label.dataInicial" />:</span>
			<input type="hidden" name="valida_contrato" value="true" id="valida_contrato" />
      		<input type="text" name="dataInicial" id="dataInicial" class="required dateBR" maxlength="10" value="${param.dataInicial}" readonly="readonly" />
    	</label>
    	 
    	<label>
			<span class="text3"><fmt:message key="label.dataFinal" />:</span>
			<jsp:useBean id="dataAtual" class="java.util.Date" scope="request" />
			<fmt:formatDate value="${dataAtual}" pattern="dd/MM/yyyy" var="dataFinal"/>

			<c:if test="${not empty param.dataFinal}">
				<c:set var="dataFinal" value="${param.dataFinal }" />
			</c:if>

			<input type="text" name="dataFinal" id="dataFinal" dateHigher="#dataInicial" class="required dateBR" maxlength="10" value="${dataFinal}" readonly="readonly" />
		</label>
		 <span class="texthelp2" style="*position:absolute;*margin-left:60px; margin-top: -5px;">
    		<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" alt="" width="16" height="16"  hspace="5" align="absmiddle"/><fmt:message key="label.buscarTodosRegistroDataMesAno" />  <br />
		</span>
			
	</div>

	<div class="busca_branca">
		<label>
			<span class="text2"> <fmt:message key="label.peloServico" />: </span>
	    
			<select name="codigoServicocontratado" id="codigoServicoContratado">
				<option value="0"><fmt:message key="label.selecione" /></option>
				<c:forEach var="servico" items="${servicosContrados}">
					<option value="${servico.codigo}">${servico.descricao}</option>
				</c:forEach>
			</select>
			
	    </label>
	</div>
	
	<div class="busca_cinza">
		<label>
			<span class="text2"> <fmt:message key="label.peloEquipamento" />: </span>
	    
			<select name="statusContrato" id="statusContrato">
				<option value=""><fmt:message key="label.selecione" /></option>
				<option value="I"><fmt:message key="label.instalado" /></option>
				<option value="N"><fmt:message key="label.naoInstalado" /></option>
			</select>
			
	    </label>
	</div>
	
	<c:choose>

		<c:when test="${SascarUser.perfil eq 'CL'}">
			<div class="busca_branca">
				<input type="submit" class="button" value="<fmt:message key="label.buscar" />" />
				<input type="button" class="button4" value="<fmt:message key="label.limpar" />" onclick="limparCampos('#formPesquisa');" />
			</div>
		</c:when>

		<c:otherwise>
			
			<div class="busca_branca">
				
				<label>
					<span class="text2"> <fmt:message key="label.placa" />: </span>
					<input type="text" name="numeroPlaca" class="text" value="${param.numeroPlaca}" maxlength="7"/>
				</label>
			
			</div>
			
			<div class="busca_cinza">
				
				<label>
					<span class="text2"> <fmt:message key="label.chassi" />: </span>
					<input type="text" name="numeroChassi" class="text" value="${param.numeroChassi}" maxlength="17"/>
				</label>
				
			</div>
			
			<div class="busca_branca">
				
				<label>
					<span class="text2"> <fmt:message key="label.cliente" />: </span>
					<input type="text" name="nomeCliente" class="text" value="${param.nomeCliente}" maxlength="40"/>
				</label>
				
			</div>
			
			<div class="busca_cinza">
				<label>
					<span class="text2"> <fmt:message key="label.cpfCnpj" />: </span>
					<input type="text" name="numeroCpfCnpj" id="numeroCpfCnpj" class="text" value="${param.numeroCpfCnpj}" maxlength="14"/>
				</label>
				
			</div>
			
			<div class="busca_branca">
				
				<label>
					<span class="text2"> <fmt:message key="label.nProposta" />: </span>
					<input type="text" name="numeroProposta" class="text" value="${param.numeroProposta}" maxlength="15" />
				</label>
				
			</div>
			
			<div class="busca_cinza">
				<input type="button" class="button4" value="<fmt:message key="label.limpar" />" onclick="limparCampos('#formPesquisa');"/>
				<input type="submit" class="button" value="<fmt:message key="label.buscar" />" />				
			</div>
			
		</c:otherwise>

	</c:choose>
	
</form>