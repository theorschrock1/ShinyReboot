test_that("filter_shelf", {
  local_edition(3)
  expect_snapshot(filter_shelf(inputId = "sd"), cran = TRUE)
})
