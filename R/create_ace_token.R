#' create an ace token.

#' @name create_ace_token
#' @param name  \code{[string]}
#' @param values  \code{[character]}
#' @param escape  \code{[logical]}  Must have an exact length of \code{1}.  Defaults to \code{TRUE}
#' @return \code{create_ace_token}: \code{[list(token=string(),regex=string())]}
#' @examples

#'  create_ace_token(name = 'variables', values = c('V(1)', 'V(2)',
#'  'V(3)'), escape = TRUE)
#'  create_ace_token(name = 'functions', values = paste0(c('SUM',
#'  'MIN', 'MAX'), followed_by('\\(')), escape = FALSE)
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
