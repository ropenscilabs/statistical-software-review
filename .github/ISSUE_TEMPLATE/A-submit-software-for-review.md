---
name: Submit software for review
about: Use this template to submit software for review

---


Submitting Author: Name (@github_handle)
Other Package Authors: (delete if none) Name (@github_handle)
Repository:  <!--repourl--><!--end-repourl-->
Version submitted:
Editor: <!--editor--> TBD <!--end-editor-->
Reviewers: <!--reviewers-list--> TBD <!--end-reviewers-list-->
<!--due-dates-list--><!--end-due-dates-list-->
Archive: TBD
Version accepted: TBD

---



-   Paste the full DESCRIPTION file inside a code block below:

```

```


## General Information


-   Who is the target audience and what are scientific applications of this package?

-   Paste your responses to our [*General Standard* **G1.1** here](https://ropenscilabs.github.io/statistical-software-review-book/standards.html#general-standards), describing whether your software is:

    - *The first implementation of a novel algorithm*; or
    - *The first implementation within **R** of an algorithm which has
      previously been implemented in other languages or contexts*; or
    - *An improvement on other implementations of similar algorithms in **R***.

    Please include hyperlinked references to all other relevant software.

-   (If applicable) Does your package comply with our [guidance around _Ethics, Data Privacy and Human Subjects Research_](https://devguide.ropensci.org/policies.html#ethics-data-privacy-and-human-subjects-research)?


## Technical checks

Confirm each of the following by checking the box.

- [ ] I/we have read the [guide for authors](https://devguide.ropensci.org/guide-for-authors.html) and [rOpenSci packaging guide](https://devguide.ropensci.org/building.html).
- [ ] I/we have read the [*Statistical Software Peer Review* Guide for Authors](https://ropenscilabs.github.io/statistical-software-review-book/pkgdev.html).
- [ ] I/we have run [`autotest`](https://github.com/ropenscilabs/autotest) checks on the package, and ensured no tests fail.
- [ ] The [`srr_stats_pre_submit()` function](https://ropenscilabs.github.io/srr/reference/srr_stats_pre_submit.html) confirms this package may be submitted.

This package:

- [ ] does not violate the Terms of Service of any service it interacts with.
- [ ] has a CRAN and OSI accepted license.
- [ ] contains a [README with instructions for installing the development version](https://ropensci.github.io/dev_guide/building.html#readme).

## Publication options

- [ ] Do you intend for this package to go on CRAN?
- [ ] Do you intend for this package to go on Bioconductor?


## Code of conduct

- [ ] I agree to abide by [rOpenSci's Code of Conduct](https://ropensci.github.io/dev_guide/policies.html#code-of-conduct) during the review process and in maintaining my package should it be accepted.
