var standard_dropdownBinding = new Shiny.InputBinding();

$.extend(standard_dropdownBinding, {
  find: function(scope) {
    return $(scope).find(".standard_dropdown");
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

      if(dataHandle!=''){
      let tmp= $(this).parents(dataClass).get(0);
      var $this=$(tmp);
      var top=e.pageY;
      var left=e.pageX;
      }else {
      var $this= $(this);
      var top=this.offsetTop+this.offsetHeight;
      var left=this.offsetLeft;
      var wd=this.offsetWidth;
      }

      let ht=window.innerHeight;
      let space=ht-top-20;


      $(el).css({
        top: top,
        left: left,
        'max-height':space,
        'overflow-y':'hidden'
      });





      $(el).data('id',$this.attr('id'));
      $(el).addClass("show");
      var scr=$(el).find('.scroll-content').get(0);
      var nscr=$(el).find('.non-scroll-content').get(0);
       /*console.log('$(nscr).height():'+$(nscr).height());
       console.log('nscr.offsetHeight:'+nscr.offsetHeight);
       console.log('nscr.offsetTop:'+nscr.offsetTop);
       console.log('scr.offsetTop:'+scr.offsetTop);*/
      var scroll_space=space-scr.offsetTop;
      $(scr).css({
        'max-height':scroll_space,
        'overflow-y':'auto'
      });
      return false;
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

    $(el).off('.standard_dropdownBinding');
  }
});

Shiny.inputBindings.register(standard_dropdownBinding, "shiny.standard_dropdown");
