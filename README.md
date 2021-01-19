<!-- badges: start -->

[![R build
status](https://github.com/ropenscilabs/statistical-software-review/workflows/R-CMD-check/badge.svg)](https://github.com/ropenscilabs/statistical-software-review/actions)
<!-- badges: end -->

<!-- README.md is generated from README.Rmd. Please edit that file -->

# Statistical Software Review

This repository is primarily intended for submissions to rOpenSci’s
expanded system of software peer review to encompass statistical
software. The documents of the project, including standards and
procedures which will be used to guide the process, are in the
[statistical-software-review-book
repository](https://github.com/ropenscilabs/statistical-software-review-book).

## But it appears to be an R package?

Ah, that’s true. The repository also contains a few functions both for
the use of developers submitting packages for review, and for reviewers.
This repository also contains an R package called `statsoftrev` which
developers and reviewers will need to install with,

``` r
# install.packages("remotes")
remotes::install_github("ropenscilabs/statistical-software-review")
```

It can then be loaded for use with,

``` r
library (statsoftrev)
```

All functions of the packages are prefixed with `rssr_`, for
“**r**OpenSci **S**tatistical **S**oftware **R**eview.” One function
provides a list of currently developed categories of statistical
software for which standards have been developed, along with links to
the online standards for each category:

``` r
rssr_available_categories ()
```

    ##       category                                                           title
    ## 1     bayesian                                                         General
    ## 2          eda                                                        Bayesian
    ## 3      general                                                             EDA
    ## 4           ml                                                Machine Learning
    ## 5   regression                              Regression and Supervised Learning
    ## 6      spatial                                                         Spatial
    ## 7  time-series                                                     Time Series
    ## 8 unsupervised Dimensionality Reduction, Clustering, and Unsupervised Learning
    ##                                                                                                                                            url
    ## 1                    https://ropenscilabs.github.io/statistical-software-review-book/standards.html#general-standards-for-statistical-software
    ## 2                             https://ropenscilabs.github.io/statistical-software-review-book/standards.html#bayesian-and-monte-carlo-software
    ## 3                                     https://ropenscilabs.github.io/statistical-software-review-book/standards.html#exploratory-data-analysis
    ## 4                                     https://ropenscilabs.github.io/statistical-software-review-book/standards.html#machine-learning-software
    ## 5                            https://ropenscilabs.github.io/statistical-software-review-book/standards.html#regression-and-supervised-learning
    ## 6                                              https://ropenscilabs.github.io/statistical-software-review-book/standards.html#spatial-software
    ## 7                                          https://ropenscilabs.github.io/statistical-software-review-book/standards.html#time-series-software
    ## 8 https://ropenscilabs.github.io/statistical-software-review-book/standards.html#dimensionality-reduction-clustering-and-unsupervised-learning

Any software within one or more of these categories may be considered
for review. The remaining functions are intended for submitting authors,
reviewers, and rOpenSci editors, and serve the two primary tasks of:

1.  Obtaining and processing checklists of standards; and
2.  Enabling and processing [`roxygen2`](https://roxygen2.r-lib.org)
    tags to align package functions with standards.

These functions will be needed, for different purposes, by both
developers and reviewers. The book on [Statistical Software
Review](https://ropenscilabs.github.io/statistical-software-review-book/index.html)
details the procedures to be followed by both developers and reviewers
to align and asses software against the standards. This package enables
copies of those standards to be obtained as markdown-formatted
checklists, as described in the first of the following sections.
Developers are also expected to align the various functions of their
software with specific standards using project-specific
[`roxygen2`](https://roxygen2.r-lib.org) tags, as described in the
subsequent section.

## 1. Checklists of standards

Both developers and reviewers will need to obtain checklists of general
and category-specific standards relevant to the package, with detailed
procedures given in the main [project
book](https://ropenscilabs.github.io/statistical-software-review-book/index.html).
The function
[`rssr_standards_checklist()`](https://ropenscilabs.github.io/statistical-software-review/reference/rssr_standards_checklist.html)
converts one or more of the currently written standards into a
rmarkdown-formatted checklist. These checklists are also copied directly
to a local clipboard, ready to be pasted directly into a local file or a
github issue. This function always extracts the checklist of [General
Standards](https://ropenscilabs.github.io/statistical-software-review-book/standards.html#general-standards-for-statistical-software),
along with any specified categories appended as additional checklists.

``` r
x <- rssr_standards_checklist (category = c ("regression", "ml"))
```

    ## ✔ Downloaded general standards

    ## ✔ Downloaded regression standards

    ## ✔ Downloaded ml standards

    ## ℹ Markdown-formatted checklist copied to clipboard

The resultant object is a character vector which starts like this:

``` r
head (x)
```

    ## [1] "## [General Standards](https://ropenscilabs.github.io/statistical-software-review-book/standards.html#general-standards-for-statistical-software)"
    ## [2] ""                                                                                                                                                 
    ## [3] "### Documentation"                                                                                                                                
    ## [4] ""                                                                                                                                                 
    ## [5] "- [ ] **G1.0** *Statistical Software should list at least one primary reference from published academic literature.* "                            
    ## [6] ""

The names of the categories are those given in the “category” column of
the output of
[`rssr_available_categories()`](https://ropenscilabs.github.io/statistical-software-review/reference/rssr_available_categories.html)
shown above. Calling that function will give you a copy of all relevant
standards for the specified category (or categories) in your clipboard
which you can paste anywhere. The function also has a `filename`
argument which can be used to save the checklist directly to a local
file.

### 1.1 Fillling out checklists

While it is possible to paste a checklist directly into a github issue
and complete it there, we recommend that you first save the checklist to
a local file (using the `file` option of the
[`rssr_standards_checklist()`](https://ropenscilabs.github.io/statistical-software-review/reference/rssr_standards_checklist.html)
function) and use that local version to complete your assessment. Each
standard which you judge the software to meet can be checked by
replacing the space between the open square brackets with an “x”.
Whether or not the checkbox is filled, please replace the text for each
standard with a comment explaining how the software does or does not
fulfil that standard. Please do not remove or change the identifiers for
each standard.

### 1.2 Inapplicable Standards

Any standards deemed inapplicable to a given software package should be
checked, the text potentially modified to indicate how or why those
standards do not apply, and the text then appended with “N/A” in bold
face (achieved by surrounding with either two asterisks or two
underscores, “\*\*N/A\*\*” or “\_\_N/A\_\_”). Multiple inapplicable
standards may be combined in a single statement through separating by a
double dash (“--”), as in the following example:

-   [x] **G4.10**–**G4.12** It is appropriate for this software not to
    implement any extended tests **N/A**

That example demonstrates that standards deemed to be inapplicable to a
given software package should be considered fulfilled and checked
appropriately. There may of course be standards which are deemed
inapplicable, yet which you as a reviewer judge should actually be
applied. For example, a package may not implement extended tests, yet
may have several functions which take too long to run to be tested
within a normal test suite. Such a package should have an extended test
suite, and so the relevant general standards **G4.10**–**G4.12** should
be considered applicable. In such cases, please simply leave these
standards unchecked, and alter the relevant text to clarify why you
think those standards should apply.

### 1.3 Check the formatting of your checklist

Having completed your checklist, please use one final function,
[`rssr_checklist_check()`](https://ropenscilabs.github.io/statistical-software-review/reference/rssr_checklist_check.html),
to ensure that common formatting mistakes can be rectified. This is
important to facilitate our automated analyses of checklists and
software assessments, through ensuring that all items are in
standardised formats. Simply pass the name of the local file containing
your checklist to this function, and the file will be updated with any
necessary changes, as well as copied again to your local clipboard ready
to be pasted into the github review issue.

## 2. `roxygen2` tags

The `statsoftrev` package associated with this repository includes
functions to process project-specific
[`roxygen2`](https://roxygen2.r-lib.org) tags of `#' @rssr`, to align
package functions with specific standards. Packages can enable these
tags by adding or modifying the `Roxygen` line of a package’s
`DESCRIPTION` file to include the `statsoftrev::rssr_roclet`. The result
might look something like the following:

    Roxygen: list(markdown = TRUE, roclets = c("namespace", "rd", "statsoftref::rssr_roclet"))

The `"namespace"` and `"rd"` roclets are the [default
roclets](https://roxygen2.r-lib.org/reference/roxygenize.html) used by
[`roxygen2`](https://roxygen2.r-lib.org), and should generally be
retained. (See also this note on [generating documentation with custom
roclets in
RStudio](https://github.com/mikldk/roxytest#document-package-keyboard-shortcut),
and see
[`roxygen::update_collate()`](https://roxygen2.r-lib.org/reference/update_collate.html)
to determine whether you might also need to add `"collate"` to your
`DESCRIPTION`’s `Roxygen` list.) You do not need to import or in any way
depend on the `statsoftrev` package, but merely add the “roclet” as in
the above line. For developers, this will have the sole effect of
enabling [`roxygen2`](https://roxygen2.r-lib.org) to ignore all `@rssr`
tags in your documentation, and to proceed to generate documentation as
normal. (Documentation will still be generated even without adding the
“roclet” to your `DESCRIPTION` file, but you’ll see warnings about
“@rssr unknown tag”.)

Developers are required to align the functions of their software with
specific standards which those functions address by inserting `@rssr`
tags in their function documentation, Each standard should be tagged at
least once within a package by a `#' @rssr <standard-number>` tag, where
`<standard number>` refers to one or more of the general or
category-specific standards.

For example, the first standard illustrated above is,

    ## [1] "- [ ] **G1.0** *Statistical Software should list at least one primary reference from published academic literature.* "

Such primary references are commonly provided in the `DESCRIPTION` file,
but should also be documented within the code itself. One common place
for references is in the primary package documentation, typically within
a file named, `R/<mypkg>-package.R`, documented as described in the
[`roxygen2`
documentation](https://roxygen2.r-lib.org/articles/rd.html#packages-1).
Packages initially generated with [`usethis`](https://usethis.r-lib.org)
with automatically have this package-level documentation. Primary
references may then be inserted anywhere within this package-level
documentation, typically with a [`\doi{}`
tag](https://cran.r-project.org/doc/manuals/R-exts.html#User_002ddefined-macros).
The documentation of that primary reference can be aligned to [Standard
**G1.0**](https://ropenscilabs.github.io/statistical-software-review-book/standards.html#documentation)
by adding the following [`roxygen2`](https://roxygen2.r-lib.org) tag:

``` r
#' @rssr G1.0
```

A full example might look something like this:

``` r
#' @details
#' This package is an implementation of the algorithm described in
#' \doi{<reference-to-published-algorithm>}.
#' @keywords internal
#' @rssr G1.0
"_PACKAGE"
```

These `@rssr` tags do not appear in any resultant documentation, rather
they only serve to enable identification of which components of a
package address which standards. Each [`roxygen2`
“block”](https://roxygen2.r-lib.org/articles/rd.html#the-description-block)
may only contain a single `@rssr` tag, with multiple standards separated
by commas. The following example illustrates that multiple consecutive
standards may be separated by hyphens, and line breaks may also be used.

``` r
#' @name this_fn
#' This is a function.
#' @rssr
#' G1.0,
#' RE2.0-RE2.4,
#' RE5.0
this_fn <- function() {}
```

Each standard or set of standards except the last should be separated by
a comma. The roclet ensures that this format is followed by triggering
errors if the lists of standards are not able to be parsed.

### 2.1 Non-applicable Standards

As described in the [main
documentation](https://ropenscilabs.github.io/statistical-software-review-book/index.html),
not all standards may be applicable to any given package. Standards
which are deemed by developers not to be applicable should nevertheless
be documented according to the procedure described in this section, and
using a dedicated `@rssrNA` tag. Each non-applicable standard should be
named, and a brief justification provided as to why that standard may
not be applicable. These should all exist within a single
[`roxygen2`](https://roxygen2.r-lib.org) block like the following:

``` r
#' @title NA_standards
#' @rssrnA G1.0
#' @note G1.0 is not applicable because there the reference has not yet been published
#' @noRd
```

A sensible location for this [`roxygen2`](https://roxygen2.r-lib.org)
block might be in the main package file, `R/<pkg>-package.R`, although
developers may prefer a separate document such as `R/MA_standards.R`,
especially if the list is quite long. This block must be formatted as
follows:

1.  It must begin with the line `@title NA_standards` (note `@title` and
    not `@name`).
2.  It must include a `@noRd` tag to prevent the block being added to
    package documentation.
3.  The standards must be listed after a single `@rssr` tag, as
    described above.
4.  Finally, the justification for why each listed standard, or
    consecutive set of hyphen-separated standards, is not applicable
    should be provided in a distinct `@note`
