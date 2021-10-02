
$(document).ready(function() {

/*function dragElement(elmnt) {
  var pos1 = 0,
      pos2 = 0,
      pos3 = 0,
      pos4 = 0

  if ($(`#${elmnt.id} .handle`)) {
    // if present, the header is where you move the DIV from:
    $(`#${elmnt.id} .handle`).onmousedown = dragMouseDown;
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


}*/
$('.toggle-draggable-model').click(function(){

    var toggleid=$(this).data('toggle-model');
    var el=document.getElementById(toggleid);
    el.style.top =$(el).data('top')+"%";
    el.style.left =$(el).data('left')+"%";
    $(el).toggleClass('d-none');
    $(el).trigger('click');
    });

});
