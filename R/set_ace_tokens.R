#' Set highlighting tokens for an ace editor.

#' @name set_ace_tokens
#' @param inputId  \code{[string]} ace editor input id.
#' @param tokens  \code{[list]} an unnamed list with structure:\code{list(list(token='tokenname',regex='pattern'),list(token='tokenname',regex='pattern'),...))}
#' @param as_is  \code{[logical]}  If TRUE, use the ID as-is even when inside a module (instead of adding the namespace prefix to the ID). Must have an exact length of \code{1}.  Defaults to \code{FALSE}
#' @param session  \code{[NULL]}  Defaults to \code{getDefaultReactiveDomain()}.
#' @return \code{set_ace_tokens}: \code{[invisible(NULL)]}
#' @examples
#' set_ace_tokens(inputId='ace_id',tokens=list(list(token='token_name1',regex='one|two|three'),list(token='token_name1',regex='a|b|c')))
#'  if(interactive()){
#'  library("shiny")
#'  library("ShinyReboot")
#'  library("bslib")
#'  bs_global_theme()
#'  ui <- fluidPage(
#'  bs_theme_dependencies(theme = bs_global_get()),
#'
#'  tags$h1("Ace Editor: Custom sythax highligher"),
#'  ace_editor('editor',mode='r',value='ifelse(cut=="ideal",max(price),min(price))'),
#'  actionButton('set_tokens','set custom tokens')
#'  )
#'
#'  server = function(input, output, session) {
#'
#'  observeEvent(input$set_tokens,{
#'  req(input$set_tokens)
#'  library(ggplot2)
#'  diamonds=data.table(diamonds)
#'  fn=function(x){is(x,'integer')|is(x,'numeric')}
#'
#'  c(nums,identity)%<-%
#'  split_vec(names(diamonds),unlist(sapply(diamonds,fn )))
#'
#'  functions = paste0(c('sum', 'min', 'max'), followed_by('\\('))
#'  tokens=c(
#'  map2(
#'  c('measure', 'dimension'),
#'  list(nums, identity),
#'  create_ace_token,
#'  escape = TRUE
#'  ),list(create_ace_token('function',functions,escape = FALSE)))
#'
#'  set_ace_tokens('editor',tokens = tokens)
#'  })
#'
#'  }
#'  shinyApp(ui = ui, server = server)
#'  }
#' @export
set_ace_tokens <- function(inputId, tokens, as_is = FALSE, session = getDefaultReactiveDomain()) {
    # Set highlighting tokens for an ace editor
    assert_string(inputId)
    assert_list(tokens)
    assert_logical(as_is, len = 1)
    if(nlen0(names( tokens)))
        g_stop('parameter `token` must be an unnamed list')

    lapply(tokens, function(x) {
        assert_named_list(x, structure = list(token = string(), regex = string()))
    })
    if (!as_is)
        inputId = session$ns(inputId)
    params <- toJSON(list(id = inputId, tokens = tokens), auto_unbox = TRUE)
    #print(params)
    session$sendCustomMessage("set-ace-tokens", params)
    # Returns: \code{[invisible(NULL)]}
}

