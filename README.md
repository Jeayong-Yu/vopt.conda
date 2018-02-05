# vopt.conda

## Description

`vopt.conda` repository provides the scripts to install
a conda virtual enviroment named `vopt` for `vopt` Veranos Optimizer

`vopt` virtual enviroment consist of:

* Python 3.6 and other python packages
* for package details, read `vopt-environment.yml`


## Prerequisite

* OS

  * Ubuntu 16.04
  * Mac OS X with Docker Toolbox
  * Windows (No CBC/CLP solver)

* You need to install Anaconda.

  Download 64-bit Python 3.6 version from
    * https://www.continuum.io/downloads

  and execute:
  ```
  $ bash Anaconda3-4.4.0-Linux-x86_64.sh
  ```

* On Linux/MAC OS X, you need to upgrade bash to 4.2 or newer version

  * see https://apple.stackexchange.com/questions/193411/update-bash-to-version-4-0-on-osx

* On Windows, you need to install "Microsoft Visual C++ Build Tools"

  * http://landinghub.visualstudio.com/visual-cpp-build-tools


## Installation

### Linux/MacOSX

1. `$ source install_lib.sh` : install linux libraries
1. `$ source create_env.sh` : create virtual environment
1. `$ source install_pkg.sh` : install Python packages


### Windows (No CBC/CLP solver in cvxpy)

1. `$ create_env.bat` : create virtual environment
1. `$ install_pkg.bat` : install Python packages


## Using Environment

* activate the environment.
  ```
  $ source activate vopt
  ```

* deactivate the environment.
  ```
  $ source deactivate
  ```

## Uninstallation

### Linux/MacOSX

```
$ source delete_env.sh
```

### on Windows

```
$ delete_env.bat
```

## Using Docker Image with Pre-Installed Enviroment

1. (Optionally on Mac/Windows) Install docker-toolbox
1. (Optionally on Mac/Windows) Start a docker machine using Docker QuickStart Terminal
1. Download a docker image from dockerhub
   ```
   $ docker pull veranostech/vopt
   ```

   or you can build the docker image on you computer.

   For details, read https://github.com/VeranosTech/vopt.docker

1. Run the docker image
   ```
   $ docker run -Pit --name vopt veranostech/vopt
   ```
