test_that("update_range_slider_input", {
  local_edition(3)
  expect_snapshot(update_range_slider_input(inputId = "myid", lower_val = 4,
    upper_val = 5, range = c(0, 10), label = "new_label", signif = 4, prefix = "$"),
  cran = TRUE)
})
