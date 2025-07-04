# Data analysis project repository template

This template repository provides an organizational structure for more quickly setting up data analysis projects. The directory structure was designed with a particular focus on starting with semi-processed omics data (e.g., transcript quantifications derived from RNA-seq reads) as opposed to starting from raw data from omics assays, though the latter is still feasible. This README should be replaced by `README_template.md` for new repositories created from this template repository.

# Is this template right for your project?

This repo template is most helpful for projects that have the following characteristcs:
* Reproducibility being a key requirement and priority.
* Cross-platform compatibility (e.g., doing project work across local machines, an on-premise server, and cloud environments).
* Complex data processing and analyses that can be divided into multiple tasks.
* Data processing or analysis tasks that may require implementing multiple iterations due to exploration of parameter choices or methods.
* Contributors needing to work simultaneously on independent components of the data processing and analysis workflow.
* Dynamic teams where an individual may only be brought on to contribute to a subset of tasks and onboarding/offboarding is common.

# Directory structure

```
# Directory tree

{project name}
├── LICENSE
├── README.md
├── README_template.md
├── task
│   ├── 0_examples
│   ├── 0_templates
│   │   └── r_analysis_notebook_template.ipynb
│   ├── 1_munging
│   │   ├── 0000
│   │   │   ├── 0001
│   │   │   │   ├── figures
│   │   │   │   ├── code
│   │   │   │   ├── serialized
│   │   │   │   └── tables
│   │   │   └── README.md
│   │   ├── 0001
│   │   │   ├── 0001
│   │   │   │   ├── figures
│   │   │   │   ├── code
│   │   │   │   ├── serialized
│   │   │   │   └── tables
│   │   │   └── README.md
│   │   └── README.md
│   ├── 2_eda
│   │   ├── 0000
│   │   │   ├── 0001
│   │   │   │   ├── figures
│   │   │   │   ├── code
│   │   │   │   ├── serialized
│   │   │   │   └── tables
│   │   │   └── README.md
│   │   ├── 0001
│   │   │   ├── 0001
│   │   │   │   ├── figures
│   │   │   │   ├── code
│   │   │   │   ├── serialized
│   │   │   │   └── tables
│   │   │   └── README.md
│   │   └── README.md
│   ├── 3_modeling_and_inference
│   │   ├── 0000
│   │   │   ├── 0001
│   │   │   │   ├── figures
│   │   │   │   ├── code
│   │   │   │   ├── serialized
│   │   │   │   └── tables
│   │   │   └── README.md
│   │   ├── 0001
│   │   │   ├── 0001
│   │   │   │   ├── figures
│   │   │   │   ├── code
│   │   │   │   ├── serialized
│   │   │   │   └── tables
│   │   │   └── README.md
│   │   └── README.md
│   ├── 4_reports
│   │   ├── 0001
│   │   │   ├── 0001
│   │   │   └── README.md
│   │   └── README.md
│   └── README.md
├── data
│   ├── processed
│   │   ├── README.md
│   │   └── dataset_0001
│   │       ├── 0001
│   │       └── README.md
│   ├── raw
│   │   ├── README.md
│   │   ├── annotations
│   │   └── dataset_0001
│   └── tmp
│       └── dataset_0001
├── scratch
├── src
│   ├── bash
│   ├── docker
│   │   ├── README.md
│   │   └── jupyter_settings
│   │       └── overrides.json
│   ├── python
│   └── r
└── tests
    └── code_linting
        ├── python3
        │   └── pylint
        │       └── pylintrc
        └── r
            └── lintr
                └── lint.R
```

<details>

<summary>Subdirectory descriptions</summary><br />

* `data`: Consists of data used for exploratory data analysis, model fitting, and statistical inference. Original data files are retrieved and stored in the `raw` folder. Intermediate files during processing are held in `tmp` before the final files are stored in `processed`. For analyses used to generate reports, there should be no dependencies on files in `tmp` so that those files can be deleted as needed.
* `task`: Contains interactive notebooks (e.g., Jupyter) or code, visualizations, tables, and serialized output files for various tasks of data analysis projects. The subdirectories further divide results or output by types of processing/analysis tasks and task instances, using a two-tier sequential numbering system.
* `src`: Contains reusable source code and utility scripts used in data retrieval, preparation, and analysis tasks.
* `tests`: Contains code for unit testing the code maintained in the src folder. Also includes code linting tools for style checking Python and R code.
* `scratch`: Scratch space for temporary local files.

**Note:** Typically in omics analyses, multiple iterations of a processed dataset or analysis task are generated. This is considered in the directory structure through the use of numeric subdirectories that categorize files relevant to a specific dataset, task type, or task iteration. In the directory tree, the incremental numbering for subdirectories uses a 4-digit ID format that can accomodate 9999 tasks/variations.

</details>
