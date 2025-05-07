---
name: Docker image build request
about: Detail specs and request Docker image build
title: Docker image for `<insert purpose>`
labels: docker
assignees:

---

# Issue summary

No Docker image exists to `<insert details>`. An image is needed to maintain consistent software versions between analysts and computing environments.

# TODO

- [ ] Identify all software packages needed for analysis tasks.
- [ ] Create Dockerfile to build an image with the needed R packages.
- [ ] Build [x86](https://www.docker.com/blog/multi-arch-build-and-images-the-simple-way/) Docker image.
- [ ] Verify software/package versions in built image match those specified in the Dockerfile.
  * For R packages this can be done using `packageVersion()`.
  * For command line executables, versions can often be identified by passing a `-v` or `--version` option to the executable (e.g., `jupyter --version`).
  * For Python packages you can use the command `pip freeze | grep <Python package name>`.
- [ ] Verify that software/packages load without raising a runtime error.

See [this guide](https://github.com/bquach_rtiintl/omics_analysis_project_template/wiki/Using-and-Creating-Docker-images) for help with Docker image construction.

----

# Operating system

* Ubuntu `<version>` from [`<DockerHub image name and tag if relevant>`](`<URL>`)
* Example: Ubuntu 22.04 from [jupyter/minimal-notebook](https://hub.docker.com/layers/jupyter/minimal-notebook/ubuntu-22.04/images/sha256-42d05d5dab361ae0116cc9c4917017322175d136962c81b63a764881b65e601e?context=explore)

# List of command line software/tools to include in Docker image

* [`<software/tool name>` v`<insert version>`](`<URL>`)
* Example: [AWS CLI v2.13.24](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-version.html)

# List of R packages to include in Docker image

* [`<software/tool name>` v`<insert version>`](`<URL>`)

# List of Python packages to include in Docker image

* [`<software/tool name>` v`<insert version>`](`<URL>`)

---

Delete this section if not needed. If using Jupyter and the template from `src/docker/dockerfile_template/Dockerfile`, the following Markdown text may be useful to copy and modify (versions may need to be updated):

```markdown
The above packages are in addition to the software and packages that get installed in the [Docker Stacks r-notebook](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html#jupyter-r-notebook) which include:
* [JupyterLab v4.0.7](https://jupyter-docker-stacks.readthedocs.io/en/latest/)
* [crayon v1.5.3](https://cran.r-project.org/package=crayon)
* [htmltools v0.5.8.1](https://cran.r-project.org/package=htmltools)
* [htmlwidgets v1.6.4](https://cran.r-project.org/package=htmlwidgets)
* [IRkernel v1.3.2](https://cran.r-project.org/package=IRkernel)
* [RCurl v1.98.1.13](https://cran.r-project.org/package=RCurl)
* [rmarkdown v2.28](https://cran.r-project.org/package=rmarkdown)
* [RODBC v1.3.23](https://cran.r-project.org/package=RODBC)
* [RSQLite v2.3.3](https://cran.r-project.org/package=RSQLite)
* [shiny v1.8.0](https://cran.r-project.org/package=shiny)
* [data.table v1.16.0](https://cran.r-project.org/package=data.table)
* [tidyverse v2.0.0](https://www.tidyverse.org/packages/)
* [tidymodels v1.2.0](https://www.tidymodels.org/packages/)
* [ggplot2 v3.5.1](https://cran.r-project.org/package=ggplot2)
```
