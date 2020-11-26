$( document ).ready(function() {
$('.ao-action-button').on('click',function(){
 console.log(".ao-action-button");
  let shinyid=$(this).attr('id');

  Shiny.setInputValue(shinyid,true,{priority:'event'});
});

$('.ao-radio-button-grp div').on('click',function(){
  let shinyid=$(this).parent().attr('id');
   console.log(".ao-radio-button-grp");
  let active = $(this).find('input').get(0);
    console.log(active);
  let val =$(active).attr('id');
   console.log(val);
  if(val === undefined){
  Shiny.setInputValue(shinyid,null);
  }else{
  Shiny.setInputValue(shinyid,val);
  }
});
$('.ao-check-button').on('click',function(){
  let shinyid=$(this).attr('id');
console.log(".ao-check-button");
  let checked = $(this).hasClass("active");
    Shiny.setInputValue(shinyid,checked);

});
});
