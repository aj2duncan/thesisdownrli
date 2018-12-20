# thesisdownrli 

[![Build Status](https://travis-ci.org/aj2duncan/thesisdownrli.svg?branch=master)](https://travis-ci.org/aj2duncan/thesisdownrli)

This project provides a template for writing a PhD dissertation in R Markdown, and rendering those files into a PDF formatted for submission at the University of the Highlands and Islands . At present it uses a modified version of the thesis template from the University of California, Santa Barbara to convert R Markdown files. This package is a more or less direct copy of `gauchodown`.  Huge thanks to

-[gauchodown](https://github.com/kmillage/gauchodown) 

-[huskydown](https://github.com/benmarwick/huskydown)

-[thesisdown](https://github.com/ismayc/thesisdown) 

-[bookdown](https://github.com/rstudio/bookdown)

Currently, the PDF and gitbook versions are fully-functional, and are the focus of this package. The word and epub versions are in development, have no templates behind them, and are essentially calls to the appropriate functions in bookdown.

## Installation

In order to use `thesisdownrli` it is necessary to have some prerequisites installed, namely Pandoc and LaTeX. Once these are installed you ready to install the package itself.

### Installing Pandoc and LaTeX

If RStudio is already installed then so is Pandoc. If you haven't installed RStudio the most recent version is available [here](http://www.rstudio.com/products/rstudio/download/) and installing it will install Pandoc. If you are not an RStudio user, Pandoc can downloaded from [here](https://pandoc.org/installing.html).

Having installed Pandoc, the final piece of software required is LaTeX, which is necessary to build PDF documents. By far the easiest way for any `R` user to install LaTeX on any platform is with the [`tinytex`](https://yihui.name/tinytex/) package:

```
install.packages(c('tinytex', 'rmarkdown'))
tinytex::install_tinytex(force = TRUE)
# after restarting your R session, confirm that you have LaTeX with 
tinytex:::is_tinytex()
```

### Installing `thesisdownrli`

The code below should install all the prerequisites for `thesisdownrli`. If you are unsure about installing packages yourself the code should be copy and paste. 

```
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

## Using `thesisdownrli`

It is possible to use `thesisdownrli` without RStudio but it will probably work best with it. 

### From RStudio

There are two ways to use `thesisdownrli` with RStudio. 

1. If you generally make use of RStudio projects then you can open a new thesis project (using thesisdownrli and bookdown) from the list of *New Project* options. 

![](https://www.dropbox.com/s/7uz6hjewx1a19ux/Thesis-Project.png?raw=1)

This will create a new RStudio project in a folder containing all the template files needed. 

2. If you don't use RStudio projects you can create a similar template folder from an *R Markdown* template. Use File -> New File -> R Markdown... then choose *From template*, then choose *Thesis-RLI*, and enter `index` as the *Name*. This will create a new folder titled *index*. Once this has been created you can rename the folder. **Note:** The temporary files will currently only **Knit** if you name the directory `index` when creating it. 
![](https://www.dropbox.com/s/m2nndk8upnb9tqq/Thesis-Template.png?raw=1)

### Without RStudio

If you're not using RStudio, run this line in your R console to create a new PhD dissertation from the template:

```r
rmarkdown::draft('index.Rmd', template = 'thesis', package = 'thesisdownrli', create_dir = TRUE)
```

## Creating Your Thesis

If you have followed the steps above then hopefully you will have a new folder containing some template R markdown files amongst other things. To test whether everything is working ok you should now open the file named *index.Rmd* (if it isn't already open) and click the **Knit** button at the top. 

## Contributing

If you would like to contribute to this project, please start by reading our [Guide to Contributing](CONTRIBUTING.md). Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
