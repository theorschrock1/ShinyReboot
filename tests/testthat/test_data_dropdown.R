test_that("data_dropdown", {
  local_edition(3)
  expect_snapshot(data_dropdown(dropdown_button(inputId = "edit", label = "Edit..."), dropdown_checkbox(
    inputId = "filter", value = FALSE, label = "Show Filter"), dropdown_radio_group(inputId = "radio_nformat",
    options = c("currency", "percentage", "float", "integer"), labels = c("currency", "percentage",
      "float", "integer")), dropdown_submenu(label = "Units", dropdown_radio_group(inputId = "radio_units",
    labels = c("duration", "distance", "mass", "speed"), options = c("duration", "distance", "mass",
      "speed"))), inputId = "myid", handle_class = "dropdown-handle", target_class = "pill-item"), cran = TRUE)
})
