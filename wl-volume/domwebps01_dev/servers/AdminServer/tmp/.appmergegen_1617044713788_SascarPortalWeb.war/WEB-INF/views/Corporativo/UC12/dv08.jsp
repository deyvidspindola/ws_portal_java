<jsp:directive.include file="/WEB-INF/views/includes.jsp" />

<div class="rbroundbox" id="popupComunicados" style="width: 65%; *width: 60%;">
	<div class="rbtop"><div></div></div>
	
	<div class="rbcontent" >
		<b><fmt:message key="label.comunicadoImportante" />:</b>		
		<p>
		<c:forEach var="mensagemComunicado" items="${mensagemComunicados}">
		<p><b>
		        	 	   ${mensagemComunicado.titulo} </b>
		<p>        	 	   
		        	 	   ${mensagemComunicado.mensagem}		        	 	   
		</p>
	    </c:forEach>
		
		
		</p>
		
        <div id="buttonPopUp">
			<input type="button" 
						class="button" 
						value="<fmt:message key="label.fechar" />"
						onclick="window.location='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&usuarioIndicadorId=indicadorComunicados'">
	  	</div>
	</div>
	
	<div class="rbbot"><div></div></div>
</div>
