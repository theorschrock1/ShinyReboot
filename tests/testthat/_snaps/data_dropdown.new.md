# data_dropdown

    Code
      data_dropdown(dropdown_button(inputId = "edit", label = "Edit..."),
      dropdown_checkbox(inputId = "filter", value = FALSE, label = "Show Filter"),
      dropdown_radio_group(inputId = "radio_nformat", options = c("currency",
        "percentage", "float", "integer"), labels = c("currency", "percentage",
        "float", "integer")), dropdown_submenu(label = "Units", dropdown_radio_group(
        inputId = "radio_units", labels = c("duration", "distance", "mass", "speed"),
        options = c("duration", "distance", "mass", "speed"))), inputId = "myid",
      handle_class = "dropdown-handle", target_class = "pill-item")
    Output
      <div class="dropdown-menu data_dropdown context-menu shadow" aria-labelledby="myid" data-for="pill-item" id="myid" data-handle="dropdown-handle">
        <div class="btn-group-toggle dropdown-group">
          <div id="action_edit" role="button" class="btn dropdown-item dropdown-btn  action-item">
            <span class="mdi mdi-check-bold icon-left"></span>
            <span class="dropdown-label">Edit...</span>
            <span class="mdi mdi-menu-right float-right icon-right"></span>
          </div>
        </div>
        <div id="checkbox_filter" class="btn-group-toggle dropdown-group ao-check-button" data-toggle="buttons">
          <div role="button" class="btn dropdown-item dropdown-btn  input-item">
            <input type="checkbox" name="checkbox_filter"/>
            <span class="mdi mdi-check-bold icon-left"></span>
            <span class="dropdown-label">Show Filter</span>
            <span class="mdi mdi-menu-right float-right icon-right"></span>
          </div>
        </div>
        <div id="radio_nformat" class="btn-group-toggle dropdown-group ao-radio-button-grp" data-toggle="buttons"><div role="button" class="btn dropdown-item input-item dropdown-btn">
        <input type="radio" name="radio_nformat" id="currency" value="currency">
      <span class="mdi mdi-checkbox-blank-circle icon-left"></span><span class='dropdown-label'>currency</span><span class="mdi mdi-menu-right float-right icon-right"></span></div>
      <div role="button" class="btn dropdown-item input-item dropdown-btn">
        <input type="radio" name="radio_nformat" id="percentage" value="percentage">
      <span class="mdi mdi-checkbox-blank-circle icon-left"></span><span class='dropdown-label'>percentage</span><span class="mdi mdi-menu-right float-right icon-right"></span></div>
      <div role="button" class="btn dropdown-item input-item dropdown-btn">
        <input type="radio" name="radio_nformat" id="float" value="float">
      <span class="mdi mdi-checkbox-blank-circle icon-left"></span><span class='dropdown-label'>float</span><span class="mdi mdi-menu-right float-right icon-right"></span></div>
      <div role="button" class="btn dropdown-item input-item dropdown-btn">
        <input type="radio" name="radio_nformat" id="integer" value="integer">
      <span class="mdi mdi-checkbox-blank-circle icon-left"></span><span class='dropdown-label'>integer</span><span class="mdi mdi-menu-right float-right icon-right"></span></div></div>
        <div class="btn-group-toggle dropdown-group dropright" id="action_submenu_units">
          <div id="units" role="button" class="btn dropdown-item dropdown-btn submenu" aria-haspopup ="true"  aria-expanded="false" >
      <span class="mdi mdi-check-bold icon-left"></span><span class='dropdown-label'>Units</span><span class="mdi mdi-menu-right float-right icon-right"></span></div>
          <div class="dropdown-menu submenu shadow" aria-labelledby="units">
            <div id="radio_units" class="btn-group-toggle dropdown-group ao-radio-button-grp" data-toggle="buttons"><div role="button" class="btn dropdown-item input-item dropdown-btn">
        <input type="radio" name="radio_units" id="duration" value="duration">
      <span class="mdi mdi-checkbox-blank-circle icon-left"></span><span class='dropdown-label'>duration</span><span class="mdi mdi-menu-right float-right icon-right"></span></div>
      <div role="button" class="btn dropdown-item input-item dropdown-btn">
        <input type="radio" name="radio_units" id="distance" value="distance">
      <span class="mdi mdi-checkbox-blank-circle icon-left"></span><span class='dropdown-label'>distance</span><span class="mdi mdi-menu-right float-right icon-right"></span></div>
      <div role="button" class="btn dropdown-item input-item dropdown-btn">
        <input type="radio" name="radio_units" id="mass" value="mass">
      <span class="mdi mdi-checkbox-blank-circle icon-left"></span><span class='dropdown-label'>mass</span><span class="mdi mdi-menu-right float-right icon-right"></span></div>
      <div role="button" class="btn dropdown-item input-item dropdown-btn">
        <input type="radio" name="radio_units" id="speed" value="speed">
      <span class="mdi mdi-checkbox-blank-circle icon-left"></span><span class='dropdown-label'>speed</span><span class="mdi mdi-menu-right float-right icon-right"></span></div></div>
          </div>
        </div>
      </div>

