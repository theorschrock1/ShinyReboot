#' create an ace token.
#' \code{create_ace_token} returns a list for use in the function set_ace_tokens
#'
#' Tokenizing allows for custom sythax highlighting in an ace editor. If a value is matched by the regex pattern, a css class will be added to the div containing the token within the editor.  The css class will be equal to \code{'ace_' + token_name}.
#'
#' @name create_ace_token
#' @param name  \code{[string]} Token name. The token name can add multiple css classes if separated by periods. For example, \code{'identity.date.time'} will add css classes \code{'ace_identity ace_date ace_time'}.
#' @param values  \code{[character]} a character vector of string patterns to match.
#' @param escape  \code{[logical]}  should the values be escaped? Must have an exact length of \code{1}.  Defaults to \code{TRUE}.
#' @return \code{create_ace_token}: \code{[list(token=string(),regex=string())]}
#' @examples
#'  create_ace_token(
#'    name = 'variables',
#'    values = c('V(1)', 'V(2)','V(3)'),
#'    escape = TRUE
#'  )
#'  create_ace_token(
#'    name = 'functions',
#'    values = paste0(
#'      c('SUM',MIN', 'MAX'), followed_by('\\(')),
#'    escape = FALSE
#'  )
#' @export
create_ace_token <- function(name, values, escape = TRUE) {
    # create an ace token
    assert_string(name)
    assert_character(values)
    assert_logical(escape, len = 1)
    if (escape)
        values <- str_escape(values)
    list(token = name, regex = values %sep% "|")
    # Returns: \code{[list(token=string(),regex=string())]}
}
