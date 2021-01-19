
#' Parse rssr tags
#'
#' @param x Input
#' @return Parsed tags
#'
#' @importFrom roxygen2 roxy_tag_parse
#' @noRd
#' @export
roxy_tag_parse.roxy_tag_rssr <- function(x) { # nolint
    roxygen2::tag_markdown (x)
}

#' @importFrom roxygen2 roxy_tag_rd
#' @noRd
#' @export
roxy_tag_rd.roxy_tag_rssr <- function(x, base_path, env) { # nolint
  NULL
}

#' Parse rssrNA tags
#'
#' @param x Input
#' @return Parsed tags
#'
#' @importFrom roxygen2 roxy_tag_parse
#' @noRd
#' @export
roxy_tag_parse.roxy_tag_rssrNA <- function(x) { # nolint
    roxygen2::tag_markdown (x)
}


#' @importFrom roxygen2 roxy_tag_rd
#' @noRd
#' @export
roxy_tag_rd.roxy_tag_rssrNA <- function(x, base_path, env) { # nolint
  NULL
}

#' rssr_roclet
#'
#' Get values of all `rssr` tags in function documentation
#'
#' Note that this function should never need to be called directly. It only
#' exists to enable "@rssr" tags to be parsed from \pkg{roxygen2} documentation.
#'
#' @importFrom roxygen2 roclet
#'
#' @export
rssr_roclet <- function () {
    roxygen2::roclet ("rssr")
}

#' @importFrom roxygen2 roclet_process
#'
#' @export
roclet_process.roclet_rssr <- function (x, blocks, env, base_path) { # nolint

    msgs <- list ()

    for (block in blocks) {

        msg <- NULL

        if (length (roxygen2::block_get_tags (block, "rssr")) > 0L) {
            msg <- process_rssr_tags (block)
        } else if (length (roxygen2::block_get_tags (block, "rssrNA")) > 0L) {
            msg <- process_rssrNA_tags (block)
        } else {
            next
        }

        msgs <- c (msgs, msg)
    }

    if (length (msgs) > 0L) {
        message ("rOpenSci Statistical Software Standards:")
        message (paste0 ("  * ", msgs, collapse = "\n"), sep = "")
    }

    return (NULL)
}

process_rssr_tags <- function (block) {

    func_name <- block$object$alias
    standards <- roxygen2::block_get_tag_value (block, "rssr")
    if (grepl ("\\n", standards)) {
        standards <- strsplit (standards, "\\n") [[1]]
        has_commas <- grepl ("\\,", standards)
        last_entry <- has_commas [length (has_commas)]
        has_commas <- has_commas [-length (has_commas)]
        if (!all (has_commas))
            stop ("Each @rssr standard should be separated by a comma.")
        if (last_entry)
            stop ("It appears you've got a comma after the last @rssr entry")
    }
    standards <- unlist (strsplit (standards, ","))

    notes <- roxygen2::block_get_tag_value (block, "note")
    block_backref <- roxygen2::block_get_tag_value (block, "backref")
    block_line <- block$line

    msg <- paste0 ("Standards [", standards,
                   "] in function '", func_name,
                   "()' on line#", block_line,
                   " of file [", basename (block_backref), "]")

    return (msg)
}

process_rssrNA_tags <- function (block) {

    block_title <- roxygen2::block_get_tag_value (block, "title")
    if (!block_title == "NA_standards")
        stop ("@rssrNA tags should only appear in ",
              "a block with a title of NA_standards")

    standards <- roxygen2::block_get_tags (block, "rssrNA")
    standards <- unlist (lapply (standards, function (i) i$val))
    standards <- gsub ("\\s.*$", "", standards)

    block_backref <- roxygen2::block_get_tag_value (block, "backref")
    block_line <- block$line

    msg <- paste0 ("NA Standards [", paste0 (standards, collapse = ", "),
                   "] on line#", block_line,
                   " of file [", basename (block_backref), "]")

    return (msg)
}

#' @importFrom roxygen2 roclet_output
#'
#' @export
roclet_output.roclet_rssr <- function (x, results, base_path, ...) { # nolint
    return (NULL)
}
