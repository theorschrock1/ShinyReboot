test_that("create_ace_token", {
  local_edition(3)
  expect_snapshot(create_ace_token(name = "variables", values = c(
    "V(1)", "V(2)", "V(3)"), escape = TRUE), cran = TRUE)
  expect_snapshot(create_ace_token(name = "functions", values = paste0(
    c("SUM", "MIN", "MAX"), followed_by("\\(")), escape = FALSE),
  cran = TRUE)
})
