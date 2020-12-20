test_that("h_arrange", {
  local_edition(3)
  expect_snapshot(h_arrange(justify = "around", align = "center"), cran = TRUE)
  expect_snapshot(h_arrange(justify = "start", align = "start"), cran = TRUE)
})
