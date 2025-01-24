# Containers for the pacs course

This repository contains the tools to build and handle the container for the repository of the Advanced Programming for Scientific Computing course. It allows you to have a copy of the repositories [pacs-examples](https://github.com/pacs-course/pacs-examples.git) and [pacs-Labs](https://github.com/pacs-course/pacs-Labs.git). With the material of these repositories you will be able to follow the course and do the exercises.

You must have docker installed on your system to use the containers. If you don't have it, you can install it following the instructions in the [Docker website](https://docs.docker.com/get-docker/).

In this direcory you have the following folders

- `Docker` It contains tha basic `Dockerfile` that enables to build the image for the container. It is not meand for general use. If you know already how docker works and you want to fiddle with it **use a copy**. Personally, I suggest this option only to experiences users
- `vsCode-precompiled`  (*suggested*) Also for Visual Studio Code users. This folder contains the configuration files to use the container with the IDE. You can use it to work with the material of the course. You can find the instructions to use it in the [README.md](vsCode-precompiled/README.md) file of this folder. With this version you will use a precompiled container that is stored in the Docker Hub. This version is faster to start but it is bigger than the previous one.
- `vsCode` For the user of Visual Studio Code, this folder contains the configuration files to use the container with the IDE. You can use it to work with the material of the course. You can find the instructions to use it in the [README.md](vsCode/README.md) file of this folder. With this version you will build the container locally in your machine. Note that the `DockerFile` contained in ths hidden folder `.devcontainer` is just a symbolic link to the one in the `Docker` folder. The difference is that this one is used by the Visual Studio Code to build the container.

## How to use the dev container in Visual Studio Code

**It applies to both versions of the `vsCode` container**  

You should install the `Dev Container` extension in Visual Studio Code. You can do it by following the instructions in the [Visual Studio Code documentation](https://code.visualstudio.com/docs/remote/containers).

Once you have the extension installed, you just open the `vsCode-precmpiled`  (or the `vsCode`, if you prefer) folder in Visual Studio Code and you will see a notification in the lower right corner of the window. Click on the notification and select the option `Reopen in Container`. The first time you do it, the container will be fetched from the docker hub (or built if you go in `vsCode` folder). If you build the container, the construction may take time, be patient.

# Shared files. 
If you want to share files between the host and the container, you can use the `shared_files` folder. This folder is in the home directory in the docker image. The `shared_files` folder is shared between the host and the container.  If you have launched visual code from the `vsCode**` folders the `shared_files` folder is autoomatically mounted in the local `shared_file` subfolder. If yoou want a different binding, change the `devcontainer.json` file in the `.devcontainer` folder.
If you are using docker independently from Visual Studio Code, you can use the following command to bind the `shared_files` folder to the container:

```bash
docker run -it --rm -v <host directory>:/home/pacs/shared_files pacs-container
```

## Some notes

If you use a dev container in Visual Studio Code, you can pull frequently from the repositories `pacs-examples` and `pacs-Labs` to keep the material updated, following the instruction in the README.md file of the repositories.

The repositories `pacs-examples` and `pacs-Labs` are cloned in the container using the https protocol. If you want to switch to the more convenient `ssh` protocol, you can do it by following the instructions in the main README.md file of the repositories. This applies also for the submodules of the `pacs-examples` repository.
