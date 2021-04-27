var Messages = {
	ID		: 'mensagem',
	ERROR 	: 'error',
	INFO 	: 'info',
	SUCCESS : 'success',
	ALERT 	: 'alert',
	TIMER	: 0,
	DELAY	: 5000,
	element : null,
	'createElement' : function(){
		if (Messages.element === null && !document.getElementById(Messages.ID)) {
			this.element = document.createElement('div');
			this.element.setAttribute('id',Messages.ID);
            document.body.insertBefore(this.element, document.body.firstChild);
		}
	},
	'getElement' : function(){
		this.createElement();
		return document.getElementById(Messages.ID);
	},
	'setText' : function(text){
		Messages.getElement().innerHTML = text;
		return this;
	},
	'show' : function() {
		Messages.getElement().style.display = 'block';
		return this;
	},
	'hide' : function() {
		Messages.getElement().style.display = 'none';
		return this;
	},
	'addClass' : function(c){
		Messages.getElement().setAttribute('class', c);
		return this;
	},
	'error' : function(text) {
		Messages.setMessage(Messages.ERROR, text);
		return this;
	},
	'info' : function(text) {
		Messages.setMessage(Messages.INFO, text);
		return this;
	},
	'success' : function(text) {
		Messages.setMessage(Messages.SUCCESS, text);
		return this;
	},
	'alert' : function(text) {
		Messages.setMessage(Messages.ALERT, text);
		return this;
	},
	'setMessage' : function(c, text) {
		Messages.addClass(c)
				.show()
				.setText(text);
		return this;
	},
	'timer' : function(callback, time){
		var callback = (typeof(callback) == 'function') ? callback : function(){};
		Messages.clearTimer();
		Messages.TIMER = window.setTimeout(callback, time);
		return this;
	},
	'clearTimer' : function(){
		if (Messages.TIMER != null || Messages.TIMER != 0)
			window.clearTimeout(Messages.TIMER);

		return this;
	}
};