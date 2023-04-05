# Adapted from https://github.com/jupyter/docker-stacks/blob/main/r-notebook/Dockerfile
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
  build-essential && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# R install
RUN mamba install --quiet --yes 'r-base' && \
  mamba clean --all -f -y && \
  fix-permissions "${CONDA_DIR}" && \
  fix-permissions "/home/${NB_USER}"

# R and python code linters
RUN mamba install --quiet --yes \
  'r-lintr' \
  'r-argparse' \
  'pylint'

USER ${NB_UID}
