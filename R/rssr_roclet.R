
#' Parse tests tag
#' 
#' @param x Input
#' 
#' @return Parsed tag
#' 
#' @importFrom roxygen2 roxy_tag_parse
#' @export
roxy_tag_parse.roxy_tag_rssr <- function(x) {
    roxygen2::tag_markdown (x)
}

#' @importFrom roxygen2 roxy_tag_rd
#' @export
roxy_tag_rd.roxy_tag_rssr <- function(x, base_path, env) {
  NULL
}

#' rssr_roclet
#'
#' Get values of all `rssr` tags in function documentation
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

        if (length (roxygen2::block_get_tags (block, "rssr")) == 0L) {
            # Block does not have @rssr
            next
        }

        func_name <- block$object$alias
        standards <- roxygen2::block_get_tag_value (block, "rssr")

        block_title <- roxygen2::block_get_tag_value (block, "title")
        block_backref <- basename (roxygen2::block_get_tag_value (block, "backref"))
        block_line <- block$line
        msg <- paste0 ("Standards [", standards, "] in function '",
                       func_name, "()' on line#",
                       block_line, " of file [",
                       block_backref, "]")
        msgs <- c (msgs, msg)
    }

    if (length (msgs) > 0L) {
        message ("rOpenSci Statistical Software Standards:")
        message (paste0 ("  * ", msgs, collapse = "\n"), sep = "")
    }

    return (NULL)
}

#' @importFrom roxygen2 roclet_output
#'
#' @export
roclet_output.roclet_rssr <- function (x, results, base_path, ...) { # nolint
    return (NULL)
}
