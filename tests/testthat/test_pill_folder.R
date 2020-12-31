test_that("pill_folder", {
  local_edition(3)
  expect_snapshot(pill_folder(folder_id = "folder_id", folder_name = "Sales Data", pill_items = pill_item(
    id = c("sales1", "transactions1", "traffic1", "basket_size1"), label = c("sales",
      "transactions", "traffic", "basket size"), data = list(nformat = c("currency", "integer",
      "integer", NA), filter = c(TRUE, FALSE, NA, FALSE), edit = c(NA, 0, 0, 0), submenu_units = c(
      0, 0, 0, NA))), sortable_group = "measures"), cran = TRUE)
})
