<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/PesquisarOrdensServico/listarMarcas?acao=1" context="/SascarPortalWeb"  />
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
	
	function carregarModelosI(codigoMarca) {

		if (codigoMarca == 0) {
			$("option[value!='0']","#modelosI").remove();
			return;
		}

		var selectModelos = $('#modelosI')[0];
		
		$.ajax({
			"url": "/SascarPortalWeb/PesquisarOrdensServico/listarModeloPorMarca",
			"data" : { "codigoMarca": codigoMarca, "acao" : 2 },
			"dataType" : "json",
			"beforeSend": function(){
				$("option[value!='0']","#modelosI").remove();
			},
			"success": function(json){
				if (json.success) {
					$.each(json.modelos, function(i, modelo){
						var option = new Option(modelo.value, modelo.id);
						if ($.browser.msie) {
							selectModelos.add(option);
						} else {
							selectModelos.add(option,null);
						}
					});
					
					$("#divMessageErrorPopup").hide();
				} else {
					$("#divMessageErrorPopup").show().find("span").html(json.mensagem);
				}
				
				$("#dialog").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
			}
		});
	}

	function incluirVeiculo(form) {
		var numeroPlaca 	= $("#numeroPlacaI", form).val();
		var numeroChassi 	= $("#numeroChassiI", form).val();
		var codMarca		= $("#codigoMarcaI", form).val();
		var descrMarca		= $("option[value='"+codMarca+"']","#codigoMarcaI").text();
		var codModelo		= $("#modelosI", form).val();
		var descrModelo		= $("option[value='"+codModelo+"']","#modelosI").text();
		var anoFabricacao 	= $("#anoFabricacaoI", form).val();
		var cor			 	= $("#corI", form).val();
		var renavam		 	= $("#renavamI", form).val();


		var input = "<input type='hidden' name='veiculo' value='"+numeroPlaca	+";"
																+numeroChassi	+";" 
																+codMarca		+";" 
																+codModelo		+";" 
																+anoFabricacao	+";" 
																+cor			+" ;"
																+renavam		+" ;"
																+"'/>";
		
		if(codMarca==0){
			descrMarca = ""; 
			descrModelo = "";
		}
		
		var lastClass = $("table#alter tr:last").attr("class");
		
		var trclass = "";
		
		if(lastClass == "dif"){
			trclass = "";
		} else {
			trclass = "dif";
		}
		
		var html = "<tr id='veiculo_" + INDEX_VEICULO + "' class='"+trclass+"'>"
					+ "<td class='linkazul'> " + input + numeroPlaca + "</td>"
					+ "<td> " + numeroChassi + "</td>"
					+ "<td> " + descrMarca + "</td>"
					+ "<td> " + descrModelo + "</td>"
					+ "<td> " + anoFabricacao + "</td>"
					+ "<td> " + cor + "</td>"
					+ "<td> " + renavam + "</td>"
					+ "<td> <a href='javascript:abrirExcluirVeiculo(null, "+INDEX_VEICULO+");'><img src='${pageContext.request.contextPath}/sascar/images/corporativo_new/excluir16-10.png' alt='Excluir' width='16' height='16' border='0'/></a></td>"
				+ "</tr>";
				
		$("#alter").append(html);
		
		INDEX_VEICULO++;
		
		$.closeOverlay();
		
	}



	$(document).ready(function(){
		$("div.breadcrumb").html('<fmt:message key="label.tituloAtendimentoConsultasOS" />');
		
		var container = $('div.container2');
		$("#formInclusaoVeiculo").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler : function(form) {
				incluirVeiculo(form);
				return false;
			}
		});
		
	});
	
</script>


	<div id="popup">
				
				
		<div id="popup_bordacima">
		</div>
				
				
		<div id="popupinterior">
			<div id="divMessageErrorPopup" class="divError">
			</div>
					
			<h3><fmt:message key="label.informeDadosVeiculo" /></h3>
					
			<div class="container2"> 
				<ol>
					<li><label for="numeroPlacaI" class="error"><fmt:message key="mensagem.campoObrigatorio.placa" /></label></li>
					<li><label for="numeroChassiI" class="error"><fmt:message key="mensagem.campoObrigatorio.chassi" /></label></li>
					<li><label for="anoFabricacaoI" class="error"><fmt:message key="mensagem.campoObrigatorio.ano" /></label></li>
					<li><label for="codigoMarcaI" class="error"><fmt:message key="mensagem.campoObrigatorio.marca" /></label></li>
					<li><label for="modelosI" class="error"><fmt:message key="mensagem.campoObrigatorio.modelo" /></label></li>
				</ol>
			</div>
				
				
			<form id="formInclusaoVeiculo" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC23/dv01" method="post">
				<label class="formleft"> <fmt:message key="label.placa" /><span class="asterisco">*</span>:
					<input type="text" id="numeroPlacaI" name="numeroPlacaI" class="required" maxlength="7"/>
				</label>
				<label class="formleft"><fmt:message key="label.chassi" /><span class="asterisco">*</span>:
					<input type="text" id="numeroChassiI" name="numeroChassiI" class="required" maxlength="20"/>
				</label>
				<p>
					<label class="formleft"><fmt:message key="label.marca" /><span class="asterisco">*</span>:
						<select name="codigoMarcaI" id="codigoMarcaI"  onchange="carregarModelosI(this.value);" class="required">
							<option value=""><fmt:message key="label.selecione" /></option>
							<c:forEach var="marca" items="${marcas}">
								<c:if test="${not empty marca.identifier && not empty marca.value}">
									<option value="${marca.identifier}">${marca.value}</option>
								</c:if>
							</c:forEach>
						</select>
					</label>
					<label class="formleft"><fmt:message key="label.modelo" /><span class="asterisco">*</span>:
						<select name="codigoModeloI" id="modelosI" class="required">
							<option value=""><fmt:message key="label.selecione" /></option>
						</select>
					</label>
				</p>
				<label class="formleft"> <fmt:message key="label.ano" /><span class="asterisco">*</span>:
					<input style="width:50px;" type="text" id="anoFabricacaoI" name="anoFabricacaoI" class="required" maxlength="5"/>   
				</label>
				<label class="formleft"><fmt:message key="label.cor" />:
					<input style="width:80px;" type="text" id="corI" name="corI" maxlength="15"/>
				</label>
				<label class="formleft"><fmt:message key="label.renavam" />:
					<input type="text" id="renavamI" name="renavamI" maxlength="15"/>
				</label>
				
				
				<div class="botoeslimparbuscar_popup">
					<input type="submit" class="button tooltip" value="<fmt:message key="label.incluir" />" title="<fmt:message key="uc23.texto.05.cliqueAquiIncluirVeiculo" />"/>
					<input type="button" class="button4 close" value="<fmt:message key="label.voltar" />" onclick="$.closeOverlay()"/>
				</div>
			</form>
		</div>
		
		
		<div id="popup_bordarodape">
		</div>
		
		
	</div>

