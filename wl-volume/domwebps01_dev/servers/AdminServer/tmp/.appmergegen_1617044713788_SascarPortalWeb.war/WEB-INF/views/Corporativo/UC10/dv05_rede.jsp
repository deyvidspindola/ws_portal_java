<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>
<c:catch var="helper" >
	<c:import url="/AtivarEquipamentoVinculo/listarRedeAcessorios?acao=34" context="/SascarPortalWeb"  />
</c:catch>

<c:if test="${not empty helper}" >
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>
<script type="text/javascript">
	function submeterRedeAcessorios(form) {
		var data = $(form).serialize();
		$.ajax({
			url: "/SascarPortalWeb/AtivarEquipamentoVinculo/submeterRedeAcessorios?acao=35",
			data: data || {},
			dataType:"json",
			success: function(json){
				if (json.success) {
					$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv05");
					$(form).unbind('submit').submit();
				} else {
					$(form).attr("action", "");
					$.showMessage(json.mensagem);
				}
			}
		});
	}
	
	function liberaCampos(rede){
		
		serial = $("#rede"+rede+"_serial_adaptador").val();
		serial = $.trim(serial);
		
		 
		if(serial === ""){
			$("#combo"+rede+"_IN1").attr("disabled", true);
			$("#rede"+rede+"_IN1_porta").attr("disabled", true);
			$("#rede"+rede+"_IN1_serial").attr("disabled", true);
			$("#combo"+rede+"_IN2").attr("disabled", true);
			$("#rede"+rede+"_IN2_porta").attr("disabled", true);
			$("#rede"+rede+"_IN2_serial").attr("disabled", true);
			$("#combo"+rede+"_OUT1").attr("disabled", true);
			$("#rede"+rede+"_OUT1_porta").attr("disabled", true);
			$("#rede"+rede+"_OUT1_serial").attr("disabled", true);
			$("#combo"+rede+"_AD1").attr("disabled", true);
			$("#rede"+rede+"_AD1_porta").attr("disabled", true);
			$("#rede"+rede+"_AD1_serial").attr("disabled", true);
			$("#combo"+rede+"_AD2").attr("disabled", true);
			$("#rede"+rede+"_AD2_porta").attr("disabled", true);
			$("#rede"+rede+"_AD2_serial").attr("disabled", true);
		}else{
			$("#combo"+rede+"_IN1").attr("disabled", false);
			$("#rede"+rede+"_IN1_porta").attr("disabled", false);
			$("#rede"+rede+"_IN1_serial").attr("disabled", false);
			$("#combo"+rede+"_IN2").attr("disabled", false);
			$("#rede"+rede+"_IN2_porta").attr("disabled", false);
			$("#rede"+rede+"_IN2_serial").attr("disabled", false);
			$("#combo"+rede+"_OUT1").attr("disabled", false);
			$("#rede"+rede+"_OUT1_porta").attr("disabled", false);
			$("#rede"+rede+"_OUT1_serial").attr("disabled", false);
			$("#combo"+rede+"_AD1").attr("disabled", false);
			$("#rede"+rede+"_AD1_porta").attr("disabled", false);
			$("#rede"+rede+"_AD1_serial").attr("disabled", false);
			$("#combo"+rede+"_AD2").attr("disabled", false);
			$("#rede"+rede+"_AD2_porta").attr("disabled", false);
			$("#rede"+rede+"_AD2_serial").attr("disabled", false);
		}
		
	}
	
	$(document).ready(function(){

		var container = $('div.container2');
		$("#formRedeAcessorios").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler : function(form) {
				submeterRedeAcessorios(form);
			}
		});
		
		$("#numeroCPF").setMask('cpf');
	});
</script>


<div class="cabecalho">
	<div class="caminho" style="*margin-left:400px;">
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; 
		<a href="#" class="linktres"><fmt:message key="label.servicos" /></a> &gt; 
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv01" class="linkquatro"><fmt:message key="label.ativacaoEquipamento" /></a>
	</div>
  	<fmt:message key="label.ativacaoEquipamento" />
</div>


<table cellspacing="0" class="detalhe" >
	<tr class="barraazulzinha">
		<th class="barraazulzinha"><fmt:message key="label.rede.acessorios" /></th>
	</tr>
</table>


