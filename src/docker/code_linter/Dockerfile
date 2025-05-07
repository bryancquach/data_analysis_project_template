# Adapted from https://github.com/jupyter/docker-stacks/blob/main/images/r-notebook/Dockerfile
ARG OWNER=jupyter
ARG BASE_CONTAINER=$OWNER/docker-stacks-foundation:ubuntu-22.04
FROM $BASE_CONTAINER
LABEL maintainer="Bryan Quach <bquach@rti.org>"

# Set pipefail to prevent pipe bugs in RUN
# https://github.com/hadolint/hadolint/wiki/DL4006
# Set bash shell to ensure equality testing syntax works
# https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

# R pre-requisites
RUN apt-get update --yes && \
  apt-get install --yes --no-install-recommends \
  build-essential \
  libfreetype6-dev && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# R install
RUN mamba install --quiet --yes 'r-base=4.2.2' && \
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
  fix-permissions "${CONDA_DIR}" && \
  fix-permissions "/home/${NB_USER}"

# R code linter
RUN Rscript -e 'devtools::install_version( \
    package = "argparse", \
    version = "2.2.2", \
    repos = "https://mirrors.nics.utk.edu/cran/" \
  )' && \
  Rscript -e 'devtools::install_version( \
    package = "lintr", \
    version = "3.1.0", \
    repos = "https://mirrors.nics.utk.edu/cran/" \
  )' && \
  mamba clean --all -f -y && \
  fix-permissions "${CONDA_DIR}" && \
  fix-permissions "/home/${NB_USER}"

COPY code_linter/lint.R /opt/bin/

RUN chmod a+x /opt/bin/lint.R

# Python code linter
RUN mamba install --quiet --yes \
  'pylint=2.17.5' && \
  mamba clean --all -f -y && \
  fix-permissions "${CONDA_DIR}" && \
  fix-permissions "/home/${NB_USER}"

# Bash script linter
RUN mamba install --quiet --yes \
  'shellcheck=0.10.0' && \
  mamba clean --all -f -y && \
  fix-permissions "${CONDA_DIR}" && \
  fix-permissions "/home/${NB_USER}"

ENV PATH="$PATH:/opt/bin"

USER ${NB_UID}
