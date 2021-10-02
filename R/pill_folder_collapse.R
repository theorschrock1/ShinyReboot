#' @export
pill_folder_collapse <- function(..., inputId, label, open = FALSE, open_icon ="folder-open" ,
                            closed_icon ="folder" ) {
  # Create a collapsible folder
  assert_string(inputId)
  assert_string(label, null.ok = TRUE)
  assert_logical(open, len = 1)
  assert_string(open_icon, null.ok = TRUE)
  assert_string(closed_icon, null.ok = TRUE)
  collapse = "collapse"
  content <- div(id = paste0(inputId, "collapse"), class = collapse, ...)
  is_collasped=" collapsed"
  if(open)is_collasped=""
  tagList(icon_toggler(
    inputId = inputId,
    value = open,
    icon_false = closed_icon,
    icon_true = open_icon,
    class = glue("d-flex flex-row pill-item pill-folder align-items-center{is_collasped}"),
    icon_class='pill-data-icon',
    `data-toggle` = "collapse",
    `aria-expanded` = js_logical(open),
    `data-target` = paste0("#", inputId, "collapse"),
    div(class='pill-area d-flex flex-fill',
    div(class = "folder-label pill-label flex-fill",`data-id`=str_remove(inputId,"_folder$"),label)
  )), content)
  # Returns: \code{[html]}
}

