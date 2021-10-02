var icon_togglerBinding = new Shiny.InputBinding();

$.extend(icon_togglerBinding, {
  find: function(scope) {
    return $(scope).find(".icon-toggler");
  },
  initialize: function(el) {
  /*  var config = $(el);
    config.find('script[data-for="' + Shiny.$escape(inputId) + '"]');
    config = JSON.parse(config.html());*/
console.log(el);
  },
  getId: function(el) {
    return el.id;
  },
  getValue: function(el) {
     console.log($(el));
     return $(el).data('value');
  },
  setValue: function(el, value) {
     $(el).data('value',value);

  },
  receiveMessage: function(el, data) {

  if (data.hasOwnProperty('value')) {
    if(data.value!=this.getValue(el)){

      $(el).trigger('click');
      }
     }

  },

  subscribe: function(el, callback) {



    $(el).click(function(){
        elem=$(elid="#"+el.id+' .icon-toggle');
      /*  let value = $(el).data('value');
        console.log(value);
        let icon_true = $(el).data('icon-true');
        let icon_false =$(el).data('icon-false');
        if(value){
          $(el).data('value',false);
          elem.addClass(icon_false);
          elem.removeClass(icon_true);
        }else{
          $(el).data('value',true);
          elem.addClass(icon_true);
          elem.removeClass(icon_false);
        }

          callback();*/
    });
  },
  unsubscribe: function(el) {

    $(el).off('.icon-togglerBinding');
  }
});

Shiny.inputBindings.register(icon_togglerBinding, "shiny.icon-toggler");
