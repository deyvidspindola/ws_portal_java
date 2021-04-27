<jsp:directive.include file="/WEB-INF/views/includes.jsp" />

<c:catch var="helper">
	<c:import
		url="/AtivarEquipamentoTestes/consultarTestesProgramados?acao=26"
		context="/SascarPortalWeb" />
</c:catch>

<c:choose>
	<c:when test="${param.fromMobile}">
		<c:set var="urlReprogramada" value="/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/"/>
	</c:when>
	<c:otherwise>
		<c:set var="urlReprogramada" value="/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/"/>
	</c:otherwise>
</c:choose>

<style>
	.testesContainer table {
		margin: 10px 0 10px 0 !important;
		width: 100%;
		color: #666;
		border: #ccc 1px solid;
		border-collapse: collapse;
	}

	.testesContainer table th {
		border-top: 1px solid #fafafa;
		border-bottom: 1px solid #ccc;
		border-left: 1px solid #e0e0e0;
		background: #ededed;
		padding: 6px;
	}

	.testesContainer table td {
		border-top: 1px solid #ffffff;
		border-bottom: 1px solid #e0e0e0;
		border-left: 1px solid #e0e0e0;
		background: #fafafa;
		padding: 6px;
	}

	.testesContainer table tr:not (:first-child ):nth-child(odd) td {
		background: #f6f6f6;
	}

	.testesContainer table tr:hover td {
		background: #f1f1f1 !important;
	}

	.testesContainer p {
		margin: 10px;
	}

	.testesContainer {
		width: 100%;
		height: auto;
	}

	.linkEnviar:visited {
		color: blue;
	}

	.centralizado {
		margin: 0 auto;
		display: block;
	}

	.loadingDiv {
		font-size: 18px;
		font-weight: bold;
		color: #00417B;
		text-align: center;
		margin-top: 10px;
	}

	.gif {
		width: 32px;
		height: 32px;
		margin-left: 10px;
		margin-right: 10px;
		border-top-width: 0px;
		border-right-width: 0px;
		border-bottom-width: 0px;
		border-left-width: 0px;
		border-top-style: solid;
		border-right-style: solid;
		border-bottom-style: solid;
		border-left-style: solid;
		vertical-align: middle;
	}

	.imgPequena {
		width: 20px;
		vertical-align: middle;
		padding-left: 25px;
	}

	.popUpMsgValidacao {
		font-weight: bold;
	}

	#msgAlerta {
		width: 350px;
		height: 65px;
		display: none;
		background-color: #FCF7F7;
		border: 1px solid #ebccd1;
		position: absolute;
		z-index: 999;
		text-align: center;
		color: #170000;
		font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
    font-size: 12px;
	}

	#msgAlerta p {
		text-align: center;
		vertical-align: middle;
	}

	#msgAlerta:hover {
		border: 1px solid #F5A6A6;
	}

	.popUp {
		padding: 20px;
		width: 380px;
		height: 110px;
		display: none;
		background-color: #F9F9F9;
		border: 1px solid #CCC;
		position: absolute;
		z-index: 999;
	}

	.popUpDuplo {
		padding: 20px;
		width: 380px;
		height: 150px;
		display: none;
		background-color: #F9F9F9;
		border: 1px solid #CCC;
		position: absolute;
		z-index: 999;
	}

	.buttonGroup {
		margin-left: 220px;
		margin-top: 20px;
	}

	#aboveall {
		background-color: #E6E6E6;
		opacity: .50; /* Standard: FF gt 1.5, Opera, Safari, CSS3 */
	 	filter: alpha(opacity=50); /* IE lt 8 */
	  -ms-filter: "alpha(opacity=50)"; /* IE 8 */
	  -khtml-opacity: .50; /* Safari 1.x */
	  -moz-opacity: .50; /* FF lt 1.5, Netscape */
		position: fixed;
		width: 100%;
		height: 100%;
		top: 0;
		left: 0;
		z-index: 998;
		display: none;
	}

	#testes {
		margin-bottom: 85px;
	}

	input[type="button"] {
    min-width: 50px;
	}

</style>

