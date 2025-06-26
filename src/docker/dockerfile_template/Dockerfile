####################################################################################################
# Dockerfile template
#
# This is a template Dockerfile with sections that can be used to build Docker images with
# specific features including:
# - Jupyter Lab
# - Specific version of R and R packages
# - Python3 with specific versions of Python packages
# - AWS CLI
# The code herein is adapted from and extends the Docker Stacks R notebook:
# https://github.com/jupyter/docker-stacks/blob/main/images/r-notebook/Dockerfile
#
# Contributors: Bryan Quach (bryancquach@gmail.com)
####################################################################################################

# ==================================== Base image ====================================

# This section is the foundation for all images for the repository. It sets Ubuntu 22.04 as the 
# operating system. Other versions of Ubuntu can be used by specifying a different base image from
# https://hub.docker.com/r/jupyter/minimal-notebook/tags. The Docker Stacks minimal-notebook
# includes Python3, JupyterLab, and conda/mamba already. More details on what's installed here:
# https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html#jupyter-minimal-notebook

ARG OWNER=jupyter
ARG BASE_CONTAINER=$OWNER/minimal-notebook:ubuntu-22.04
FROM $BASE_CONTAINER

LABEL maintainer="Full Name <email>"

# Set pipefail to prevent pipe bugs in RUN
# https://github.com/hadolint/hadolint/wiki/DL4006
# Set bash shell to ensure equality testing syntax works
# https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

# Enable Docker container user to run Jupyter server as root user by default
RUN sed -i 's/c\.ServerApp\.allow_root = False/c.ServerApp.allow_root = True/' \
  /home/${NB_USER}/.jupyter/jupyter_server_config.py

# ==================================== Including R ====================================

# This section extends the base image with a set of Linux packages needed to install R and a core
# set of R packages. The R version can be manually set. Here it is preset as R v4.3.2 but can be
# any version that exists in conda-forge. The R devtools package is used to install other R
# packages. This enables a simple way to ensure that a specific version of the packages gets
# installed. The R package versions are pre-defined in this section, but they should be updated
# with the desired versions. Ideally, the package versions should be the most recent possible for
# a given version of R.

