

var variableDropzoneBinding = new Shiny.InputBinding();
$.extend(variableDropzoneBinding, {
  find: function(scope) {

    return $(scope).find(".variable-dropzone");
  },
  getId: function(el) {
    return el.id;
  },


  getValue: function(el) {
  variable=$(el).data('variable');
  if(variable===undefined){
    return null;
  }
  return  variable
  },
  setValue: function(el, value) {
    $(el).data('variable',value)
  },

  subscribe: function(el, callback) {

   $(el).on("dragover",function(e){

    $(this).addClass("dragover")

     }).on("dragleave",function(e){

    $(this).removeClass("dragover")
     }).on("drop",function(e){

    $(this).removeClass("dragover")

     });
      $(el).on("click",function(){
        console.log('click');
        callback();
      });
      $(el).on("variableChange",function(){
        console.log('variableChange');
        callback();
      });
  },
  unsubscribe: function(el) {

    $(el).off(".variableDropzoneBinding");

  },
  receiveMessage: function(el, data) {
    //console.log(data);

  },
  initialize: function(el) {
   console.log("hello var dropzone");

  }
});

Shiny.inputBindings.register(variableDropzoneBinding, "shiny.variableDropzone");

