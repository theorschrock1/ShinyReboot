
$(document).ready(function() {

$('.dropdown-menu div.submenu').on('click', function(e) {
  if (!$(this).next().hasClass('show')) {
    $(this).parents('.dropdown-menu').first().find('.show').removeClass('show');
  }
  var $subMenu = $(this).next('.dropdown-menu');
  $subMenu.toggleClass('show');


  $(this).parents('.dropdown.show').on('hidden.bs.dropdown', function(e) {
    $('.dropdown-menu.submenu.show').removeClass('show');
  });


  return false;
});
});
