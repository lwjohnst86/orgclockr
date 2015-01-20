##' Extract the todo states of an org file.
##'
##' A function to extract the \code{org-todo-keywords} matching a
##' pattern. If you are not familiar with regular expressions, you may
##' pass the todo states you are interested in as a character vector.
##' The default pattern extracts the first word in uppercase letters
##' of each element in \code{x}. Uppercase todo states seem to be
##' quite common in the orgmode community. The pattern also regards
##' keywords containing an underscore.
##' @param x org object as character vector.
##' @param pattern either a regular expression
##' (see:\url{http://www.regular-expressions.info/}) or a character
##' vector of \code{org-todo-keywords}.
##' @return the \code{org-todo-keywords} of an orgfile as a character vector.
##' @export extract_todostates
##' @examples
##' extract_todostates(c("* TODO test", "** Test Headline"), c("DONE", "TODO"))
##' ## [1] "TODO" NA
##'
##' system.file("extdata", "sample.org", package = "orgclockr") %>%
##' readLines() %>%
##' extract_todostates()
##' ##  [1] NA      "TODO"  "TODO"  "TODO"  NA      "HABIT" "TODO"  NA      "DONE"
##' ## [10] "TODO"  "TODO"
##' @seealso \code{extract_timestamps}, \code{extract_headlines},
##' \code{extract_tags}, \code{extract_levels} and
##' \code{extract_categories} to extract other org elements.
extract_todostates <-
    function(x, pattern = "\\b[[:upper:]]+((\\b)|(_[[:upper:]]+\\b))") {
        if (is.vector(pattern)) {
            pat <-
                pattern %>%
                    paste0(sep="|", collapse = "") %>%
                    stringr::str_replace("\\|$", "")
        }
        else {
            pat <- pattern
        }
        x %>%
            extract_raw_headlines() %>%
            na.omit() %>%
            stringr::str_extract(pat)
    }