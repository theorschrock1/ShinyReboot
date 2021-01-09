test_that("color_seq", {
  local_edition(3)
  expect_snapshot(color_seq(colors = c("white", "purple"), from = 0.25, to = 1, length = 3),
  cran = TRUE)
})
