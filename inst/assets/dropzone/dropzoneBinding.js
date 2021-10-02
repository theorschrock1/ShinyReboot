

/*dropzones.addEventListener('dragover', function(e) {
  e.preventDefault();
})
dropzones.addEventListener('dragenter', function(e) {
  if (e.target.classList.contains('dropzone')) {
    e.target.classList.add('solid-border');
  }
})
dropzones.addEventListener('drop',function(e) {
  e.preventDefault();
  e.target.appendChild(el);
  el = null;
  e.target.classList.remove('solid-border');
})

dropzones.addEventListener('dragleave', function(e) {
  if (e.target.classList.contains('dropzone')) {
    e.target.classList.remove('solid-border');
  }
})*/



var dropzoneBinding = new Shiny.InputBinding();
$.extend(dropzoneBinding, {
  find: function(scope) {

    return $(scope).find(".dropzone");
  },
  getId: function(el) {
    return el.id;
  },


  getValue: function(el) {


 //dataids = $(el).children('div').
   //         map(function(){
     //         return $(this).data('id');
       //    }).get();
   // dataids = $(el).children('div').map(function(){
  //    this.data('id');
  //  });

  return null;

  },
  setValue: function(el, value) {

  },
  dragOver:function(e) {



        },
   dragEnter:function(e) {

       var target=e.target;
        if (target.classList.contains('dropzone')) {
            target.classList.add('dragover');
        }
      },
   drop:function(e) {


       /* var target=e.target;
        var shelf=$(target).parents(".marks-card").get(0);
        var sort=$(shelf).find(".sortable-div").get(0);*/
        if (target.classList.contains('dropzone')) {
          //  var icon=$(target).find(".mdi").attr('class');
          //  var mark=$(target).data("mark");
             e.target.classList.remove('dragover');
          }else{
            let p=$(target).parents('.dropzone').get(0);
          //  var icon=$(p).find(".mdi").attr('class');
        //   var mark=$(p).data("mark");
             p.classList.remove('dragover');
          }
       /* let data = e.dataTransfer.getData("DataId");
        let clone=$(data).clone();
        let agg=clone.data("option_aggregation");
        if(agg!=undefined && agg!="NA"){
          let lab=clone.find(".pill-label").get(0);
          let current=$(lab).text();
          $(lab).text(agg+"("+current+")");
        }

        clone.find(".pill-data-icon .mdi").attr("class",icon);
        clone.addClass("pill-marks pill-selected");
        clone.data("mark",mark);
        $(sort).append(clone);
        console.log(data);*/
      },
    dragLeave:function(e) {
             var target=e.target;
        if (e.target.classList.contains('dropzone')) {
            e.target.classList.remove('dragover');
          }
    },
  subscribe: function(el, callback) {



  },
  unsubscribe: function(el) {

    $(el).off(".dropzoneBinding");

  },
  receiveMessage: function(el, data) {
    //console.log(data);

  },

  initialize: function(el) {
    el.addEventListener('dragenter', this.dragEnter);
    el.addEventListener('dragover', this.dragOver);
    el.addEventListener('dragleave', this.dragLeave);
    el.addEventListener('drop', this.drop);

  }
});

Shiny.inputBindings.register(dropzoneBinding, "shiny.dropzone");

