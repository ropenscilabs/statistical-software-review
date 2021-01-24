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

Ah, that’s true. The repository also contains a few tools for the use
both of developers submitting packages for review, and for reviewers.
These tools are bundled s an R package called `rssr` (for “**r**OpenSci
**S**tatistical **S**oftware **R**eview”) which developers and reviewers
will need to install with,

``` r
# install.packages("remotes")
remotes::install_github("ropenscilabs/statistical-software-review")
```

and loaded for use with,

``` r
library (rssr)
```

    ## Loading rssr

All functions of the package are prefixed with `rssr_`. The remainder of
this document is in two main sections. If you’re developing a package
for submission to our peer review system, keep straight on reading. If
you’ve been invited to review a package, you may skip the following
section and proceed straight to the subsequent section.

Both sections provide explicit descriptions of how the functions of the
`rssr` package can help developers prepare them for submission (in the
first), and use the package’s function to aid the review process (in the
second). In both cases, the general procedures are described in the
[main project
book](https://ropenscilabs.github.io/statistical-software-review-book/index.html),
with this `README` intended to provide supporting technical details
only.

## For Package Developers

People intending to develop packages for submission to our system for
peer reviewing statistical software will need to following the following
three general steps. The main mechanism is implemented via
custom-developed [`roxygen2` “roclets”](https://roxygen2.r-lib.org).
Once you’ve loaded these (as explained below), running
[`devtools::document()`](https://devtools.r-lib.org/reference/document.html)
or the equivalent
[`roxygen2::roxygenise()`](https://roxygen2.r-lib.org/reference/roxygenize.html),
will cause the roclet to scan your package’s documentation for the state
of standards, and to summarise the result on your screen. In order to
submit, you’ll need to document within your package code itself how and
where you’ve addressed each of these standards.

1.  Ensure the package successfully passes all
    [`autotest`](https://github.com/ropenscilabs/autotest) tests,
    including setting `test = FALSE` flags to switch off any particular
    tests.

2.  Decide which of our in-scope categories of statistical software best
    describe your package. The package has a function,
    [`rssr_available_categories()`](https://ropenscilabs.github.io/statistical-software-review/reference/rssr_available_categories.html),
    which provides a list of currently developed categories for which
    standards have been developed, along with links to the online
    standards for each category:

    ``` r
    rssr_available_categories ()$title
    ```

        ## [1] "General"                                                        
        ## [2] "Bayesian"                                                       
        ## [3] "EDA"                                                            
        ## [4] "Machine Learning"                                               
        ## [5] "Regression and Supervised Learning"                             
        ## [6] "Spatial"                                                        
        ## [7] "Time Series"                                                    
        ## [8] "Dimensionality Reduction, Clustering, and Unsupervised Learning"

    That function also returns links to the full descriptions of each
    category in the [main project
    book](https://ropenscilabs.github.io/statistical-software-review-book/index.html).
    Any software within one or more of these categories may be
    considered for review.

3.  Enable your package to use the roclet by modifying the package’s
    `DESCRIPTION` file so that the `Roxygen` line looks like this:

    ``` r
    Roxygen: list(markdown = TRUE, roclets = c ("namespace", "rd", "rssr::rssr_roclet"))
    ```

    That will load the [“roclet”](https://roxygen2.r-lib.org) used by
    this package to insert standards within your actual code. (You do
    not need to add, import, or depend upon the `rssr` package anywhere
    else within the `DESCRIPTION` file.)

4.  Load the `rssr` package and generate lists of standards within your
    package’s `/R` folder by running,
    [`rssr_standards_roxygen(category = c("<my-category-1>", "<my-category-2>"))`](https://ropenscilabs.github.io/statistical-software-review/reference/rssr_standards_roxygen.html).
    This will by default create a new file called by default
    `R/rssr_standards.R`, the first few lines of which will look like
    this:

        ## [1] "#' rssr_standards"                                                                                                     
        ## [2] "#'"                                                                                                                    
        ## [3] "#' @rssrVerboseDoc TRUE"                                                                                               
        ## [4] "#'"                                                                                                                    
        ## [5] "#' @rssrTODO G1.0 Statistical Software should list at least one primary reference from published academic literature. "
        ## [6] "#' @rssrTODO G1.1 All statistical terminology should be clarified and unambiguously defined. "

    The file will contain a list of all standards from your nominated
    categories. This file may be renamed, and the individual items moved
    to other locations in other files, but all nominated standards
    should remain somewhere in [`roxygen2`](https://roxygen2.r-lib.org)
    blocks somewhere in your source code.

    The `@rssrVerboseDoc` line defines a variable which may be used to
    suppress output from the `rssr` roclet when updating package
    documentation (by setting to `FALSE`). After that comes the list of
    standards, each of which is prefixed by a
    [`roxygen2`](https://roxygen2.r-lib.org) tag, `@rssrTODO`. A package
    can only be submitted once all of these `TODO` items have been
    addressed via one of the options described in the following two
    items.

5.  A standard may be addressed by moving the item in the
    `rssr_standards.R` file (or wherever you’ve chosen to list these
    within your own package) to one or more places in your code where
    these standards have been addressed. In doing so, the
    [`roxygen2`](https://roxygen2.r-lib.org) tag should be changed from
    `@rssrTODO` to `@rssr`, and the text which initially lists the
    actual standard should be changed to provide a brief description of
    how that standard has been met. Tags for one particular standard may
    be repeated in multiple places within your code, and we encourage
    locating an `@rssr` tag reference to a particular standard at all
    locations which directly address that standard. Alternatively, any
    standards which you consider not applicable to your software may
    remain listed in the main `rssr_standards.R` document, with their
    tag changed from `@rssrTODO` to `@rssrNA`, and the description of
    the standard removed and replace by an explanation of why that
    standard does not apply.
