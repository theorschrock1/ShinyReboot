test_that("add_editable_class", {
  local_edition(3)
  expect_snapshot(add_editable_class(inputId = "myid", editable_class = "pill-item", assert_unique = TRUE),
  cran = TRUE)
  expect_snapshot(add_editable_class(inputId = "myid", editable_class = "pill-item", assert_unique = FALSE),
  cran = TRUE)
})
