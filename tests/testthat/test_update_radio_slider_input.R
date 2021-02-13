test_that("update_radio_slider_input", {
  local_edition(3)
  expect_snapshot(update_radio_slider_input(inputId = "myid", range = LETTERS,
    label = "new_label", selected = "A"), cran = TRUE)
})
