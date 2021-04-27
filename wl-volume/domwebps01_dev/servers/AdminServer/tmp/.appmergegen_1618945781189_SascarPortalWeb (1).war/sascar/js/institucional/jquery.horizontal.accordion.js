$(function(){
	
	lastBlock = $("#a1");
	maxWidth = 476;
	minWidth = 30;	
	
	$(".caixa_slideshow ul li").click(
	  function(){
		$(lastBlock).animate({width: minWidth+"px"}, { queue:false, duration:400 });
		$(this).animate({width: maxWidth+"px"}, { queue:false, duration:400});
		lastBlock = this;
	  }
	);

});