$(document).ready(function() {
  console.log("sfs");
Shiny.addCustomMessageHandler('shinyReboot-sethtmldata', function(message) {
   console.log("shinyReboot-sethtmldata");
  var selector=message.selector
  var data=message.data
  var has_trigger=message.hasOwnProperty('trigger');
  var event=message.trigger;
  $(selector).each(function(){
    $(this).data(data)
    if(has_trigger){
      $(this).trigger(event);
    }
    });

});

})
