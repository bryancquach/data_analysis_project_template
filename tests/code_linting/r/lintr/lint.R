#!/opt/conda/bin/Rscript
# Run code linting on a given file
package_list <- c("argparse", "lintr")
for (package in package_list) {
  library(package, character.only = TRUE, quietly = TRUE)
}
options(stringsAsFactors = FALSE)

p <- argparse::ArgumentParser(
  prog = "Rscript lint.R",
  description = paste0(
    "A wrapper script for the lintr R package. Checks an R code file for style consistency with ",
    "a specified style guide."
  ),
  add_help = TRUE
)
p$add_argument(
  "-c",
  "--config",
  type = "character",
  dest = "config",
  required = TRUE,
  help = paste0(
    "A .lintr DCF file that specifies the linters to use. A default file is available within the ",
    "repository at tests/code_linting/r/lintr/.lintr that uses a modified version of Google's R ",
    "style guide."
  )
)
p$add_argument(
  "code_file",
  metavar = "code_file",
  nargs = 1,
  type = "character",
  help = "The code file (with path) to lint."
)
argv <- p$parse_args()
config_file <- argv$config
code_file <- argv$code_file
cat("\nLoading .lintr file", config_file, "...\n")
if (!file.exists(config_file)) {
  warning(
    paste0(
      "Default .lintr file could not be found at ",
      config_file,
      ". Reverting to default lintr package settings."
    )
  )
}
options(lintr.linter_file = config_file)
cat("\nLinting file", code_file, "...\n\n")
lintr::lint(code_file)
cat("Linting complete.\n")
