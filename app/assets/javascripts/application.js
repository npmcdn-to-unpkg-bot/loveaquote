//= require jquery
//= require jquery_ujs
//= require foundation

$(function(){
  $(document).foundation();
  console.log("Working");
});

$(function() {
  $(".share-quote-twitter").on("click", function(){
    ga('send', 'event', 'Quote', 'Shared', 'Twitter');
  });

  $(".share-quote-faceook").on("click", function(){
    ga('send', 'event', 'Quote', 'Shared', 'Facebook');
  });

  $(".share-quote-pinterest").on("click", function(){
    ga('send', 'event', 'Quote', 'Shared', 'Pinterest');
  })
});
