---
name: Analysis plan
about: Detail itemized plan for analyses
title: Analysis plan for `<short analysis description>`
labels: analysis plan
assignees:

---

# Overview

This issue outlines the analysis plan and tracks progress for `<analysis details (analysis type, dataset version, statistical inference method, analysis software, analysis goals, etc.)>`.

## AWS S3 data locations

**Note:** S3 files archived by intelligent-tiering need to be restored before processing. Example code for doing batch restores with the AWS CLI:

<details>
  
  <summary>Expand for code</summary><br />

  ```bash
  # This works if multiple Intelligent-tiering files are mixed among Standard tier files. 
  # Restores objects within ALL directory levels below the one you specify, so only use if that is
  # what you want. Replace `<S3 BUCKET>` with the name of your S3 bucket, and replace 
  # `<S3 PATH TO OBJECTS>` with the path to the directory level that has objects you want to 
  # restore. Use `"Tier": "Expedited"` or `"Tier": "Standard"` in the below command for expedited
  # retrieval (costs more money). Other storage class options for `?StorageClass` include:
  # `STANDARD`, `REDUCED_REDUNDANCY`, `STANDARD_IA`, `ONEZONE_IA`, `GLACIER`, `DEEP_ARCHIVE`,
  # `OUTPOSTS`, `GLACIER_IR`, `SNOW`, and `EXPRESS_ONEZONE`. The `--query` option filters S3
  # objects to retrieve according to their storage class.

  
  for file in $(aws s3api list-objects-v2 \
        --bucket <S3 BUCKET> \
        --prefix <S3 PATH TO OBJECTS>/ \
        --no-paginate \
        --query "Contents[?StorageClass=='INTELLIGENT_TIERING'].Key" \
        --output text | \
      sed \n \
    ); do
    # Apply terminal output formatting for easier reading
    echo -e "\n\n--------------------------------------------------------------------------------"
    echo "Attempting S3 restore on ${file}"
    aws s3api restore-object \
      --bucket <S3 BUCKET> \
      --key ${file} \
      --restore-request '{"GlacierJobParameters": {"Tier":"Bulk"}}' \
      --output text
    done
  ```
    
</details>

[//]: # (Include here a bulleted list of data files on S3 needed for processing)

* `<Data type>`: `<S3 URI>`

## External data locations

[//]: # (Include here a bulleted list of public data URLs needed for this analysis)

* `<Data type>`: `<URL>`

---

# Analysis plan

The following will be executed by `<tag GitHub user>`:

[//]: # (Include here a checkbox list of tasks to complete. Some standard tasks are include as a starting point.)

- [ ] Setup a local copy of the repository to work from, and [enable code cell clearing](../tree/develop#repository-setup).
- [ ] Branch off `develop` and build a Docker image with software needed for data processing tasks. See [this guide](https://github.com/bquach_rtiintl/omics_analysis_project_template/wiki/Using-and-Creating-Docker-images) for help with Docker image construction.
- [ ] Update `src/docker/README.md` and `src/docker/<Docker image name>/Dockerfile`.
- [ ] Submit a pull request to merge the Docker branch into `develop`. Templates for pull requests can be found [here](../tree/develop/.github/PULL_REQUEST_TEMPLATE/).
- [ ] Branch off `develop` onto a new analysis iteration branch `<branch name>`. Use the `task/*/0000` or `task/*/0000/0001` directory to [recursively create](https://github.com/bquach_rtiintl/omics_analysis_project_template/wiki/Template-repository-tips-and-tricks#0000-subdirectory-templates) a new analysis type or analysis iteration directory.
- [ ] Initiate restore of needed files programmatically using the AWS CLI. Use `aws s3 sync` to retrieve or update any processed data files needed for analysis. Commands for these processes should be logged in a notebook or code file in `task/<task category>/<task ID>/<iteration ID>/code`.
- [ ] `<task details>`
- [ ] Apply [code linting](https://github.com/bquach_rtiintl/omics_analysis_project_template/wiki/Using-and-creating-Docker-images#code-linting-for-python-and-r) to R and Python scripts.
- [ ] Update `task/<task category>/README.md` and `task/<task category>/<task ID>/README.md`.
- [ ] Submit pull request to merge `<branch name>` into `develop`. Templates for pull requests can be found [here](../tree/develop/.github/PULL_REQUEST_TEMPLATE/).

Key deliverables:

[//]: # (Include here a list of files/file types that you want to highlight as crucial output)

* `<Description of deliverable here (e.g., data type, repo location, etc.)>`

[//]: # (OPTIONAL: Include here best practice reminders. Some suggestions are provided as a starting point.)

General conventions to note:

* Add a `YYYYMMDD` date stamp to filenames for log files, serialized objects, figures, tables, and analysis task iteration specific scripts and notebooks.
* Use lowercase and `_` instead of spaces in naming conventions when possible.
* Use 2 spaces to represent an indentation in code.
* Code lines should typically be 100 characters max.
* Follow the [tidyverse style guide](https://style.tidyverse.org/syntax.html?q=spacing#syntax) for R code and Google's [style guides](https://google.github.io/styleguide/) for other languages.
