# thesisdownrli 

[![Build Status](https://travis-ci.org/aj2duncan/thesisdownrli.svg?branch=master)](https://travis-ci.org/aj2duncan/thesisdownrli) [![Coverage status](https://codecov.io/gh/aj2duncan/thesisdownrli/branch/master/graph/badge.svg)](https://codecov.io/github/aj2duncan/thesisdownrli?branch=master)

This project provides a template for writing a PhD dissertation in R Markdown, and rendering those files into a PDF formatted for submission at the University of the Highlands and Islands . At present it uses a modified version of the thesis template from the University of California, Santa Barbara to convert R Markdown files. This package is a more or less direct copy of `gauchodown`.  Huge thanks to

- [gauchodown](https://github.com/kmillage/gauchodown) 

- [huskydown](https://github.com/benmarwick/huskydown)

- [thesisdown](https://github.com/ismayc/thesisdown) 

- [bookdown](https://github.com/rstudio/bookdown)

Complete documentation can be found on [https://aj2duncan.github.io/thesisdownrli](https://aj2duncan.github.io/thesisdownrli).

Currently, the PDF and gitbook versions are fully-functional, and are the focus of this package. The word and epub versions are in development, have no templates behind them, and are essentially calls to the appropriate functions in bookdown.

## Installation

In order to use `thesisdownrli` it is necessary to have some prerequisites installed, namely Pandoc and LaTeX. Once these are installed you ready to install the package itself.

### Installing Pandoc and LaTeX

If RStudio is already installed then so is Pandoc. If you haven't installed RStudio the most recent version is available [here](http://www.rstudio.com/products/rstudio/download/) and installing it will install Pandoc. If you are not an RStudio user, Pandoc can downloaded from [here](https://pandoc.org/installing.html).

Having installed Pandoc, the final piece of software required is LaTeX, which is necessary to build PDF documents. By far the easiest way for any `R` user to install LaTeX on any platform is with the [`tinytex`](https://yihui.name/tinytex/) package:

```r
install.packages(c('tinytex', 'rmarkdown'))
tinytex::install_tinytex(force = TRUE)
# after restarting your R session, confirm that you have LaTeX with 
tinytex:::is_tinytex()
```

### Installing `thesisdownrli`

The code below should install all the prerequisites for `thesisdownrli`. If you are unsure about installing packages yourself the code should be copy and paste. 

```r
# check for and install devtools (for install_github) 
# and bookdown
pkgs = c("devtools", "bookdown")
pkgs_needed = pkgs[!(pkgs %in% installed.packages())]
for (pkg in pkgs_needed) {
    install.packages(pkg, dependecies = TRUE)
}
# install thesisdownrli
devtools::install_github("aj2duncan/thesisdownrli")
```

You should now have everything you need to start using `thesisdownrli`. 

## Contributing

If you would like to contribute to this project, please start by reading our [Guide to Contributing](CONTRIBUTING.md). Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
