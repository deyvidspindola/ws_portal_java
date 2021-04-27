(function($) {
	function initTranformCheck(idList, isRadio) {
			
		$("#"+idList+" > li > a").live('click', function (event) {
			event.preventDefault();

			var id = this.id;
			var idLink = isRadio ? 'link_radio' : 'link_checkbox';
			var idElem = isRadio ? 'radio' : 'checkbox';
			var newselect = id.replace(idLink, idElem);
			var check = $('#'+newselect);

			if(!check.attr('disabled')) {

				if (isRadio) {
					$('#'+idList+' .active').removeClass("active");
				}

				check.attr( 'checked', !check.attr('checked') );
			

				// Executando os eventos do elemento (click, mouseover, etc...)
				if (check.data('events')) {
					$.each(check.data('events'), function(eventName, event) {
		   	 			$(check).trigger(eventName);
					});
				}
	
				$(this).parent().toggleClass( "active", check.attr('checked'));

			}
			
			return false;
		});
	}
	
	/***************************
	  Check Boxes 
	 ***************************/	
	$.fn.jqTransRadioCheck = function(){
	
		var time = new Date().getTime();
		
		var optionName = 'options_'+time;
		var listName = 'list_'+time;
		var dvOption = $('<div id="'+optionName+'" class="options"></div>');
		var ulOption = $('<ul id="'+listName+'"></ul>');
		$(dvOption).append(ulOption);
		
		var parent = $(this).parent();
		$(parent).append(dvOption);
		//var widthSpan = 0;
		
		this.each(function(count, b) {
			var $input = $(this);
			var inputSelf = this;

			/*if ($input.next().width() > widthSpan) { 
				widthSpan = $input.next().width();
			}*/

			var clazz = $input.attr('checked')?"active":"";
			var inputId = 'link_'+$input.attr('type') + count;
			var texto = $input.next().text();

			$(ulOption).append('<li class="'+clazz+'"><a href="#" class="option" id="'+inputId+'" ><span>'+texto+'</span></a></li>');

			$input.css('display', 'none');	
			$input.next().css('display', 'none');	
		});
		
		//$('a.option').css('width', widthSpan);

		$(parent).append(dvOption);
		initTranformCheck(listName, $(this).get(0).type =='radio');
		
	};


})(jQuery);