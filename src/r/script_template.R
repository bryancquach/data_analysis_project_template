#!/opt/conda/bin/Rscript

# Short description of script's purpose.
#
# Contributors:
#   Full name (email)
#
# Additional details worth noting, if any.
package_list <- c(
  "argparse"
)
for (package in package_list) {
  library(package, character.only = TRUE, quietly = TRUE)
}
options(stringsAsFactors = FALSE)

p <- argparse::ArgumentParser(
  prog = "Rscript script_template.R",
  description = paste0(
    "Description of this script's purpose. Word wrap at 100 characters."
  ),
  add_help = TRUE
)
p$add_argument( #example option
  "-f",
  "--foo",
  default = NULL,
  type = "character",
  dest = "foobar",
  required = FALSE,
  help = paste0(
    "Description for this option. Word wrap at 100 characters."
  )
)
p$add_argument( #example positional argument
  "bar",
  metavar = "bar",
  nargs = 1,
  type = "character",
  help = paste0(
    "Description for this positional argument. Word wrap at 100 characters."
  )
)
argv <- p$parse_args()
foo <- argv$foo #store option value
bar <- argv$bar #store positional argument value

#TODO: Add code body
