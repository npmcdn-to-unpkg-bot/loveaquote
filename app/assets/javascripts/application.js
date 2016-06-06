//= require jquery
//= require jquery_ujs
//= require bootstrap-sass/assets/javascripts/bootstrap-sprockets
//= require cocoon
//= require toastr
//= require masonry/dist/masonry.pkgd.js
//= require imagesloaded/imagesloaded.pkgd.js
//= require bootstrap-multiselect
//= require js-cookie/src/js.cookie.js
//= require jquery-validation/dist/jquery.validate.js
//= require protonet/jquery.inview/jquery.inview.js
//= require jquery-placeholder/jquery.placeholder.js

$(function() {
  
  var $grid = $('.grid').imagesLoaded( function() {
    $grid.masonry({
      itemSelector: '.grid-item',
      columnWidth: '.grid-item'
    });
  });
  
  $("input").placeholder();
  
  if (Cookies.get("page_view_count")) {
    Cookies.set("page_view_count", parseInt(Cookies.get("page_view_count")) + 1);
  } else {
    Cookies.set("page_view_count", 1);
  }

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
