test_that("icon_toggler", {
  local_edition(3)
  expect_snapshot(icon_toggler(inputId = "myid", value = FALSE, icon_false = "folder-outline",
    icon_true = "folder-open-outline"), cran = TRUE)
  expect_snapshot(icon_toggler(inputId = "myid", value = TRUE, icon_false = "folder-outline",
    icon_true = "folder-open-outline", class = "icon-sm"), cran = TRUE)
})
