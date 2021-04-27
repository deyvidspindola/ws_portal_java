<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>
      
<div class=popup_consulta_inadimplencia>

	<div class="popup_padrao_consulta_inadimplencia" >
		
		<p>
			<fmt:message key="uc35.dv06.texto.01">
				<fmt:param>${param.dias}</fmt:param>
			</fmt:message>		
		</p>
		
	</div>
	
	<div style="clear:both;"></div>
	
	<div class="popup_padrao_resposta_consulta_inadimplencia" >
		<input class="button" 
		       value=<fmt:message key="label.fechar" /> 
		       type="button" 
		       onclick="document.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}'"/>
		
	</div>
	

</div>