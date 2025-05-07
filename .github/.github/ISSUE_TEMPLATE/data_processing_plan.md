---
name: Data processing plan
about: Detail itemized plan for data processing
title: Data processing for `<insert data type and/or dataset label>`
labels: analysis plan
assignees: bquach_rtiintl

---

# Overview

This issue outlines the analysis plan and tracks progress for processing `<dataset details (e.g., data type, source, cohort>`.
  
## Data description

The data are derived from `<tissue type>` from `<cohort participant/animal model/in vitro expierment details>`. 

[//]: # (Include the section below if working with omics data. Something similar should be generated for other data types.)

The following are the library prep and sequencing specifics for the data:

  * Sample library prep kit\*: [`<name (e.g., Kapa Biosystems Stranded mRNA-seq Kit)>`](`<vendor URL>`) (see the [technical data sheet](`<link to technical data sheet>`) for details).
    * `<Bulleted list of potentially relevant info (e.g., polyA selection, biotype filtering, strandedness, spike-in controls, adapter sequences>`.
    
  * Sequencing was carried out on the [`<sequencing machine>`](`<vendor URL>`).
    * Read type: `<paired or single-end sequencing>`.
    * Read length: `<read length in base pairs>` bp.
    * Sequencing quality reported on the `<PHRED33 or PHRED64>` scale.

\***Note 1:** The library prep kit creates [`<library type (e.g., "directional, first-strand">` library types](https://chipster.csc.fi/manual/library-type-summary.html). For RNA-seq data processing this corresponds to the [`<Salmon library type (e.g., "ISR")>` library type for Salmon](https://salmon.readthedocs.io/en/latest/library_type.html#fraglibtype) and the [`--rna-strandness <parameter value>` specification for HISAT2](http://daehwankimlab.github.io/hisat2/manual/).

[//]: # (End section for omics data)

`<Paragraph here with additional details relevant for data processing>`.

## AWS S3 data location

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

[//]: # (Include here a bulleted list of data files needed for processing. Examples are included below.)

* FASTQ files: `s3://rti-hiv/shared_data/raw/omics_hiv_latent_reservoir/rna_expression/sequencing/cd4_t_cells/`. There should be `<number>` files per sample for `<number>` samples (`<number>` total files). 
* Adapter sequence file: `s3://rti-common/rnaseq_refs/hg38/rnaseq_trimmomaic_adapters.fa`
* Genome FASTA file: `s3://rti-common/rnaseq_refs/hg38/gencode_v34/GRCh38.primary_assembly.genome.fa`
* Transcriptome annotation files: 
  * `s3://rti-common/rnaseq_refs/hg38/gencode_v34/gencode.v34.primary_assembly.annotation.bed`
	* `s3://rti-common/rnaseq_refs/hg38/gencode_v34/gencode.v34.primary_assembly.annotation.gtf`
	* `s3://rti-common/rnaseq_refs/hg38/gencode_v34/gencode.v34.primary_assembly.annotation.flattened.gff`
* Salmon transcriptome reference index file: `s3://rti-common/rnaseq_refs/hg38/gencode_v34/salmon_index_hg38_gencode_human_v34.tar.gz`
* HISAT2 genome reference index file: `s3://rti-common/rnaseq_refs/hg38/gencode_v34/hisat2_index_hg38_gencode_human_v34.tar.gz`
* Example WDL workflow batch config template files: 
    * `s3://rti-hiv/shared_data/final/omics_hiv_latent_reservoir/rna_expression/sequencing/cd4_t_cells/rnaseq_analysis_alex_batch_4-3-13-2021/workflow_metadata/single_sample_rnaseq/hiv_batch4_rnaseq_input_template.yaml`
    * `s3://rti-hiv/shared_data/final/omics_hiv_latent_reservoir/rna_expression/sequencing/cd4_t_cells/rnaseq_analysis_alex_batch_4-3-13-2021/workflow_metadata/merge_rnaseq/hiv_batch4_rnaseq_merge_batch_config.yaml`

---

# Analysis plan

The following will be executed by `<tag GitHub user>`:

[//]: # (Include here a checkbox list of tasks to complete. Some standard tasks are include as a starting point.)

- [ ] Setup a local copy of the repository to work from, and [enable code cell clearing](../tree/develop#repository-setup).
- [ ] Branch off `develop` and build a Docker image with software needed for data processing tasks. See [this guide](https://github.com/bquach_rtiintl/omics_analysis_project_template/wiki/Using-and-Creating-Docker-images) for help with Docker image construction.
- [ ] Update `src/docker/README.md` and `src/docker/<Docker image name>/Dockerfile`.
- [ ] Submit a pull request to merge the Docker branch into `develop`. Templates for pull requests can be found [here](../tree/develop/.github/PULL_REQUEST_TEMPLATE/).
- [ ] Branch off `develop` onto a new analysis iteration branch `<branch name>`. Use the `analysis/1_munging/0000` or `analysis/1_munging/0000/0001` directory to [recursively create](https://github.com/bquach_rtiintl/omics_analysis_project_template/wiki/Template-repository-tips-and-tricks#0000-subdirectory-templates) a new analysis type or analysis iteration directory.
- [ ] Initiate restore of needed files. Do this programmatically with the AWS CLI as a bash script in `analysis/1_munging/<analysis ID>/<iteration ID>/code`. Commit and push code.
- [ ] `<task details>`
- [ ] Apply [code linting](https://github.com/bquach_rtiintl/omics_analysis_project_template/wiki/Using-and-creating-Docker-images#code-linting-for-python-and-r) to R and Python scripts.
- [ ] Update `analysis/1_munging/README.md` and `analysis/1_munging/<analysis ID>/README.md`.
- [ ] Submit pull request to merge `<branch name>` into `develop`. Templates for pull requests can be found [here]

[//]: # (OPTIONAL: Include here best practice reminders. Some suggestions are provided as a starting point.)

General conventions to note:

* Use lowercase and `_` instead of spaces in naming conventions when possible.
* Use 2 spaces to represent an indentation in code.
* Code lines should typically be 100 characters max.
* Follow the [tidyverse style guide](https://style.tidyverse.org/syntax.html?q=spacing#syntax) for R code and Google's [style guides](https://google.github.io/styleguide/) for other languages.
