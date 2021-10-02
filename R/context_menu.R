#' @export
context_menu=function(...,id,class=""){
  # Create a context menu

  assert_character(id,len = 1)
  assert_character(class,len = 1)

  assert_character(class,len = 1)
  out<-ml_dropdown(class=class,is_submenu = FALSE,
              dd_header(label="contenxtlabel",
                        id = label2id("contenxtlabel"),
                        class = "menu-text context-label",
                        carat = FALSE,
                        is_submenu = FALSE),
              dd_menu(id = id, class = glue("context-menu shadow"),add_dividers(..., type = "-")))

  attachDependencies(out,html_dependency_context_menu(),append=TRUE)
  # returns [HTML]
}
