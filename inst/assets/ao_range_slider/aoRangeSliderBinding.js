var aoRangeSliderBinding = new Shiny.InputBinding();

$.extend(aoRangeSliderBinding, {
  find: function(scope) {
    return $(scope).find(".ao-range-slider");
  },
  initialize: function(el) {
  /* var instance=$(`#${elid}_range_slider`).data("ionRangeSlider");
   var configEl = $(el).find('script[data-for="' + Shiny.$escape(el.id) + '"]');

   config = JSON.parse(configEl.html());
   instance.update(config);
  $(configEl).remove();*/

  },
  getId: function(el) {
    return el.id;
  },
  getValue: function(el) {
     var elid=el.id;
     var to =$(`#${elid}_range_slider`).data("to");
     var from =$(`#${elid}_range_slider`).data("from");
     var out = [from,to]
     $(el).data('filter',out);
     $(el).trigger('filter');
     return  out
  },
  setValue: function(el, value) {
    var elid=el.id
    var instance=$(`#${elid}_range_slider`).data("ionRangeSlider");

    instance.update(value);
  },
  receiveMessage: function(el, data) {
    if(data.hasOwnProperty('value')){
     this.setValue(el,data.value);
    }
    if(data.hasOwnProperty('data')){
      $(el).data(data.data)
    }
    if(data.hasOwnProperty('label')){
      var lab=$(el).find('.checkbox-group-label').get(0);
      $(lab).html(data.label)
    }
  },
    getState: function (el) {
    // Store options in an array of objects, each with with value and label
    },

  subscribe: function(el, callback) {
   var elid=el.id;
 $(document).ready(function(){
         var instance=$(`#${el.id}_range_slider`).data("ionRangeSlider");
         if($(el).hasClass('factor-range')){
           var configEl = $(el).find('script[data-for="' + Shiny.$escape(el.id) + '"]');
           var config = JSON.parse(configEl.html());
           instance.update(config);
         }
          instance.update({
              onFinish:function(data){
                  callback();
              }
            });
    });
  $(`#${elid} .filter-remove`).on('click',function(e){
            var instance=$(`#${el.id}_range_slider`).data("ionRangeSlider");
            var data=$(el).data();
            instance.update({
              from:data.min,
              to:data.max
            });

      });
 $(el).on('click','.edit-numeric', function(e) {
    e.stopPropagation();      //<-------stop the bubbling of the
    let $el= $(this);
    var $parent=$($el.parents(".ao-range-slider").get(0));
    var range_data=$parent.data();
    var lowerlim;
    var upperlim;
    var value;
    var whichlim;

      if($el.hasClass("range-min")){
         whichlim="lower"
         lowerlim=+range_data.min
         upperlim=+range_data.upper
         value=+range_data.lower;
      }else{
         whichlim="upper"
         lowerlim=+range_data.lower
         upperlim=+range_data.max
         value=+range_data.upper;
      }
      updateVal($el,value,whichlim,lowerlim,upperlim,$parent,range_data);
    });
 $(`#${elid}_range_slider`).on('change',function(e){

       var instance=$(`#${elid}_range_slider`).data("ionRangeSlider");

       var elMin = document.getElementById(`${elid}_min_input`);
       var elMax = document.getElementById(`${elid}_max_input`);
       var isFocused = (document.activeElement === elMin||document.activeElement === elMax);
       if(isFocused===false){
          $parent=$($(this).parents(".ao-range-slider").get(0));
          var data=$parent.data();
          var max=$(this).data("to");
          var is_numeric=$(elMax).hasClass('edit-numeric');
          var both=true
          var val=$(`#${elid} .irs .irs-to`).html();
          if(max===undefined){
                   max=$(this).data("from");
                   val= $(`#${elid} .irs .irs-single`).html();
                   both=false
          }
          if(is_numeric){
          $(elMax).html(formatNumber(max,data));
            }else{
          $(elMax).html(val);
            }

          if(both){
          var min=$(this).data("from");

          if(is_numeric){
          $(elMin).html(formatNumber(min,data));
              }else{
          var valmin=$(`#${elid} .irs .irs-from`).html();
          $(elMin).html(valmin);
              }
          }

          $parent.data('lower',min).data('upper',max);

       }


   });

 function updateVal(el,value,whichlim,lowerlim,upperlim,parent,range_data) {
     var $el=el;
     var $parent=parent;
     var last=$el.html();
     var elid=$parent.attr('id');
      $el.html(`<input id=${elid}-edit-val type="text" class="edit-val" value="${value}">`);
      $(".ao-range-slider .edit-val").focus();
        $(".ao-range-slider .edit-val").on("click",function(e){
              e.stopPropagation();
        });
      $(`#${elid}-edit-val`).on('blur',function (e) {

        var newValue=+$(this).val();

            if(newValue>=lowerlim& newValue<=upperlim){
          $parent.data(whichlim,newValue);
           var instance=$(`#${elid}_range_slider`).data("ionRangeSlider");

              if(whichlim=="lower"){
               instance.update({
                 from: newValue
                  });
              }else{
               instance.update({
                   to: newValue
                  });
              }
             $(`#${elid}_range_slider`).trigger('change');
           // $el.html(formatNumber(newValue,data));
            }else{
                $el.html(last);
            }

      });
  }

 function formatNumber(newValue,data){
                 if(data.prefix===undefined){
                   data.prefix=''
                 }
                 if(data.suffix===undefined){
                   data.suffix=''
                 }
                if(data.suffix=='K'){
                  newValue= newValue/1000 ;
                }
                if(data.suffix=='M'){
                  newValue=  newValue/1000000;
                }
                if(data.suffix=='B'){
                  newValue=  newValue/1000000000;
                }
                if(data.suffix=='T'){
                  newValue=  newValue/1000000000000;
                }
                if(data.suffix=='%'){
                  newValue=  newValue*100 ;
                }
                newValue=+newValue.toPrecision(+data.digits);

                if(data.prefix != ""&& newValue<0 ){
                  newValue= "("+data.prefix+ numberWithCommas(-1*newValue)+data.suffix+")";
                }else{
                    newValue=data.prefix+numberWithCommas(newValue)+data.suffix;
                }
                return newValue;
                }


  function numberWithCommas(x) {
    return x.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
                   }
  },
  unsubscribe: function(el) {

    $(el).off('.aoRangeSliderBinding');
  }
});

Shiny.inputBindings.register(aoRangeSliderBinding, "shiny.ao-range-slider ");

