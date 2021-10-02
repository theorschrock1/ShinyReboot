var discretePalPickerBinding = new Shiny.InputBinding();

$.extend(discretePalPickerBinding, {
  find: function(scope) {
    return $(scope).find(".d-palette-picker");
  },
  initialize: function(el) {

  },

  getId: function(el) {
    return el.id;
  },
  getValue: function(el) {
    var ids=[];
    var cols=[];
    $("#"+el.id+" .sortable_vars").each(function(){
      ids.push($(this).data("id"));
    });
    $("#"+el.id+" .sortable_colors").each(function(){
      cols.push($(this).css("background-color"));
    });
    return {id:ids,color:cols}
  },
  setValue: function(el, value) {
    // $(el).val(value);

  },
  receiveMessage: function(el, data) {


  // other parameters to update...
  },
    getState: function (el) {
    // Store options in an array of objects, each with with value and label
    },

  subscribe: function(el, callback) {

  var elid=el.id;
  var elid_sp='#'+elid+' ';

    $(elid_sp+".sortable-div").each(function(){
     let sort=  Sortable.get(this);
     sort.option('onSort',function(evt){
       callback();
     });

    });
    var sortColors= document.getElementById(el.id+"_selected_colors");

    $( sortColors).on("end",function(){
      callback();
    });
    $( sortColors).on("updateInput",function(){
          callback();
        });

    var sortvar= document.getElementById(el.id+"_selected_vars");
    $(sortvar).on("end",function(){
      callback();
    });
    $(sortvar).on("updateInput",function(){
          callback();
        });
    $(el).on('click',".pal-sqr",function(e){
      console.log('click:.pal-sqr');
       e.stopPropagation();
      $(elid_sp+'.var-div').data('color',null);
      $(elid_sp+'.var-div').removeClass("active");
        var has=$(this).hasClass("active");
       $(elid_sp+".pal-sqr").each(function(){
           $(this).removeClass("active");
       })
       if(has===false){
       $(this).addClass("active");
       $(elid_sp+'.var-div').addClass("active");
        var color=$(this).attr('style');
         $(elid_sp+'.var-div').data('color',color);
    }
      callback();
       });
    $(elid_sp+".grid-container").on("click",function(){
      console.log('click:.grid-container');
          $(elid_sp+'.var-div').removeClass("active");
         $(elid_sp+".pal-sqr").each(function(){
           $(this).removeClass("active");
       });
        callback();
    });
    $(el).on("click",".sortable_colors",function(){
     console.log('click:.sortable_colors');
        if($(elid_sp+'.var-div').hasClass("active")){
         var style=$('.var-div').data('color');
         $(this).attr('style',style);
          callback();
        }
    });
    $(elid_sp+".assign_palette-btn").on("click",function(){
       console.log('click:.assign_palette');
        var palColors=[];
    $(elid_sp+".grid-container .pal-sqr").each(function(){
        palColors.push($(this).css("background-color"));
    });
    var $sort_colors=$(elid_sp+".sortable_colors")
    var sc_len=$sort_colors.length;
    console.log(sc_len);
    if(sc_len>palColors.length){
         var palColors = new Array(sc_len).fill(palColors).flat();
    }
    $sort_colors.each(function(i,el){
        $(el).css('background-color',palColors[i]).data("id",palColors[i]);
    });
    callback();
    });
    $("#"+elid+"_"+"palette_picker").on("changed.bs.select",function(){
    var html=''
    $(elid_sp+".filter-option .palette div").each(function(){
    var color=$(this).css("background-color");
    html=html+`<div data-color=${color} class = 'pal-sqr border m-1' style ='background-color:${color}'></div>`
    });

    $(elid_sp+".grid-container").html(html);
     callback();
    });


  },
  unsubscribe: function(el) {
    $(el).off('.discretePalPickerBinding');
  }
});

Shiny.inputBindings.register(discretePalPickerBinding, "shiny.d-pallete-picker");

