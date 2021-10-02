var continuousPalPickerBinding = new Shiny.InputBinding();

$.extend(continuousPalPickerBinding, {
  find: function(scope) {
    return $(scope).find(".c-palette-picker");
  },
  initialize: function(el) {

  var myDefaultWhiteList = $.fn.selectpicker.Constructor.DEFAULTS.whiteList;

  var myCustomRegex = /^data-[\w-]+/;
  myDefaultWhiteList['*'].push(myCustomRegex);

  },

  getId: function(el) {
    return el.id;
  },
  getValue: function(el) {
    $el=$(`#${el.id}-selected_c_palette`);

out={
  'palette':[$el.data('id')],
  'color_range':
         [$el.data('color_min'),
          $el.data('color_center'),
          $el.data('color_max')
          ],
  'data_range':[
    +$(`#${el.id}-variable_min`).val(),
    +$(`#${el.id}-variable_mid`).val(),
    +$(`#${el.id}-variable_max`).val()
    ],
  "stepped":[
    $(`#${el.id}-stepped_range`).prop('checked')==true
    ],
    "n_steps":[+$(`#${el.id}-n_steps`).val()]
}
return out;
      },
  setValue: function(el, value) {
   $(`#${el.id}-selected_c_palette`).data(value);
  },
  receiveMessage: function(el, data) {

    if(data.hasOwnProperty('selected_min')){
      $(`#${el.id}-variable_min`).data('min',data.selected_min);
    }
    if(data.hasOwnProperty('selected_max')){
     $(`#${el.id}-variable_max`).data('max',data.selected_max);
    }
     if(data.hasOwnProperty('data_max')){
     $(el).data('max',data.data_max);
    }
     if(data.hasOwnProperty('data_mid')){
      $(el).data('mid',data.data_mid);
    }
     if(data.hasOwnProperty('data_min')){
      $(el).data('min',data.data_min);
    }

    if(data.hasOwnProperty('selected_min')==false&&data.hasOwnProperty('data_min')){
      $(`#${el.id}-variable_min`).val(data.data_min);
     $(`#${el.id}-variable_min`).data('min',data.data_min);
    }

    if(data.hasOwnProperty('selected_max')==false&&data.hasOwnProperty('data_max')){
       $(`#${el.id}-variable_max`).val(data.data_max);
       $(`#${el.id}-variable_max`).data('max',data.data_max);
    }
    if(data.hasOwnProperty('selected_min')==false&&data.hasOwnProperty('data_mid')){
       $(`#${el.id}-variable_mid`).data('mid',data.data_mid);
       $(`#${el.id}-variable_mid`).val(data.data_mid);
    }
   $('.range-inputs').trigger('updateRange');

  },
    getState: function (el) {
    // Store options in an array of objects, each with with value and label
    },

  subscribe: function(el, callback) {
    var ns=function(x){
         return '#'+el.id+'-'+x;
       }


          var inpid =el.id
      $(ns("reset_palette")).on("click",function(){
          var org = $("#"+inpid).data();
          $(ns("variable_min")).data('min',org.min).val(org.mid);
          $(ns("variable_max")).data('max',org.max).val(org.max);
          $(ns("variable_mid")).data('mid',org.mid).val(org.mid);
          $(ns("handle_min")).css("left",'0%');
          $(ns("handle_mid")).css("left",'50%');
          $(ns("handle_max")).css("left",'100%');
          let $sel=$(ns("selected_c_palette"));

          $sel.data("handle_min",0);
          $sel.data("handle_mid",0.5);
          $sel.data("handle_max",1);
          $sel.css('background-image',updateGradient( $sel.data()));
          $(ns('flip')).prop("checked", false).trigger("input");
          $(ns('stepped_range')).prop("checked", false).trigger("change");

      });
$('.range-inputs').on("updateRange",function(e){
    let vmind=+$(ns("variable_min")).data('min');
    let vmaxd= +$(ns("variable_max")).data('max');

    let range=vmaxd-vmind;
    let vmin=(+$(ns("variable_min")).val()-vmind )/range;
    let vmid=(+$(ns("variable_mid")).val()-vmind )/range;
    let vmax=(+$(ns("variable_max")).val()-vmind )/range;

    $(ns('handle_min')).css("left",vmin*100+'%');
    $(ns('handle_max')).css("left",vmax*100+'%');
    $(ns('handle_mid')).css("left",vmid*100+'%');
    $sel=$(ns("selected_c_palette"));
    $sel.data('handle_min',vmin);
    $sel.data('handle_max',vmax);
    $sel.data('handle_mid',vmid);
    $sel.css('background-image',updateGradient( $sel.data()));

    //$(ns('stepped_range')).trigger("input");
     callback();
});
$('.range-inputs').on("blur","input",function(e){
    let vmind=+$(ns("variable_min")).data('min');
    let vmaxd= +$(ns("variable_max")).data('max');
    let vmin=  +$(ns("variable_min")).val();
    let vmid=  +$(ns("variable_mid")).val();

    let vmax=   +$(ns("variable_max")).val();
    let range=vmax-vmin;

    let elmt=e.target;
    let change=$(elmt).val();

    //console.log("min:"+vmin);

    let elid=e.target.id;
    if(elid=='variable_min'&&change>vmid){
        $(elmt).val(vmid);
    }
    if(elid=='variable_min'&&change<vmind){
        $(elmt).data('min',change);
      }
    if(elid=='variable_mid'&&change<vmin){
        $(elmt).val(vmin);
    }

    if(elid=='variable_mid'&change>vmax){
        $(elmt).val(vmax);
    }
    if(elid=='variable_max'&&change<vmid){
        $(elmt).val(vmid);
    }
    if(elid=='variable_max'&&change>vmaxd){
        $(elmt).data('max',change);
    }
    change=$(elmt).val();
    vmind=$(ns('variable_min')).data('min');
    vmaxd=$(ns("variable_max")).data('max');
    let current=(+change+vmind)/(+vmaxd-vmind);
    let handle=$(elmt).data("handle");
    $(ns(handle)).css("left",current*100+'%')

    $(ns("selected_c_palette")).data(handle,current);
    var vdata=$(ns("selected_c_palette")).data();

    $(ns("selected_c_palette")).css('background-image',updateGradient(vdata));
     callback();
});
$(ns("palette_picker")).on("changed.bs.select",function(){
    //console.log('df');
    var clone=$('.filter-option .c_palette').clone();
    $(clone).css("width","100%");
    $(clone).data("handle_mid",0.5);
    $(clone).data("handle_min",0);
    $(clone).data("handle_max",1);

    if($(ns(`selected_c_palette`)).length>0){
      let dat=$(ns(`selected_c_palette`)).data();
      if(dat.hasOwnProperty("handle_mid")){
      $(clone).data("handle_mid",dat["handle_mid"]);
      }
      if(dat.hasOwnProperty("handle_min")){
      $(clone).data("handle_min",dat["handle_min"]);
      }
      if(dat.hasOwnProperty("handle_max")){
      $(clone).data("handle_max",dat["handle_max"]);
      }
}


    $(clone).attr('id',el.id+"-selected_c_palette");
    $(clone).addClass("h-100 w-100").removeClass("align-self-stretch");
    $(`#${el.id} .cont_p_selected .c_palette`).remove();
    $(`#${el.id} .cont_p_selected`).append($(clone));
    let data= $(clone).data();
    $(`#${el.id} .cont_p_selected .c_palette`).html(
         `<div id='${el.id}-handle_min' data-lim='handle_min' class='spectrum-handle handle-left h-100'  style='left:${data["handle_min"]*100+'%'}'></div><div id='${el.id}-handle_mid' data-lim='handle_mid' class='spectrum-handle handle-mid h-100' style='left:${data["handle_mid"]*100+'%'}'></div><div id='${el.id}-handle_max'  data-lim='handle_max' class='spectrum-handle handle-right h-100' style='left:${data["handle_max"]*100+'%'}'></div>`);


    $(ns("color_min")).prop("value",data.color_min);
    $(ns("color_max")).prop("value",data.color_max);



    var d1= dragElement(el.id+'-handle_min');
    var d2=  dragElement(el.id+'-handle_mid');
    var d3=  dragElement(el.id+'-handle_max');
     callback();
 });
$(ns('edit_range')).on('change',function(){
      // console.log('hds')
   var checked=$(this).is(':checked');
   if(checked){
        $(`#${el.id} .range-inputs`).children().each(function(){
           $(this).removeClass("disabled").prop("disabled",false).attr('type',"number");
           $(`#${el.id} .range-label`).removeClass("disabled");
        });
   }else{
        $(`#${el.id} .range-inputs`).children().each(function(){
         $(`#${el.id} .range-label`).addClass("disabled");
         $(this).addClass("disabled").prop("disabled",true).attr('type',"text");
         });
   }
    callback();
 });
$(ns('stepped_range')).on('change',function(){
   var checked=$(this).is(':checked');
   if(checked){
        $(ns('n_steps')).removeClass("disabled").prop("disabled",false);
         $(ns('steps-label')).removeClass("disabled");
   }else{
         $(ns('n_steps')).addClass("disabled").prop("disabled",true);
         $(ns('steps-label')).addClass("disabled");
   }
    callback();
 });
$(ns('flip')).on('input',function(){
   var checked=$(this).is(':checked');

   let cmin=$(ns("color_min")).val();
   let cmax=$(ns("color_max")).val();
   var $sel=$(ns("selected_c_palette"));
   $sel.data('color_min',cmax);
   $sel.data('color_max',cmin);
   $(ns("color_min")).val(cmax);
   $(ns("color_max")).val(cmin);

   var vdata=$sel.data();
   console.log(vdata);
   $(ns("selected_c_palette")).css('background-image',updateGradient(vdata));
    callback();
 });
$(`#${el.id} .spectrum_lim`).on("change",function(){
    //console.log("change");
    let $selectedPal=$(ns("selected_c_palette"));
    let vdata= $selectedPal.data();
      //  console.log(vdata);
    let val=$(this).val();
    let id=$(this).data("id");
    //console.log(id);
    //console.log(val);
    $selectedPal.data(id,val);
    vdata= $selectedPal.data();

    //console.log(val);

    $selectedPal.css('background-image',updateGradient(vdata));
     callback();
 });
$(ns("n_steps")).on("input",function(){
  callback();
});

  function dragElement(elmnt_id) {
  var elmnt=document.getElementById(elmnt_id);
  var parent= $(elmnt).parent().get(0);
  var left=parent.offsetLeft;
  var pos1 = 0,
      pos2 = 0,
      pos3 = 0

    // otherwise, move the DIV from anywhere inside the DIV:
    elmnt.onmousedown = dragMouseDown;


  function dragMouseDown(e) {
    e = e || window.event;
    e.preventDefault();
    // get the mouse cursor position at startup:
    pos3 = e.clientX;
  // console.log("startx:"+e.clientX);
    document.onmouseup = closeDragElement;
    // call a function whenever the cursor moves:
    document.onmousemove = elementDrag;
  }

  function elementDrag(e) {
    e = e || window.event;
    e.preventDefault();
    // calculate the new cursor position:
    var vdata=$(parent).data();
    var lower,
        upper,
        update_var;
    var elid =$(elmnt).data("lim");
    if(elid =="handle_min"){
        lower=0;
        upper=vdata["handle_mid"]-0.025;
        update_var='variable_min';
    }
     if(elid =="handle_mid"){
         lower=vdata["handle_min"]+0.025;
         upper=vdata["handle_max"]-0.025;
          update_var='variable_mid';
    }

     if(elid =="handle_max"){
         lower=vdata["handle_mid"]+0.025;
         upper=1;
         update_var='variable_max';
    }

    pos1 = pos3- e.clientX;
    pos3 = e.clientX-left;
    var vmin=$(ns("variable_min")).data('min');
    var vmax=$(ns("variable_max")).data('max');

    var range=vmax-vmin;
    let wd = parent.offsetWidth;
    var percent= Math.min(upper,Math.max(lower,pos3/wd));



  elmnt.style.left= percent*100+'%'

  var new_val=parseFloat(percent*range+vmin).toFixed(2);
  $(ns(update_var)).val(new_val);
  $(parent).data(elid,percent);
  vdata=$(parent).data();
  $(parent).css('background-image',updateGradient(vdata));
   callback();
  }

  function closeDragElement() {
    // stop moving when mouse button is released:
    document.onmouseup = null;
    document.onmousemove = null;
  }
  }

  function updateGradient(vdata){
    return  `linear-gradient(90deg,${vdata['color_min']} ${vdata['handle_min']*100+'%'},${vdata['color_center']} ${vdata['handle_mid']*100+'%'},${ vdata['color_max']} ${vdata['handle_max']*100+'%'})`;
  }
$( document ).ready(function() {
   $(ns('palette_picker')).trigger("changed.bs.select");

});

  },
  unsubscribe: function(el) {
    $(el).off('.continuousPalPickerBinding');
  }
});

Shiny.inputBindings.register(continuousPalPickerBinding, "shiny.d-pallete-picker");





