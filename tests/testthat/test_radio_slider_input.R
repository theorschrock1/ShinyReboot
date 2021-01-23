test_that("radio_slider_input", {
  local_edition(3)
  expect_snapshot(radio_slider_input(inputId = "myid", choices = names(mtcars)), cran = TRUE)
})
