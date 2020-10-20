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
    x <- httr::GET (u)
    x <- httr::content (x)
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
    u <- paste0 (base_url (raw = TRUE),
                 "master/standards/", category, ".Rmd")
    tmp <- tempfile (fileext = ".Rmd")
    ret <- utils::download.file (u, destfile = tmp)
    readLines (tmp)
}

#' @param s Full text describing and including a set of standards downloaded
#' with `dl_standards`
#' @return The standards only extracted from `s`, formatted as checklist items.
#' @noRd
format_standards <- function (s) {
    index1 <- grep ("\\s?-\\s\\*\\*[A-Z]", s)
    index_sp <- grep ("^\\s*$", s)
    index2 <- vapply (seq_along (index1), function (i) {
                      ret <- index_sp [which (index_sp > index1 [i]) [1]]
                      if (is.na (ret)) {
                          if (i == length (index1)) {
                              ret <- length (s)
                          } else {
                              ret <- index1 [i + 1] - 1L
                          }
                      } else if (i < length (index1)) {
                          if (ret > index1 [i + 1])
                              ret <- index1 [i + 1] - 1L
                      }
                      return (ret)},
                      integer (1))

    # include 3rd- and 4th-level sub-section headings:
    index3 <- grep ("^\\#\\#\\#\\s|^\\#\\#\\#\\#\\s", s)
    index1 <- sort (c (index1, index3))
    index2 <- sort (c (index2, index3))

    s <- vapply (seq_along (index1), function (i)
                 paste0 (s [index1 [i]:index2 [i]], collapse = " "),
                 character (1))
    s <- gsub ("\\s*\\-\\s+\\*\\*", "- \\[ \\] **", s)

    # index sub-standards
    index <- grep ("\\-\\s?\\[\\s\\]\\s\\*\\*[A-Z]+[0-9]\\.[0-9]+[a-z]\\*\\*", s)
    s [index] <- paste0 ("    ", s [index])

    return (s)
}

category_titles_urls <- function (category) {
    ret <- list ()
    u_base = paste0 ("https://ropenscilabs.github.io/",
                     "statistical-software-review-book/",
                     "standards.html#")

    if (category == "bayesian")
        ret <- list (title = "Bayesian",
                     url = paste0 (u_base, "bayesian-and-monte-carlo-software"))
    else if (category == "eda")
        ret <- list (title = "EDA",
                     url = paste0 (u_base, "exploratory-data-analysis"))
    else if (category == "ml")
        ret <- list (title = "Machine Learning",
                     url = paste0 (u_base, "machine-learning-software"))
    else if (category == "regression")
        ret <- list (title = "Regression and Supervised Learning",
                     url = paste0 (u_base, "regression-and-supervised-learning"))
    else if (category == "time-series")
        ret <- list (title = "Time Series",
                     url = paste0 (u_base, "time-series-software"))
    else if (category == "unsupervised")
        ret <- list (title = paste0 ("Dimensionality Reduction, Clustering, ",
                                     "and Unsupervised Learning"),
                     url = paste0 (u_base, "dimensionality-reduction-",
                                   "clustering-and-unsupervised-learning"))

    return (ret)
}

#' Obtain a set of one or more category-specific standards as a checklist, and
#' store the result in the local clipboard ready to paste.
#' @param category One of the names of files given in the directory contents of
#' \url{https://github.com/ropenscilabs/statistical-software-review-book/tree/master/standards},
#' each of which is ultimately formatted into a sub-section of the standards.
#' @return A character vector containing a markdown-style checklist of general
#' standards along with standards for any additional categories.
#' @export
rssr_standards_checklist <- function (category = NULL) {
    s <- dl_standards (category = "general")
    s <- format_standards (s)
    u <- paste0 ("https://ropenscilabs.github.io/",
                 "statistical-software-review-book/",
                 "standards.html#general-standards-for-statistical-software")
    s <- c (paste0 ("## [General Standards](", u, ")"),
            "", s, "")

    if (!is.null (category)) {
        categories <- tolower (list_categories ())
        for (i in seq_along (category)) {
            category [i] <- match.arg (tolower (category [i]), categories)
            cat_title <- category_titles_urls (category [i])
            s_cat <- dl_standards (category = category [i])
            s_cat <- format_standards (s_cat)
            stitle <- paste0 ("## [",
                              cat_title$title,
                              " Standards](",
                              cat_title$url,
                              ")")
            s <- c (s, "", "---", "", stitle, "", s_cat)
        }
    }

    message (cli::col_cyan (cli::symbol$star),
             " Markdown-formatted checklist copied to clipboard")

    invisible (clipr::write_clip (s))
}

#' List all currently available categories and associated URLs to full category
#' descriptions.
#' @return A `data.frame` with 3 columns of "category" (the categories to be
#' submitted to \link{rssr_standards_checklist}), "title" (the full title), and
#' "url".
#' @export
rssr_available_categories <- function () {
    cats <- list_categories ()
    cat_full <- unlist (lapply (cats, function (i)
                                category_titles_urls (i)))

    cat_full <- c ("General",
                   paste0 ("https://ropenscilabs.github.io/",
                           "statistical-software-review-book/",
                           "standards.html#",
                           "general-standards-for-statistical-software"),
                   cat_full)

    index <- seq (length (cat_full) / 2) * 2
    data.frame (category = cats,
                title = cat_full [index - 1],
                url = cat_full [index],
                stringsAsFactors = FALSE)
}
