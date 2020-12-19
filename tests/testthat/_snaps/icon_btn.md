# icon_btn

    Code
      icon_btn(inputId = "hi", icon = "pencil", toggleId = NULL)
    Output
      <button id="hi" class="icon-btn action-button btn btn-sm shadow-none btn-light">
        <span class="mdi mdi-pencil "></span>
      </button>

---

    Code
      icon_btn(inputId = "hi", icon = "pencil", toggleId = "model")
    Output
      <button id="hi" class="icon-btn action-button btn btn-sm shadow-none btn-light toggle-draggable-model" data-toggle-model="model">
        <span class="mdi mdi-pencil "></span>
      </button>

---

    Code
      icon_btn(inputId = "hi", icon = "pencil", toggleId = "model", tooltip = "launch model",
        size = "md")
    Output
      <button id="hi" class="icon-btn action-button btn shadow-none btn-light toggle-draggable-model" data-toggle-model="model" title="launch model" data-toggle="tooltip">
        <span class="mdi mdi-pencil "></span>
      </button>

