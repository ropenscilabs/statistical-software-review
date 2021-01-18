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
        block_obj <- block$object

        if (length (roxygen2::block_get_tags (block, "rssr")) == 0L) {
            # Block does not have @rssr
            next
        }

        func_name <- block_obj$alias

        file_nm <- ""
        if (!is.null (attr (block, "filename"))) {
            file_nm <- paste0(" [in '", attr (block, "filename"), "']: ")
        }

        block_title <- roxygen2::block_get_tag_value (block, "title")
        msg <- paste0 ("Function '", func_name,
                       "()' with title '", block_title, "'", file_nm)
        msgs <- c (msgs, msg)
    }

    if (length (msgs) > 0L) {
        message ("Functions with `rssr` tags:")
        message (paste0 ("  * ", msgs, collapse = "\n"), sep = "")
    }

    return (NULL)
}

#' @importFrom roxygen2 roclet_output
#'
#' @export
roclet_output.roclet_rssr <- function (x, results, base_path) { # nolint
    return (NULL)
}
