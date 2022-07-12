var splitBinding = new Shiny.InputBinding();
$.extend(splitBinding, {
  find: function(scope) {
    return $(scope).find(".split-div");
  },
  getId: function(el) {
    return el.id;
  },

  getValue: function(el) {
    var splitId = el.id;
    return window[splitId].getSizes().map(function(x) { return x / 100; });

  },
  setValue: function(el, value) {
    var splitId = el.id;

    window[splitId].setSizes(value);
  },
  subscribe: function(el, callback) {
    var splitId = el.id;
    $(el).on("click", function(e) {
      callback();
    });
  },
  unsubscribe: function(el) {
    var splitId = el.id;
    window[splitId].destroy();
    $(el).off(".splitBinding");
  },
  receiveMessage: function(el, data) {
    var splitId = el.id;
    if (data.hasOwnProperty('sizes')) {
     window[splitId].setSizes(data.sizes);
     }
    if (data.hasOwnProperty('collapse')){
      console.log("collapse:"+ data.collapse);
    if( typeof data.collapse==='number'){
    window[splitId].collapse(data.collapse);
    }else{
       data.collapse.map(function(d){
           window[splitId].collapse(d);
       });
    }

    }
    if (data.hasOwnProperty('split_ids')){
    window[splitId]=Split(data.split_ids,data.options);
    }
    this.setValue(el,this.getValue(el).map(function(x) { return x * 100; }));
    $(el).trigger('click');

  },

  initialize: function(el) {
    var splitId = el.id;
    var $el = $(el);
    var config = $el
      .find('script[data-for="' + Shiny.$escape(el.id) + '"]');
    config = JSON.parse(config.html());
    config.options.onDrag=eval("(" + config.options.onDrag + ")");
    config.options.onDragStart=eval("(" +config.options.onDragStart + ")");
    config.options.onDragEnd=eval("(" +config.options.onDragEnd + ")");
    config.options.gutter=eval("(" +config.options.gutter + ")");
    config.options.elementStyle=eval("(" +config.options.elementStyle + ")");
    config.options.gutterStyle=eval("(" +config.options.gutterStyle + ")");
   window[splitId]=Split(config.split_ids,config.options);
  }
});

Shiny.inputBindings.register(splitBinding, "shiny.split-div");

