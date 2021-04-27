<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/AgendarOrdemServico/listarHorarios?acao=5" context="/SascarPortalWeb"  />
</c:catch>

<c:if test="${not empty helper}" >
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>

<script type="text/javascript">
	$(document).ready(function() {
		var container = $('#msgErrorFormBuscaAgendamento');
		$("#formLista").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler : function(){
				var horarioCheck = $('#formLista :checked');
				var tds = horarioCheck.parents('tr').find('td');
				var selectLocalInstalacao = $('select[name="localInstalacao"]');
				
				var dataHora 	= $.trim($(tds[1]).html());
				var nomeEmpresa = $.trim($(tds[2]).html());
				var endereco 	= $.trim($(tds[3]).html());
				var telefone 	= $.trim($(tds[4]).html());

				if (selectLocalInstalacao.val() == "R") {
					$('input[name="nomeContato"]').attr('disabled', false);
					$('input[name="numeroTelefone"]').attr('disabled', false);
					$('textarea[name="observacao"]').attr('disabled', false);
					$('input[name="descricao"]').attr('disabled', true);
					$('input[name="descricaoEndereco"]').attr('readonly', true).val(endereco);
				}

				if (selectLocalInstalacao.val() == "C") {
					$('input[name="descricao"]').attr('disabled', false);
					$('input[name="descricaoEndereco"]').val('').attr('readonly', false);
					$('input[name="nomeContato"]').attr('disabled', false);
					$('input[name="numeroTelefone"]').attr('disabled', false);
					$('textarea[name="observacao"]').attr('disabled', false);
				}

				$('input[name="dataHora"]').val(dataHora);
				$('input[name="codigoInstalador"]').val(horarioCheck.val());

				$.closeOverlay();

				return false;
			}
		});
	});
</script>


	<c:if test="${not empty agendamentos }">
	
		<div class="texthelp" id="divlembretepopup">
			<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/Copia de clock32.png" width="16" height="16" hspace="5" align="baseline" />
			${agendamentos[0].instrucao}
		</div>
		
		<form action="" method="post" name="formLista" id="formLista" style="height:325px;">
			<div id="divbuscapopup"  >
				<table width="688" border="0" cellpadding="0px" class="popup" cellspacing="0">
					<tr>
						<th width="28" class="texttable_azul">&nbsp;</th>
						<th width="80" class="texttable_azul"><fmt:message key="label.dataHora" /></th>
						<th width="249" class="texttable_cinza"><fmt:message key="label.nomeEmpresa" /></th>
						<th width="260" class="texttable_cinza"><fmt:message key="label.endereco" /></th>
						<th width="71" class="texttable_cinza"><fmt:message key="label.telefone" /></th>
					</tr>
				</table>
					
						
				<div style="height:200px; overflow:auto;">
					<table width="680" border="0" cellpadding="0px" class="popup" cellspacing="0" style="margin:0">
						<c:forEach items="${agendamentos }" var="agendamento" varStatus="contador">
							<tr <c:if test="${contador.count % 2 != 0 }">class="dif2"</c:if>>
								<td class="linkazulescuro">
									<input type="radio" name="horario" id="horario" class="required" <c:if test="${not agendamento.disponivel }">disabled="disabled"</c:if> value="${agendamento.numero }" />
								</td>
								<td class="camposinternos2">
									<fmt:formatDate value="${agendamento.dataAgendamento}" pattern="dd/MM/yyyy HH:mm" />
								</td>
								<td>${agendamento.nomeInstalador }</td>
								<td>${agendamento.endereco.descricaoLogradouro }</td>
								<td>${agendamento.telefone1 }</td>
							</tr>
						</c:forEach>
					</table>
				</div>	   
				
				<% /* <render:callelement elementname="Corporativo/Paginacao">
					<render:argument name="pagina" value="${paginacao.paginaAtual}"/>
					<render:argument name="totalPaginas" value="${paginacao.totalPaginas}"/>
					<render:argument name="url" value="/cs/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC11/dv03"/>
					<render:argument name="formName" value="formPesquisa"/>
				</render:callelement> */ %>
						
				<div class="botoeslimparbuscar2" style="position:aboslut;">
					<label>
						<input name="button" type="submit" class="button" id="button" value="<fmt:message key="label.confirmar" />" />
					</label>
				</div>
				
				
			</div>
		</form>
	</c:if>


	<c:if test="${empty agendamentos }">
		<div class="container2" id="ajaxListMsgError" style="display: block;">
			<fmt:message key="mensagem.informacao.nenhumRegisroEncontrado" />
		</div>
		<script type="text/javascript">
			$("#ajaxListMsgError").fadeIn(400).delay(2000).fadeOut(400);
		</script>
	</c:if>

