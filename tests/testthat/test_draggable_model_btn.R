test_that("draggable_model_btn", {
  local_edition(3)
  expect_snapshot(draggable_model_btn(inputId = "drag_btn", toggleId = "drag", "Show"),
  cran = TRUE)
  expect_snapshot(draggable_model_btn(inputId = "drag_btn", toggleId = "drag", "Show",
    outerTag = "div"), cran = TRUE)
})
