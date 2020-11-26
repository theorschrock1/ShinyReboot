var sortableBinding = new Shiny.InputBinding();
$.extend(sortableBinding, {
  find: function(scope) {
    return $(scope).find(".sortable-div");
  },
  getId: function(el) {
    return el.id;
  },
  getValue: function(el) {

  function removeScript(x) {
  return x != 'sortable-options';
  }
 //dataids = $(el).children('div').
   //         map(function(){
     //         return $(this).data('id');
       //    }).get();
   // dataids = $(el).children('div').map(function(){
  //    this.data('id');
  //  });
  var sort=Sortable.get(el);
  var dataids=sort.toArray().filter(removeScript);


  return dataids;

  },
  setValue: function(el, value) {

  Sortable.get(el).sort(value);
  },
  subscribe: function(el, callback) {
     var sort=Sortable.get(el)

    $(el).on("end.sortableBinding", function(e) {
      callback();
    });

    sort.option('onSort',function(evt){
       callback();
     });
     /* $(el).on("add.sortableBinding", function(e) {
     // callback();
    });
     $(el).on("update.sortableBinding", function(e) {
      callback();
    });
     $(el).on("change.sortableBinding", function(e) {
      callback();
    });

     $(el).on("end.sortableBinding", function(e) {
      callback();
    });*/
  },
  unsubscribe: function(el) {

    sortables[el.id].destroy();
    $(el).off(".sortableBinding");
  },
  receiveMessage: function(el, data) {
  function isDict(v) {
    return typeof v==='object' && v!==null && !(v instanceof Array) && !(v instanceof Date);
   }
 var sort=Sortable.get(el);
   if (data.hasOwnProperty('value')) {

     sort.sort(data.value);
     this.setValue(el,this.getValue(el));
    $(el).trigger('end');
     }

  if (data.hasOwnProperty('options')) {
    var config=data.options;
     if(config.hasOwnProperty('group')){
    console.log(isDict(config.group.put));
    if(isDict(config.group.put)){
     var classNames=config.group.put.class_types

     config.group.put =function(to,from,item) {

     if (classNames.some(className =>item.classList.contains(className))) {
       return true
     }
     return false

     }
    }
      }
       console.log(config.disabled);
      keys=Object.keys(config);
      keys.map(function(d){
      sort.option(d,config[d]);
      });

   }
  if (data.hasOwnProperty('append')){
     console.log(data.append);
     var $newNode=$(data.append);
     console.log($newNode);
     $(el).append($newNode);
     vals=this.getValue(el);


     this.setValue(el,vals);
     $(el).trigger('end');
  }
  if (data.hasOwnProperty('content')){
     console.log(data.content);
     $(el).html(data.content);
     this.setValue(el,this.getValue(el));
     $(el).trigger('end');
  }
  },

  initialize: function(el) {
   function isDict(v) {
    return typeof v==='object' && v!==null && !(v instanceof Array) && !(v instanceof Date);
   }
   if(typeof sortables == "undefined"){
     sortables={};
   }

    var config = $(el)
      .find('script[data-for="' + Shiny.$escape(el.id) + '"]');
    config = JSON.parse(config.html());

    if(isDict(config.group.put)){
     var classNames=config.group.put.class_types

     config.group.put =function(to,from,item) {

     if (classNames.some(className =>item.classList.contains(className))) {
       return true
     }
     return false

     }
    }

    var callbacks=["onChoose",
                  "onUnchoose",
                  "onStart",
                  "onEnd",
                  "onMove",
                  "onAdd",
                  'onSort',
                  "onRemove",
                  "onClone",
                  "onChange",
                  "onFilter",
                  "onUpdate",
                  "onSelect",
                  "onDeselect"];

     callbacks.map(function(d){
      if (config.hasOwnProperty(d)){
     config[d]=eval("(" + config[d] + ")");
      }
     });


    sortables[el.id] = new Sortable(el,config);
  }
});

Shiny.inputBindings.register(sortableBinding, "shiny.sortable-div");
