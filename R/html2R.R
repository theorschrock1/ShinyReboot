#' Generate R code from raw html.

#' @name html2R
#' @param x  [character]  Must have an exact length of 1.
#' @param try_parsing  [logical]  Must have an exact length of 1.  Defaults to TRUE
#' @param silent_eval  [logical]  Try evaluating the R code? Must have an exact length of 1.  Defaults to TRUE
#' @return \code{html2R}: R code
#' @examples

#'  x = '<div class=\'btn-group\' role=\'group\' aria-label=\'Basic example\'>\n    <button type=\'button\' class=\'btn btn-secondary\'>Left</button>\n      <button type=\'button\' class=\'btn btn-secondary\'>Middle</button>\n        <button type=\'button\' class=\'btn btn-secondary\'>Right</button>\n          </div>'

#'  html2R(x)

#' @export
html2R <- function(x, try_parsing = TRUE,silent_eval=TRUE) {
    # Generate R code from raw html
    assert_character(x, len = 1)
    assert_logical(try_parsing, len = 1)
    x<-str_remove_all(x,"\n\\s+")
    tags_names <- paste0("<", names(tags)) %sep% "|"
    x=str_replace_all(x,'\'','\"')
    x=str_extract_all(x, "\\<[^/].*?\\>|[[:alnum:][:punct:]\\s]*\\</.*?\\>") %>% unlist()


    x <- str_replace_all(x, tags_names %preceding% "[\\s>]", "\\(") %>% unlist()
    x <- str_replace_all(x, "\"" %preceding% ("\\s" %nfollowed_by% "\\>"), ",")

    x[grepl('<[^/].*?\\>',x)]<-str_replace_all(x[grepl('<[^/].*?\\>',x)],"[\"\']"%preceding%("\\s"%nfollowed_by%"\\>"),",")


    x <- str_replace_all(x, "\\<\\/\\w+\\>", "</)") %>% unlist()
    x=x %>% str_split("\\<\\/")%>% unlist() %>% str_trim()
    x=x[x!=""]
    is_tag=grepl('<[^/].*?\\>',x)
    x[!grepl("<|>",x)&x!=")"]<-paste0('<spantext("',x[!grepl("<|>",x)&x!=")"],'",spantextend)')
    x[grepl(start_with("<input|<img|<hr|<link|<br|<link"), x)] <- str_replace_all(x[grepl(start_with("<input|<img|<hr|<link|<br|<link"),
        x)], "\\/?>", "\\)")
    x[grepl(ends_with("/>"), x)] <- str_replace_all(x[grepl(ends_with("/>"), x)],
        "\\/>", "\\)")
    x[is_tag]=str_replace_all(x[is_tag],"\",[[:alpha:]-]{1,40}"%preceding%'\\s'%followed_by%"\\)|>|[[:alpha:]-]{1,40}",",")
    x = x %sep% ""
    x
    x <- str_replace_all(x, "<" %nfollowed_by% "div", "<tags$")
    x = str_replace_all(x, "\\s+", " ")
    x = str_replace_all(x, "\\s=", "=")
    x = str_replace_all(x, "=\\s", "=")
    x = str_replace_all(x, "><", ",")
    x = str_replace_all(x, ">\\)", ")")
    x = str_replace_all(x, "\\)<", "),")
   # x = str_replace_all(x, ">,", ",")
    x = str_replace_all(x, ">", ")")
    x = x %>% str_remove_all("<") %>% glue()
    x = str_replace_all(x, "\\s+", " ")
    x = str_replace_all(x, "\\s=", "=")
    x = str_replace_all(x, "=\\s", "=")
    x = str_replace_all(x, "for=", "`for`=")

    emptyTag = ""
    while (!is.na(emptyTag)) {
        emptyTag <- str_extract(x, "tags\\$\\w+\\)")
        if (!is.na(emptyTag)) {
            x = str_replace(x, "tags\\$\\w+\\)", "{emptyTag}")
            emptyTag = str_replace(emptyTag, "\\)","()")
            x <- glue(x)
        }
    }

    hyphen = ""
    while (!is.na(hyphen)) {
        hyphen <- str_extract(x, "\\w+-\\w+=")
        if (!is.na(hyphen)) {
            x = str_replace(x, "\\w+-[[[:alpha:]]_\\-]+=", "{hyphen}")
            hyphen = paste0("`", str_remove(hyphen, "="), "`=")
            x <- glue(x)
        }
    }

    x=str_remove_all(x,'tags\\$spantext\\(') %>%str_remove_all(',spantextend\\)')


    emptyAttr=""
    while (!is.na( emptyAttr)) {
        emptyAttr <-    str_extract(x,","%preceding%'\\w{1,40}'%followed_by%"\\)|,")
        if (!is.na(emptyAttr)) {
            x = str_replace(x, ","%preceding%'\\w{1,40}'%followed_by%"\\)|,", "{emptyAttr}")
            emptyAttr = paste0(emptyAttr,'="',emptyAttr,'"')
            x <- glue(x)
        }
    }



    x = str_replace_all(x, "\\)" %followed_by% "\\w", "),")
    if (try_parsing == FALSE)
        return(as_glue(x))
    out = try(parse_expr(x), silent = TRUE)
    if (is_error(out))
        out<-parse_expr(glue("tagList({x})"))
    if (silent_eval == FALSE)
        return(out)
    tryeval<-eval(out)
    out
    # Returns: R code
}

