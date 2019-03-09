thesis_skeleton = function(path) {

  # ensure directory exists
  dir.create(path, recursive = TRUE, showWarnings = FALSE)

  # copy 'resources' folder to path
  resources = system.file('rstudio', 'templates', 'project', 'resources',
                          package = 'thesisdownrli', mustWork = TRUE)
  # list directories
  dirs = c("bib", "csl", "figure")

  # create directories
  lapply(paste0(path, "/", dirs), FUN = dir.create, showWarnings = FALSE)

  # list files to move
  files = list.files(resources, recursive = TRUE, include.dirs = TRUE)
  # move files
  source = file.path(resources, files)
  target = file.path(path, files)
  file.copy(source, target)

  # add book_filename to _bookdown.yml and default to the base path name
  f = file.path(path, '_bookdown.yml')
  x = xfun::read_utf8(f)
  xfun::write_utf8(c(sprintf('book_filename: "%s"', basename(path)), x), f)

  return(TRUE)
}