# R pre-requisites
RUN apt-get update --yes && \
  apt-get install --yes --no-install-recommends \
    fonts-dejavu \
    gfortran \
    build-essential \
    automake \
    libfreetype6-dev && \
  apt-get clean && rm -rf /var/lib/apt/lists/* && \
  mamba install --yes 'unixodbc=2.3.12' && \
  mamba clean --all -f -y && \
  fix-permissions "${CONDA_DIR}" && \
  fix-permissions "/home/${NB_USER}"

# Add channel for Bioconductor packages
RUN conda config --append channels bioconda --file /opt/conda/.condarc

# R packages including IRKernel (needed to link R and Jupyter) which gets installed globally.
# Default packages included in Docker Stacks r-notebook
# Forcing R version to be 4.4.1
RUN mamba install --quiet --yes 'r-base=4.4.1' && \
  mamba clean --all -f -y && \
  fix-permissions "${CONDA_DIR}" && \
  fix-permissions "/home/${NB_USER}"

RUN ln -sf /opt/conda/include/freetype2/* /opt/conda/include/ && \
  ln -sf /opt/conda/include/harfbuzz/* /opt/conda/include/ && \
  ln -sf /opt/conda/include/fribidi/* /opt/conda/include/ && \
  Rscript -e 'install.packages( \
    c( \
      "devtools" \
    ), \
    repos = "https://mirrors.nics.utk.edu/cran/" \
  );' && \
  mamba clean --all -f -y && \
  fix-permissions "${CONDA_DIR}"
  
RUN Rscript -e 'devtools::install_version( \
    package = "crayon", \
    version = "1.5.3", \
    repos = "https://mirrors.nics.utk.edu/cran/" \
  )' && \
  Rscript -e 'devtools::install_version( \
    package = "htmltools", \
    version = "0.5.8.1", \
    repos = "https://mirrors.nics.utk.edu/cran/" \
  )' && \
  Rscript -e 'devtools::install_version( \
    package = "htmlwidgets", \
    version = "1.6.4", \
    repos = "https://mirrors.nics.utk.edu/cran/" \
  )' && \
  Rscript -e 'devtools::install_version( \
    package = "IRkernel", \
    version = "1.3.2", \
    repos = "https://mirrors.nics.utk.edu/cran/" \
  )' && \
  Rscript -e 'devtools::install_version( \
    package = "RCurl", \
    version = "1.98.1.13", \
    repos = "https://mirrors.nics.utk.edu/cran/" \
  )' && \
  Rscript -e 'devtools::install_version( \
    package = "rmarkdown", \
    version = "2.28", \
    repos = "https://mirrors.nics.utk.edu/cran/" \
  )' && \
  Rscript -e 'devtools::install_version( \
    package = "RODBC", \
    version = "1.3.23", \
    repos = "https://mirrors.nics.utk.edu/cran/" \
  )' && \
  Rscript -e 'devtools::install_version( \
    package = "RSQLite", \
    version = "2.3.3", \
    repos = "https://mirrors.nics.utk.edu/cran/" \
  )' && \
  Rscript -e 'devtools::install_version( \
    package = "shiny", \
    version = "1.8.0", \
    repos = "https://mirrors.nics.utk.edu/cran/" \
  )' && \
  Rscript -e 'devtools::install_version( \
    package = "data.table", \
    version = "1.16.0", \
    repos = "https://mirrors.nics.utk.edu/cran/" \
  )' && \
  Rscript -e 'devtools::install_version( \
    package = "tidyverse", \
    version = "2.0.0", \
    repos = "https://mirrors.nics.utk.edu/cran/" \
  )' && \
  Rscript -e 'devtools::install_version( \
    package = "tidymodels", \
    version = "1.2.0", \
    repos = "https://mirrors.nics.utk.edu/cran/" \
  )'  && \
  Rscript -e 'devtools::install_version( \
    package = "ggplot2", \
    version = "3.5.1", \
    repos = "https://mirrors.nics.utk.edu/cran/" \
  )' && \
  Rscript -e 'IRkernel::installspec()' && \
  mamba clean --all -f -y && \
  fix-permissions "${CONDA_DIR}"

# ==================================== Adding R packages ====================================

# This section is for any additional R packages that are desired beyond the core set above. It
# follows the same syntax of using devtools to install specific package versions from CRAN. For
# Bioconductor packages, the package version installed is governed by the BiocManager package
# version, which determines the Bioconductor version.
#
# Some of the R packages may be missing Linux package dependencies, which will cause an error when
# building the Docker image. These should be added to the `apt-get install` line below or through
# the use of `mamba install`. See the troubleshooting guide for insight on how to deal with errors
# when building packages from source:
# https://github.com/bquach_rtiintl/omics_analysis_project_template/wiki/Template-repository-tips-and-tricks#dealing-with-cc-related-compilation-errors-when-installing-software-or-building-from-source

# Additional R CRAN packages and dependencies that extend r-notebook
RUN apt-get update --yes && \
  apt-get install --yes --no-install-recommends <INSERT UBUNTU PACKAGE NAME HERE> && \
  apt-get clean && rm -rf /var/lib/apt/lists/* && \
  Rscript -e 'devtools::install_version( \
    package = "<INSERT PACKAGE NAME HERE>", \
    version = "<INSERT PACKAGE VERSION HERE>", \
    repos = "https://mirrors.nics.utk.edu/cran/" \
  )' && \
  Rscript -e 'devtools::install_version( \
    package = "BiocManager", \
    version = "<INSERT PACKAGE VERSION HERE>", \
    repos = "https://mirrors.nics.utk.edu/cran/" \
  )' && \
  mamba clean --all -f -y && \
  fix-permissions "${CONDA_DIR}"
  
# Additional R Bioconductor packages that extend r-notebook
RUN Rscript -e 'BiocManager::install( \
    c( \
      "<INSERT PACKAGE NAME HERE>" \
    ) \
  );' && \
  mamba clean --all -f -y && \
  fix-permissions "${CONDA_DIR}"

# ================================ Adding omixjutsu R package ================================

# This section is for installing the R package omixjutsu (https://github.com/bryancquach/omixjutsu).
# Due to a bug in how R installs and resolves package dependencies, a specific set of steps is
# needed and laid out in this section to ensure that compilation of source code for dependencies
# succeeds. Version specification for omixjutsu is done using a git commit hash.
  
# Manually install lpsymphony and IHW as a pre-req for omixjutsu
# https://github.com/bryancquach/omixjutsu/issues/2#issue-1557056581
RUN apt-get remove --yes gfortran gfortran-11 && \
  apt-get update --yes && \
  apt-get install --yes --no-install-recommends \
  build-essential \
  pkg-config && \
  Rscript -e 'BiocManager::install(c("lpsymphony", "IHW"));' && \
  apt-get install --yes --no-install-recommends \
  gfortran \
  gfortran-11 && \
  Rscript -e 'devtools::install_github("bryancquach/omixjutsu", ref = "532373d");' && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# ==================================== Adding Python packages ====================================

# This section is for installing Python packages. It makes use of the conda-forge and bioconda 
# package channels in conjunction with the mamba package manager. The template below can be
# expanded with multiple "mamba install" commands, one for each package desired.

RUN mamba install --quiet --yes '<INSERT PACKAGE NAME HERE>=<INSERT PACKAGE VERSION HERE>' && \
  mamba clean --all -f -y && \
  fix-permissions "${CONDA_DIR}" && \
  fix-permissions "/home/${NB_USER}"


# ==================================== Adding AWS CLI ====================================

# This section is for installing the AWS CLI so that AWS resources can be used within the
# Docker image. AWS creates zipped source files for each version of the CLI. One is included by
# default in this section, but a different version can be selected as described here:
# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-version.html

# AWS CLI install
RUN apt-get update --yes && \
  apt-get install --yes --no-install-recommends \
    curl \
    unzip \
    groff-base && \
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.13.24.zip" \
    -o "awscliv2.zip" && \
  unzip awscliv2.zip && \
  ./aws/install && \
  rm -rf aws/ awscliv2.zip && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# ==================================== Image finalization ====================================

# This section should include final configurations that may be needed for the image. By default a
# JupyterLab JSON config file is added from src/docker/jupyter_settings/. The JSON file can be
# tailored to modify UI theme, tab behavior, etc.

# Jupyter Lab settings config file
RUN mkdir /opt/conda/share/jupyter/lab/settings
COPY jupyter_settings/overrides.json /opt/conda/share/jupyter/lab/settings/

# Set user back to not being root
USER ${NB_UID}
