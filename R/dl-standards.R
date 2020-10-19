# functions to download current standards from reference (bookdown) site
# https://github.com/ropenscilabs/statistical-software-review-book

#' @param raw If `TRUE`, use api.github.com to access raw file contents,
#' otherwise standard github.com URL.
#' @noRd
base_url <- function (raw = FALSE) {
    if (raw)
        ret <- "https://raw.githubusercontent.com/"
    else
        ret <- "https://api.github.com/repos/"
    return (paste0 (ret, "ropenscilabs/statistical-software-review-book/"))
}

#' @return List of all current categories as obtained from directory contents of
#' https://github.com/ropenscilabs/statistical-software-review-book/tree/master/standards
#' @noRd
list_categories <- function () {
    u <- paste0 (base_url (), "git/trees/master?recursive=1")
    x <- httr::GET (u) %>%
        httr::content ()
    index <- which (vapply (x$tree, function (i)
                            grepl ("^standards\\/", i$path),
                            logical (1)))
    s <- vapply (x$tree [index], function (i) i$path, character (1))
    gsub ("^standards\\/|\\.Rmd$", "", s)
}

#' @param category One of the names of files in above link (for
#' `list_categories`)
#' @return Character vector of contents of the `.Rmd` file for nominated
#' standards
#' @noRd
dl_standards <- function (category = "general") {
    categories <- tolower (list_categories ())
    category <- match.arg (tolower (category), categories)
    u <- paste0 (base_url (raw = TRUE),
                 "master/standards/", category, ".Rmd")
    tmp <- tempfile (fileext = ".Rmd")
    ret <- utils::download.file (u, destfile = tmp)
    readLines (tmp)
}
