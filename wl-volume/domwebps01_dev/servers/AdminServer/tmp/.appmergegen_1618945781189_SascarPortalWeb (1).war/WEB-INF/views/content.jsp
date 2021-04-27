<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/RealizarPesquisaOpiniaoServlet/consultarPesquisaSatisfacaoDisponivel?acao=4" context="/SascarPortalWeb"  />	
</c:catch>

<c:if test="${not empty mensagem }">
	<script type="text/javascript">
		$.showMessage("${mensagem }");
	</script>
</c:if>

<script type="text/javascript">



   function alterarClasses(){

	   momentoAtual = new Date(); 
	   segundo = momentoAtual.getSeconds() ;
	   
	   // ESTA FUNÇÃO PEGA OS SEGUNDOS DO SISTEMA
	   // E FAZ A VALIDAÇÃO PARA SABER SE É PAR 
	   // OU ÍMPAR, ALTERNANDO AS CLASSES VISÍVEL
	   // E INVISÍVEL, PARA FAZER COM QUE O TEXTO
	   // E A IMAGEM PISQUEM.

	   if(segundo % 2 == 0){
		   $("#pisca").removeClass("invisivel").addClass("visivel");
	   }else{
		   $("#pisca").removeClass("visivel").addClass("invisivel");
	   }

	   alertaProgramado();
   }
	
	
   var t;
   function alertaProgramado() {
      t=setTimeout("alterarClasses()",100);
   }
   
	function popupPesquisaSatisfacao() {
	   
		var qtdePesquisaDisponivel = $('#qtdePesquisaDisponivel').html();	   
		var qtde = 0;
		
		if ("" != $.trim(qtdePesquisaDisponivel)) {
	   
			try {	
				
				qtde = parseInt(qtdePesquisaDisponivel, 10);
				if (0 < qtde) {
				  
				 $("#popupPesquisaSatisfacao").jOverlay({'color':'#ffffff', 'opacity' : '0.8', closeOnEsc : false, bgClickToClose : false});		
		  		}
			} catch (e) {
				
				qtde = 0;
				alert(e);
			}		 
		}
   }
	
	$(document).ready(function(){
		
	/// PARA A TAG BLINK FUNCIONAR NO IE
		
     alertaProgramado();

	var exibir = '${exibirPesquisa}';
		if(exibir){
			var random = Math.floor(Math.random()*11);
			
			if(random % 2 == 0){
				$("#bannerrandomico-20").attr("src", "${pageContext.request.contextPath}/sascar/images/corporativo_new/bannerrandomico-20.png");
				$("#linkBannerRandomico").attr("href", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC17/dv01");
			}else{
				$("#bannerrandomico-20").attr("src",  "${pageContext.request.contextPath}/sascar/images/corporativo_new/bannerpesquisa.png");
				$("#linkBannerRandomico").attr("href", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC06/dv01");
			}
		}
		
		$("a[href*=.pdf]").click(function(){
			window.open(this.href, "", "toolbar=0");
			return false;
		});
		
		popupPesquisaSatisfacao();
		
	});
	
	function reponderDepois() {		
		
		 $("#popupPesquisaSatisfacao").hide();
		 return false;
	}
	
	function pesquisaVazia() {
		
		 $("#popupPesquisaSatisfacaoVazia").jOverlay({'color':'#ffffff', 'opacity' : '0.8', closeOnEsc : false, bgClickToClose : false});		
	}
	
	function goToPesquisa() {	
		
		window.location.href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC07/dv02&codPesquisa=${codigoPesquisa}";
	}
	
</script>

<div class="acessorapido">
	<div id="botaoacesso"><fmt:message key="label.acessoRapido" /></div>
</div>
<div id="dashboard">
	<div style="width: 50%" id="acessorapido">
	<!--     <p>
	    	<img id="UC02" style="display: none;" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/agendamento32.png" width="32" height="32" hspace="10" border="0" align="absmiddle" class="iconshome" />
			<span class="dashboard">
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC02/dv01" class="dashboard tooltip" title="<fmt:message key="content.agendeInstacaoAssistenciaRetirada" />"><fmt:message key="label.agendarAtendimento" /></a>
			</span>
		</p>--> 
		 <p>
			<img id="UC16" style="display: none;" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/2via32.png" width="32" height="32" hspace="10" border="0" align="absmiddle" class="iconshome" />
			<span class="dashboard">
				 <a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC16/dv01&menu=1" class="dashboard tooltip" title="Consulte e imprima boletos"><fmt:message key="content.2viaBoleto" /></a>
			</span>
		</p>
		<p>
			<img id="UC08" style="display: none;" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/atualizardados32.png" width="32" height="32" hspace="10" border="0" align="absmiddle" class="iconshome" />
		  	<span class="dashboard">
		  		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC08/dv01" class="dashboard tooltip" title="<fmt:message key="content.atualizeDadosClienteVeiculoContatos" />"><fmt:message key="label.atualizacaoCadastral" /></a>
		  	</span>
		</p>
		<p>
			<img id="UC45" style="display: none;" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/question.png" width="32" height="32" hspace="10" border="0" align="absmiddle" class="iconshome" />
		  	<span class="dashboard">
		  		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC45/dv01" class="dashboard tooltip" title="<fmt:message key="content.perguntasFrequentes" />"><fmt:message key="content.perguntasFrequentes" /></a>
		  	</span>
		</p>
		<p>
			<img id="UC07" style="display: none;" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/ico-pesquisa-satisfacao.png" width="32" height="32" hspace="10" border="0" align="absmiddle" class="iconshome" />
		  	<span class="dashboard">
		  		<c:choose>
						<c:when test="${quantidadePesquisa > 0}">
							<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC07/dv02&codPesquisa=${codigoPesquisa}" class="dashboard tooltip" title="<fmt:message key="label.pesquisaSatisfacao" />"><fmt:message key="label.pesquisaSatisfacao" /></a>						
						</c:when>
						<c:otherwise>
							<a href="#" class="dashboard tooltip" title="<fmt:message key="label.pesquisaSatisfacao" />" onclick="pesquisaVazia()"><fmt:message key="label.pesquisaSatisfacao" /></a>
						</c:otherwise>
				</c:choose>		  	
		  		
		  	</span>
		  	<span id="qtdePesquisaDisponivel">${quantidadePesquisa}</span>
		</p>

	<c:if test="${SascarUser.veiculoSemMonitoramento}">
		<div id="pisca" class="visible">
		  <p style="width:500px;">
			<img id="UC56" style="display: none;" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/alert.jpg" width="26" height="26" hspace="15" border="0" align="absmiddle" class="iconshome" />
		  	<span class="dashboard" >
		  		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC56/dv01" class="dashboard tooltip"  title="<fmt:message key="label.veiculoEquipSemAtualizacao" />"><fmt:message key="label.atencao" />: <fmt:message key="label.veiculoEquipSemAtualizacao" />.</a>
		  	</span>
		 </p>
		</div>
	</c:if>
	<div id="bannerrandomico">
		<a id="linkBannerRandomico"  href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC17/dv01">
			<img id="bannerrandomico-20" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/bannerrandomico-20.png" width="470" height="75" border="0" />
	  	</a>
	</div>	
	
	</div>
	
	<div style="width: 50%; float: left;">
		
		<div style="margin-top: 20px;">
			<h3 class="titulo_download">Downloads<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/linha-download.png" style="float: left;" /></h3>
		</div>
		<div  id="textosPrincipalDownloads">
			<a href="${pageContext.request.contextPath}/LoginUsuarioServlet?acao=14&download=Guia_Portal_Servicos.pdf">
				<div id="botaodownloads">
					<div id="textoDownloads">
					<fmt:message key="content.download.duvidasPortal" />
					</div>
				</div>
			</a>
		</div>
		

		
		<div  id="textosPrincipalDownloads">
			<a href="${pageContext.request.contextPath}/LoginUsuarioServlet?acao=14&download=Manual_Direcionamento_Sinal.pdf">
				<div id="botaodownloads">
					<div id="textoDownloads">
					<fmt:message key="content.download.direcionamentoSinal" />
					</div>
				</div>
			</a>
		</div>
		
		<div  id="textosPrincipalDownloads">
			<a href="${pageContext.request.contextPath}/LoginUsuarioServlet?acao=14&download=Tabela_de_Mau_Uso_de_Equipamento.pdf">
				<div id="botaodownloads">
					<div id="textoDownloads">
					<fmt:message key="content.download.mauUsoEquipamento" />
					</div>
				</div>
			</a>
		</div>
		
		<div  id="textosPrincipalDownloads">
			<a href="${pageContext.request.contextPath}/LoginUsuarioServlet?acao=14&download=Retirada_Troca_Veiculo.pdf">
				<div id="botaodownloads">
					<div id="textoDownloads">
					<fmt:message key="content.download.retiradaTrocaVeiculo" />
					</div>
				</div>
			</a>
		</div>
		
		<div  id="textosPrincipalDownloads">
			<a href="${pageContext.request.contextPath}/LoginUsuarioServlet?acao=14&download=Manual_2a_Via_Boleto.pdf">
				<div id="botaodownloads">
					<div id="textoDownloads">
					<fmt:message key="content.download.segundaViaBoleto" />
					</div>
				</div>
			</a>
		</div>

		<div  id="textosPrincipalDownloads">
			<a href="${pageContext.request.contextPath}/LoginUsuarioServlet?acao=14&download=Manual_Autorizacao_Debito_Automatico.pdf">
				<div id="botaodownloads">
					<div id="textoDownloads">
					<fmt:message key="content.download.debitoAutomatico" />
					</div>
				</div>
			</a>
		</div>

		<div  id="textosPrincipalDownloads">
			<a href="${pageContext.request.contextPath}/LoginUsuarioServlet?acao=14&download=Manual_Atualizacao_Cadastral.pdf">
				<div id="botaodownloads">
					<div id="textoDownloads">
					<fmt:message key="content.download.atualizacaoCadastral" />
					</div>
				</div>
			</a>
		</div>


		<div  id="textosPrincipalDownloads">
			<a href="${pageContext.request.contextPath}/LoginUsuarioServlet?acao=14&download=Manual_Declaracao_Veiculo_Monitorado.pdf">
				<div id="botaodownloads">
					<div id="textoDownloads">
					<fmt:message key="content.download.declaracaoVeiculoMonitorado" />
					</div>
				</div>
			</a>
		</div>

		<div  id="textosPrincipalDownloads">
			<a href="${pageContext.request.contextPath}/LoginUsuarioServlet?acao=14&download=Taxas_Vigentes_Portal.pdf">
				<div id="botaodownloads">
					<div id="textoDownloads">
					<fmt:message key="content.download.tabelaVigenteTaxas" />
					</div>
				</div>
			</a>
		</div>
		<div  id="textosPrincipalDownloads">
			<a href="${pageContext.request.contextPath}/LoginUsuarioServlet?acao=14&download=Entenda_Sua_Fatura_Digital.pdf">
				<div id="botaodownloads">
					<div id="textoDownloads">
					<fmt:message key="content.download.entendaFaturaDigital" />
					</div>
				</div>
			</a>
		</div>
		<div  id="textosPrincipalDownloads">
			<a href="${pageContext.request.contextPath}/LoginUsuarioServlet?acao=14&download=Manual_Web_Service_Integracao_1.24.pdf">
				<div id="botaodownloads">
					<div id="textoDownloads">
					<fmt:message key="content.download.manualIntegracaoWEbService" />
					</div>
				</div>
			</a>
			
		</div>
	<div  id="textosPrincipalDownloads">
			<a href="${pageContext.request.contextPath}/LoginUsuarioServlet?acao=14&download=Entenda_Sua_Fatura_Boleto.pdf">
				<div id="botaodownloads">
					<div id="textoDownloads">
						<fmt:message key="content.download.entendaFaturaBoleto" />
					</div>
				</div>
			</a>
		</div>
		<div id="banner_faleconosco">
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC48/dv01">
				<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/banner-fale-conosco.png" width="225" height="75" border="0" />
			</a>
		</div>

	
</div>
</div>

<div id="popupPesquisaSatisfacao" class="popup_padrao3" style="display: none;">
	<div id="popup_msg_modal" class="popup_padrao_pergunta">
		<p>			
			<fmt:message key="mensagem.pesquisaSatisfacao" />
		</p>	
	</div>	
	<div class="popup_padrao_resposta">
		<div class="st-botoes">
			<input type="button" class="button4" value="<fmt:message key="label.responderDepois" />" onclick="$.closeOverlay()"/>
			<input type="button" class="button4" value="<fmt:message key="label.irParaPesquisa" />" onclick="goToPesquisa()"/>
		</div>	
	</div>	
</div>
<div id="popupPesquisaSatisfacaoVazia" class="popup_padrao3" style="display: none;">
	<div id="popup_msg_modal" class="popup_padrao_pergunta">
		<p>
			<fmt:message key="mensagem.semPesquisaSatisfacao" />
		</p>	
	</div>	
	<div class="popup_padrao_resposta">
		<div class="st-botoes">
			<input type="button" class="button4" value="<fmt:message key="label.fechar" />" onclick="$.closeOverlay()"/>			
		</div>	
	</div>	
</div>