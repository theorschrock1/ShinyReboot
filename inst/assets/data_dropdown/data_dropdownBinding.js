var data_dropdownBinding = new Shiny.InputBinding();

$.extend(data_dropdownBinding, {
  find: function(scope) {
    return $(scope).find(".data_dropdown");
  },
  initialize: function(el) {

  },
  renameValue:function(value){
     if(value===undefined){
        return value
     }
     vecout={};
     res=Object.getOwnPropertyNames(value);
     let isAction= new RegExp('action_');
     res.map(function(d){
       if(isAction.test(d)==false){
       let oldname=d;
       let newname=d.replace("option_","").replace("toggle_","");
       vecout[newname]=value[d];
       }
     });
     return vecout
  },
  dataClass:null,
  dataHandle:"",
  getId: function(el) {
    return el.id;
  },
  getValue: function(el) {
   let elid=$(el).data('active');
   let data=$(elid).data();

   return this.renameValue(data);
  },
  setValue: function(el, value) {
   $(el).data('active',value);
  },
  receiveMessage: function(el, data) {

  if(data.hasOwnProperty('id')){
  let elid= "#"+data.id;
  $(elid).data(data.data);
  }

  },
    getState: function (el) {
    // Store options in an array of objects, each with with value and label
    },

  subscribe: function(el, callback) {
     var setValue= this.setValue;
     var dataHandle="";
     var dataClass=$(el).data('for');
    var handle=$(el).data('handle');
     if(handle!=undefined){
         dataHandle=' .' +handle
     }

    $(document).on('click',dataClass+dataHandle, function(e) {
       $(".context-menu").removeClass('show');
       $(".submenu").removeClass('show');

      let isRadio= new RegExp('option');
      let isCheckBox= new RegExp('toggle');
      let isAction= new RegExp('action');

      if(dataHandle!=''){
      let tmp= $(this).parents(dataClass).get(0);
      var $this=$(tmp);
      var top=e.pageY;
      var left=e.pageX;
      }else if($(el).data("position")=='relative'){
      var $this= $(this);
      var top=0;
      var left=0;
      var wd='100%'
      }else {
      var $this= $(this);
      var top=this.offsetTop+this.offsetHeight;
      var left=this.offsetLeft;
      var wd=this.offsetWidth;
      }
       //console.log($this);
      let data=$this.data();
      let datanames=Object.getOwnPropertyNames(data);
      //console.log(data);
      datanames.map(function(d,i){
        if(isRadio.test(d)){
            let value=$this.data(d);
            //console.log(value);
            //console.log(d);
            //console.log("radio");
            $('#'+el.id+" "+'#'+d).find('.dropdown-item').each(function(){
                $(this).removeClass('active');
               //console.log($(this));
            });
              //console.log(value=='NA');
              if(value=='NA'){
                //console.log('#'+d);
                $('#'+el.id+" "+'#'+d).addClass('d-none');

              }else{
           $('#'+el.id+" "+'#'+d).removeClass('d-none');
            let inp =$("input[name='" +d+ "'][value=" +value+ "]");
            $(el).data(d,value);
            inp.prop('checked', true);
            inp.parent().addClass('active');
            }

        }
        if(isCheckBox.test(d)){
            let value=$this.data(d);
            let inp =$(`input[name='${d}']`);

            inp.prop('checked',value);
            $(el).data(d,value);
            if(value=='NA'){
              $('#'+el.id+" "+'#'+d).addClass('d-none');

            }else{
            $('#'+el.id+" "+'#'+d).removeClass('d-none');
            if(value){
            inp.parent().addClass('active');
            }else{
            inp.parent().removeClass('active');
            }

            }
        }
        if(isAction.test(d)){
            let value=$this.data(d);
            if(value==false){
              $('#'+el.id+" "+'#'+d).addClass('d-none');

            }else{
            $('#'+el.id+" "+'#'+d).removeClass('d-none');
        }
      }
     });
      let ht=window.innerHeight;
      let space=ht-($(el).height()+e.pageY)-10;
      let topAdjust=Math.min(0,space)+top;

       let wd_type=$(el).data('width');
      if(wd_type==='auto'||wd_type==='fixed'){
      $(el).css({
        top: topAdjust,
        left: left
      });
      }
      if(wd_type=='fit'){
        $(el).css({
        top: topAdjust,
        left: left,
        width : wd
      });
      }
      if(wd_type=='min_fit'){
        $(el).css({
        top: topAdjust,
        left: left,
        "min-width" : wd
      });
      }


      $(el).data('id',$this.attr('id'));
      $(el).addClass("show");

      return false;
    });

    $(".dropdown-item.input-item").on('click', function(e){
      let $item=$(this);
      let inp = $(this).find('input').get(0);
      let type= $(inp).attr('type')
      if(type=='radio'){
         //console.log('radio');
      var val=$(inp).val();
      }
      if(type=='checkbox'){
          //console.log('checkbox');
          var val=$(inp).is(':checked')==false;
      }
      let dname=$(inp).attr('name');

      //console.log(dname+':'+val);
      let elid="#" + $(this).parents('.context-menu').data('id');
      //console.log(elid);
      $(elid).data(dname,val);
      $(el).data('active',elid);

      //console.log($item);
      //console.log(elid);
      evt= $item.data("trigger");
       //console.log(evt);
      if(evt!==undefined){
        $(elid).trigger(evt);
      }
      callback();
      $(".context-menu").removeClass('show');
      $(".submenu").removeClass('show');

    });
    $(".dropdown-item.action-item").on('click', function(e){
        let actionId=this.id;
        let elid=$(this).parents('.context-menu').data('id');
        let menuId=$(this).parents('.context-menu').attr('id');
        console.log(elid);
        let inputId=menuId+"_"+actionId;
        Shiny.setInputValue(inputId,elid,{priority:'event'});
        $(".context-menu").removeClass('show');
        $(".submenu").removeClass('show');
    });
    $(document).on('click', function (e) {

        if ($(e.target).closest(".context-menu.show").length === 0) {
            $(".context-menu").removeClass('show');
            $(".submenu").removeClass('show');
        }
    });
    $(".dropdown-item.submenu").on('click',function(e){

      let item=$(this).parent().get(0);

      $(item).siblings().each(function(){
            $(this).find('.submenu').removeClass('show');
        });

      if($(item).parent().hasClass('dropdown-group')){
        let item2=  $(item).parent().get(0);

        $(item2).siblings().each(function(){
            $(this).find('.submenu').removeClass('show');
        });
      }
      let parent=$(this).parents('.dropdown-menu').get(0);
      let left=$(parent).css('left')+this.offsetWidth;



      //console.log("parent.style.top"+parent.style.top);
      //console.log("parent.style.top"+parent.style.left);
      //console.log("parent.style.offsetWidth"+parent.offsetWidth);
      let menup=$(this).parent().get(0);

      let menu=$(menup).find('.dropdown-menu.submenu').get(0);
      //console.log(menu);
      //console.log(left);
      // console.log(top);

      let ht=window.innerHeight;
      let space=ht-($(menu).height()+e.pageY);
      let top=Math.min(this.offsetTop,space);
      $(menu).css({
        top: top,
        left: this.offsetWidth
      });
       //console.log('spaceleft:'+space);
       //console.log('window.innerHeight'+window.innerHeight);

      $(menu).addClass("show");



    });


  },
  unsubscribe: function(el) {

    $(el).off('.data_dropdownBinding');
  }
});

Shiny.inputBindings.register(data_dropdownBinding, "shiny.data_dropdown");




