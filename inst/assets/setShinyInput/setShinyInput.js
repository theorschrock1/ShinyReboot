$(document).on('shiny:connected',function() {
  Shiny.addCustomMessageHandler('setInputValue', function(message) {
    console.log(message);
   Shiny.setInputValue(message[0],message[1]);
  });
});
