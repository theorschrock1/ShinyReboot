# checkbox_group_input

    Code
      checkbox_group_input(inputId = "myid", label = "label", choices = names(mtcars))
    Output
      <div class="d-flex flex-column ao-checkbox-group w-100 h-100 checklist" id="myid">
        <div class="d-flex flex-row  w-100 align-items-baseline justify-content-around">
          <span class="align-self-end mr-auto checkbox-group-label">label</span>
          <div class="btn-group">
            <button class="mdi-sm py-0 text-secondary filter-remove icon-btn action-button btn btn-sm shadow-none btn-light" id="myid-clear_filter">
              <span class="mdi mdi-filter-remove"></span>
            </button>
            <button class="mdi-sm menu-btn py-0 icon-btn action-button btn btn-sm shadow-none btn-light" id="myid-options">
              <span class="mdi mdi-menu-down"></span>
            </button>
            <button class="mdi-sm mag-btn py-0 icon-btn action-button btn btn-sm shadow-none btn-light" id="myid-show_search">
              <span class="mdi mdi-magnify"></span>
            </button>
          </div>
        </div>
        <div class="mb-1 border search-box  d-none">
          <input id="myid-search" type="text" class="form-control form-control-sm border-0 shadow-none" placeholder="Search"/>
          <button class="mdi-sm mag-btn py-0 icon-btn action-button btn btn-sm shadow-none btn-light" id="myid-hide_search">
            <span class="mdi mdi-close"></span>
          </button>
        </div>
        <div class="d-flex flex-row btn-group w-100 align-items-center justify-content-around">
          <div class="btn btn-sm btn-light btn-all py-0 w-50 border">All</div>
          <div class="btn btn-sm w-50 btn-none btn-light py-0  border">None</div>
        </div>
        <div class="d-flex flex-column p-1 h-100 checkgroup">
          <div class="d-flex flex-row checkbox-row p-0 w-100 align-items-center justify-content-start">
            <div class=" checkbox checked">
              <span class="mdi mdi-checkbox-blank-outline mdi-lg"></span>
              <span class="mdi mdi-check-box-outline mdi-lg"></span>
            </div>
            <div class="ml-2 flex-fill check-label">mpg</div>
          </div>
          <div class="d-flex flex-row checkbox-row p-0 w-100 align-items-center justify-content-start">
            <div class=" checkbox checked">
              <span class="mdi mdi-checkbox-blank-outline mdi-lg"></span>
              <span class="mdi mdi-check-box-outline mdi-lg"></span>
            </div>
            <div class="ml-2 flex-fill check-label">cyl</div>
          </div>
          <div class="d-flex flex-row checkbox-row p-0 w-100 align-items-center justify-content-start">
            <div class=" checkbox checked">
              <span class="mdi mdi-checkbox-blank-outline mdi-lg"></span>
              <span class="mdi mdi-check-box-outline mdi-lg"></span>
            </div>
            <div class="ml-2 flex-fill check-label">disp</div>
          </div>
          <div class="d-flex flex-row checkbox-row p-0 w-100 align-items-center justify-content-start">
            <div class=" checkbox checked">
              <span class="mdi mdi-checkbox-blank-outline mdi-lg"></span>
              <span class="mdi mdi-check-box-outline mdi-lg"></span>
            </div>
            <div class="ml-2 flex-fill check-label">hp</div>
          </div>
          <div class="d-flex flex-row checkbox-row p-0 w-100 align-items-center justify-content-start">
            <div class=" checkbox checked">
              <span class="mdi mdi-checkbox-blank-outline mdi-lg"></span>
              <span class="mdi mdi-check-box-outline mdi-lg"></span>
            </div>
            <div class="ml-2 flex-fill check-label">drat</div>
          </div>
          <div class="d-flex flex-row checkbox-row p-0 w-100 align-items-center justify-content-start">
            <div class=" checkbox checked">
              <span class="mdi mdi-checkbox-blank-outline mdi-lg"></span>
              <span class="mdi mdi-check-box-outline mdi-lg"></span>
            </div>
            <div class="ml-2 flex-fill check-label">wt</div>
          </div>
          <div class="d-flex flex-row checkbox-row p-0 w-100 align-items-center justify-content-start">
            <div class=" checkbox checked">
              <span class="mdi mdi-checkbox-blank-outline mdi-lg"></span>
              <span class="mdi mdi-check-box-outline mdi-lg"></span>
            </div>
            <div class="ml-2 flex-fill check-label">qsec</div>
          </div>
          <div class="d-flex flex-row checkbox-row p-0 w-100 align-items-center justify-content-start">
            <div class=" checkbox checked">
              <span class="mdi mdi-checkbox-blank-outline mdi-lg"></span>
              <span class="mdi mdi-check-box-outline mdi-lg"></span>
            </div>
            <div class="ml-2 flex-fill check-label">vs</div>
          </div>
          <div class="d-flex flex-row checkbox-row p-0 w-100 align-items-center justify-content-start">
            <div class=" checkbox checked">
              <span class="mdi mdi-checkbox-blank-outline mdi-lg"></span>
              <span class="mdi mdi-check-box-outline mdi-lg"></span>
            </div>
            <div class="ml-2 flex-fill check-label">am</div>
          </div>
          <div class="d-flex flex-row checkbox-row p-0 w-100 align-items-center justify-content-start">
            <div class=" checkbox checked">
              <span class="mdi mdi-checkbox-blank-outline mdi-lg"></span>
              <span class="mdi mdi-check-box-outline mdi-lg"></span>
            </div>
            <div class="ml-2 flex-fill check-label">gear</div>
          </div>
          <div class="d-flex flex-row checkbox-row p-0 w-100 align-items-center justify-content-start">
            <div class=" checkbox checked">
              <span class="mdi mdi-checkbox-blank-outline mdi-lg"></span>
              <span class="mdi mdi-check-box-outline mdi-lg"></span>
            </div>
            <div class="ml-2 flex-fill check-label">carb</div>
          </div>
        </div>
      </div>

