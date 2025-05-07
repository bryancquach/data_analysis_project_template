# README for Apptainer images

Each subdirectory for this directory includes a definition file to build an Apptainer image that creates an environment for a task/set of tasks. 

---
## Building an image

To build an amd64/x86_64 image, use the following build command:

```sh
# Working dir must be src/apptainer
singularity build --fakeroot --arch amd64 <image_name>/<image_name>_amd64_<yyyymmddhhmm>.sif <image_name>/<image_name>.def
```

To build an arm64 image, use the following build command:

```sh
# Working dir must be src/apptainer
singularity build --fakeroot --arch arm64 <image_name>/<image_name>_arm64_<yyyymmddhhmm>.sif <image_name>/<image_name>.def
```

The format `yyyymmddhhmm` corresponds to the year, month, day, hour (in 24-hour format), and minute.

---
## Singularity images

* `image name`: Description here. Installed software and packages of note:
  * [package name v0.0](URL)
* `gwas`: Software and tools for processing genotype and phenotype data and executing genetic variant association testing. Installed software and packages of note:
  * [Python3](https://www.python.org/)
  * [R v4.4.1](https://www.r-project.org/)
  * [tidyverse v2.0.0](https://cran.r-project.org/package=tidyverse)
  * [bcftools v1.21](https://samtools.github.io/bcftools/)
  * [PLINK v1.90b6.21](https://www.cog-genomics.org/plink/)
  * [Eigensoft v8.0.0](https://github.com/DReichLab/EIG)
  * [rvtests v2.1.0](https://github.com/zhanxw/rvtests)
  * [METAL v2011-03-25](https://csg.sph.umich.edu/abecasis/Metal/index.html)

