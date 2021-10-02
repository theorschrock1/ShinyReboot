var draggableModelBinding = new Shiny.InputBinding();

$.extend(draggableModelBinding, {
  find: function(scope) {
    return $(scope).find(".draggableModel");
  },
  initialize: function(el) {


  function dragElement(elmnt_id) {
  elmnt=document.getElementById(elmnt_id);
  var pos1 = 0,
      pos2 = 0,
      pos3 = 0,
      pos4 = 0;
   console.log(elmnt);
  if ($(`#${elmnt.id} .drag-handle`).length>0) {
     //if present, the header is where you move the DIV from:
   let handle=elmnt.getElementsByClassName('drag-handle')[0];
   console.log(handle);
   handle.onmousedown = dragMouseDown;

  } else {
    // otherwise, move the DIV from anywhere inside the DIV:
    elmnt.onmousedown = dragMouseDown;
  }

  function dragMouseDown(e) {
    e = e || window.event;
    e.preventDefault();
    // get the mouse cursor position at startup:
    pos3 = e.clientX;
    pos4 = e.clientY;
    document.onmouseup = closeDragElement;
    // call a function whenever the cursor moves:
    document.onmousemove = elementDrag;
  }

  function elementDrag(e) {
    e = e || window.event;
    e.preventDefault();
    // calculate the new cursor position:
    pos1 = pos3 - e.clientX;
    pos2 = pos4 - e.clientY;
    pos3 = e.clientX;
    pos4 = e.clientY;
    var wd=window.innerWidth,ht=window.innerHeight;

    elmnt.style.top = Math.max(0, Math.min((ht-elmnt.offsetHeight)/ht*100,(elmnt.offsetTop - pos2)/ht*100))+"%";
    elmnt.style.left= Math.max(0, Math.min((wd-elmnt.offsetWidth)/wd*100,(elmnt.offsetLeft - pos1)/wd*100))+"%";

  }

  function closeDragElement() {
    // stop moving when mouse button is released:
    document.onmouseup = null;
    document.onmousemove = null;
  }


}

  dragElement(el.id);
  },
  getId: function(el) {
    return el.id;
  },
  getValue: function(el) {
     var elem=document.getElementById(el.id);

    return {left: elem.style.left,top:elem.style.top,hidden:$(el).hasClass('d-none')}

  },
  setValue: function(el, value) {
     var elem=document.getElementById(el.id);

     if(value.hasOwnProperty('top')){
        elem.style.top = value.top + "%";
       }
     if(value.hasOwnProperty('left')){
        elem.style.left = value.left+ "%";
       }
     if(value.hasOwnProperty('show')){
       if(value.show){

        $(el).removeClass('d-none');

        }else{

        $(el).addClass('d-none');
       }
     }
  },
  receiveMessage: function(el, data) {

    this.setValue(el, data);


  },
    getState: function (el) {
    // Store options in an array of objects, each with with value and label
    },
  getRatePolicy: function(){
    return {
      policy: "debounce",
      delay: 250
    };
  },
  subscribe: function(el, callback) {
    /*register shiny events
    var inputId = el.id;
    $(el).on('click', function(e) {
      callback();
    });
    */
    $(el).on('click',
    function(e) {
      callback();
    });

  },
  unsubscribe: function(el) {

    $(el).off('.draggableModelBinding');
  }
});

Shiny.inputBindings.register(draggableModelBinding, "shiny.draggableModel");
