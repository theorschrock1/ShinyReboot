test_that("ao_sheet", {
  local_edition(3)
  expect_snapshot(ao_sheet(inputId = "myid"), cran = TRUE)
})
