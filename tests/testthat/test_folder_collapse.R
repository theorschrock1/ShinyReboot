test_that("folder_collapse", {
  local_edition(3)
  expect_snapshot(folder_collapse(inputId = "myid", label = "folder1", div("one"), div(
    "two")), cran = TRUE)
})
