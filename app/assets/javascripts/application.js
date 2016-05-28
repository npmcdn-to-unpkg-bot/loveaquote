//= require jquery
//= require jquery_ujs
//= require jquery.slick
//= require jquery_lazyload/jquery.lazyload.js
//= require sticky-kit/jquery.sticky-kit.js

$(function() {
  
  $(".quote-slider").slick({
    dots: true,
    arrows: false
  });
  
  $(".top-social-bar").stick_in_parent({
    parent: $("article")
  });
  
  $("img.lazy").lazyload();
  
  $(".social-share-image").on("click", function(){
    window.open($(this).attr("data-url"), "_blank");
  });
  
  $(".share-quote-twitter").on("click", function(){
    window.open($(this).attr("data-url"), "_blank");
    ga('send', 'event', 'Social', 'QuoteShare', 'Twitter');
  });

  $(".share-quote-faceook").on("click", function(){
    window.open($(this).attr("data-url"), "_blank");
    ga('send', 'event', 'Social', 'QuoteShare', 'Facebook');
  });

  $(".share-quote-pinterest").on("click", function(){
    window.open($(this).attr("data-url"), "_blank");
    ga('send', 'event', 'Social', 'QuoteShare', 'Pinterest');
  })
});
