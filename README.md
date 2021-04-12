# Omics data analysis project repository template

This template repository provides an organizational structure for more quickly setting up projects focused on the analysis of omics data. The directory structure accomodates projects that focus mainly on using semi-processed omics data (e.g., transcript quantifications derived from RNA-seq reads) as opposed to starting from raw data from omics assays. This README should be replaced by `README_template.md` for new repositories created from this template repository.

```
# Directory tree

{project name}
├── README.md
├── README_template.md
├── data
│   ├── processed
│   │   └── 0001
│   ├── raw
│   └── tmp
│       └── 0001
├── notebooks
│   ├── 1_preprocessing
│   ├── 2_eda
│   ├── 3_modeling_and_inference
│   └── 4_reports
├── results
│   ├── figures
│   │   └── 0001
│   ├── serialized
│   │   └── 0001
│   └── tables
│       └── 0001
├── src
│   ├── bash
│   ├── python
│   └── r
└── tests
```

<details>

<summary>Subdirectory descriptions</summary><br />


* `data`: Consists of data used for exploratory data analysis, model fitting, and statistical inference. Original data files are retrieved and stored in the `raw` folder. Intermediate files during processing are held in `tmp` before the final files are stored in `processed`. For analyses used to generate reports, there should be no dependencies on files in `tmp` so that those files can be deleted as needed.
* `notebooks`: Contains interactive notebooks (e.g., Jupyter) for various stages of data analysis projects. Data processing is logged in `1_preprocessing`, exploratory data analysis is logged in `2_eda`, model fitting and inference is logged in `3_modeling_and_inference`, and deliverable reports summarizing data characteristics, model details, inference results, etc. are stored in `4_reports`.
* `results`: Contains visualizations and tables for deliverable reports, as well as serialized results files that can be loaded into programming environments for further use.
* `src`: Contains source code and utility scripts used in data preparation and analysis.
* `tests`: Contains code for unit testing the code maintained in the src folder.

**Note:** Typically in omics analyses, multiple iterations of an analysis are conducted. This is considered in the directory structure through the use of numeric subdirectories that categorize files relevant to a specific analysis iteration. In the directory tree, `0001` represents the ID for the first analysis. With incremental numbering for analysis iterations, this ID format can accomodate 9999 analysis types/variations.

</details>
