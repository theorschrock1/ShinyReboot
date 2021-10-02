var defaultColorPickerBinding = new Shiny.InputBinding();

$.extend(defaultColorPickerBinding, {
  find: function(scope) {
    return $(scope).find(".default-color-picker");
  },
  initialize:function(el){

    var value=$(el).data("value");
    $(el).prop("value",value);
  },
  getId: function(el) {
    return el.id;
  },
  getValue: function(el) {
   return $(el).prop("value");
  },
  setValue: function(el, value) {
   $(el).prop("value",value);

  },
  receiveMessage: function(el, data) {

    this.setValue(el,data);
    $(el).trigger('change');
  },

  subscribe: function(el, callback) {

    $(el).on('change',function(){
     $(el).trigger("inputChange");
    });
    $(el).on("inputChange",function(){
      callback();
    });
    },
  unsubscribe: function(el) {
    $(el).off('.defaultColorPickerBinding');
  }
});

Shiny.inputBindings.register(defaultColorPickerBinding, "shiny.default-color-picker");
