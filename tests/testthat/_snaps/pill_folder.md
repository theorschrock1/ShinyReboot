# pill_folder

    Code
      pill_folder(folder_id = "folder_id", folder_name = "Sales Data", pill_items = pill_item(
        id = c("sales1", "transactions1", "traffic1", "basket_size1"), label = c(
          "sales", "transactions", "traffic", "basket size"), data = list(nformat = c(
          "currency", "integer", "integer", NA), filter = c(TRUE, FALSE, NA, FALSE),
        edit = c(NA, 0, 0, 0), submenu_units = c(0, 0, 0, NA))), sortable_group = "measures")
    Output
      <div class="pill-folder" data-id="Sales Data">
        <div class="d-flex flex-row mdi-md align-items-center text-center">
          <div>
            <span class="mdi mdi-chevron-right"></span>
          </div>
          <div aria-expanded="false" class="icon icon-toggler" data-icon-false="mdi-folder-outline" data-icon-true="mdi-folder-open-outline" data-target="#folder_id_foldercollapse" data-toggle="collapse" data-value="false" id="folder_id_folder" role="button">
            <span class="mdi mdi-folder-outline icon-toggle"></span>
            <span class="folder-label">Sales Data</span>
          </div>
        </div>
        <div id="folder_id_foldercollapse" class="collapse">
          <div class="pill-card-column">
            <div class="sortable-div d-flex flex-column flex-fill flex-wrap bg-transparent shelf" id="folder_id">
              <div id="sales1" data-radio_nformat="currency" data-checkbox_filter="true" data-action_edit="NA" data-action_submenu_units="0" data-id="sales1" class="pill-item pill-measure order-1">
                <span class="pill-label" data-id="sales1">sales</span>
                <span class="mdi mdi-menu-down icon-right dropdown-handle float-right"></span>
              </div>
              <div id="transactions1" data-radio_nformat="integer" data-checkbox_filter="false" data-action_edit="0" data-action_submenu_units="0" data-id="transactions1" class="pill-item pill-measure order-1">
                <span class="pill-label" data-id="transactions1">transactions</span>
                <span class="mdi mdi-menu-down icon-right dropdown-handle float-right"></span>
              </div>
              <div id="traffic1" data-radio_nformat="integer" data-checkbox_filter="NA" data-action_edit="0" data-action_submenu_units="0" data-id="traffic1" class="pill-item pill-measure order-1">
                <span class="pill-label" data-id="traffic1">traffic</span>
                <span class="mdi mdi-menu-down icon-right dropdown-handle float-right"></span>
              </div>
              <div id="basket_size1" data-radio_nformat="NA" data-checkbox_filter="false" data-action_edit="0" data-action_submenu_units="NA" data-id="basket_size1" class="pill-item pill-measure order-1">
                <span class="pill-label" data-id="basket_size1">basket size</span>
                <span class="mdi mdi-menu-down icon-right dropdown-handle float-right"></span>
              </div>
              <script type="application/json" data-for="folder_id" data-id="sortable-options">{"sort":false,"dragClass":"drag","setData":"function(dataTransfer,dragEl){console.log(dragEl.textContent);let text= dragEl.textContent;let trim_text=text.trim();if(isValidName(trim_text)){dataTransfer.setData(\"Text\",trim_text);}else{ dataTransfer.setData(\"Text\",\"`\"+trim_text+\"`\");}}","group":{"name":"measures","pull":"clone","put":false}}</script>
            </div>
          </div>
        </div>
      </div>

