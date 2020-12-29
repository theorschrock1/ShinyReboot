test_that("dropdown_button", {
  local_edition(3)
  expect_snapshot(dropdown_button(inputId = "edit", label = "Edit..."), cran = TRUE)
})
