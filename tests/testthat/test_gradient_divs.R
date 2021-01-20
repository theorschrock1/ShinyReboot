test_that("gradient_divs", {
  local_edition(3)
  expect_snapshot(gradient_divs(class = "flex-fill", n = 5, domain = continuous_pal(
    "Blues", n = 3), range = c(0, 4, 5)), cran = TRUE)
})
