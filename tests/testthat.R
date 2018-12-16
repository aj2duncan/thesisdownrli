library(testthat)
library(thesisdownrli)

# installing tinytex if not already present
if (!("tinytex" %in% installed.packages())) {
  install.packages("tinytex")
  tinytex::install_tinytex(force = TRUE)
} else if (!tinytex:::is_tinytex()) {
  tinytex::install_tinytex(force = TRUE)
}

test_check("thesisdownrli")
