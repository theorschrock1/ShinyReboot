var aoSheetBinding = new Shiny.InputBinding();

$.extend(aoSheetBinding, {
  find: function(scope) {
    return $(scope).find(".ao-sheet");
  },
  initialize: function(el) {
    //console.log("init");
  },
  getId: function(el) {
    return el.id;
  },
  getValue: function(el) {

   return ;
  },
  setValue: function(el, value) {

  },
  receiveMessage: function(el, data) {


  },
    getState: function (el) {
    // Store options in an array of objects, each with with value and label
    },

  subscribe: function(el, callback) {

  $(el).on('click','.pill-item .modify-hierachy.expand',function(){
      //console.log("check");
    $this=$($(this).parents(".pill-item").get(0));

    let n =+$this.data('hierachy_n')+1;
     var newid=$this.data('id')+Date.now()+n;
    let ops =$this.data('conversion_opts');
     clone= $this.clone(true);
    $this.removeClass('collapsed');
    clone.data('hierachy_n',n);
    let lab=clone.find(".pill-label").get(0);
    clone.data("conversion",ops[n]);
    var newlab=ops[n]+"("+$this.data('name')+')';
    $(lab).text(newlab);
    if(n===(ops.length-1)){
        clone.removeClass("hierachy")

    }
    clone.find(".pill-data-icon .mdi").attr("class","mdi mdi-grain");
    clone.attr('id',newid);
    clone.attr('data-mark','detail');
    clone.insertAfter( $this);
});
  $(el).on('click','.pill-item .modify-hierachy.collapse',function(){
    $this=$($(this).parents(".pill-item").get(0));
    var n =+$this.data('hierachy_n');
    var var_id =$this.data('id')
    $this.siblings(`[data-id='${var_id}']`).each(function(){
        let this_n=+$(this).data('hierachy_n');
        if(this_n>n){
            $(this).remove();
        }
    });
    $this.addClass('collapsed');
});
  $(el).on("rename",'.pill-item',function(){
   $pill=$(this)
   //console.log($pill);
   let agg= $pill.data("option_aggregation");
   //console.log("agg:"+agg)
   let conversion= $pill.data("conversion");
   let $lab= $($pill.find(".pill-label").get(0));

   var current=$pill.data("name");
    if(conversion!="NA"){
       current=conversion+"("+current+")";
    }
    if(agg!=="NA"){
     current=agg+"("+current+")";
    }
    $lab.text(current);

});


  },
  unsubscribe: function(el) {

    $(el).off('.aoSheetBinding');
    $(el).off('click','.pill-item .modify-hierachy.expand');
    $(el).off('click','.pill-item .modify-hierachy.collapse');
  }
});

Shiny.inputBindings.register(aoSheetBinding, "shiny.ao-sheet");
