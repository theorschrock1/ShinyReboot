test_that("discrete_pallete_picker", {
  local_edition(3)
  expect_snapshot(discrete_pallete_picker(inputId = "myid"), cran = TRUE)
})
