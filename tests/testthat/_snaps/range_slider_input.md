# range_slider_input

    Code
      range_slider_input(inputId = "myid", label = NULL, min = 0, max = 100,
        lower_val = 0, upper_val = 100, prefix = NULL, suffix = "%", signif = 4)
    Output
      <div class="ao-range-slider d-flex flex-column w-100" data-digits="5" data-lower="0" data-max="100" data-min="0" data-suffix="%" data-upper="100" id="inputId">
        <div class="d-flex flex-row px-1 ao-range-label w-100 align-items-center justify-content-start">
          <span class="pl-1 label-units"></span>
        </div>
        <div class="d-flex flex-row mb-2">
          <div id="myid_min_input" class="edit-numeric flex-fill range-min text-left">10,000%</div>
          <div id="myid_max_input" class="edit-numeric range-max flex-fill  text-right">10,000%</div>
        </div>
        <div class="d-flex flex-row px-1">
          <div class="form-group shiny-input-container">
            <label class="control-label shiny-label-null" for="myid_range_slider"></label>
            <input class="js-range-slider" id="myid_range_slider" data-type="double" data-min="0" data-max="100" data-from="0" data-to="100" data-step="1" data-grid="false" data-grid-snap="false" data-prettify-separator="," data-prettify-enabled="true" data-keyboard="true" data-drag-interval="true" data-data-type="number"/>
          </div>
        </div>
      </div>

