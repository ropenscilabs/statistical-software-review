<!-- badges: start -->

[![R build
status](https://github.com/ropenscilabs/statistical-software-review/workflows/R-CMD-check/badge.svg)](https://github.com/ropenscilabs/statistical-software-review/actions)
<!-- badges: end -->

<!-- README.md is generated from README.Rmd. Please edit that file -->

Statistical Software Review
===========================

This repository is primarily intended for submissions to rOpenSci’s
expanded system of software peer review to encompass statistical
software. The documents of the project, including standards and
procedures which will be used to guide the process, are in the
[statistical-software-review-book
repository](https://github.com/ropenscilabs/statistical-software-review-book).

But it appears to be an R package?
----------------------------------

Ah, that’s true. The repository also contains a few functions intended
to aid the review process, bundled within an R package called
`statsoftrev`. The functions themselves are prefixed with `rssr_` for
**r**OpenSci **s**tatistical **s**oftware **r**eview. At present these
functions are

    library (statsoftrev)
    ls ("package:statsoftrev")

    ## [1] "rssr_available_categories" "rssr_standards_checklist"

The first of these functions provides a list of currently developed
categories of statistical software for which standards have been
developed.

    rssr_available_categories ()

    ##       category                                                           title
    ## 1     bayesian                                                         General
    ## 2          eda                                                        Bayesian
    ## 3      general                                                             EDA
    ## 4           ml                                                Machine Learning
    ## 5   regression                              Regression and Supervised Learning
    ## 6  time-series                                                     Time Series
    ## 7 unsupervised Dimensionality Reduction, Clustering, and Unsupervised Learning
    ##                                                                                                                                            url
    ## 1                    https://ropenscilabs.github.io/statistical-software-review-book/standards.html#general-standards-for-statistical-software
    ## 2                             https://ropenscilabs.github.io/statistical-software-review-book/standards.html#bayesian-and-monte-carlo-software
    ## 3                                     https://ropenscilabs.github.io/statistical-software-review-book/standards.html#exploratory-data-analysis
    ## 4                                     https://ropenscilabs.github.io/statistical-software-review-book/standards.html#machine-learning-software
    ## 5                            https://ropenscilabs.github.io/statistical-software-review-book/standards.html#regression-and-supervised-learning
    ## 6                                          https://ropenscilabs.github.io/statistical-software-review-book/standards.html#time-series-software
    ## 7 https://ropenscilabs.github.io/statistical-software-review-book/standards.html#dimensionality-reduction-clustering-and-unsupervised-learning

The second function converts one or more of the currently written
standards into a rmarkdown-formatted checklist for the benefit of
reviewers. These checklists are also copied directly to a local
clipboard, ready to be pasted directly into a local file or a github
issue. This function always extracts the checklist of [General
Standards](https://ropenscilabs.github.io/statistical-software-review-book/standards.html#general-standards-for-statistical-software),
with any specified categories appended as additional checklists.

    x <- rssr_standards_checklist (category = "regression")

    ## ✔ Downloaded general standards

    ## ✔ Downloaded regression standards

    ## ℹ Markdown-formatted checklist copied to clipboard

The resultant object is a character vector which starts like this:

    head (x)

    ## [1] "## [General Standards](https://ropenscilabs.github.io/statistical-software-review-book/standards.html#general-standards-for-statistical-software)"              
    ## [2] ""                                                                                                                                                               
    ## [3] "### Documentation"                                                                                                                                              
    ## [4] "- [ ] **G1.0** *Software should use [`roxygen`](https://roxygen2.r-lib.org/) for all   documentation.*"                                                         
    ## [5] "    - [ ] **G1.0a** *All internal (non-exported) functions should also be documented       in standard [`roxygen`](https://roxygen2.r-lib.org/) format.* "      
    ## [6] "- [ ] **G1.1** *Software should include all code necessary to reproduce results which   form the basis of performance claims made in associated publications.* "

So I’m reviewing a package, what should I do?
---------------------------------------------

Hopefully we’ve made that pretty easy with these steps:

    # install.packages("remotes")
    remotes::install_github("ropenscilabs/statistical-software-review")
    library(statsoftrev)
    x <- rssr_standards_checklist (category = c ("eda", "ml")) # EAD + Machine Learning Software, for example

As demonstrated above, that will give you a copy of all relevant
standards for the specified category (or categories) in your clipboard
which you can paste anywhere. To save the checklist directly to a local
file, simply type:

    writeLines (x, file = "/<local>/<file>/<name>.md")
