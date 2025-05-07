# Directory overview for `task`

The subdirectories within `task` are divided by stage of analysis. Each stage will include a subdirectory ID that denotes a particular type of task (e.g., RNA-seq sample QC, differential gene expression analysis) using a sequential numbering system. Each task will have its own subdirectory with a sequential numbering system for specific iterations of that task type.

Directory descriptions:

* `0_examples`: Notebooks demonstrating how to do various tasks/analyses.
* `0_templates`: Cookie cutter notebook templates useful for copying when starting a new task.
* `1_munging`: Data munging and preprocessing tasks (e.g., phenotype harmonization, variable construction, data formatting).
* `2_eda`: Exploratory data analysis tasks (e.g., data characterization).
* `3_modeling_and_inference`: Model fitting and inference tasks.
* `4_reports`: Deliverable reports summarizing data characteristics, model details, inference results, etc.
