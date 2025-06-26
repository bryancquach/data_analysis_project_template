----

**Update and rename this README as `README.md` to replace the default template repository README.**

----

# Project title

**Contributors:**

* Full name (email address)

---

# Overview

Description of project, project ID numbers, data types and datasets used, etc.

## Repository setup

To clone a specific repository branch:

```
git clone -b <branch name> <repository URL>
```

The `main` branch is intended for manuscript ready analyses, but most work in this repository will branch from and merge into `develop`.

The repository includes a custom `.gitconfig` and a `.gitattributes` file that clears output from `.ipynb` notebook cells. **To enable this** call the following command after cloning to create a local repository version:

```
git config --local include.path ../.gitconfig
```

Note that code cell clearing has only been tested with nbconvert version 6.2.0.

Analyses in this repository are executed within Docker containers from images built using Dockerfiles in `src/docker/*`. See `src/docker/README.md` for additional details on using Docker.

## Recommended reading

* `[<Title>](<URL>)`.

## Computing infrastructure resources

Include in this section information regarding the computing environment being used for this project. The example in this section is for an AWS server computing environment.

### AWS-based HPC info

AWS [ParallelCluster](https://aws.amazon.com/hpc/parallelcluster/) simplifies the creation and use of an HPC cluster in a cloud environment. Additionally, the HPCs set up by ParallelCluster can dynamically scale the quantity and types of compute nodes (i.e., the number of CPUs and RAM) available based on needs at a given point in time.

* AWS ParallelCluster name: `name`
* AWS ParallelCluster head node IP: `public IP address`
* AWS ParallelCluster username: `username`
* AWS ParallelCluster SSH private key: Reference how to obtain it here. Do **not** include the key in this README.
* AWS ParallelCluster head node working directory: `/path/to/dir`
* [Using the SLURM job scheduler on AWS](https://docs.aws.amazon.com/parallelcluster/latest/ug/multiple-queue-mode-slurm-user-guide-v3.html)
* [EC2 console for managing the ParallelCluster head node (instance ID: `id`)]()

### AWS S3 console info

* [S3 console login page]([https://signin.aws.amazon.com/signin](https://us-east-2.signin.aws.amazon.com/oauth?client_id=arn%3Aaws%3Asignin%3A%3A%3Aconsole%2Fcanvas&code_challenge=Va-pAvRECpqks3Ybp27SbfHSDOrmrWTYkQXb114cSYU&code_challenge_method=SHA-256&response_type=code&redirect_uri=https%3A%2F%2Fconsole.aws.amazon.com%2Fconsole%2Fhome%3FhashArgs%3D%2523%26isauthcode%3Dtrue%26nc2%3Dh_ct%26src%3Dheader-signin%26state%3DhashArgsFromTB_us-east-2_d756a2f29ab06f63))
* AWS account ID: `id`
* AWS account alias: `alias`
* AWS region: `region`

### Contributing to this repository

* [Generating and adding an SSH key for command line repo access](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
* [Thinking from a modular perspective](https://github.com/bquach_rtiintl/omics_analysis_project_template/wiki/Modular-analysis-design). A primer for shifting your mindset of seeing an analysis or project as one monolithic task to seeing things as many interconnected, but distinct, smaller tasks.
* [A great introduction to git-based version control](https://medium.com/@jake.page91/the-guide-to-git-i-never-had-a89048d4703a).
* [Using the GitFlow framework for collaborative data analysis projects](https://ericmjl.github.io/essays-on-data-science/workflow/gitflow/). An introduction to some concepts around how analyses in this repository are structured (i.e., how to develop analysis plans), as well as the GitFlow framework for how analyses in this repository are managed.
* [GitFlow in GitHub quickstart](https://docs.github.com/en/get-started/quickstart/github-flow). A quickstart guide for executing various tasks that are routinely used in the GitFlow framework.
* [Guide to working with Docker images within this repository structure](https://github.com/bryancquach/data_analysis_project_template/wiki/Using-and-creating-Docker-images). Provides general information for working with Docker images and containers.
* For contributing to this repo, the main tools you need on your local machine are a Unix/Linux command line interface, AWS CLI, and Docker for running containers.
  * For Windows users, the best way to get this is to install WSL2 then install Docker Desktop with WSL2 integration enabled. The AWS CLI should then be installed and configured in your WSL2 environment.
  * Mac users have a built-in unix terminal, so only Docker Desktop and the AWS CLI need to be installed.
* [Reference guide for Markdown syntax](https://www.markdownguide.org/basic-syntax)
* [Reference guide for git commands](https://git-scm.com/doc)
* [IP address lookup to enable web browser-based EC2 access](https://www.iplocation.net/)

---

# Project roadmap

This project is structured around a primary hypothesis and objectives geared towards testing that hypothesis.

* **Primary hypothesis:** Detail the hypothesis.

* **Primary objectives:** 

  * Detail objective 1.
  * Detail objective 2.
  * Detail objective n.
