# draggable_model

    Code
      draggable_model(inputId = "drag", left = 10, top = 10, width = "30%")
    Output
      <div id="drag" class="draggableModel d-none" style="left:10%;top:10%;width:30%;" data-top="10" data-left="10"></div>

---

    Code
      draggable_model(inputId = "drag", class = "myModel", left = 10, top = 10,
        width = "30%", div("someContent"))
    Output
      <div class="myModel draggableModel d-none" data-left="10" data-top="10" id="drag" style="left:10%;top:10%;width:30%;">
        <div>someContent</div>
      </div>

---

    Code
      draggable_model(inputId = "drag", left = 100, top = 10, width = "30px")
    Output
      <div id="drag" class="draggableModel d-none" style="left:100%;top:10%;width:30px;" data-top="10" data-left="100"></div>

---

    Code
      draggable_model(inputId = "drag", left = 120, top = 10, width = "30%")
    Error <simpleError>
      Assertion on 'left' failed: Element 1 is not <= 100.

