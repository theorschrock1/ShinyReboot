var editableTextBinding = new Shiny.InputBinding();

$.extend(editableTextBinding, {
  find: function(scope) {
    return $(scope).find(".editable-text");
  },
  initialize: function(el) {
    this.dataClass =$(el).data('for');
    this.assertUnique=$(el).data('assert_unique');
    this.dataEvent=$(el).data('event');
   // console.log(this.dataClass);

  },
  dataClass:null,
  assertUnique:true,
  dataEvent:null,
  getId: function(el) {
    return el.id;
  },
  getValue: function(el) {
    let dataid=$(el).data('active');

   if(dataid===undefined){
     return null
   }
   let elid= `${this.dataClass}[data-id="${dataid}"]`
   console.log(elid);
   let out={};
   var id=$(elid).data('id');
   out['id']=$(elid).data('id');
   out['data']=$(`#${id}`).data();
   out['value']=$(elid).html();
   return  out
  },
  setValue: function(el, value) {
    // $(el).val(value);

  },
  receiveMessage: function(el, data) {
   console.log(data);

   var dataid= data.id;
   var elid=`${this.dataClass}[data-id="${dataid}"]`
  if(data.hasOwnProperty('value')){
    $(elid).html(data.value);
    $(elid).trigger('change');
  }
  if(data.hasOwnProperty("edit")){
    $(elid).trigger(this.dataEvent);
  }


  // other parameters to update...
  },
    getState: function (el) {
    // Store options in an array of objects, each with with value and label
    },

  updateVal: function(currentEle,value,callback,dataClass,assertUnique) {
      $(currentEle).html(`<input type="text" class="edit-val" value="${value}">`);
      $(".edit-val").focus();
      /*$(".edit-val").keyup(function (event) {
          if (event.keyCode == 13) {
              $(currentEle).html($(".thVal").val().trim());
          }
      });*/




         $('.edit-val').on('blur',function (e) {

       //   if ($(e.target).closest(".edit-val").length === 0) {
            var newValue=$(".edit-val").val().trim();

            var labels=[""];
           if(assertUnique){
            var labels=[];
            $(dataClass).each(function(){
                let text=$(this).text();
                labels.push(text);
              });
            }

            if(labels.includes(newValue)){
              $(".edit-val").addClass('is-invalid');
             $(".edit-val").focus();

             $('.edit-val.is-invalid').on('input',function (event) {
                 $(this).removeClass('is-invalid');
                 });

            }else{

            $(currentEle).html(newValue);
            callback();

            }
      });
  },
  subscribe: function(el, callback) {

    var setValue= this.setValue;
    var dataHandle=this.dataHandle;
    var updateVal=this.updateVal;
    var dataClass=this.dataClass;
    var assertUnique=this.assertUnique;

    $(document).on(this.dataEvent,this.dataClass, function(e) {
       e.stopPropagation();      //<-------stop the bubbling of the event here
     /* if(dataHandle!=''){
       let tmp= $(this).parents(this.dataClass).get(0);
       var currentEle=$(tmp);
      }else{
       var currentEle= $(this);
      }*/
      let currentEle= $(this);

      let value=currentEle.text().trim();
      //let tmpNode=$(this).find('.editable').get(0);
      //let value=$(tmpNode).html();
      $(el).data('active',currentEle.data('id'));
      updateVal( currentEle,value,callback,dataClass,assertUnique);
    });
    $(this.dataClass).on('change',function(){
      callback();
    });

  },
  unsubscribe: function(el) {

    $(el).off('.editableTextBinding');
    $(document).off(this.dataEvent,this.dataClass);
  }
});

Shiny.inputBindings.register(editableTextBinding, "shiny.editable-text");

