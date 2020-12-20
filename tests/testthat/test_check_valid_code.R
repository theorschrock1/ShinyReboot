test_that("check_valid_code", {
  local_edition(3)
  x = "SUM(X)"
  expect_snapshot(check_valid_code("SUM(X)", null.ok = FALSE), cran = TRUE)
  expect_snapshot(check_valid_code("SUMX)", null.ok = FALSE), cran = TRUE)
  expect_snapshot(check_valid_code("SUM(X){", null.ok = FALSE), cran = TRUE)
  expect_snapshot(check_valid_code("SUM(X){}", null.ok = FALSE), cran = TRUE)
  expect_snapshot(check_valid_code("SUM(X){\"}", null.ok = FALSE), cran = TRUE)
  expect_snapshot(check_valid_code("SUM(X{\"]", null.ok = FALSE), cran = TRUE)
})
