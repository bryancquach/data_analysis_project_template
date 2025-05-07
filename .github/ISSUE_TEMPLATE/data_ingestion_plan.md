---
name: Data ingestion plan
about: Detailed plan for retrieving external data
title: Data ingestion for `<insert data type and/or dataset label>`
labels: data ingestion
assignees: 

---

# Overview

This issue outlines the data ingestion plan for `<dataset details (e.g., data type, source, cohort>`.
  
## Data description

The data are derived from `<tissue type>` from `<cohort participant/animal model/in vitro expierment details>`. 

`<Additional details such as batch info and email references (if applicable) that are useful for understanding the data>`.

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

## External data sources

`<Paragraph and/or bulleted list of details regarding where the data are coming from and how many samples/files to expect>`.

## AWS S3 data location

[//]: # (Include here a bulleted list of proposed data locations. An example is provided.)

The external data will be stored at the following S3 locations:
* FASTQ files: `s3://rti-hiv/shared_data/raw/omics_hiv_latent_reservoir/rna_expression/sequencing/cd4_t_cells/`. 

---

General conventions to note:

* Add a `YYYYMMDD` date stamp to filenames for log files, serialized objects, figures, tables, and analysis task iteration specific scripts and notebooks.
* Keep file names from data sent by collaborators unmodified.
* Use only `_` to separate components of a file name. Avoid the use of `.`, `-`, `+`, `%`, `$` and other special characters. Exceptions are made for file and folder names that use decimal numbers, but `dot` can be used as an alternative to `.` (e.g., `fdr0dot01` vs. `fdr0.01`).
* Use all lowercase. Avoid [camel case](https://en.wikipedia.org/wiki/Camel_case).
* With the exception of README files, all files should include a file extension.