<script>

	/** GLOBALS **/
	var gruposteste;
	var ordoid;
	var cpf;
	var placa;
	var tipoExtra;

	/** METODOS UTEIS **/
	// Verifica se um elemento encontra-se em um array
	var contains = function (array, element) {
		return !!~array.indexOf(element);
	};

	// Busca o a distancia do topo em relacao a um elemento especifico
	function getOffsetTop( elem ) {
	    var offsetTop = 0;
	    do {
	      if ( !isNaN( elem.offsetTop ) ) {
	          offsetTop += elem.offsetTop;
	      }
	    } while( elem = elem.offsetParent );
	    return offsetTop;
	}

	/*
	 * Preenche um texto com 0 a direita
	 * de acordo com a quantidade especificada em quantity
	 */
	function padRight(string, quantity) {
      for(var i=0; i<quantity; i++)
        string += '0';
      return string;
    }

	/*
	 * Previne que chares nao numericos
	 * sejam digitados
	 */
    function preventNonNumericChar(e) {
			var target = e.target;
			var position = target.selectionStart;
			target.value = target.value.replace(/[^0-9\,]/g,'');
			var charCode = (e.which) ? e.which : e.keyCode;
			var validCodes = [8, 37, 38, 39, 40, 46];

			if (!contains(validCodes, e.keyCode) && (charCode < 48 || charCode > 57))
				e.preventDefault();

			target.selectionEnd = position;
    }

    /*
     * Aplica uma mascara com a quantidade de precisao
     * definida no parametro precision para um input do tipo text
     */
    function applyDecimalPrecision(DOMelement, precision) {

			if(precision != null || precision > 0) {
      	DOMelement.value = padRight('0,', precision);

	      DOMelement.onblur = function(e) {
	        this.value = this.value.replace(/[^0-9\,]/g,'');
	        var decArray = this.value.split(',');
	        if (decArray[1].length < precision) {
	          decArray[1] = padRight(decArray[1], precision - decArray[1].length);
	        }
	        if (decArray[0].length == 0) {
	          decArray[0] = 0;
	        }
	        this.value = decArray[0] + '.' + decArray[1];
	        this.value = Number(this.value);
	        this.value = this.value.replace('.', ',');
	      };

	      DOMelement.onkeyup = function(e) {
	        var target = e.target;
	        var position = target.selectionStart;
	        if(target.value.indexOf(',') == -1) {
	          var left = target.value.substr(0, target.value.length - precision);
	          var right = target.value.substr(-precision);
	          target.value = left + ',' + right;
	        } else {
	          var decArray = target.value.split(',');
	          while (decArray[1].length > precision) {
	            decArray[0] += decArray[1].substr(0, 1);
	            decArray[1] = decArray[1].substr(1);
	            target.value = decArray[0] + ',' + decArray[1];
	          }
	        }
	        target.selectionEnd = position;
	      };
			}

			DOMelement.onkeypress = function(e) {
        preventNonNumericChar(e);
      };

    }
	/** FIM METODOS UTEIS **/

	// Construtor do GruposTeste - eh este que sera retornado pelo java
	function GruposTeste(grupos) {
		this.grupos = grupos;
	}

	// Verifica se os testes que estao na tela estao concluidos
	var testesConcluidos = function() {
		for (g in this.grupos) {
			for (t in this.grupos[g].testes) {
				var teste = this.grupos[g].testes[t];

				var idTxt = String(teste.id + ':justificativaTestes');

				var e = document.getElementById(idTxt);
				var valueSelect = '';
				if(e != null) {
					valueSelect = e.options[e.selectedIndex].value;
				}

				if( teste.status != "TE" &&  valueSelect.length == 0 ) {
					return false;
				}
				//var check = document.getElementById(teste.id + ":sucesso");
				//if (!check.checked) return false;
			}
		}
		return true;
	};

	var processaJustificativas = function(resposta,form) {
		console.log('processaJustificativas')

		var submeteForm = false;

		for (g in this.grupos) {
			for (t in this.grupos[g].testes) {
				var teste = this.grupos[g].testes[t];

				if( (teste.status != "TE") ) {

					var idTxt = String(teste.id + ':justificativaTestes');

					var e = document.getElementById(idTxt);
					var valueSelect = '';
					if(e != null) {
						valueSelect = e.options[e.selectedIndex].value;
					}

					if(valueSelect.length > 0) {
						enviarJustificativa(valueSelect, teste.id, false);
					}

				}

			}


		}

		if(resposta) form.submit();
	};

	// Busca um grupo de teste por nome
	var retrieveGrupoByName = function(nome) {
		return this.grupos.find(function(g) {
			return g.nome == nome;
		});
	};

	// Busca um teste por id
	var retrieveTesteById = function(testeId) {
		var teste;

		for (g in this.grupos) {
			teste = this.grupos[g].testes.find(function(t) {
				return t.id == testeId;
			});

			if (teste != undefined)
				return teste;
		}

		return teste;
	};

	// Cria um objeto aceitavel pelo java para ser enviado por ajax
	var retrieveTestesRequest = function(condition) {
		var ids = [];

		this.grupos.forEach(function(g) {
				g.testes.forEach(function(t){
					if(condition === undefined) {
						ids.push(	new TesteRequest(t.id, null, t.idTesteProjeto, t.portaInstalacao, null) );
					} else if(condition(t)) {
						ids.push(	new TesteRequest(t.id, null, t.idTesteProjeto, t.portaInstalacao, null) );
					}
				});
		});

		return ids;
	};

	// Retorna o indice do grupo de teste por um teste
	var retrieveGrupoIndexByTeste = function (teste) {

		var grupo;

		this.grupos.forEach(function(g) {
			if(contains(g.testes, teste)) {
				grupo = g;
			}
		});

		return this.grupos.indexOf(grupo);
	};

	// Construtor do TesteRequest - objeto que sera enviado via ajax ao java
	var TesteRequest = function(cntioid, extra, idTesteProjeto, portaInstalacao,justificativa, extra2) {
		this.cntioid = cntioid;
		this.extra = extra;
		this.extra2 = extra2;
		this.idTesteProjeto = idTesteProjeto;
		this.portaInstalacao = portaInstalacao;
		this.justificativaTeste = justificativa;
	};

	// Prototype do GruposTeste
	GruposTeste.prototype = {
		constructor : GruposTeste,
		testesConcluidos : testesConcluidos,
		retrieveTesteById : retrieveTesteById,
		retrieveGrupoByName : retrieveGrupoByName,
		retrieveTestesRequest: retrieveTestesRequest,
		retrieveGrupoIndexByTeste: retrieveGrupoIndexByTeste,
		processaJustificativas: processaJustificativas
	};

	/** FIM GLOBALS **/

	// Reduz a qtd de tentativas
	function reduzQtdTentativas(id) {

		var t = gruposteste.retrieveTesteById(id);

		// Nao validar se for Satelital ou Teclado ou testes de config
		var nReduz = [ 41, 42, 53, 54, 66, 67, 68, 69 ];
		if (contains(nReduz, t.idTesteProjeto)) return;

		if(t.qtdTentativasAuxiliar == null) return;

		t.qtdTentativasAuxiliar = t.qtdTentativasAuxiliar - 1;

		if(t.qtdTentativasAuxiliar <= 0) {
			mudarStatus(id, "TI");

			// Reinicia tentativas
			t.qtdTentativasAuxiliar = t.qtdTentativas;
			return;
		}

	}

	// Apresenta div vermelha de erro
	function showErr(msg) {
		var divMessageError = document.getElementById("divMessageError");
		var span = divMessageError.querySelector("span");

		span.innerHTML = msg;
		divMessageError.style.display = "block";

		$("html, body").animate({ scrollTop: 0 }, "slow");
	}

	// Esconde div vermelha de erro
	function hideErr() {
		var divMessageError = document.getElementById("divMessageError");
		var span = divMessageError.querySelector("span");

		divMessageError.style.display = "none";
		span.innerHTML = "";
	}

	// Verifica o status do teste para apresentar a instrucao adequada
	function definirInstrucao(teste) {

		if (teste.status == "TE") {
			return teste.instrucaoSucesso;
		}

		if (teste.status == "PE") {
			return teste.instrucao;
		}

		if (teste.status == "AE") {
			return teste.instrucaoAndamento;
		}

		if (teste.status == "EX") {
			return teste.instrucaoInsucesso;
		}

		if (teste.status == "TI") {
			return teste.instrucaoInsucesso;
		}

	}

	/*
	 * Define qual será a mensagem que aparecera no link do teste
	 * (Enviar ou Reenviar)
	 * Será 'Enviar' apenas quando o status for pendente
	 */
	function definirLink(status) {
		return (status == "PE") ? "Testar" : "Re-testar";
	}

	/*
	 * Retorna um loading gif ao lado do status
	 * caso este esteja como 'AE' - Aguardando Execução
	 */
	function enfeitarStatus(status) {

		// ico-sucesso.png
		// ico-erro.png
		// ajax-loader.gif

		if(status == "TE") {
			return showImage(16, 'ico-sucesso.png');
		}

		if(status == "AE") {
			return showImage(16, 'ajax-loader.gif');
		}

		return showImage(16, 'ico-erro.png');
	}

	/* Sera executado pelo check que fica na linha de um teste
	 * Caso o teste nao possua status 'TE' sera exibita uma mensagem de alerta
	 * Caso possua, sua flag de sucesso sera true e o check sera marcado
	 */
	var confirmarTeste = function(teste) {
		var element = document.getElementById(teste.id).querySelector(
				"input[type='checkbox']");

		if (element.checked) {
			if (teste.status === 'TE') {
				teste.sucesso = true;
			} else {
				teste.sucesso = false;
				element.checked = false;
				abrirPopupAlerta(
						element,
						document.getElementById("msgAlerta"),
						"Para confirmar a execu\u00E7\u00E3o do teste, o status dever\u00E1 ser 'Teste Executado'.");
			}
		}
	};

	// A partir da sigla do status pega-se a descricao do status
	function getStatusDescricao(status) {

		switch (status) {
		case "TE":
			return "Teste Executado";
		case "PE":
			return "Pendente";
		case "AE":
			return "Aguardando Execu\u00E7\u00E3o";
		case "TI":
			return "Teste Insucesso";
		case "EX":
			return "Expirado";
		default:
			return "Pendente";
		}

	}

	// Mostra um gif de Loading num elemento do DOM
	function showImage(size, imgName) {

		var gif = document.createElement("img");
		// ico-sucesso.png
		// ico-erro.png
		// ajax-loader.gif

		gif.src = '/SascarPortalWeb/sascar/images/corporativo/' + imgName;
		gif.className = 'gif';
		gif.style.width = size + 'px';
		gif.style.height = size + 'px';
		gif.verticalAlign = 'middle';

		return gif;
	}

	// Esconde o gif existente dentro de um elemento do DOM
	function hideImage(DOMelement) {

		var divs = DOMelement.querySelectorAll('.gif');
		for (var i = 0; i < divs.length; i++) {
			DOMelement.removeChild(divs[i]);
		}
	}

	// Mostra um gif de Loading juntamente com uma mensagem em um elemento do DOM
	function showLoading(DOMelement, msg) {

		var gif = document.createElement("img");
		gif.src = '/SascarPortalWeb/sascar/images/corporativo/ajax-loader.gif';
		gif.className = 'gif';

		var span = document.createElement("span");
		span.innerHTML = msg;

		var divLoading = document.createElement("div");
		divLoading.appendChild(gif);
		divLoading.appendChild(span);

		divLoading.className = 'centralizado loadingDiv';

		DOMelement.appendChild(divLoading);
	}

	// Esconde o gif e a mensagem existentes dentro de um elemento DOM
	function hideLoading(DOMelement) {

		var divs = DOMelement.querySelectorAll('.loadingDiv');
		for (var i = 0; i < divs.length; i++) {
			DOMelement.removeChild(divs[i]);
		}
	}

	/*
	 * Utiliza metodos como definirInstrucao e getStatusDescricao (definidos acima)
	 * para atualizar a tela e os objetos da tela
	 */
	function atualizarStatus(id, status) {

		var teste = gruposteste.retrieveTesteById(id);
		var grupoIndex = gruposteste.retrieveGrupoIndexByTeste(teste);
		var testeIndex = gruposteste.grupos[grupoIndex].testes.indexOf(teste);

		teste.statusDescricao = getStatusDescricao(status);
		teste.status = status;
		teste.sucesso = (status == 'TE');

		var elementInstrucao = document.getElementById(teste.id + ":instrucao");
		if (elementInstrucao != undefined) {
			elementInstrucao.innerHTML = definirInstrucao(teste);
		}

		var elementStatusDesc = document.getElementById(teste.id + ":statusDescricao");
		if (elementStatusDesc != undefined) {
			elementStatusDesc.innerHTML = '';
			elementStatusDesc.appendChild(enfeitarStatus(teste.status));
			elementStatusDesc.appendChild(document.createTextNode(teste.statusDescricao));
		}

		var elementStatus = document.getElementById(teste.id + ":status");
		if (elementStatus != undefined) {
			elementStatus.innerHTML = teste.status;
		}

		var elementLink = document.getElementById(teste.id + ":link");
		if (elementLink != undefined) {
			elementLink.innerHTML = definirLink(teste.status);
		}

		gruposteste.grupos[grupoIndex].testes[testeIndex] = teste;

		if(status == 'TE') {
			var comboJustificativa = document.getElementById(teste.id + ':justificativaTestes') ;
			if(comboJustificativa != null) {
				comboJustificativa.parentNode.removeChild(comboJustificativa);
			}
		}
	}

	// Esconde a popUp passada por atributo
	function fecharPopup(popUp) {
		var msg = popUp.querySelector(".popUpMsgValidacao");
		if(msg !== undefined && msg !== null) msg.style.color = '#000000';
		popUp.style.display = "none";
		document.getElementById("aboveall").style.display = "none";
	}

	/*
	 * A partir de um evento, abre a popUp passada como parametro exibindo
	 * a mensagem, tambem passada por parametro
	 */
	function abrirPopupAlerta(e, popUp, msg) {

		popUp.style.top = (getOffsetTop(e) - (200)) + "px";
		popUp.style.left = "0";
		popUp.style.right = "0";
		popUp.style.margin = "auto";
		popUp.style.display = "table";
		document.querySelector("#" + popUp.id + " span").innerHTML = msg;
		document.getElementById("aboveall").style.display = "block";
	}

	/*
	 * Exibe, a partir de um evento, um popUp de confirmacao
	 * exibindo a mensagem passada por parametro
	 * por fim executa a funcao f com um parametro dependendo do evento executado
	 */
	function abrirConfirm(e, popUp, text, f) {

		popUp.style.top = (getOffsetTop(e) - (200)) + "px";
		popUp.style.left = "0";
		popUp.style.right = "0";
		popUp.style.margin = "auto";
		popUp.style.display = "block";

		var msg = popUp.querySelector(".popUpMsgValidacao");
		msg.innerHTML = text;

		var cancelarBtn = popUp.querySelector(".cancelar");
		cancelarBtn.onclick = function(e) {
			e.preventDefault;
			fecharPopup(popUp);
			f(false);
		};

		var enviarBtn = popUp.querySelector(".enviarTeste");
		enviarBtn.onclick = function(e) {
			e.preventDefault;
			fecharPopup(popUp);
			f(true);
		};

		document.getElementById("aboveall").style.display = "block";
	}

	 /*
	  * Exibe um popUp passado por parametro
	  * este popup possui um radio
	  * Por fim executa uma funcao f com um parametro dependendo do evento executado
	  */
	function enviarRadio(e, popUp, teste, f) {

		popUp.style.top = (getOffsetTop(e) - (200)) + "px";
		popUp.style.left = "0";
		popUp.style.right = "0";
		popUp.style.margin = "auto";
		popUp.style.display = "block";

		var extra = popUp.querySelector("input[type='radio']:checked");
		if (extra !== undefined && extra !== null) extra.checked = false;

		var cancelarBtn = popUp.querySelector(".cancelar");
		cancelarBtn.onclick = function(e) {
			e.preventDefault;
			fecharPopup(popUp);
			f(null);
		};

		var enviarBtn = popUp.querySelector(".enviarTeste");
		enviarBtn.onclick = function(e) {
			e.preventDefault;
			extra = popUp.querySelector("input[type='radio']:checked");
			if (extra === undefined || extra === null) {
				popUp.querySelector(".popUpMsgValidacao").style.color = '#FF0000';
			} else {
				fecharPopup(popUp);
				var extraInput = document.getElementById(teste.id + ":extra");
				extraInput.value = extra.value;
				f(extra.value);
			}
		};

		document.getElementById("aboveall").style.display = "block";
	}

	/*
	 * Exibe um popUp passado por parametro
	 * este popup possui um inputText
	 * Por fim executa uma funcao f com um parametro dependendo do evento executado
	 */
	function enviarText(e, popUp, teste, f) {

		popUp.style.top = (getOffsetTop(e) - (200)) + "px";
		popUp.style.left = "0";
		popUp.style.right = "0";
		popUp.style.margin = "auto";
		popUp.style.display = "block";

		var extra = popUp.querySelector("input[type='text']");
		extra.value = '';

		extra.onkeyup = function(e) {
			var target = e.target;
			var position = target.selectionStart;

			// Se for temperatura, aceitar negativo
			if(teste.idTesteProjeto == 52) {
				target.value = target.value.replace(/[^-\d]/g,'').replace(/(?!^)-/g, '');
			} else {
				target.value = target.value.replace(/\D/g, '');
			}

			target.selectionEnd = position;
		};

		extra.onblur = function(e) {
			if(teste.idTesteProjeto == 52) {
				e.target.value = Number(e.target.value);
				if(isNaN(e.target.value)) {
					e.target.value = 0;
				}
			}
		};

		var msg = popUp.querySelector(".popUpMsgValidacao");
		msg.innerHTML = teste.instrucao;

		var cancelarBtn = popUp.querySelector(".cancelar");
		cancelarBtn.onclick = function(e) {
			e.preventDefault;
			fecharPopup(popUp);
			f(null);
		};

		var enviarBtn = popUp.querySelector(".enviarTeste");
		enviarBtn.onclick = function(e) {
			e.preventDefault;

			if (extra.value == '') {
				popUp.querySelector(".popUpMsgValidacao").style.color = '#FF0000';
			} else {
				fecharPopup(popUp);
				var extraInput = document.getElementById(teste.id + ":extra");
				extraInput.value = extra.value;
				f(extra.value);
			}
		};

		document.getElementById("aboveall").style.display = "block";
	}


	/*
	 * Exibe um popUp passado por parametro
	 * este popup possui dois inputText com mascara de decimal
	 * Por fim executa uma funcao f com um parametro dependendo do evento executado
	 */
	function enviarDuplo(e, popUp, teste, f) {

		popUp.style.top = (getOffsetTop(e) - (200)) + "px";
		popUp.style.left = "0";
		popUp.style.right = "0";
		popUp.style.margin = "auto";
		popUp.style.display = "block";

		var extra = popUp.querySelector("input[name='extra']");
		var extra2 = popUp.querySelector("input[name='extra2']");

		extra.value = '';
		extra2.value = '';

		setValidadorDecimal(extra, false); //umidade
		setValidadorDecimal(extra2, true); //temperatura (aceita negativo)

		var msg = popUp.querySelector(".popUpMsgValidacao");
		msg.innerHTML = teste.instrucao;

		var cancelarBtn = popUp.querySelector(".cancelar");
		cancelarBtn.onclick = function(e) {
			e.preventDefault;
			fecharPopup(popUp);
			f(null, null);
		};

		var enviarBtn = popUp.querySelector(".enviarTeste");
		enviarBtn.onclick = function(e) {
			e.preventDefault;

			if (extra.value == '' || extra2.value == '') {
				popUp.querySelector(".popUpMsgValidacao").style.color = '#FF0000';
			} else {
				fecharPopup(popUp);
				var extraInput = document.getElementById(teste.id + ":extra");
				var extraInput2 = document.getElementById(teste.id + ":extra2");
				extraInput.value = extra.value.replace(',', '.');
				extraInput2.value = extra2.value.replace(',', '.');
				f(extraInput.value, extraInput2.value);
			}
		};

		document.getElementById("aboveall").style.display = "block";
	}

	function setValidadorDecimal(input, aceitaNegativo) {
		input.setAttribute('maxlength','5'); // Por exemplo: -99,9

		input.onkeyup = function(e) {
			var target = e.target;
			var position = target.selectionStart;

			if(aceitaNegativo)
				target.value = target.value.replace(/[^-,\d]/g,'');
			else
				target.value = target.value.replace(/[^,\d]/g,'');

			// Não permitir mais que 1 virgula
			var v = 0;
			target.value = target.value.replace(/,/g, function (match) {
				v++;
				return (v > 1) ? '' : match;
			});

			target.selectionEnd = position;
		};

		input.onblur = function(e) {
			e.target.value = Number(e.target.value.replace(',','.'));
			if(isNaN(e.target.value))
				e.target.value = 0;
			else
				e.target.value = e.target.value.replace('.',',');
		};
	}

	/*
	 * Exibe um popUp passado por parametro
	 * este popup possui um inputText com mascara de decimal
	 * Por fim executa uma funcao f com um parametro dependendo do evento executado
	 */
	function enviarDecimal(e, popUp, teste, f) {

		popUp.style.top = (getOffsetTop(e) - (200)) + "px";
		popUp.style.left = "0";
		popUp.style.right = "0";
		popUp.style.margin = "auto";
		popUp.style.display = "block";

		var extra = popUp.querySelector("input[type='text']");
		extra.value = '';

		applyDecimalPrecision(extra, teste.precisao);

		var msg = popUp.querySelector(".popUpMsgValidacao");
		msg.innerHTML = teste.instrucao;

		var cancelarBtn = popUp.querySelector(".cancelar");
		cancelarBtn.onclick = function(e) {
			e.preventDefault;
			fecharPopup(popUp);
			f(null);
		};

		var enviarBtn = popUp.querySelector(".enviarTeste");
		enviarBtn.onclick = function(e) {
			e.preventDefault;

			if (extra.value == '') {
				popUp.querySelector(".popUpMsgValidacao").style.color = '#FF0000';
			} else {
				fecharPopup(popUp);
				extra.value = extra.value.replace(',', '.');
				var extraInput = document.getElementById(teste.id + ":extra");
				extraInput.value = extra.value;
				f(extra.value);
			}
		};

		document.getElementById("aboveall").style.display = "block";
	}

	/*
	 * Verifica se o teste em questao precisa que um popup seja aberto
	 * para que o instalador insira algum dado adicional
	 */
	function abrirPopupExtra(e, teste, enviarTeste) {

		var textPopUpIdsarr = [ 50, 51, 52, 70, 71, 72, 73, 83, 141 ];

		if (teste.idTesteProjeto == 85) {
			var popUpMeiaLuz = document.getElementById("popUpMeiaLuz");
			enviarRadio(e, popUpMeiaLuz, teste, function(extra) {
				enviarTeste(extra != null);
			});

		} else if (teste.idTesteProjeto == 43 || teste.idTesteProjeto == 44) {
			var popUpCambioAutomatico = document.getElementById("popUpCambioAutomatico");
			enviarRadio(e, popUpCambioAutomatico, teste, function(extra) {
				enviarTeste(extra != null);
			});

		} else if (teste.idTesteProjeto == 89) {
			var popUpDecimal = document.getElementById('popUpDecimal');
			enviarDecimal(e, popUpDecimal, teste, function(extra) {
				enviarTeste(extra != null);
			});

		} else if (teste.idTesteProjeto == 141) {
			//Sensor Serial de Umidade e Temperatura
			var popUpDuplo = document.getElementById('popUpDuplo');
			enviarDuplo(e, popUpDuplo, teste, function(extra, extra2) {
				enviarTeste(extra != null && extra2 != null);
			});

		} else if (contains(textPopUpIdsarr, teste.idTesteProjeto)) {
			// [ 50, 51, 52, 70, 71, 72, 73, 83 ]
			var popUpOutro = document.getElementById("popUpOutro");
			enviarText(e, popUpOutro, teste, function(extra) {
					enviarTeste(extra != null);
			});
		} else {
			enviarTeste(true);
		}
	}

	function allValuesSame(arr) {

	    for(var i = 1; i < arr.length; i++) {
	        if(arr[0] !== arr[i])
	            return false;
	    }

	    return true;
	}

	function in_array(needle, haystack) {
	    for(var i in haystack) {
	        if(haystack[i] == needle) return true;
	    }
	    return false;
	}

	/*
	 * Funcao que exibe as tabelas de testes, os testes e todas as funcionalidades envolvidas
	 * Sera executada apos o carregar a pagina.
	 */
	function criarTabelaTestes(gruposteste,listaMotivoJustificativa, listaItensOS) {

		var optionsJustificativa = '<option value="">Selecione</option>';

		var grupos = gruposteste.grupos;

		var divTestes = document.getElementById("testes");

		var itensOrdemMesmoTipo = allValuesSame(listaItensOS);

		while (divTestes.firstChild) {
			divTestes.removeChild(divTestes.firstChild);
		}

		if(typeof listaMotivoJustificativa != "undefined" && listaMotivoJustificativa.length > 0) {
			for (var i in listaMotivoJustificativa) {
				optionsJustificativa += '<option value="' + listaMotivoJustificativa[i].codigo + '">' + listaMotivoJustificativa[i].descricao + '</option>';
			}
		}

		for (g in grupos) {

			var txtBarraSubstitulo = document.createElement("div");
			txtBarraSubstitulo.className = "textoBarraSubtitulo";
			txtBarraSubstitulo.innerHTML = grupos[g].nome;

			var barraSubtitulos = document.createElement("div");
			barraSubtitulos.style.marginTop = "15px";
			barraSubtitulos.appendChild(txtBarraSubstitulo);
			barraSubtitulos.className = "barraSubtitulos";

			divTestes.appendChild(barraSubtitulos);

			var testesContainer = document.createElement("div");
			testesContainer.className = "testesContainer";

			divTestes.appendChild(testesContainer);

			var tabelaTestes = document.createElement("table");

			var col1 = document.createElement("col");
			col1.style.width = "20%";
			tabelaTestes.appendChild(col1);
			var col2 = document.createElement("col");
			col2.style.width = "35%";
			tabelaTestes.appendChild(col2);
			var col3 = document.createElement("col");
			col3.style.width = "7%";
			tabelaTestes.appendChild(col3);
			var col4 = document.createElement("col");
			col4.style.width = "20%";
			tabelaTestes.appendChild(col4);
			var col5 = document.createElement("col");
			col5.style.width = "10%";
			tabelaTestes.appendChild(col5);
			var col6 = document.createElement("col");
			col6.style.width = "8%";
			tabelaTestes.appendChild(col6);

			var trHeader = document.createElement("tr");

			var thTeste = document.createElement("th");
			thTeste.innerHTML = '<fmt:message key="label.teste" />';
			trHeader.appendChild(thTeste);

			var thInstrucao = document.createElement("th");
			thInstrucao.innerHTML = '<fmt:message key="label.instrucao" />';
			trHeader.appendChild(thInstrucao);

			var thPorta = document.createElement("th");
			thPorta.innerHTML = '<fmt:message key="label.porta" />';
			trHeader.appendChild(thPorta);

			var thStatus = document.createElement("th");
			thStatus.innerHTML = '<fmt:message key="label.statusTeste" />';
			trHeader.appendChild(thStatus);

			/*var thExecutado = document.createElement("th");
			thExecutado.innerHTML = '<fmt:message key="label.testeExecutado" />';
			trHeader.appendChild(thExecutado);*/

			var thJustificativa = document.createElement("th");
			thJustificativa.innerHTML = '<fmt:message key="label.justificarTeste" />';
			trHeader.appendChild(thJustificativa);


			var thAcao = document.createElement("th");
			thAcao.innerHTML = '<fmt:message key="label.acoes" />';
			trHeader.appendChild(thAcao);

			tabelaTestes.appendChild(trHeader);
			testesContainer.appendChild(tabelaTestes);

			for (t in grupos[g].testes) {

				var trTeste = document.createElement("tr");
				trTeste.id = grupos[g].testes[t].id;

				var extraElement = document.createElement('input');
				extraElement.type = 'hidden';
				extraElement.id = grupos[g].testes[t].id + ":extra";
				trTeste.appendChild(extraElement);

				var extra2Element = document.createElement('input');
				extra2Element.type = 'hidden';
				extra2Element.id = grupos[g].testes[t].id + ":extra2";
				trTeste.appendChild(extra2Element);

				var tdTeste = document.createElement("td");
				tdTeste.id = grupos[g].testes[t].id + ":descricao";
				tdTeste.innerHTML = grupos[g].testes[t].descricao;
				trTeste.appendChild(tdTeste);

				var tdInstrucao = document.createElement("td");
				tdInstrucao.id = grupos[g].testes[t].id + ":instrucao";
				tdInstrucao.innerHTML = definirInstrucao(grupos[g].testes[t]);
				trTeste.appendChild(tdInstrucao);

				var tdPorta = document.createElement("td");
				tdPorta.id = grupos[g].testes[t].id + ":portaInstalacao";
				tdPorta.innerHTML = grupos[g].testes[t].portaInstalacao;
				trTeste.appendChild(tdPorta);

				var tdStatus = document.createElement("td");
				tdStatus.id = grupos[g].testes[t].id + ":statusDescricao";
				tdStatus.innerHTML = '';

				if(grupos[g].testes[t].sucesso == false){
					grupos[g].testes[t].status = 'TI';
				}

				tdStatus.appendChild(enfeitarStatus(grupos[g].testes[t].status));
				tdStatus.appendChild(document.createTextNode(grupos[g].testes[t].statusDescricao));
				trTeste.appendChild(tdStatus);

				var tdJustificativa = document.createElement("td");
				tdJustificativa.innerHTML = '';

				var tipoOrdemJustificativaPermitida = grupos[g].testes[t].tipoOSTesteObrigatorio.split(",");

				var permiteJustificativa = false;

				if(itensOrdemMesmoTipo == true &&
					listaItensOS && listaItensOS.length > 0 && in_array(listaItensOS[0],tipoOrdemJustificativaPermitida)) {
					permiteJustificativa = true;
				}

				if(grupos[g].testes[t].travaComboJustificativa == false &&
					permiteJustificativa == true) {

					var selectList = document.createElement("select");
					selectList.id = grupos[g].testes[t].id + ":justificativaTestes";
					selectList.innerHTML = optionsJustificativa;
					if(grupos[g].testes[t].idJustificativa > 0) {
						selectList.value = grupos[g].testes[t].idJustificativa;
					}
					tdJustificativa.appendChild(selectList);
				}

				trTeste.appendChild(tdJustificativa);

				var tdEnviar = document.createElement("td");
				var link = document.createElement("a");
				link.id = grupos[g].testes[t].id + ":link";
				link.href = "";
				link.className = "linkEnviar";
				link.innerHTML = definirLink(grupos[g].testes[t].status);
				link.onclick = function(e) {
					e.preventDefault();

					var teste = gruposteste
							.retrieveTesteById(this.parentNode.parentNode.id);

					abrirPopupExtra(this, teste, function(executarTeste) {
						if (executarTeste) {
							var extra = document.getElementById(teste.id + ":extra").value;
							var extra2 = document.getElementById(teste.id + ":extra2").value;

							extra = (isNaN(extra) ? null : extra);
							extra2 = (isNaN(extra2) ? null : extra2);
							var arrayEnvio = new Array();

							arrayEnvio.push(new TesteRequest(teste.id, extra, teste.idTesteProjeto, teste.portaInstalacao, null, extra2));

							enviarTestes(arrayEnvio, document.getElementById(teste.id + ":link"));
						}
					});
				};

				tdEnviar.appendChild(link);
				trTeste.appendChild(tdEnviar);
				tabelaTestes.appendChild(trTeste);
			}

			if (grupos[g].executarTudo) {

				var inputSend = document.createElement("input");
				inputSend.type = "button";
				inputSend.value = "Executar Testes";
				inputSend.className = "button centralizado";
				inputSend.id = grupos[g].nome;
				inputSend.onclick = function(e) {
					e.preventDefault();
					var grupo = gruposteste.retrieveGrupoByName(this.id);
					preparareEnviarTestes(this, grupo, 0);
				};

				testesContainer.appendChild(inputSend);
			}
		}
	}

	/**
	 * Caso o teste não seja possível executar o teste, persiste a justificativa
	 */
	function enviarJustificativa(justificativa, testeId, mostraMensagemSucesso) {
		$.ajax({
			type : "POST",
			sync : false,
			crossDomain : true,
			url : "/SascarPortalWeb/PilotoTestes/do",
			data : {
				acao : 1001,
				id_justificativa: justificativa,
				id_teste: testeId
			},
			dataType : "json",
			global : false,
			success : function(json) {
				if(mostraMensagemSucesso == true) {
					$("#dialog_mensagem .popup_padrao_pergunta")
								.html('<fmt:message key="0613" />');

					$("#dialog_mensagem").jOverlay({
						'closeOnEsc' : false,
						'bgClickToClose' : false
					});
				}

			},
			error : function(jqXHR, textStatus, errorThrown) {
				if(jqXHR.status === 400) {
					var msg = jqXHR.responseText.replace(/(^\")|(\"$)/g, "");
					abrirPopupAlerta(document.getElementById("testes"), document.getElementById('msgAlerta'), msg);
				} else {
					location.reload();
				}
			},
			complete : function(json) {
				console.log('complete')
				hideLoading(document.getElementById('testes'));
				resizeIframeParent();
			}
		});
	}

	/*
	 * Prepara os testes de um grupo que sera enviado para o back
	 * Alem de verificar teste por teste a necessidade de exigir parametro extra
	 * Realiza chamadas recursivas a sim mesmo para iterar sobre teste
	 */
	function preparareEnviarTestes(e, grupotestes, index) {

		if (grupotestes == null) return;

		if(grupotestes.testes.length <= index) {
			var arrayEnvio = new Array();
			for(var i=0; i<grupotestes.testes.length; i++) {
				if(grupotestes.testes[i].seraEnviado) {
					var extra = document.getElementById(grupotestes.testes[i].id + ":extra").value;
					var extra2 = document.getElementById(grupotestes.testes[i].id + ":extra2").value;

					extra = (isNaN(extra) ? null : extra);
					extra2 = (isNaN(extra2) ? null : extra2);

					arrayEnvio.push(new TesteRequest(grupotestes.testes[i].id, extra,
						grupotestes.testes[i].idTesteProjeto,
						grupotestes.testes[i].portaInstalacao,
						null,
						extra2));
				}
			}
			console.log("Enviando testes: " + JSON.stringify(arrayEnvio));
			enviarTestes(arrayEnvio, e);
			return;
		}

		var teste = grupotestes.testes[index];

		var textPopUpIdsarr = [ 50, 51, 52, 70, 71, 72, 73, 83, 141];

		if (teste.idTesteProjeto == 85) {
			var popUpMeiaLuz = document.getElementById("popUpMeiaLuz");
			enviarRadio(e, popUpMeiaLuz, teste, function(extra) {
				if (extra != null) {
					teste.seraEnviado = true;
					preparareEnviarTestes(e, grupotestes, ++index);
				} else {
					preparareEnviarTestes(e, null, null);
				}
			});

		} else if (teste.idTesteProjeto == 43 || teste.idTesteProjeto == 44) {
			var popUpCambioAutomatico = document.getElementById("popUpCambioAutomatico");
			enviarRadio(e, popUpCambioAutomatico, teste, function(extra) {
				if (extra != null) {
					teste.seraEnviado = true;
					preparareEnviarTestes(e, grupotestes, ++index);
				} else {
					preparareEnviarTestes(e, null, null);
				}
			});

		}  else if (teste.idTesteProjeto == 89) {
			var popUpDecimal = document.getElementById('popUpDecimal');
			enviarDecimal(e, popUpDecimal, teste, function(extra) {
				if (extra != null) {
					teste.seraEnviado = true;
					preparareEnviarTestes(e, grupotestes, ++index);
				} else {
					preparareEnviarTestes(e, null, null);
				}
			});

		} else if (teste.idTesteProjeto == 141) {
			//Sensor Serial de Umidade e Temperatura
			var popUpDuplo = document.getElementById('popUpDuplo');
			enviarDuplo(e, popUpDuplo, teste, function(extra, extra2) {
				if (extra != null && extra2 != null) {
					teste.seraEnviado = true;
					preparareEnviarTestes(e, grupotestes, ++index);
				} else {
					preparareEnviarTestes(e, null, null);
				}
			});

		}
		 else if (contains(textPopUpIdsarr, teste.idTesteProjeto)) {
			// [ 50, 51, 52, 70, 71, 72, 73, 83 ]
			var popUpOutro = document.getElementById("popUpOutro");
			enviarText(e, popUpOutro, teste, function(extra) {
				if (extra != null) {
					teste.seraEnviado = true;
					preparareEnviarTestes(e, grupotestes, ++index);
				} else {
					preparareEnviarTestes(e, null, null);
				}
			});

		} else {
			teste.seraEnviado = true;
			return preparareEnviarTestes(e, grupotestes, ++index);
		}

	}

	// Chamada assincrona ao back para atualizar status dos testes que estao como Aguardando execucao
	function recuperarStatusTestesFiltrado() {

		if(typeof gruposteste != "undefined") {
			// Nao buscar os testes com status diferente de 'AE'
			var testes = gruposteste.retrieveTestesRequest(function(t) { return (t.status == 'AE')});
			if (testes.length == 0) return;

			console.log('Verificando se existe extra definido');
			for(var i = 0; i < testes.length; i++) {
				var teste = testes[i];
				if((teste.extra === undefined || teste.extra === null) && (teste.idTesteProjeto === 44 || teste.idTesteProjeto == 43)) {
					console.log('Setando extra como ' + tipoExtra);
					teste.extra = tipoExtra;
				}
			}

			$.ajax({
				type : "POST",
				sync : false,
				crossDomain : true,
				url : "/SascarPortalWeb/PilotoTestes/do",
				data : {
					acao : 999,
					testes : JSON.stringify(testes)
				},
				dataType : "json",
				global : false,
				success : function(json) {
					json.forEach(function(e) {
						atualizarStatus(e.cntioid, e.status);
						if(e.status != 'TE') {
							reduzQtdTentativas(e.cntioid);
						}
					});
				},
				error : function(jqXHR, textStatus, errorThrown) {
						console.error('Falha ao atualizar status dos testes');
				},
				complete : function(json) {
					hideLoading(document.getElementById('testes'));
					resizeIframeParent();
				}
			});
		}
	}

	// Chamada assincrona ao back para atualizar status dos testes
	function recuperarStatusTestes(e) {

		hideErr();
		hideLoading(document.getElementById('testes'));
		showLoading(document.getElementById('testes'), 'Atualizando...');

		var testes = gruposteste.retrieveTestesRequest();

		console.log('Verificando se existe extra definido');
		for(var i = 0; i < testes.length; i++) {
			var teste = testes[i];
			if((teste.extra === undefined || teste.extra === null) && (teste.idTesteProjeto === 44 || teste.idTesteProjeto == 43)) {
				console.log('Setando extra como ' + tipoExtra);
				teste.extra = tipoExtra;
			}
		}

		$.ajax({
			type : "POST",
			sync : false,
			crossDomain : true,
			url : "/SascarPortalWeb/PilotoTestes/do",
			data : {
				acao : 999,
				testes : JSON.stringify(testes)
			},
			dataType : "json",
			global : false,
			success : function(json) {
				json.forEach(function(e) {
					atualizarStatus(e.cntioid, e.status);
				});
			},
			error : function(jqXHR, textStatus, errorThrown) {
				if(jqXHR.status === 400) {
					var msg = jqXHR.responseText.replace(/(^\")|(\"$)/g, "");
					abrirPopupAlerta(e, document.getElementById('msgAlerta'), msg);
				} else {
					location.reload();
				}
			},
			complete : function(json) {
				hideLoading(document.getElementById('testes'));
				resizeIframeParent();
			}
		});
	}

	// Chamada assincrona ao back para cancelar comandos pendentes
	function cancelarComandosPendentes(e) {

		hideErr();

		var testes = gruposteste.retrieveTestesRequest();

		$.ajax({
			type : "POST",
			sync : false,
			crossDomain : true,
			url : "/SascarPortalWeb/PilotoTestes/do",
			data : {
				acao : 42,
				ordoid: ordoid,
				testes : JSON.stringify(testes)
			},
			dataType : "json",
			global : false,
			success : function(json) {
				json.forEach(function(e) {
					atualizarStatus(e.cntioid, e.status);
				});
			},
			error : function(jqXHR, textStatus, errorThrown) {
				if(jqXHR.status === 400) {
					var msg = jqXHR.responseText.replace(/(^\")|(\"$)/g, "");
					abrirPopupAlerta(e, document.getElementById('msgAlerta'), msg);
				} else {
					location.reload();
				}
			}
		});
	}

	// Chamada assincrona ao back para mudar o status de um teste
	function mudarStatus(cntioid, status, e) {

		$.ajax({
			type : "POST",
			sync : false,
			crossDomain : true,
			url : "/SascarPortalWeb/PilotoTestes/do",
			data : {
				acao : 787,
				cntioid : cntioid,
				status : status
			},
			dataType : "json",
			global : false,
			success : function(e) {
				atualizarStatus(cntioid, status);
			},
			error : function(jqXHR, textStatus, errorThrown) {
				if(jqXHR.status === 400) {
					showErr(jqXHR.responseText.replace(/(^\")|(\"$)/g, ""));
				} else {
					location.reload();
				}
			}
		});
	}

	// Chamada assincrona ao back para enviar testes
	function enviarTestes(testes, e) {

		hideErr();

		testes.forEach(function(e) {
			atualizarStatus(e.cntioid, 'AE');
		});

		$.ajax({
			type : "POST",
			sync : false,
			crossDomain : true,
			url : "/SascarPortalWeb/PilotoTestes/do",
			data : {
				acao : 666,
				testes : JSON.stringify(testes),
				numeroCPF : cpf,
				numeroPlaca : placa,
				numeroOs : ordoid
			},
			dataType : "json",
			global : false,
			success : function(json) {
				console.log(JSON.stringify(json));
				json.forEach(function(e) {
					atualizarStatus(e.cntioid, e.status);
				});
			},
			error : function(jqXHR, textStatus, errorThrown) {
				if(jqXHR.status === 400) {
					testes.forEach(function(e) { atualizarStatus(e.cntioid, 'PE'); });
					var msg = jqXHR.responseText.replace(/(^\")|(\"$)/g, "");
					abrirPopupAlerta(e, document.getElementById('msgAlerta'), msg);
				} else {
					location.reload();
				}
			}
		});
	}

	// Metodo iniciado apos o load da pagina e apos o onload do jquery
	window.onload = function() {

		ordoid = '${param.numeroOS}';
		cpf = '${param.numeroCPF}';
		placa = '${param.numeroPlaca}';

		showLoading(document.getElementById("testes"), 'Buscando Testes...');

		// Busca os testes e cria tabela
		$.ajax({
			type : "POST",
			sync : false,
			crossDomain : true,
			url : "/SascarPortalWeb/PilotoTestes/do",
			data : {
				acao : 15,
				numeroOS : ordoid,
				numeroCPF : cpf
			},
			dataType : "json",
			global : false,
			success : function(json) {
				gruposteste = new GruposTeste(json);
				buscaListaJustificativa(gruposteste,ordoid);
			},
			error : function(jqXHR, textStatus, errorThrown) {
				if(jqXHR.status === 400) {
					var msg = jqXHR.responseText.replace(/(^\")|(\"$)/g, "");
					abrirPopupAlerta(document.getElementById("testes"), document.getElementById('msgAlerta'), msg);
				} else {
					location.reload();
				}
			},
			complete : function(json) {
				hideLoading(document.getElementById('testes'));
				resizeIframeParent();
			}

		});

		/* Atualiza os status dos testes de 10 em 10 segundos */
		setInterval(recuperarStatusTestesFiltrado, 10000);

		/*
		 * Adiciona um listener para submit
		 * Caso todos os testes estejam concluidos
		 * o sistema direciona o usuario para a tela de conclusao
		 */
		document.getElementById("formConcluirTestes").onsubmit = function(e) {

			console.log(gruposteste);

			var form = this;
			if (!gruposteste.testesConcluidos()) {
				e.preventDefault();
				abrirPopupAlerta(document.getElementById("concluirTestes"), document.getElementById("msgAlerta"),
						"Existem testes que n&atilde;o est&atilde;o confirmados, ou que n&atilde;o foram executados/justificados, por favor, verifique.");
			} else {
				e.preventDefault();

				abrirConfirm(document.getElementById("concluirTestes"), document.getElementById("popUpConfirm"),
						"Esta opera&ccedil;&atilde;o ir&aacute; concluir os testes de ativa&ccedil;&atilde;o, certifique-se de que todos os testes foram executados com sucesso.",
						function(resposta) {

							gruposteste.processaJustificativas(resposta,form);

						}
				);
			}
		};

		/*
		 * Adiciona um listener para o botao Atualizar Status
		 * Irá fazer uma chamada assincrona no backend que, por sua vez, ira
		 * validar cada teste com o status 'AE'
		 */
		/*document.getElementById("atualizaStatus").onclick = function(e) {
			e.preventDefault();
			recuperarStatusTestes(this);
		};*/

		var divMsgAlerta = document.getElementById("msgAlerta");
		var buttonAlerta = divMsgAlerta.querySelector('input[type=button]');
		buttonAlerta.onclick = function(e) {
			e.preventDefault();
			fecharPopup(divMsgAlerta);
		};

		/*
		 * Adiciona um listener para o botao Cancelar Comandos Pendentes
		 * Irá fazer uma chamada assincrona no backend que, por sua vez, ira
		 * cancelar todos os comandos pendentes para o veiculo em questao
		 */
		document.getElementById("cancelarComandos").onclick = function(e) {
			e.preventDefault();
			abrirConfirm(this, document.getElementById("popUpConfirm"),
					"Esta opera&ccedil;&atilde;o ir&aacute; cancelar todos os comandos pendentes de execu&ccedil;&atilde;o, confirma a&ccedil;&atilde;o?",
					function(resposta) {
						if(resposta) cancelarComandosPendentes(document.getElementById("cancelarComandos"));
					}
			);
		};

	};
</script>

<c:if test="${not empty mensagem }">
	<script type="text/javascript">
		$.showMessage("${mensagem}");
	</script>
</c:if>

<c:if test="${not empty helper}">
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>

<script type="text/javascript">
	function submeterObservacao(form) {
		var data = $(form).serialize();

		var qtdeCaract = $("#observacao").val().length;
		if (qtdeCaract < 20) {
			$.showMessage('<fmt:message key="mensagem.informacao.peloMenos20Caracteres" />');
		} else {

			//configuracoes para tirar os caches - IE
			$.support.cors = true; //  cross-site scripting
			$.ajaxSetup({
				cache : false
			});

			//Recupera defeitos conforme OS
			$.ajax({
				type : "POST",
				sync : false,
				crossDomain : true,
				url : "/SascarPortalWeb/AtivarEquipamentoTestes/submeterObservacao?acao=2",
				data : data || {},
				dataType : "json",
				success : function(json) {
					if (json.success) {
						$("#observacao").val("");
						$("#dialog_mensagem .popup_padrao_pergunta")
								.html(
										'<fmt:message key="mensagem.sucesso.observacaoEnviada" />');
						$("#dialog_mensagem").jOverlay({
							'closeOnEsc' : false,
							'bgClickToClose' : false
						});
					} else {
						$.showMessage(json.mensagem);
					}
				}
			});
		}
	}

	/*
	 * Metodo verifica se o motivo da Os  e igual a assistencia e se o tipo equipamento e igual a caso ( S )
	 * Se for igual, segue para tela de laudo da demanda 84154, caso nao for, segue o fluxo antigo para a DV05
	 */
	function validaMotivoETipoEquipamento() {

		var motivo = "${param.motivo}";
		var tipoEquipamento = "${param.tipoEquipamento}";
		var fromMobile = "${param.fromMobile}";
		var gerarLaudo = "${equipamento.gerarLaudo}";

		if (fromMobile == 'true') {
			$('#formConcluirTestes')
			.attr(
					'action',
					'${pageContext.request.contextPath}${urlReprogramada}UC13/dv05');

		} else if(gerarLaudo == "true"){
			$('#formConcluirTestes')
					.attr(
							'action',
							'${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv14');
		} else {
			$('#formConcluirTestes')
					.attr(
							'action',
							'${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv05');
		}

	}

	$(document).ready(function() {

		$('#cambioAuto').click(function(evt){
			tipoExtra = "1";
			console.log('Tipo câmbio: ' + tipoExtra);
		});

		$('#cambioManual').click(function(evt){
			tipoExtra = "0";
			console.log('Tipo câmbio: ' + tipoExtra);
		});

		validaMotivoETipoEquipamento();

		$('#id-teste > div:gt(1)').bind('click', function() {

		});

		if ($("#observacao").length) {
			$('#observacao').limit('150', '#charsLeft');
		}
	});

	function exibePopUpDependencia(descricaoTesteRealizado) {

		var str = '<fmt:message key="uc13.dv09.texto.001.realizarOTeste"><fmt:param>'
				+ descricaoTesteRealizado + '</fmt:param></fmt:message>';

		$("#testeDependencia").html(str);
		$("#dialog_mensagem_teste_dependencia").jOverlay({
			'onSuccess' : function() {

			}
		});
	}


	function buscaListaJustificativa(gruposteste,ordoid) {

		// Busca os testes e cria tabela
		$.ajax({
			type : "POST",
			sync : false,
			crossDomain : true,
			url : "/SascarPortalWeb/PilotoTestes/do",
			data : {
				acao : 1000
			},
			dataType : "json",
			global : false,
			success : function(json) {
				buscaItensOrdem(ordoid,gruposteste,json);
			},
			error : function(jqXHR, textStatus, errorThrown) {
				if(jqXHR.status === 400) {
					var msg = jqXHR.responseText.replace(/(^\")|(\"$)/g, "");
					abrirPopupAlerta(document.getElementById("testes"), document.getElementById('msgAlerta'), msg);
				} else {
					location.reload();
				}
			},
			complete : function(json) {
				console.log('complete')
				hideLoading(document.getElementById('testes'));
				resizeIframeParent();
			}

		});

	}

	function buscaItensOrdem(ordoid,gruposTeste,listaJustificativa) {
		// Busca os itens da ordem
		$.ajax({
			type : "POST",
			sync : false,
			crossDomain : true,
			url : "/SascarPortalWeb/PilotoTestes/do",
			data : {
				acao : 1002,
				os: ordoid
			},
			dataType : "json",
			global : false,
			success : function(tipoItensOS) {
				criarTabelaTestes(gruposTeste,listaJustificativa,tipoItensOS);
			},
			error : function(jqXHR, textStatus, errorThrown) {
				if(jqXHR.status === 400) {
					var msg = jqXHR.responseText.replace(/(^\")|(\"$)/g, "");
					abrirPopupAlerta(document.getElementById("testes"), document.getElementById('msgAlerta'), msg);
				} else {
					location.reload();
				}
			},
			complete : function(json) {
				console.log('complete')
				hideLoading(document.getElementById('testes'));
				resizeIframeParent();
			}

		});
	}
</script>

<!-- FORM VOLTAR TIPO EQUIPAMENTO CASCO 'S' -->
<form method="post" id="formVoltarTipoEquipamentoCasco"
	action="${pageContext.request.contextPath}${urlReprogramada}UC13/dv01">
	<input type="hidden" name="numeroOS" value="${param.numeroOS}" />
	<input type="hidden" name="numeroPlaca" value="${param.numeroPlaca}" />
	<input type="hidden" name="motivo" value="${param.motivo}" />
	<input type="hidden" name="fromMobile" value="${param.fromMobile}" />
</form>

<!-- FORM VOLTAR TIPO EQUIPAMENTO CARGA  'C' -->
<form method="post" id="formVoltarTipoEquipamentoCarga"
	action="${pageContext.request.contextPath}${urlReprogramada}UC13/dv02">
	<input type="hidden" name="numeroOS" value="${param.numeroOS }" />
	<input type="hidden" name="numeroPlaca" value="${param.numeroPlaca}" />
	<input type="hidden" name="origem" value="${param.origem}" />
	<input type="hidden" name="reiniciarTestes" value="${param.reiniciarTestes}" />
	<input type="hidden" name="numeroCPF" value="${param.numeroCPF }" />
	<input type="hidden" name="tipoEquipamento" value="${param.tipoEquipamento }" />
	<input type="hidden" name="motivo" value="${param.motivo}" />
	<input type="hidden" name="fromMobile" value="${param.fromMobile}" />
</form>

<form id="formAtualizar"
	action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv09Piloto"
	method="post">
	<input type="hidden" name="numeroOS" value="${param.numeroOS }" />
	<input type="hidden" name="numeroPlaca" value="${param.numeroPlaca}" />
	<input type="hidden" name="origem" value="${param.origem}" />
	<input type="hidden" name="reiniciarTestes" value="${param.reiniciarTestes}" />
	<input type="hidden" name="numeroCPF" value="${param.numeroCPF }" />
	<input type="hidden" name="tipoEquipamento" value="${param.tipoEquipamento }" />
	<input type="hidden" name="numeroCPF_testeEquipamento" value="${param.numeroCPF }" />
	<input type="hidden" name="numeroOS_testeEquipamento" value="${param.numeroOS }" />
	<input type="hidden" name="motivo" value="${param.motivo}" />
	<input type="hidden" name="fromMobile" value="${param.fromMobile}" />
</form>

<!--  A action deste form, e inserida conforme o motivo da os e o tipo de equipamento. Verificacao no $(document).ready do javascript -->
<form method="post" id="formConcluirTestes" action="">

	<input type="hidden" name="numeroOS" value="${param.numeroOS }" />
	<input type="hidden" name="numeroPlaca" value="${param.numeroPlaca}" />
	<input type="hidden" name="origem" value="${param.origem}" />
	<input type="hidden" name="reiniciarTestes" value="${param.reiniciarTestes}" />
	<input type="hidden" name="numeroCPF" value="${param.numeroCPF }" />
	<input type="hidden" name="tipoEquipamento" value="${param.tipoEquipamento }" />
	<input type="hidden" name="numeroCPF_testeEquipamento" value="${param.numeroCPF }" />
	<input type="hidden" name="numeroOS_testeEquipamento" value="${param.numeroOS }" />
	<input type="hidden" name="motivo" value="${param.motivo}" />
	<input type="hidden" name="fromMobile" value="${param.fromMobile}" />

	<div class="principal">

		<div class="barraTituloPagina">
			<div class="textoTituloPagina">
				<fmt:message key="label.testesProgramados" />
			</div>
		</div>

		<c:if test="${not empty equipamento}">
			<table cellspacing="0" class="detalhe">
				<tr class="barraazulzinha">
					<th class="barraazulzinha"><fmt:message
							key="label.testeAtivacaoEquipamento" /></th>
				</tr>
			</table>

			<table cellspacing="3" class="detalhe2">
				<tbody>
					<tr>
						<th width="200px" class="barracinza"><fmt:message
								key="label.dataHora" /></th>
						<td width="350px" class="camposinternos"><fmt:formatDate
								value="${equipamento.dataHoraPosicao }"
								pattern="dd/MM/yyyy HH:mm" /></td>
						<th width="200px" class="barracinza"><fmt:message
								key="label.latitude" /></th>
						<td width="350px" class="camposinternos">${equipamento.latitude }</td>
					</tr>
					<tr>
						<th width="200px" class="barracinza"><fmt:message
								key="label.longitude" /></th>
						<td width="350px" class="camposinternos">${equipamento.longitude }</td>
						<th width="200px" class="barracinza"><fmt:message
								key="label.endereco" /></th>
						<td width="350px" class="camposinternos">${equipamento.descricaoEndereco }</td>
					</tr>
					<tr>
						<th width="200px" class="barracinza"><fmt:message
								key="label.satelites" /></th>
						<td width="350px" class="camposinternos">${equipamento.quantidadeSatelites }</td>
						<th width="200px" class="barracinza"><fmt:message
								key="label.hdop" /></th>
						<td width="350px" class="camposinternos">${equipamento.hdop }</td>
					</tr>
					<tr>
						<th width="200px" class="barracinza"><fmt:message
								key="label.velocidade" /></th>
						<td width="350px" class="camposinternos">${equipamento.velocidade }
							km/h</td>
						<th width="200px" class="barracinza"><fmt:message
								key="label.tensao" /></th>
						<td width="350px" class="camposinternos">${equipamento.tensao }</td>
					</tr>
					<tr>
						<th width="200px" class="barracinza"><fmt:message
								key="label.ignicao" /></th>
						<td width="350px" class="camposinternos"><img
							src="${pageContext.request.contextPath}/sascar/images/corporativo/bullet_${equipamento.statusIgnicao }.gif"
							alt="bullet" /></td>
						<th width="200px" class="barracinza"><fmt:message
								key="label.statusGps" /></th>
						<td width="350px" class="camposinternos"><img
							src="${pageContext.request.contextPath}/sascar/images/corporativo/bullet_${equipamento.statusGPS }.gif"
							alt="bullet" /></td>
					</tr>
					<tr>
						<th width="200px" class="barracinza"><fmt:message
								key="label.alimentacaoPrincipal" /></th>
						<td width="350px" class="camposinternos"><img
							src="${pageContext.request.contextPath}/sascar/images/corporativo/bullet_${equipamento.statusAlimentacao }.gif"
							alt="bullet" /></td>
						<th width="200px" class="barracinza"><fmt:message
								key="label.statusPosicaoOnline" /></th>
						<td width="350px" class="camposinternos"><img
							src="${pageContext.request.contextPath}/sascar/images/corporativo/bullet_${equipamento.statusPosicaoOnline }.gif"
							alt="${equipamento.statusPosicaoOnline }"
							title="Online - ${equipamento.statusPosicaoOnline }" /></td>
					</tr>
					<tr>
						<th width="200px" class="barracinza"><fmt:message
								key="label.statusPosicaoMemoria" /></th>
						<td width="350px" class="camposinternos"><img
							src="${pageContext.request.contextPath}/sascar/images/corporativo/bullet_${equipamento.statusPosicaoMemoria }.gif"
							alt="${equipamento.statusPosicaoMemoria }"
							title="Memoria - ${equipamento.statusPosicaoMemoria }" /></td>
						<td></td>
						<td></td>
					</tr>
				</tbody>
			</table>

			<div class="pgstabela">
				<input type="button" onclick="$('#formAtualizar').submit();"
					class="button" value="<fmt:message key="label.atualizar" />" />
			</div>

			<div id="relato-box">
				<div>
					<label class="text3" for="relato"><fmt:message
							key="mensagem.informacao.insiraInformacoesAlimentarHistContrato" /></label>
				</div>
				<div>
					<textarea name="observacao" id="observacao" class="text required"></textarea>
				</div>
				<div class="charsLeft2">
					Resta(m) <span id="charsLeft"></span>&nbsp;caracter(es).
				</div>
				<div class="pgstabela">
					<input type="button"
						onclick="submeterObservacao('#formConcluirTestes');"
						class="button"
						value="<fmt:message key="label.enviarObservacao" />" />
				</div>

			</div>

			<div class="clear"></div>
		</c:if>

		<div id="testes">
			<!-- TESTES SERAO JOGADOS AQUI -->
		</div>

		<div style="text-align: center;">

			<input id="cancelarComandos" type="button" class="button"
				value="<fmt:message key="label.cancelarPendentes" />" />
			<input id="concluirTestes" type="submit" class="button"
				value="<fmt:message key="label.concluirTestes" />" />

			<c:choose>
				<c:when test="${param.tipoEquipamento eq 'S' }">
					<input type="button" class="button4"
						value="<fmt:message key="label.voltar" />"
						onclick="$('#formVoltarTipoEquipamentoCasco').submit();" />
				</c:when>
				<c:when test="${param.tipoEquipamento eq 'C'}">
					<input type="button" class="button4"
						value="<fmt:message key="label.voltar" />"
						onclick="$('#formVoltarTipoEquipamentoCarga').submit();" />
				</c:when>
			</c:choose>

		</div>

	</div>

</form>

<div id="msgAlerta">
	<p>
		<span></span>
	</p>
	<p>
		<input type="button" class="button4 cancelar" value="OK">
	</p>
</div>

<div id="popUpMeiaLuz" class="popUp">
	<p class="popUpMsgValidacao">Favor informar o valor da
		tens&atilde;o da bateria do ve&iacute;culo.</p>
	<p>
		<input name="extra" type="radio" value="12" />12V
		<input name="extra"	type="radio" value="24" />24V
	</p>
		<input type="button" class="button4 cancelar" value="Cancelar">
	<div class="buttonGroup">
		<input type="button" class="button enviarTeste" value="Salvar">
	</div>
</div>

<div id="popUpCambioAutomatico" class="popUp">
	<p class="popUpMsgValidacao">Ve&iacute;culo com cambio
		autom&aacute;tico?</p>
	<p>
		<input name="extra" type="radio" value="1" id="cambioAuto" />Sim
		<input name="extra" type="radio" value="0" id="cambioManual" />N&atilde;o
	</p>
	<div class="buttonGroup">
		<input type="button" class="button4 cancelar" value="Cancelar">
		<input type="button" class="button enviarTeste" value="Salvar">
	</div>
</div>

<div id="popUpDecimal" class="popUp">
	<p class="popUpMsgValidacao"></p>
	<p>
		<input name="extra" type="text" class="nofilter" />
	</p>
	<div class="buttonGroup">
		<input type="button" class="button4 cancelar" value="Cancelar">
		<input type="button" class="button enviarTeste" value="Salvar">
	</div>
</div>

<div id="popUpDuplo" class="popUpDuplo">
	<p class="popUpMsgValidacao"></p>

	<table style="margin: 1px">
		<tr>
			<td><label><fmt:message key="label.umidade" /></label></td>
			<td><input name="extra" type="text" class="nofilter" maxlength="5"></td>
		</tr>
		<tr>
			<td><label><fmt:message key="label.temperatura" /></label></td>
			<td><input name="extra2" type="text" class="nofilter" maxlength="5"></td>
		</tr>
	</table>

	<div class="buttonGroup">
		<input type="button" class="button4 cancelar" value="Cancelar">
		<input type="button" class="button enviarTeste" value="Salvar">
	</div>
</div>

<div id="popUpOutro" class="popUp">
	<p class="popUpMsgValidacao"></p>
	<p>
		<input name="extra" type="text" class="nofilter" />
	</p>
	<div class="buttonGroup">
		<input type="button" class="button4 cancelar" value="Cancelar">
		<input type="button" class="button enviarTeste" value="Salvar">
	</div>
</div>

<div id="popUpConfirm" class="popUp">
	<p class="popUpMsgValidacao"></p>
	<div class="buttonGroup">
		<input type="button" class="button4 cancelar" value="N&atilde;o">
		<input type="button" class="button enviarTeste" value="Sim">
	</div>
</div>

<div id="aboveall"></div>

<div id="dialog_mensagem" class="popup_padrao" style="display: none;">
	<div class="popup_padrao_pergunta"></div>
	<div class="popup_padrao_resposta">
		<input type="button" class="button" value="Ok"
			onclick="javascript:$.closeOverlay();" />
	</div>
</div>

<div id="dialog_mensagem_teste_dependencia" class="popup_padrao"
	style="display: none;">
	<div class="popup_padrao_pergunta">
		<div id="testeDependencia"></div>
	</div>
	<div class="popup_padrao_resposta">
		<input type="button" class="button" value="Ok"
			onclick="javascript:$.closeOverlay();" />
	</div>
</div>
