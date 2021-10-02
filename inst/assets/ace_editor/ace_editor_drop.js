Shiny.addCustomMessageHandler('invoke_ace_drop',function(params){
  console.log('asfafa');
$('.ace_editor').on('drop',function(){
    let el_id= this.id;

    let inputid=el_id+'_drop_event';
   console.log('drop');
    Shiny.setInputValue(inputid,'dropevent',{priority:'event'});
});
});
