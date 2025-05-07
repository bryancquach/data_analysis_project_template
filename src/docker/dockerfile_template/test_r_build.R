#!/opt/conda/bin/Rscript

# Test Docker R environment for build issues.
#
# Contributors:
#   Bryan Quach (bquach@rti.org)
#
# This script logs output to STDOUT with pertinent information regarding the R environment within
# a Docker image, including:
#   * R version.
#   * Package versions of installed R packages.
#   * Package loading messages.
# Issues with any of the above will output as runtime errors. Only packages explicitly specified
# in the code will be checked.

# Template code for default packages installed with r-notebooks
# Use an empty vector if you do not want to check these
packages <- c(
  "crayon",
  "htmltools",
  "htmlwidgets",
  "IRkernel",
  "RCurl",
  "rmarkdown",
  "RODBC",
  "RSQLite",
  "shiny",
  "data.table",
  "tidyverse",
  "tidymodels",
  "ggplot2"
)

# Additional packages you want to check
packages <- c(
  packages,
  ""
)

# Check R version
cat(version$version.string, "\n")

# Check package versions. Error message will be printed if package is not installed.
for (package in packages) {
  cat("\n========================================\n")
  cat("Package: ", package, "\n")
  try_out <- try(packageVersion(package), silent = TRUE)
  if (!any(class(try_out) %in% "try-error")) {
    cat("Version: ", as.character(try_out), "\n")
  } else {
    cat(geterrmessage(), "\n")
  }
}

# Try package loading. Error message will be printed if package is not installed.
for (package in packages) {
  cat("\n================================================================================\n")
  cat("PACKAGE: ", package, "\n\n")
  try_out <- try(library(package, character.only = TRUE), silent = TRUE)
  if (any(class(try_out) %in% "try-error")) {
    cat("ERROR: Package failed to load.\n")
    cat(geterrmessage(), "\n")
  }
}
