test_that("checkbox_group_input", {
  local_edition(3)
  expect_snapshot(checkbox_group_input(inputId = "myid", label = "label",
    choices = names(mtcars)), cran = TRUE)
})
