#' Creates pdf document from a single chapter of thesis with references
#'
#' In general the references in a thesis will be in a separate references
#' section but a student will want an individual chapter to be proof read
#' by someone else (e.g. a supervisor). This function makes this easier by
#' creating a temporary R markdown file adding a references section and
#' with the chapter to be rendered as a child document.
#'
#' @param chapter filename of chapter to render.
#' @param bib_file filepath to bibtex file for references. Defaults to
#' "bib/thesis.bib" the default for thesisdownrli.
#'
#' @examples
#' \dontrun{
#' single_chapter("01-chap1.Rmd")
#' }
#' @export
single_chapter = function(chapter, bib_file = "bib/thesis.bib") {
  # create random file name
  rand_num = sample(c(1000:9999), size = 1)
  rand_file = paste0("temporary_", rand_num, ".Rmd")

  # create YAML header in temporary file
  Rmd_file = c(
    "---",
    paste("bibliography:", bib_file),
    "params:",
    "  filename: ''",
    "---",
    "```{r, child = params$filename}",
    "```",
    "",
    "## References",
    "")

  xfun::write_utf8(paste(Rmd_file, collapse = "\n"), con = rand_file)

  # render file with chapter as child document
  rmarkdown::render(rand_file,
                    output_file = sub("Rmd", "pdf", chapter),
                    output_format = "bookdown::pdf_document2",
                    output_options = list(toc = FALSE),
                    params = list(filename = chapter))

  # remove directories containing temp files
  # start with temporary_####_cache
  temp_directory = sub(".Rmd", "_cache", rand_file)
  if (dir.exists(temp_directory)) {
    unlink(temp_directory, recursive = TRUE, force = TRUE)
  }
  # remove .Rmd file
  unlink(rand_file)

  # remove chapter_files directory
  temp_directory = sub(".Rmd", "_files", chapter)
  if (dir.exists(temp_directory)) {
    unlink(temp_directory, recursive = TRUE, force = TRUE)
  }

}

