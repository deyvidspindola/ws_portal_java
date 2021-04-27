<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

	
	<c:catch var="helper" >
		<c:import url="/PesquisarOrdensServico/listarTipoServico?acao=7" context="/SascarPortalWeb"  />
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
	
	
		$(document).ready(function(){
					
		
			
			var container = $('div.container2');
			$("#formPesquisa").validate({
				errorContainer: container,
				errorLabelContainer: $("ol", container),
				wrapper: 'li'
			});
	
		});
		
	</script>


	<div class="cabecalho">
		<!--
		<fmt:message key="label.agendarAtendimento" />
		<div class="caminho"><a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a>&gt; <a href="#" class="linktres"><fmt:message key="label.servicos" /></a> &gt; 
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC02/dv01"  class="linkquatro"><fmt:message key="label.agendarAtendimento" /></a>
		-->
		</div>
	</div>


	<div class="container2"> 
		<ol>
			<li><label for="dataInicial" class="error"><fmt:message key="mensagem.campo.dataInicialValida" /></label></li>
			<li><label for="dataFinal" class="error"><fmt:message key="mensagem.campo.dataFinalValidaMaiorOuIgualInicial" /></label></li>
		</ol>
	</div>

	<form id="formPesquisa" action="<c:url value="/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC02/dv02"/>" method="post">
		
		<div class="busca_branca">
			<span class="text1"><fmt:message key="label.escolhaTipoBusca" /></span>
			<span class="texthelp2">
				<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" />
				<fmt:message key="label.buscaAvancada" /> 
			</span>
		</div>
		
		
		<div class="busca_cinza">
		  	<label>
				<span class="text2"><fmt:message key="label.pelaOs" />: </span>
	      		<input type="text" name="numeroOs" id="numeroOs" maxlength="7" value="">
	    	</label>

				<label>
			 	<span class="text2"><fmt:message key="label.tipoServico" />:</span>
		  		<select name="codigoTipoServico" id="codigoTipoServico">
					<option value="0"><fmt:message key="label.selecione" /></option>
					<c:forEach var="tipoServico" items="${tipoServico}">
						<c:if test="${not empty tipoServico.identifier && not empty tipoServico.value}">
							<option value="${tipoServico.identifier}">${tipoServico.value}</option>
						</c:if>
					</c:forEach>
		  		</select>
		  	</label>
		</div>
		
		
		<div class="busca_branca">
		<label>
				<span class="text2"><fmt:message key="label.pelaPlaca" />: </span>
	      	<!-- 	<span class="text3"><fmt:message key="label.nAbrev" />:</span> -->
	      	<span class="text3"><fmt:message key="label.nAbrev" />:</span>
	      		<input type="text" name="numeroPlaca" id="numeroPlaca" maxlength="7" value="${param.numeroPlaca}">
	    	</label>
	  
	    		
			<label>
				<span class="text2"><fmt:message key="label.peloChassi" />:</span>
	      		<span class="text3"><fmt:message key="label.nAbrev" />:</span>
	      		<input type="text" name="numeroChassi" id="numeroChassi" maxlength="20" value="${param.numeroChassi}" />
			</label>
	
		</div>

		<div class="busca_cinza">
		
	    	<label>
	    	<span class="text2"><fmt:message key="label.tipoBusca" /></span>
	    	  	<input name="statusAgendamento" type="radio" value="" class="check" id="statusAgendamento" checked="checked"/>
		    	<span class="text2"><fmt:message key="label.buscarTodos" /></span>
                <input name="statusAgendamento" value="P" type="radio" class="check" id="statusAgendamento"/>
                <span class="text2"><fmt:message key="label.pendenciaAgendamento" /></span>
                    <input name="statusAgendamento" value="A" type="radio" class="check" id="statusAgendamento"/>
                <span class="text2"><fmt:message key="label.agendado" /></span>
                       <input name="statusAgendamento" type="radio" value="C" class="check" id="statusAgendamento"/>
                <span class="text2"><fmt:message key="label.concluido" /></span>
	    	</label>
	
	  </div>
	
	
		<div class="busca_branca">
			<input name="button" type="submit" class="button" id="button" value="<fmt:message key="label.buscar" />" />
	   		<input name="button2" type="button" class="button4" id="Limpar" value="<fmt:message key="label.limpar" />" onclick="limparCampos('#formPesquisa');"/>
	   	</div>
	</form>

