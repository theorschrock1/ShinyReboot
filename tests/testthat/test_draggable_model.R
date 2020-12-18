test_that("draggable_model", {
  local_edition(3)
  expect_snapshot(draggable_model(inputId = "drag", left = 10, top = 10, width = "30%"),
  cran = TRUE)
  expect_snapshot(draggable_model(inputId = "drag", class = "myModel", left = 10, top = 10,
    width = "30%", div("someContent")), cran = TRUE)
  expect_snapshot(draggable_model(inputId = "drag", left = 100, top = 10, width = "30px"),
  cran = TRUE)
  expect_snapshot(draggable_model(inputId = "drag", left = 120, top = 10, width = "30%"),
  cran = TRUE)
})
