# folder_collapse

    Code
      folder_collapse(inputId = "myid", label = "folder1", div("one"), div("two"))
    Output
      <div class="d-flex flex-row mdi-md align-items-center text-center">
        <div>
          <span class="mdi mdi-chevron-right"></span>
        </div>
        <div aria-expanded="false" class="icon icon-toggler" data-icon-false="mdi-folder-open-outline" data-icon-true="mdi-folder-outline" data-target="#myidcollapse" data-toggle="collapse" data-value="false" id="myid" role="button">
          <span class="mdi mdi-folder-open-outline icon-toggle"></span>
          <span class="folder-label">folder1</span>
        </div>
      </div>
      <div id="myidcollapse" class="collapse">
        <div>one</div>
        <div>two</div>
      </div>

