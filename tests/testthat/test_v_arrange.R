test_that("v_arrange", {
  local_edition(3)
  expect_snapshot(v_arrange(justify = "around", align = "center"), cran = TRUE)
  expect_snapshot(v_arrange(justify = "start", align = "start"), cran = TRUE)
})
