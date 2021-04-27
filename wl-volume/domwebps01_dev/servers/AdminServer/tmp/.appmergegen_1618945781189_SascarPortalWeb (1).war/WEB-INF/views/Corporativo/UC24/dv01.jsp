<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/ConsultarVeiculosServlet/listarSeguradoras?acao=3" context="/SascarPortalWeb"  />
</c:catch>

<script type="text/javascript">
	$(document).ready(function(){

		$("div.breadcrumb").html('<fmt:message key="label.tituloAtendimentoConsultasVeiculos" />');
		
		var container = $('div.container2');
		$("#formPesquisa").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			rules: {
				dataInicial: {
					dateBR:  true,
					required: true
				},
				dataFinal: {
					dateHigher: "#dataInicial",
					dateBR:  true,
					required: true
				},
				tipoSeguradora : {
					required : true
				}
			},
			messages: {
				dataInicial: {
					dateBR:  '<fmt:message key="label.dataInicialInvalida" />',
					required: '<fmt:message key="mensagem.campoObrigatorio.dataInicial" />'
				},
				dataFinal: {
					dateHigher: '<fmt:message key="mensagem.informacao.dataFinalMaiorInicial" />',
					dateBR:  '<fmt:message key="label.dataFinalInvalida" />',
					required: '<fmt:message key="mensagem.campoObrigatorio.dataFinal" />'
				},
				tipoSeguradora: {
					required: '<fmt:message key="mensagem.campoObrigatorio.tipoDeContrato" />'
				}
			}
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
	</ol>
</div>
	
	
<c:choose>
	<c:when test="${param.menu eq 1}">
		<c:set var="titulo">
			<fmt:message key="label.consultarVeiculos" />
		</c:set>
	</c:when>
	<c:when test="${param.menu eq 2}">
		<c:set var="titulo">
			<fmt:message key="label.declaracaoDeVeiculosMonitorados" />
		</c:set>
	</c:when>
	<c:when test="${param.menu eq 3}">
		<c:set var="titulo">
			<fmt:message key="label.retiradaDeEquipamentos" />
		</c:set>
	</c:when>
</c:choose>

<div class="cabecalho3">
  
	<div class="caminho3" style="*margin-left:350px">
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> > 
		<a href="#" class="linktres"><c:choose><c:when test="${param.menu > 2}"><fmt:message key="label.servicos" /></c:when><c:otherwise><fmt:message key="label.informacoes" /></c:otherwise></c:choose></a> > 
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC24/dv01&menu=${param.menu }" class="linkquatro">${titulo }</a>
	</div>
	${titulo}
</div>
	
	
<form id="formPesquisa" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC24/dv02" method="post" class="filtro">
	
	<input type="hidden" value="${param.menu }" name="menu" />
	
	<div class="busca_branca" style="height:38px;">
		<span class="text1"><fmt:message key="label.escolhaTipoBusca" /></span>
		
		<span class="texthelp2">
			<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" />
			<fmt:message key="label.buscaAvancada" />
			<br>
			<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" />
			<fmt:message key="label.periodoMaximoBuscas1Mes" />
		</span>
	</div>
	
	<div class="busca_cinza">
		<span class="text2">
			<fmt:message key="label.periodo" /><span class="asterisco">*</span>:
		</span>  
		<label>
			<span class="text3"><fmt:message key="label.dataInicial" />:</span>
			<input type="text" name="dataInicial" id="dataInicial" readonly="readonly" class="required text data dateBR" maxlength="10" value="${param.dataInicial}" />
		</label>  
		<label>
			<span class="text3"><fmt:message key="label.dataFinal" />:</span>
			<jsp:useBean id="dataAtual" class="java.util.Date" scope="request" />
			<fmt:formatDate value="${dataAtual}" pattern="dd/MM/yyyy" var="dataFinal"/>
	
			<c:if test="${not empty param.dataFinal}">
				<c:set var="dataFinal" value="${param.dataFinal }" />
			</c:if>
		
			<input type="text" name="dataFinal" id="dataFinal" readonly="readonly" class="required dateBR" maxlength="10" value="${dataFinal}" />
		</label>
	</div>
	
	<c:choose>
		<c:when test="${SascarUser.perfil eq 'CL'}">
			<tr>
				<td></td>
				<td></td>
				<td>
					<input type="button" class="button" value="<fmt:message key="label.limpar" />" onclick="limparCampos('#formPesquisa');"/> &nbsp; &nbsp; &nbsp; 
					<input type="submit" class="button" value="<fmt:message key="label.buscar" />"/>
				</td>
			</tr>
		</c:when>

		<c:otherwise>	
		
			<div class="busca_branca">
					<span class="text2"> <fmt:message key="label.placa" />: 
					</span>
				<label>
					<input type="text" name="numeroPlaca" class="text" value="${param.numeroPlaca }" maxlength="10" value="${param.numeroPlaca }"/>
				</label>
			</div>
			
			<div class="busca_cinza">
				<span class="text2"><fmt:message key="label.tipoDeContato" /><span class="asterisco">*</span>: 
				</span>
				<label>
					<select id="tipoSeguradora" name="tipoSeguradora" class="required text" >
						<c:if test="${fn:length(listaSeguradora) > 1}">
							<option value=""><fmt:message key="label.selecione" /></option>
						</c:if>
						<c:forEach  var="seguradora" items="${listaSeguradora}">
							<c:if test="${not empty seguradora.identifier and not empty seguradora.value}">
								<option value="${seguradora.identifier}"
									<c:if test="${seguradora.identifier eq param.tipoSeguradora}">selected="selected"</c:if>>
									${seguradora.value}
								</option>
							</c:if>
						</c:forEach>
					</select> 
				</label>
			</div>
	
			<div class="busca_branca">
				<span class="text2"> <fmt:message key="label.segurado" />: 
				</span>
				<label>
					<input type="text" name="nomeCliente" class="text" value="${param.nomeCliente }" maxlength="20" />
				</label>
			</div>
	  
			<div class="busca_cinza">
				<span class="text2"> <fmt:message key="label.chassi" />: 
				</span>
				<label>
					<input type="text" name="numeroChassi" class="text" value="${param.numeroChassi }" maxlength="17" />
				</label>
			</div>
	
			<div class="busca_branca">
				<span class="text2"><fmt:message key="label.nProposta" />: 
				</span>
				<label>
					<input type="text" name="numeroProposta" class="text" value="${param.numeroProposta }" maxlength="25" />
				</label>
			</div>
	
		</c:otherwise> 
	</c:choose>
		
	<div class="busca_cinza">
			<input type="submit" class="button" value="<fmt:message key="label.buscar" />" />
			<input id="Limpar" class="button4" type="button" value="<fmt:message key="label.limpar" />" name="limpar" onclick="limparCampos('#formPesquisa');"/>
	</div>
</form>
