#Check Usage -----
checks=checkPackageUsage()
runTests(package="ShinyReboot")
#Dismiss Usage Warnings -----
#  suppressUsageWarnings(checks)
###Dev Setup -----
## INSTALL: CTRL + SHIFT + B
sDevTools::clearEnv() ## CTRL + SHIFT + R
library(sDevTools)
sDevTools::loadUtils()
#Dev -----
assert_css_unit<-
 function(x){
   #Documentation

   fdoc("Checks that the argument is valid for use as a CSS unit of length","[invisible(x)] if valid, otherwise throws an error.")
   #Assertions
    assert_any(x,
       check_number(),
       check_string()
    )
    if (is.null(x) || is.na(x))
       return(x)

    if (length(x) > 1 || (!is.character(x) && !is.numeric(x)))
       g_stop("CSS units must be a single-element numeric or character vector")
    if (is.character(x) && nchar(x) > 0 && gsub("\\d*",
                                                "", x) == "")
       x <- as.numeric(x)
    pattern <- "^(auto|inherit|fit-content|calc\\(.*\\)|((\\.\\d+)|(\\d+(\\.\\d+)?))(%|in|cm|mm|ch|em|ex|rem|pt|pc|px|vh|vw|vmin|vmax|fr))$"
    if (is.character(x) && !grepl(pattern, x)) {
       stop("\"", x, "\" is not a valid CSS unit (e.g., \"100%\", \"400px\", \"auto\")")
    }
    else if (is.numeric(x)) {
       x <- paste(x, "px", sep = "")
    }
    x

 }
#document------
fn_document(assert_css_unit,overwrite = TRUE)
