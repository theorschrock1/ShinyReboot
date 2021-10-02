var aoCheckboxGroupBinding = new Shiny.InputBinding();

$.extend(aoCheckboxGroupBinding, {
  find: function(scope) {
    return $(scope).find(".ao-checkbox-group");
  },
  initialize: function(el) {

  },
  getId: function(el) {
    return el.id;
  },
  getValue: function(el) {
    var elid=el.id;
    var out=[];
    var selector=`#${elid} .checkbox-row .checked`
    var all=$(`#${elid} .checkbox-row .radio-all.checked`);
    //console.log(all);
    if(all.length!==0){
      //console.log("hisd");
      selector=`#${elid} .checkbox-row .select-option:not(.checked)`
    }
  $(selector).each(function(){
      var lab=$($(this).next().get(0));
      out.push($(lab).html());
      });
      $(el).data('filter',out).trigger("filter");
      return out;
  },
  setValue: function(el, value) {
    var elid=el.id;
    $(`#${elid} .checkbox`).removeClass("checked");

    if(value!==undefined&&value.length>0){
    $(`#${elid} .checkbox`).each(function(){
     if(value.includes($(this).text())){
         $(`#${elid} .checkbox`).addClass("checked");
     }

    });
    }
  },
  receiveMessage: function(el, data) {
    var elid=el.id;
    if(data.hasOwnProperty('label')){
      $(`#${elid} .checkbox-group-label`).html(data.label);
    }
    if(data.hasOwnProperty('data_attrs')){
      $(el).data(data.data_attrs);
    }
     if(data.hasOwnProperty('options')){
       var opts=''
       data.options.map(function(x){
       opts=opts+`<div class="d-flex flex-row checkbox-row p-0 w-100 align-items-center justify-content-start">
            <div class=" checkbox">
              <span class="mdi mdi-checkbox-blank-outline mdi-lg"></span>
              <span class="mdi mdi-check-box-outline mdi-lg"></span>
            </div>
            <div class="ml-2 flex-fill check-label">${x}</div></div>`
     });
      $(`#${elid} .checkgroup`).html(opts);
     }

     this.setValue(el,data.selected);

     $(el).trigger("updateInput");
     },
  subscribe: function(el, callback) {

   var elid=el.id;

    $(el).on('updateInput',function(e){
      callback()
    });
    $(`#${elid} .mag-btn`).on('click',function(e){
        $(`#${elid} .search-box`).toggleClass("d-flex");
        if($(`#${elid} .search-box`).hasClass("d-flex")===false){
          $(`#${elid}-search`).val("").trigger("input");

        };
    });
    $(`#${elid} .filter-remove`).on('click',function(e){
                $(`#${elid} .checkbox`).addClass("checked");
                $(`#${elid} .radio`).removeClass("checked");
                $(`#${elid} .radio.radio-all`).addClass("checked");
                $(`#${elid} .selected-label`).html('(All)');
                callback();
      });
    $(el).on('click','.checkbox',function(e){

         $(this).toggleClass("checked");
               if($(this).hasClass("check-all")){
                   if($(this).hasClass("checked")){
                  $(`#${elid} .d-flex > .checkbox`).addClass("checked")
               }else{
                   $(`#${elid} .checkbox`).removeClass("checked")
               }

               }else{
                    $(`#${elid} .check-all`).removeClass("checked")
               }

                updateDropDownLabel();
                callback();

   });
    $(el).on('click','.radio',function(e){
    $(`#${elid} .radio`).removeClass("checked");
         $(this).addClass("checked");
         var text=$($(this).siblings('.check-label').get(0)).text();
         $(`#${elid} .selected-label`).html(text);
         callback();
   });
    $(`#${elid} .btn-all`).on('click',function(e){
                  var $checks= $(`#${elid} .d-flex > .checkbox`);
                  $checks.addClass("checked");

                  $(`#${elid} .selected-label`).html('(All)');
                  callback();

   });
    $(`#${elid} .btn-none`).on('click',function(e){
                  $(`#${elid} .selected-label`).html('(None)');
                  $(`#${elid} .d-flex > .checkbox`).removeClass("checked");
                  callback();
   });
    $(`#${elid}-search`).on("input",function(){
       var val=$(this).val().toLowerCase();
       if(val==''){
                $(`#${elid} .checkbox-row`).addClass('d-flex').removeClass('d-none');
                return;
       }

           $(`#${elid} .checkbox-row`).each(function(){
              if($(this).hasClass("all")){
                  return;
              }
             text=$($(this).find(`.check-label`).get(0)).text().toLowerCase();
             if(text.includes(val)){
              $(this).addClass('d-flex').removeClass('d-none');
             }else{
             $(this).addClass('d-none').removeClass('d-flex');

             }
           });
   });
function updateDropDownLabel(){
               var $checks= $(`#${elid} .checkbox-row .checked`);
               var notChecks= $(`#${elid} .checkbox-row :not(.checked)`).length;
               var lenChecks= $checks.length;

                if( lenChecks==0){
                   $(`#${elid} .selected-label`).text('(None)');

                     return;
                 }

                if( notChecks==0){
                   $(`#${elid} .selected-label`).html('(All)');

                     return;
                }

               if(lenChecks>1){
              $(`#${elid} .selected-label`).html(`(${lenChecks} selected)`);

                     return;
               }
               if(lenChecks==1){
               var text=$($checks.siblings('.check-label').get(0)).text();
               $(`#${elid} .selected-label`).html(text);
               return;
                }
  }
  },
  unsubscribe: function(el) {
    let elid=el.id;
    $(`#${elid} .mag-btn`).off('click');
    $(`#${elid} .filter-remove`).off('click');
    $(el).off('updateInput');
    $(`#${elid} .btn-all`).off('click');
    $(`#${elid} .btn-none`).off('click');
    $(`#${elid}-search`).off("input");
    $(el).off('click','.radio');
    $(el).off('.aoCheckboxGroupBinding');
    $(el).off('click','.checkbox');
  }
});

Shiny.inputBindings.register(aoCheckboxGroupBinding, "shiny.ao-checkbox-group ");

