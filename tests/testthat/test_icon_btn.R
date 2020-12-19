test_that("icon_btn", {
  local_edition(3)
  expect_snapshot(icon_btn(inputId = "hi", icon = "pencil", toggleId = NULL), cran = TRUE)
  expect_snapshot(icon_btn(inputId = "hi", icon = "pencil", toggleId = "model"), cran = TRUE)
  expect_snapshot(icon_btn(inputId = "hi", icon = "pencil", toggleId = "model", tooltip = "launch model",
    size = "md"), cran = TRUE)
})
