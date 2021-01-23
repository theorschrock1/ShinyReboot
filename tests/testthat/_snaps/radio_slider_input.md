# radio_slider_input

    Code
      radio_slider_input(inputId = "myid", choices = names(mtcars))
    Output
      <div class="ao-radio-slider d-flex flex-column w-100 w-100" data-value="(All)" id="myid">
        <div class="d-flex flex-row px-1 ao-range-label w-100 align-items-center justify-content-start">
          <span class="pl-1 label-units"></span>
        </div>
        <div class="d-flex flex-row mb-3 w-100 px-2 border">
          <div id="myid_max_input" class="edit-numeric range-max flex-fill w-100">(All)</div>
        </div>
        <div class="d-flex flex-row px-1">
          <div class="form-group shiny-input-container">
            <label class="control-label shiny-label-null" for="myid_range_slider"></label>
            <input class="js-range-slider" id="myid_range_slider" data-min="0" data-max="1" data-from="NA" data-step="1" data-grid="false" data-grid-snap="false" data-prettify-separator="," data-prettify-enabled="true" data-keyboard="true" data-data-type="number"/>
          </div>
          <button class="border mx-1  shift-left icon-btn action-button btn btn-sm shadow-none btn-light" id="myid_shift_left">
            <span class="mdi mdi-chevron-left"></span>
          </button>
          <button class="border mr-1 shift-right icon-btn action-button btn btn-sm shadow-none btn-light" id="myid_shift_right">
            <span class="mdi mdi-chevron-right"></span>
          </button>
        </div>
        <script>{"values":["(All)","mpg","cyl","disp","hp","drat","wt","qsec","vs","am","gear","carb"]}</script>
      </div>

