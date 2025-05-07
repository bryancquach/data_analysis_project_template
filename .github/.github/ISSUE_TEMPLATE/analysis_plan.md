---
name: Analysis plan
about: Detail itemized plan for analyses
title: Analysis plan for `<short analysis description>`
labels: analysis plan
assignees: bquach_rtiintl

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
  # what you want. Replace `<s3_bucket>` with the name of your S3 bucket, and replace 
  # `<s3_path_to_objects>` with the path to the directory level that has objects you want to restore.
  # Use `"Tier": "Expedited"` in the below command for expedited retrieval (costs more money).

  path=s3://<s3_bucket>/<s3_path_to_objects>/
  for file in $(aws s3 ls $path --recursive  | awk '{print $4}'); do
      # Apply terminal output formatting for easier reading
      echo -e "\n\n--------------------------------------------------------------------------------"   
      echo "Attempting S3 restore on ${file}"
      aws s3api restore-object \
        --bucket <s3_bucket> \
        --restore-request '{"GlacierJobParameters":{"Tier":"Standard"}}' \
        --key $file
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
- [ ] Branch off `develop` onto a new analysis iteration branch `<branch name>`. Use the `analysis/*/0000` or `analysis/*/0000/0001` directory to [recursively create](https://github.com/bquach_rtiintl/omics_analysis_project_template/wiki/Template-repository-tips-and-tricks#0000-subdirectory-templates) a new analysis type or analysis iteration directory.
- [ ] Initiate restore of needed files programmatically using the AWS CLI. Use `aws s3 sync` to retrieve or update any processed data files needed for analysis. Commands for these processes should be logged in a notebook or code file in `analysis/<analysis category>/<analysis ID>/<iteration ID>/code`.
- [ ] `<task details>`
- [ ] Apply [code linting](https://github.com/bquach_rtiintl/omics_analysis_project_template/wiki/Using-and-creating-Docker-images#code-linting-for-python-and-r) to R and Python scripts.
- [ ] Update `analysis/<analysis category>/README.md` and `analysis/<analysis category>/<analysis ID>/README.md`.
- [ ] Submit pull request to merge `<branch name>` into `develop`. Templates for pull requests can be found [here](../tree/develop/.github/PULL_REQUEST_TEMPLATE/).

[//]: # (OPTIONAL: Include here best practice reminders. Some suggestions are provided as a starting point.)

General conventions to note:

* Use lowercase and `_` instead of spaces in naming conventions when possible.
* Use 2 spaces to represent an indentation in code.
* Code lines should typically be 100 characters max.
* Follow the [tidyverse style guide](https://style.tidyverse.org/syntax.html?q=spacing#syntax) for R code and Google's [style guides](https://google.github.io/styleguide/) for other languages.
