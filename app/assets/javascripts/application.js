//= require jquery
//= require jquery_ujs
//= require jquery.slick
//= require jquery_lazyload/jquery.lazyload.js

$(function() {
  $(".quote-slider").slick({
    dots: true,
    arrows: false
  });
  
  $("img.lazy").lazyload();
  
  $(".share-quote-twitter").on("click", function(){
    window.open($(this).attr("data-url"), "_blank");
    ga('send', 'event', 'Quote', 'Shared', 'Twitter');
  });

  $(".share-quote-faceook").on("click", function(){
    window.open($(this).attr("data-url"), "_blank");
    ga('send', 'event', 'Quote', 'Shared', 'Facebook');
  });

  $(".share-quote-pinterest").on("click", function(){
    window.open($(this).attr("data-url"), "_blank");
    ga('send', 'event', 'Quote', 'Shared', 'Pinterest');
  })
});
