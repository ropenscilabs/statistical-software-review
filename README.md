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
**r**OpenSci **s**tatistical **s**oftware **r**eview. The package can be
installed with,

``` r
# install.packages("remotes")
remotes::install_github("ropenscilabs/statistical-software-review")
```

It can then be loaded for use with,

``` r
library (statsoftrev)
```

At present the package contains the following functions:

``` r
ls ("package:statsoftrev")
```

    ## [1] "rssr_available_categories" "rssr_checklist_check"     
    ## [3] "rssr_standards_checklist"

The first of these functions provides a list of currently developed
categories of statistical software for which standards have been
developed.

``` r
rssr_available_categories ()
```

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

The remaining two functions are to aid package reviewers, as now
described.

So I’m reviewing a package, what should I do?
---------------------------------------------

Hopefully we’ve made that pretty easy with these steps.

### 1. Obtain relevant checklists of standards

You first need to obtain checklists of general and category-specific
standards relevant to the package. The function
[`rssr_standards_checklist()`](https://ropenscilabs.github.io/statistical-software-review/reference/rssr_standards_checklist.html)
converts one or more of the currently written standards into a
rmarkdown-formatted checklist for the benefit of reviewers. These
checklists are also copied directly to a local clipboard, ready to be
pasted directly into a local file or a github issue. This function
always extracts the checklist of [General
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

### 2. Fill out checklists

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

#### Inapplicable Standards

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

### 3. Check the formatting of your checklist

Having completed your checklist, please use one final function,
[`rssr_checklist_check()`](https://ropenscilabs.github.io/statistical-software-review/reference/rssr_checklist_check.html),
to ensure that common formatting mistakes can be rectified. This is
important to facilitate our automated analyses of checklists and
software assessments, through ensuring that all items are in
standardised formats. Simply pass the name of the local file containing
your checklist to this function, and the file will be updated with any
necessary changes, as well as copied again to your local clipboard ready
to be pasted into the github review issue.
