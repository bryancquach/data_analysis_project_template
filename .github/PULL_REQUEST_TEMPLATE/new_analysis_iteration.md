# Overview

Brief description of the analysis you are proposing to incorporate.

Specific items to bring to attention to review (if any):
* Item 1 (tag user that you want to review)
* Item 2 (tag user that you want to review)
* Item n (tag user that you want to review)

# Checklist

Things to always check before submitting a pull request:
- [ ] READMEs are added/updated for the new analysis.
- [ ] A `YYYYMMDD` date stamp is prefixed or suffixed in the filenames for log files, serialized objects, figures, tables, and analysis task iteration specific scripts and notebooks.
- [ ] Cell outputs in notebooks do not show data (i.e., calls to `head()` in R).
- [ ] Data files are not being committed.
- [ ] New data files are copied/synced to the repo storage space on AWS S3. See main repository README for the storage location.
- [ ] Committed serialized objects do not contain data.
- [ ] Committed serialized objects and output tables are not too large (>50Mb). See main repository README for the storage location of large repository files (e.g., AWS S3).
- [ ] Notebooks include a reference to the Docker image used (and Dockerfile from which it was built).
- [ ] R notebooks include a `sessionInfo()` call at the end.
- [ ] New functions include documentation. Use [roxygen2 compatible Markdown syntax](https://roxygen2.r-lib.org/articles/rd-formatting.html) for R code. Use [docstrings](https://peps.python.org/pep-0257/) that are [docutils compatible](https://peps.python.org/pep-0258/) for Python code.
- [ ] Bash scripts include [usage documentation](https://opensource.com/article/19/12/help-bash-program).
- [ ] R scripts include usage documentation using [argparse](https://cran.r-project.org/package=argparse).
- [ ] Python scripts include usage documentation using [argparse](https://docs.python.org/3/library/argparse.html#module-argparse).
- [ ] Code linting has been applied to R and Python scripts.

