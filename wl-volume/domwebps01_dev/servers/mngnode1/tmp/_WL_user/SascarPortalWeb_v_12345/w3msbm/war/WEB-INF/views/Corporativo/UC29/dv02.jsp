<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<form id="formResultadoBordero" 
	  onsubmit="openPopupPrint(this);" 
	  action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Imprimir&page=Corporativo/UC29/dv05" 
	  method="post">

	<input type="hidden" name="numeroBordero" 		 id="numeroBordero" value="${param.numeroBordero}" />
	<input type="hidden" name="representanteBordero" id="representanteBordero" value="${param.representanteBordero}" />
	<input type="hidden" name="dataInclusaoBordero"  id="dataInclusaoBordero" value="${param.dataInclusaoBordero}" />

	<div class="popup_padrao">
		
		<div class="popup_padrao_pergunta">
			<fmt:message key="uc29.texto.012.borderoGeradoSucesso" />
			<span style="color: rgb(102, 102, 102);"> <fmt:message key="label.nAbrevBordero" />:</span>
			<span style="color: rgb(255, 0, 0);">${param.numeroBordero}</span>
		</div>
		
		<div class="popup_padrao_resposta">
			<input class="button close" type="submit"  value="<fmt:message key="label.imprimir" />" />
			<input class="button4 close" type="button" value="<fmt:message key="label.fechar" />" onclick="$.closeOverlay(); $('#formAtualizar').submit();" />
		</div>
		
	</div>

</form>