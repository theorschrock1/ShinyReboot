# icon_toggler

    Code
      icon_toggler(inputId = "myid", value = FALSE, icon_false = "folder-outline",
        icon_true = "folder-open-outline")
    Output
      <span class="mdi mdi-folder-outline icon-toggler" data-icon-on="folder-open-outline" data-value="false" id="myid"></span>

---

    Code
      icon_toggler(inputId = "myid", value = TRUE, icon_false = "folder-outline",
        icon_true = "folder-open-outline", class = "icon-sm")
    Output
      <span class="mdi mdi-folder-outline icon-sm icon-toggler folder-open-outline" data-icon-on="folder-open-outline" data-value="true" id="myid"></span>

