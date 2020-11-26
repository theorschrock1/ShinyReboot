$(function() {

$('.select-pager').click(function(){
  var shiny_id=$(this).data('name');
  var picker_id="#"+shiny_id;
  var increase_page=$(this).hasClass('page-up');

  var options=[];
  var selected=$(picker_id).selectpicker('val');
  $(picker_id+" option").each(function () {
    options.push($(this).html());
  });
  if(increase_page){

    nexti=options.indexOf(selected)+1;
    nextval=Math.min( nexti,options.length);
  }else{
    nexti=options.indexOf(selected)-1;
    nextval=Math.max( nexti,0);
  }
  $(picker_id).selectpicker('val',options[nextval]);
  Shiny.setInputValue(shiny_id,options[nextval]);
});


});