<form action="" method="post" id="formRedeAcessorios">
	<input type="hidden" name="origem" value="V" />
	<input type="hidden" name="numeroOS" value="${param.numeroOS }" />
	<input type="hidden" name="numeroCPF" value="${param.numeroCPF }" />
	<input type="hidden" name="numeroContrato" value="${param.numeroContrato}" />
	<input type="hidden" id="isPossuiRedeAcessorio" name="isPossuiRedeAcessorio" value="${param.isPossuiRedeAcessorio }" />
	
	<c:forEach begin="1" end="10" varStatus="loop">
		<table  cellspacing="0px" cellpadding="1px" width="960" style="margin-left:0px;">
			<tbody>
				<tr>
					<th style="background-color: rgb(204, 204, 204); color: rgb(51, 51, 51);text-align: left" scope="col" colspan="6">Adaptador de Acessorio<input type="text" value="" onkeyup="liberaCampos(${loop.index})" id="rede${loop.index}_serial_adaptador" name="rede${loop.index}_serial_adaptador" style="color:black;"/></th>
				</tr>
				<tr>
					<th width="50%" scope="col">Entrada/Saida</th>
					<th width="25%" scope="col">Porta Adaptador</th>
					<th width="25%" scope="col">Porta Rastreador</th>
					<!-- <th width="30%" scope="col">Numero de serie</th>-->
				</tr>
				<!-- itens -->			
				<tr class="dif" style="text-align: center;">
					<td>
						<select id="combo${loop.index}_IN1" disabled>
							<option value=""><fmt:message key="label.selecione" /></option>
							<c:forEach var="co" items="${combo}">
								<option value="">${co}</option>
							</c:forEach>
						</select>
					</td>
					<td>IN1</td>
					<td><input type="text" value="" id="rede${loop.index}_IN1_porta" name="rede${loop.index}_IN1_porta" style="text-align: center;color:black;" disabled/></td>
					<!-- <td><input type="text" value="" id="rede${loop.index}_IN1_serial" name="rede${loop.index}_IN1_serial" style="text-align: center;color:black;" disabled/></td> -->
				</tr>
				<tr class="dif" style="text-align: center;">
					<td>
						<select id="combo${loop.index}_IN2" disabled>
							<option value=""><fmt:message key="label.selecione" /></option>
							<c:forEach var="co" items="${combo}">
								<option value="">${co}</option>
							</c:forEach>
						</select>
					</td>
					<td>IN2</td>
					<td><input type="text" value="" id="rede${loop.index}_IN2_porta" name="rede${loop.index}_IN2_porta" style="text-align: center;color:black;" disabled/></td>
					<!--<td><input type="text" value="" id="rede${loop.index}_IN2_serial" name="rede${loop.index}_IN2_serial" style="text-align: center; color:black;" disabled/></td>-->
				</tr>
				<tr class="dif" style="text-align: center;">
					<td>
						<select  id="combo${loop.index}_OUT1" disabled>
							<option value=""><fmt:message key="label.selecione" /></option>
							<c:forEach var="co" items="${combo}">
								<option value="">${co}</option>
							</c:forEach>
						</select>
					</td>
					<td>OUT1</td>
					<td><input type="text" value="" id="rede${loop.index}_OUT1_porta" name="rede${loop.index}_OUT1_porta" style="text-align: center;color:black;" disabled/></td>
					<!--<td><input type="text" value="" id="rede${loop.index}_OUT1_serial" name="rede${loop.index}_OUT1_serial" style="text-align: center; color:black;" disabled/></td>-->
				</tr>
				<tr class="dif" style="text-align: center;">
					<td>
						<select  id="combo${loop.index}_AD1" disabled>
							<option value=""><fmt:message key="label.selecione" /></option>
							<c:forEach var="co" items="${combo}">
								<option value="">${co}</option>
							</c:forEach>
						</select>
					</td>
					<td>AD1</td>
					<td><input type="text" value="" id="rede${loop.index}_AD1_porta" name="rede${loop.index}_AD1_porta" style="text-align: center;color:black;" disabled/></td>
					
					<!--<td><input type="text" value="" id="rede${loop.index}_AD1_serial" name="rede${loop.index}_AD1_serial" style="text-align: center; color:black;" disabled/></td>-->
				</tr>
				<tr class="dif" style="text-align: center;">
					<td>
						<select  id="combo${loop.index}_AD2" disabled>
							<option value=""><fmt:message key="label.selecione" /></option>
							<c:forEach var="co" items="${combo}">
								<option value="">${co}</option>
							</c:forEach>
						</select>
					</td>
					<td>AD2</td>
					<td><input type="text" value="" id="rede${loop.index}_AD2_porta" name="rede${loop.index}_AD2_porta" style="text-align: center;color:black;" disabled/></td>
					<!--<td><input type="text" value="" id="rede${loop.index}_AD2_serial" name="rede${loop.index}_AD2_serial" style="text-align: center; color:black;" disabled/></td>-->
				</tr>
				
			</tbody>
		</table>
	</c:forEach>

	<div class="pgstabela">
		<p>
			<input class="button4" type="button" onclick="window.location.href ='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv04&numeroOS=${param.numeroOS}&numeroCPF=${param.numeroCPF}&numeroContrato=${param.numeroContrato}&isPossuiRedeAcessorio=${param.isPossuiRedeAcessorio}'" value="<fmt:message key="label.voltar" />">
	        <input type="submit" class="button" value="<fmt:message key="label.continuar" />" />
		</p>
	</div>
</form>
