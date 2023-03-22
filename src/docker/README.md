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

**NOTE:** If you are on an arm64 system, then [`docker buildx`](https://docs.docker.com/build/building/multi-platform/) is needed to build an `x86_64` compatible image.

---
## Starting a container

For Docker containers with Jupyter Lab included, starting a Jupyter Lab session can be accomplished by calling:

```sh
docker run -p <host_port_number>:8888 -v <host_absolute_path_to_repo_root>:/<repo_name> --rm -t <image_tag> jupyter lab /<repo_name>
```

Assuming `<host_port_number>` is `8889`, the Jupyter session can be accessed via your web browser using the URL `http://127.0.0.1:8889/lab?token=<token_value>` where `<token_value>` is provided as command line output after calling `docker run`.

---
## Docker images

* `image name`: Description here. Explicitly installed packages:
  * [package name v0.0](URL)
