//= require jquery
//= require jquery_ujs
//= require slick-carousel/slick/slick.js
//= require jquery_lazyload/jquery.lazyload.js

$(function() {
  $(".quote-images").slick({
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
