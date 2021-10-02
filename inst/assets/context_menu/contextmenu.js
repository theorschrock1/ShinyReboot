$(document).ready(function() {
$('.pill-item').on('contextmenu', function(e) {
  var top = e.pageY;
  var left = e.pageX;
  $(".context-menu").css({
    top: top,
    left: left
  });
 $(".context-label").dropdown("show");

  return false;
}).on("click", function() {
  $(".context-menu").removeClass("show").hide();
});
});
