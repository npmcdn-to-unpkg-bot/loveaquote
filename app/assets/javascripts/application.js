//= require jquery
//= require jquery_ujs
//= require bootstrap-sass/assets/javascripts/bootstrap-sprockets
//= require cocoon
//= require toastr
//= require jquery.slick
//= require masonry/dist/masonry.pkgd.js
//= require imagesloaded/imagesloaded.pkgd.js
//= require bootstrap-multiselect
//= require js-cookie/src/js.cookie.js
//= require jquery-validation/dist/jquery.validate.js
//= require protonet/jquery.inview/jquery.inview.js

$(function() {
  
  var $grid = $('.grid').imagesLoaded( function() {
    $grid.masonry({
      itemSelector: '.grid-item',
      columnWidth: '.grid-item'
    });
  });  

  $(".quote-slider").slick({
    dots: true,
    arrows: false
  });

  $("body").on("click", ".social-sharing i", function(){
    window.open($(this).attr("data-url"), "_blank");
  });
  
  // $(".share-quote-twitter").on("click", function(){
  //   window.open($(this).attr("data-url"), "_blank");
  //   ga('send', 'event', 'Social', 'QuoteShare', 'Twitter');
  // });

  // $(".share-quote-facebook").on("click", function(){
  //   window.open($(this).attr("data-url"), "_blank");
  //   ga('send', 'event', 'Social', 'QuoteShare', 'Facebook');
  // });

  // $(".share-quote-pinterest").on("click", function(){
  //   window.open($(this).attr("data-url"), "_blank");
  //   ga('send', 'event', 'Social', 'QuoteShare', 'Pinterest');
  // })
});
