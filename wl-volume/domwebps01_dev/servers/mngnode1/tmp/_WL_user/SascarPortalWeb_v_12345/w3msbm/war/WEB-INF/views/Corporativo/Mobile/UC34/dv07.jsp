<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>
      
<div class="window modal">
	
	<div class="topo"></div>
		<div class="middle" style="text-align: center;">
		
			<h3><fmt:message key="label.confirmacaoDeRetirada" /></h3>
			<br/>
	
			<c:choose>
				<c:when test="${not empty param.numeroSerialAcessorio}">
					
					<span style="color:#666; font-size:11px;">
						<fmt:message key="mensagem.confirmacao.retiradaAcessorioSerial">
							<fmt:param><span style="color:#F00; font-size:11px;">${param.descricaoAcessorio}</span></fmt:param>
							<fmt:param><span style="color:#F00; font-size:11px;">${param.numeroSerialAcessorio}</span></fmt:param>
						</fmt:message>
					</span><br />
					
				</c:when>
				<c:otherwise>
				
					<span style="color:#666; font-size:11px;"><fmt:message key="mensagem.confirmacao.retiradaAcessorio" /> </span>
					<span style="color:#F00;">${param.descricaoAcessorio}</span>?<br />
					
				</c:otherwise>
			</c:choose>
	
			<br/><br/>
	
			<table width="100%" cellspacing="0">
				<tr>
					<td align="center">
					
						<input class="button" 
							   value="<fmt:message key="label.sim" />" 
							   type="button" 
							   onclick="submeterDadosAcessorio('#formPesquisa');"/>
							   
						<input class="button4 close" 
							   type="button" 
							   onclick="javascript:$.closeOverlay();" value="<fmt:message key="label.nao" />">
					</td>
				</tr>
			</table>

		</div>
		
	<div class="bottom"></div>
</div>

