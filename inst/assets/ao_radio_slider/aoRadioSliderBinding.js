var aoRadioSliderBinding = new Shiny.InputBinding();

$.extend(aoRadioSliderBinding, {
  find: function(scope) {
    return $(scope).find(".ao-radio-slider");
  },
  initialize: function(el) {

  },
  getId: function(el) {
    return el.id;
  },
  getValue: function(el) {

    var out=$(`#${el.id} .irs .irs-single`).html();
    $(el).data('filter',out)
    $(el).trigger("filter");
     return  out
  },
  setValue: function(el, value) {
    var instance=$(`#${el.id}_range_slider`).data("ionRangeSlider");

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
       var configEl = $(el).find('script[data-for="' + Shiny.$escape(el.id) + '"]');

       var config = JSON.parse(configEl.html());
    instance.update(config);
    });
   //$(configEl).remove();
       $(`#${elid} .filter-remove`).on('click',function(e){
            var instance=$(`#${el.id}_range_slider`).data("ionRangeSlider");
            instance.update({
              from:0
            })

      });
   $(`#${elid}_range_slider`).on('change',function(e){

          var data=$(el).data();
          var val=$(`#${elid} .irs .irs-single`).html();

          $(`#${elid}_max_input`).html(val);

          $(el).data('value',val);

          callback();
   });
 $(`#${elid} .toggle-slider`).on('click',function(e){
           val=1
          if($(this).hasClass("shift-left")){
              val=-1
          }
           var instance=$(`#${elid}_range_slider`).data("ionRangeSlider");
           var from=$(`#${elid}_range_slider`).data('from');
             instance.update({
                 from:val+from
             });
   });
  },
  unsubscribe: function(el) {

    $(el).off('.aoRadioSliderBinding');
  }
});

Shiny.inputBindings.register(aoRadioSliderBinding, "shiny.ao-radio-slider ");

