var splitGridBinding = new Shiny.InputBinding();
$.extend(splitGridBinding, {
  find: function(scope) {
    return $(scope).find(".split-grid");
  },
  getId: function(el) {
    return el.id;
  },

  getValue: function(el) {
    var splitId = el.id;
    return;

  },
  setValue: function(el, value) {
    var splitId = el.id;

  //  window[splitId].setSizes(value);
  },
  subscribe: function(el, callback) {
    var splitId = el.id;

  },
  unsubscribe: function(el) {
    var splitId = el.id;

    $(el).off(".splitGridBinding");
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
    var config = $(`script[data-for='${el.id}']`);
    console.log(`script[data-for='${el.id}']`);
    config = JSON.parse(config.html());
  /*  config.options.onDrag=eval("(" + config.options.onDrag + ")");
    config.options.onDragStart=eval("(" +config.options.onDragStart + ")");
    config.options.onDragEnd=eval("(" +config.options.onDragEnd + ")");
*/

  var rowGutters=[];
  var columnGutters=[];
   $(el).find('.vertical_gutter').each(function(){
     let el=this;
     let track=+$(el).data('track');
      let tmp={
        track:track-1,
        element: el
      }
      columnGutters.push(tmp)
   });

   $(el).find('.horizontal_gutter').each(function(){
     let el=this;
     let track=+$(el).data('track');
      let tmp={
        track:track-1,
        element: el
      }
      rowGutters.push(tmp)
   });
console.log(columnGutters);
   SplitGrid({
     columnGutters:columnGutters,
     rowGutters:rowGutters
   },
   config.options);
   console.log(config.options)
  }
});

Shiny.inputBindings.register(splitGridBinding, "shiny.split-grid");
