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
