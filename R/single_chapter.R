#' Creates pdf document from a single chapter of thesis with references
#'
#' In general the references in a thesis will be in a separate references
#' section but a student will want an individual chapter to be proof read
#' by someone else (e.g. a supervisor). This function makes this easier by
#' creating a temporary R markdown file adding a references section and
#' with the chapter to be rendered as a child document. More information
#' please see the online \href{https://aj2duncan.github.io/thesisdownrli/reference/single_chapter.html}{vignette}.
#'
#' The function will parse the contents of index.Rmd and file the line which
#' details the bibliography for the thesis and use this for the single chapter.
#' Please make sure index.Rmd is in the working directory.
#'
#' @param chapter filename of chapter to render.
#'
#' @examples
#' \dontrun{
#' single_chapter("01-chap1.Rmd")
#' }
#' @export
single_chapter = function(chapter) {
  # create random file name
  rand_num = sample(c(1000:9999), size = 1)
  rand_file = paste0("temporary_", rand_num, ".Rmd")

  if (file.exists("index.Rmd")) {
    temp_index = readLines("index.Rmd")
    bib = temp_index[grepl("^bibliography", temp_index)]
  } else {
    stop("Unable to find index.Rmd.
         Please make sure the current working directory is correct.")
  }


  # create YAML header in temporary file
  Rmd_file = c(
    "---",
    bib,
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

#' Add in for \code{single_Chapter} function.
#'
#' @export
single_chapter_addin <- function(){


  # Our ui will be a simple gadget page, which
  # simply displays the time in a 'UI' output.
  ui <- miniPage(
    miniTitleBar("Knit a Single Chapter"),
    miniContentPanel(
      fileInput("single_chapter_input", "Please choose single chapter to knit",
                multiple = FALSE, accept = ".Rmd"),
      p(strong("Note:"), "The R Markdown file selected must be in the current
        working directory."),
      actionButton("knit_chapter", "Knit Single Chapter")
    )
  )

  server <- function(input, output, session) {
    observeEvent(input$knit_chapter, {
      chapter_to_knit = isolate(input$single_chapter_input)
      single_chapter(chapter_to_knit$name)
    })

  }

  # run add-in in viewer
  viewer <- dialogViewer("thesisdownrli", width = 400, height = 400)
  runGadget(ui, server, viewer = viewer)
}

