#Render an Ace editor
#' @inheritParams aceEditor
#'
#' @export
ace_editor = function(outputId,
                      value,
                      mode,
                      theme,
                      vimKeyBinding = FALSE,
                      readOnly = FALSE,
                      height = "400px",
                      fontSize = 12,
                      debounce = 1000,
                      wordWrap = FALSE,
                      showLineNumbers = TRUE,
                      highlightActiveLine = TRUE,
                      selectionId = NULL,
                      cursorId = NULL,
                      hotkeys = NULL,
                      code_hotkeys = NULL,
                      autoComplete = c("disabled",
                                       "enabled", "live"),
                      autoCompleters = c("snippet", "text", "keyword"),
                      autoCompleteList = NULL,
                      tabSize = 4,
                      useSoftTabs = TRUE,
                      showInvisibles = FALSE,
                      setBehavioursEnabled = TRUE,
                      autoScrollEditorIntoView = FALSE,
                      maxLines = NULL,
                      minLines = NULL,
                      placeholder = NULL,
                      css_dependency=html_dependency_ace_highlighter()){
  args<-drop_nulls(args2list())
  args$css_dependency=NULL

  if(nnull(css_dependency)){
assert_class( css_dependency,'html_dependency')
  }

editor<-expr_eval(shinyAce::aceEditor(!!!args))
htmlDependencies(editor) <-
  list(html_dependency_ace_editor(), css_dependency)
editor
  }
