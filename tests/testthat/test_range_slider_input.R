test_that("range_slider_input", {
  local_edition(3)
  expect_snapshot(range_slider_input(inputId = "myid", label = NULL, min = 0, max = 100,
    lower_val = 0, upper_val = 100, prefix = NULL, suffix = "%", signif = 4), cran = TRUE)
})
