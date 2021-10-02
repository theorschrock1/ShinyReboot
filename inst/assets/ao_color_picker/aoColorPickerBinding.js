var aoColorPickerBinding = new Shiny.InputBinding();

$.extend(aoColorPickerBinding, {
  find: function(scope) {
    return $(scope).find(".aoColorPicker");
  },
  initialize: function(el) {

  },
  getId: function(el) {
    return el.id;
  },
  getValue: function(el) {
     var elid=el.id
     var color=  $("#"+elid+"_colorpicked").data("color");
     var opacity= $("#"+elid+"_colorpicked").data("opacity");
     return {"color":color,"opacity":opacity}
     },
  setValue: function(el, value) {
      var elid="#"+el.id;
      $(`${elid}_colorpicked`).data(value);
      $(`${elid}_colorpicked`).css('background-color',value.color);
      var instance=$(`${elid}_opacity_slider`).data("ionRangeSlider");
      instance.update({
            from:value.opacity
        });

  },
  receiveMessage: function(el, data) {
    console.log("hi")
    this.setValue(el, data);

    $(el).trigger("setColor");

  },
    getState: function (el) {
    // Store options in an array of objects, each with with value and label
    },

  subscribe: function(el, callback) {
   var elid="#"+el.id;
   var $input = $(`${elid}_opacity_input`);
   var $color=$(`${elid}_colorpicked`);
   var min = 0;
   var max = 1;
   var instance=$(`${elid}_opacity_slider`).data("ionRangeSlider");
   $(`${elid}_opacity_slider`).on("change",function(){

       var dummyEl = document.getElementById(`${el.id}_opacity_input`);
       var isFocused = (document.activeElement === dummyEl);
       if(isFocused===false){
          var opacity=$(`${elid}_opacity_slider`).data("from");
          $input.prop("value",$(`${elid}_opacity_slider`).data("from")*100+"%");
          $color.css('opacity',1-opacity);
          $color.data("opacity",1-opacity);
            callback();
       }
   });

    $input.on("focus", function() {
        var val = $(this).prop("value");
        var thenum = val.replace(/[^0-9]/g,'')/100;

        $input.prop("value", thenum);
        $(this).on("blur",function(){
        var val = $(this).prop("value");
            console.log(val);
               console.log(val <= max && val>=min);
           if (val <= max && val>=min) {
          $input.prop("value", val*100+"%");
          $(this).off("blur");
          callback();
           return;
           }
        if (val < min) {
            val = min;
        } else if (val > max) {
            val = max;
        } else{
            val=thenum;
        }

         $input.prop("value", val*100+"%");
         $(this).off("blur");
           callback();
    });
    });
    $(`${elid} .color-btn`).on('click', function() {

     $(`${elid} .color-btn`).each(function(){
         $(this).removeClass("active");
      });

      $(this).addClass("active");
      var color=$(this).css('background-color');

      $(`${elid}_colorpicked`).css('background-color',color);
      $(`${elid}_colorpicked`).data("color",color);
        callback();
    });

  $input.on("input", function() {
        var val = $(this).prop("value");

        // validate
        if (val < min) {
            val = min;
        } else if (val > max) {
            val = max;
        }

        instance.update({
            from: val
        });
        callback();
    });

    $(el).on('setColor',
    function(e) {
      callback();
    });

  },
  unsubscribe: function(el) {

    $(el).off('.aoColorPickerBinding');
  }
});

Shiny.inputBindings.register(aoColorPickerBinding, "shiny.aoColorPicker");








