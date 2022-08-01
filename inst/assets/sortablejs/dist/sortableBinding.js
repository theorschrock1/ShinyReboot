var sortableBinding = new Shiny.InputBinding();
$.extend(sortableBinding, {
  find: function(scope) {

    return $(scope).find(".sortable-div");
  },
  getId: function(el) {
    return el.id;
  },
  getRatePolicy: function(){
  return {
      policy: "debounce",
      delay: 0
    };
  },

  getValue: function(el) {

  var sort=Sortable.get(el);
  if(sort.options.hasOwnProperty("customGetValueFn")){
      return sort.options.customGetValueFn(el);
  }
  var dataids=sort.toArray();


  return dataids;

  },
  setValue: function(el, value) {

  Sortable.get(el).sort(value);
  },

  selected_class:null,
  select:false,
  setData:function(dataTransfer,dragEl){
    console.log($(dragEl).find(".pill-label").text());
    let text= $(dragEl).find(".pill-label").text();
    let trim_text=text.trim();
    if(isValidName(trim_text)){
      dataTransfer.setData("Text",trim_text);
    }else{
      dataTransfer.setData("Text","`"+trim_text+"`");
    }
    dataTransfer.setData("Html", dragEl.outerHTML);
    let parid=$(dragEl).parent().get(0).id;
    dataTransfer.setData("DataId","#"+parid+" .pill-item[data-id='"+$(dragEl).data('id')+"']");
  },

  subscribe: function(el, callback) {
     var elid=el.id
     var sort=Sortable.get(el);
     let cb= function(mutations){
      console.log(mutations);
      let dataChange= mutations.some(function(d){
      var target_id=$(d.target).attr('id');
      let cond_one=target_id!==elid;
      var cond_two=false;
      if(d.removedNodes.length>0&&target_id===elid){
      console.log(d.removedNodes);
       $(d.removedNodes).each(function(){

          cond_two=$(this).hasClass("pill-item")&&!$(this).hasClass('sortable-chosen');

      });
      }
      console.log( cond_two);
      return cond_one || cond_two;
       });
     if(dataChange){
         console.log("mutation cb");
              callback();
      }
      //var ghost=$(el).find('.pill-item.sortable-chosen.sortable-ghost').get(0);

     //if(ghost===undefined){
       //callback()
       //}

     }
    var observer = new MutationObserver(cb);
    const config = { attributes: true,
                     subtree: true,
                     childList:true,
                     attributeFilter: ['data-callback'] };
    observer.observe(el,config );


    $(el).on("updateInput.sortableBinding", function(e) {
      callback();
    });

    sort.option('onSort',function(evt){
       callback();
     });


    if(this.select){
      var selected_class=this.selected_class;
      var selectFun=function(evt){
        console.log('selected');
       var selected =[];

       el=$(evt.item).parents(".sortable-div").get(0);
       elid=$(el).attr('id');

       $(el).find(selected_class).each(function(){
         $(this).data('parent',elid);
         selected.push($(this).data('id'));
       });
      $(el).children(':not('+selected_class+')').each(function(){
        $(this).removeData("parent");
      });

       Shiny.setInputValue(elid+'_selected',selected);

     }
     sort.option('onSelect',selectFun);
     sort.option('onDeselect',selectFun);
    }
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
    //observer.disconnect();
    Sortable.get(el).destroy();
    $(el).off(".sortableBinding");

  },
  receiveMessage: function(el, data) {
    //console.log(data);
    //console.log(el.id);
  function isDict(v) {
    return typeof v==='object' && v!==null && !(v instanceof Array) && !(v instanceof Date);
   }

 var sort=Sortable.get(el);
   if (data.hasOwnProperty('order')) {
    console.log(data.order);
    sort.sort(data.order);
    $(el).trigger('updateInput');


   }

  if (data.hasOwnProperty('options')) {
    var config=data.options;
     if(config.hasOwnProperty('group')){
   // console.log(isDict(config.group.put));
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
    //   console.log(config.disabled);
      keys=Object.keys(config);
      keys.map(function(d){
      sort.option(d,config[d]);
      });

   }
  if (data.hasOwnProperty('append')){
    // console.log(data.append);
     var $newNode=$(data.append);
   //  console.log($newNode);
     $(el).append($newNode);
     vals=this.getValue(el);


     this.setValue(el,vals);
     $(el).trigger('updateInput');
  }
  if (data.hasOwnProperty('content')){
     //console.log(data.content);
     $(el).html(data.content);
     //this.setValue(el,this.getValue(el));
     $(el).trigger('updateInput');
  }
  },

  initialize: function(el) {

   var is_func = new RegExp("^function");

   function isDict(v) {
    return typeof v==='object' && v!==null && !(v instanceof Array) && !(v instanceof Date);
   }
   if(typeof sortables == "undefined"){
     sortables={};
   }

    var configEl = $(el)
      .find('script[data-for="' + Shiny.$escape(el.id) + '"]');
    config = JSON.parse(configEl.html());

    if(isDict(config.group.put)){
     var classNames=config.group.put.class_types

     config.group.put =function(to,from,item) {

     if (classNames.some(className =>item.classList.contains(className))) {
       return true
     }
     return false

     }
    }

    var callbacks=["setData",
                   "onChoose",
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
                  "onDeselect",
                  "onSpill",
                  "customGetValueFn"];

     callbacks.map(function(d){
      if (config.hasOwnProperty(d)){
     config[d]=eval("(" + config[d] + ")");
      }
     });

    if(config.hasOwnProperty('selectedClass')){
      this.select=true;
      this.selected_class="."+config.selectedClass;
    }

    if(config.group.hasOwnProperty('pull')&&is_func.test(config.group.pull)){
         config.group.pull=eval("(" + config.group.pull + ")");
       }
     $(configEl).remove();
     var sortable =new Sortable(el,config);
     sortable.option('setData',this.setData);
     if(config.hasOwnProperty('multiDrag')&& config.hasOwnProperty("deselectOnBody")){
     if(config.multiDrag && config.deselectOnBody==false){
     let deselectMultiDrag = sortable.multiDrag._deselectMultiDrag;
     document.removeEventListener('pointerup', deselectMultiDrag, false);
     document.removeEventListener('mouseup',   deselectMultiDrag, false);
     document.removeEventListener('touchend',  deselectMultiDrag, false);
     }}

  }
});

Shiny.inputBindings.register(sortableBinding, "shiny.sortable-div");

function isValidName(str){
    var regex1 = RegExp('^[0-9A-Za-z_]+$');
    var regex2= RegExp('^[A-Za-z]');
    return regex2.test(str) && regex1.test(str)
  }
