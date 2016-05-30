//= require jquery
//= require jquery_ujs
//= require bootstrap-sass/assets/javascripts/bootstrap-sprockets
//= require TweenMax
//= require resizeable
//= require neon-api
//= require neon-custom 
//= require joinable
//= require cocoon
//= require toastr
//= require jquery.slick
//= require jquery_lazyload/jquery.lazyload.js
//= require sticky-kit/jquery.sticky-kit.js
//= require masonry/dist/masonry.pkgd.js

$(function() {
  
  $('.grid').masonry({
    itemSelector: '.grid-item',
    columnWidth: '.grid-item',
  });  
  
  $(".quote-slider").slick({
    dots: true,
    arrows: false
  });
  
  $(".top-social-bar").stick_in_parent({
    parent: $(".main-content")
  });

  $(".social-share-icon i").on("click", function(){
    window.open($(this).attr("data-url"), "_blank");
  });
  
  $(".share-quote-twitter").on("click", function(){
    window.open($(this).attr("data-url"), "_blank");
    ga('send', 'event', 'Social', 'QuoteShare', 'Twitter');
  });

  $(".share-quote-facebook").on("click", function(){
    window.open($(this).attr("data-url"), "_blank");
    ga('send', 'event', 'Social', 'QuoteShare', 'Facebook');
  });

  $(".share-quote-pinterest").on("click", function(){
    window.open($(this).attr("data-url"), "_blank");
    ga('send', 'event', 'Social', 'QuoteShare', 'Pinterest');
  })
});
