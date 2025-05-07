# README for Docker images

Each subdirectory for this directory includes a Dockerfile to build a Docker image that creates an environment for a component of an analysis. 

---
## Building an image

To build an x86-64/amd64 architecture compatible Docker image, use the following build command:

```sh
# Working dir must be src/docker
docker build --rm --file <image_name>/Dockerfile --tag <dockerhub_account>/<image_name>:<tag> .
```

The format for `<tag>` should be `yyyymmddhhmm_<architecture>` where `<architecture>` is one of `x86_64`, `arm64`, or `multiarch`. For example, the tag `202302241705_multiarch` signifies an image built on February 24, 2023 at 17:05 that is compatible with both the x86-64 and ARM64 architectures.

## Checking build R environment

To check that the R version and package versions you intended to install successfully built in the Docker image, copy and use the template script `src/docker/dockerfile_template/test_r_build.R`. Copy the script to the same location as your Dockerfile and add to the script the packages that you want to check. You can then run the check inside a container for your Docker image using the following command:

```sh
docker run \
  --rm \
  -v <host_absolute_path_to_repo_root>:/scratch \
  -t <dockerhub_account>/<image_name>:<tag> \
  Rscript /scratch/src/docker/<image_name>/test_r_build.R
```

---
## Starting a container

For Docker containers with Jupyter Lab included, starting a Jupyter Lab session can be accomplished by calling:

```sh
docker run \
  -p <host_port_number>:8888 \
  -v <host_absolute_path_to_repo_root>:/<repo_name> \
  --rm \
  -t <dockerhub_account>/<image_name>:<tag> \
  jupyter lab /<repo_name>
```

Assuming `<host_port_number>` is `8889`, the Jupyter session can be accessed via your web browser using the URL `http://127.0.0.1:8889/lab?token=<token_value>` where `<token_value>` is provided as command line output after calling `docker run`.

---

## Using the `code_linter` Docker image

To promote consistent code styling for R and python scripts. The `code_linter` Docker image is provided to check code style and syntax errors.

An example template of how to run R code linting:

```sh
repo=<repository_name>
host_path=<absolute path to repo on host system>
image=<image name>
docker run \
  --rm \
  -v ${host_path}/${repo}:/${repo} \
  -t ${image} \
  lint.R \
    --config /${repo}/src/r/.lintr \
    /${repo}/src/r/utils.R

# Example    
repo=wihs_network_analysis
host_path=/mnt/c/Users/bquach/projects/hiv
image=bryancquach/code_linter:202309071145_x86_64
docker run \
  --rm \
  -v /mnt/c/Users/bquach/projects/hiv/${repo}:/${repo} \
  -t ${image} \
  lint.R \
    --config /${repo}/src/r/.lintr \
    /${repo}/src/r/utils.R
```

An example of how to run python code linting:

```sh
repo=<repository_name>
host_path=<absolute path to repo on host system>
image=<image name>
docker run \
  --rm \
  -v ${host_path}/${repo}:/${repo} \
  -t ${image} \
  pylint /${repo}/<path to .py file>
```

An example of how to run bash script code linting:

```sh
repo=<repository_name>
host_path=<absolute path to repo on host system>
image=<image name>
docker run \
  --rm \
  -v ${host_path}/${repo}:/${repo} \
  -t ${image} \
  shellcheck --shell=bash --severity=style /${repo}/<path to .sh file>
```


---
## Docker images

* `image name`: Description here. Explicitly installed packages:
  * [package name v0.0](URL)
* `code_linter`: Contains code linters for Python and R within Ubuntu 22.04. The following R and Python packages are explicitly installed via the Dockerfile:
  * [argparse v2.2.2](https://cran.r-project.org/package=argparse)
  * [lintr v3.1.0](https://cran.r-project.org/package=lintr)
  * [pylint v2.17.5](https://pypi.org/project/pylint/)
  * [ShellCheck v0.10.0](https://github.com/koalaman/shellcheck)
