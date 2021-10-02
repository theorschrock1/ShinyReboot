
filter_head=function(inputId,label, clear_filter = TRUE, search = TRUE, options_dropdown = TRUE){
  ms = function(x) paste0(inputId, "-", x)
  clear_filter_btn = NULL
  if (clear_filter)
    clear_filter_btn <- icon_btn(ms("clear_filter"), "filter-remove", class = "mdi-sm py-0 text-secondary filter-remove")
  show_search_btn = NULL
  if (search)
    show_search_btn <- icon_btn(ms("show_search"), "magnify", class = glue("{ifelse(search==FALSE,'d-none ','')}mdi-sm mag-btn py-0"))
  dropdown_btn = NULL
  if (options_dropdown)
    dropdown_btn <- icon_btn(ms("options"), "menu-down", class = "mdi-sm menu-btn py-0")
  toolbarBtnGroup = NULL
  if (nnull(c(clear_filter_btn,show_search_btn,dropdown_btn )))
    toolbarBtnGroup <- div(class = "btn-group", clear_filter_btn, show_search_btn,dropdown_btn )

  h_arrange(class='filter-header',align = "baseline", span(class = "align-self-end mr-auto checkbox-group-label",label), toolbarBtnGroup) %>% attachDependencies(html_dependency_filter_header(),append=TRUE)
}
