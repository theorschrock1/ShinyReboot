test_that("dropdown_checkbox", {
  local_edition(3)
  expect_snapshot(dropdown_checkbox(inputId = "filter", value = FALSE, label = "Show Filter"), cran = TRUE)
})
