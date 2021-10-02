var filterShelfBinding = new Shiny.InputBinding();

$.extend(filterShelfBinding, {
  find: function(scope) {
    return $(scope).find(".filter-shelf");
  },
  initialize: function(el) {
    console.log(el.id)
  },
  getId: function(el) {
    return el.id;
  },
  getValue: function(el) {
    var out={};
    $(el).find('.data-filter').each(function(){
      var id=$(this).attr('id');
      out[id]=$(this).data('filter');
    })

    return JSON.stringify(out);
  },
  setValue: function(el, value) {

  },
  receiveMessage: function(el, data) {

  },
  getState: function (el) {

  },

  subscribe: function(el, callback) {
    $(el).on("filter",'.data-filter',function(){
      callback();
    })

    $(document).ready(function(){
      callback();
      });
  },
  unsubscribe: function(el) {
    $(el).off("filter",'.data-filter');
    $(el).off('.filterShelfBinding');
  }
});

Shiny.inputBindings.register(filterShelfBinding, "shiny.filter-shelf ");
