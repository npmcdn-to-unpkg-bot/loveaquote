//= require jquery
//= require jquery_ujs
//= require slick-carousel/slick/slick.js

$(function() {
  $(".quote-images").slick({
    dots: true,
    arrows: false
  });
  
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
