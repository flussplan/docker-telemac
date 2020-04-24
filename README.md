# What is TELEMAC-MASCARET

The [TELEMAC-MASCARET solver suite](http://www.opentelemac.org) is a high-performance Fortran based application for a range
of free-surface flow problems.

This software is a very powerful toolkit for numeric simulation that can be slightly cumbersome to install depending on the
host operating system. The runtime might also need some tweaks to the configuration provided in the upstream repository to
reflect Fortran compiler version and library locations.

This image provides a Debian-based precompiled packaging of the latest TELEMAC-MASCARET suitable for immediate usage. This
alleviates the burden to setup TELEMAC-MASCARET and only requires a [Docker installation](https://docs.docker.com/get-docker/)
on the workstation/server and an Intel VT-x or AMD-V enabled CPU to run simulations practically at bare metal performance.

It is built with Open MPI support for immediate multi-CPU/multi-core parallelization. Therefor it is also well prepared for
HPC cluster operations with some additional host discovery tweaking and an orchestration software like Kubernetes to spread
the image in multiple containers over a group of nodes.

The package includes custom builds for:

* [METIS](http://glaros.dtc.umn.edu/gkhome/metis/metis/overview)
* [HDF5](https://support.hdfgroup.org/HDF5/)
* [MED](https://www.salome-platform.org/user-section/about/med)

The image is hosted as public [Dockerhub Repository](https://hub.docker.com/repository/docker/flussplan/telemac) and Docker
build sources can be found on the [flussplan Github](https://github.com/flussplan/docker-telemac).

# How to use this image

The image is designed for interactive usage in the shell. It can be launched like follows directly with the Docker CLI:

```
docker run --rm -it -v ./workdir:/opt/telemac-mascaret/latest/workdir flussplan/telemac:v8-latest
```

The TELEMAC-MASCARET suite is installed in the folder `/opt/telemac-mascaret/<version>` with a symbolic link being provided
via `/opt/telemac-mascaret/latest` for easy access from the host system.

In the example above a local folder named `workdir` is mapped into the `${HOMETEL}` root installation folder. This is where you
can put your own persistent simulation files and data for execution and fetch/visualize the results on the host machine if required.

The root installation folder is also where the image shell will drop you after startup.

You can run TELEMAC or MASCARET solvers from there like:

```
cd examples/telemac2d/gouttedo
telemac2d.py t2d_gouttedo.cas --ncsize=4
```

Just copy your simulation files into the `workdir` folder on the host machine and run your it inside the Docker container, e.g.
in a subfolder named `my-simulation` like:

```
cd workdir/my-simulation
telemac2d.py my-simulation.cas --ncsize=4
```

On the host machine you can browse the local folder `workdir/my-simulation` after the simulation has finished to check the results.  

# Docker compose file

In the github repository provided above you will find a Docker compose file for easy startup of the image. Just download the matching
release and refer to the top-level folder `docker-compose.yml` to start using the image immediately as shown here:

```
git clone https://github.com/flussplan/docker-telemac.git
cd docker-telemac
docker-compose run --rm telemac-mascaret
```

This compose file is prepared with an automated mapping of the subfolder `workdir` (as in the `docker run` example above).
The compose file also makes sure to map all available CPUs into the docker image for parallelization, please adapt your `--ncsize` parameter
accordingly.

# Image tags

While the tag `trunk` will provide access to the most recent building SVN trunk TELEMAC-MASCARET, you can also access stable release versions directly
with the corresponsing TELEMAC-MASCARET Subversion repository tag like `v8p1r1`.

Major releases can be tracked with `vX-latest`, eg. use `v8-latest` to automatically get the latest `v8` patch/revision updates. This enables easy
automatic upgrades of TELEMAC-MASCARET while simulation files are retained in the `workdir` volume folder accross versions.

# Docker configuration

Please refer to the official documentation on how to setup Docker on [Windows](https://docs.docker.com/docker-for-windows/install/),
[Mac](https://docs.docker.com/docker-for-mac/) or via Linux package manager according to your needs. This is a prerequisite to be able to use this
TELEMAC-MASCARET distribution package.

Too ensure maximum performance you should make sure to map all available CPUs/cores into the Docker containers by using the respective Docker settings.

# Custom configuration file

The container is equipped with a TELEMAC-MASCARET Open MPI configuration configured and optimized for the Debian environment. You can run the container
with a custom configuration file by mounting it into /opt/telemac-mascaret/systel.cfg in the Docker startup command or Docker compose file:

```
# docker run --rm -it -v ./workdir:/opt/telemac-mascaret/latest/workdir -v ./workdir/my-systel.cfg:/opt/telemac-mascaret/systel.cfg flussplan/telemac:v8-latest
```

See the [included configuration file](https://github.com/flussplan/docker-telemac/blob/master/docker/systel.cfg) for a baseline that works well with the
Debian environment of the container.

# Debug compiler target

The image is built with the optimized `openmpi` target for ideal runtime performance. It also includes an `openmpidbg` target that allows you to debug TELEMAC-MASCARET
binaries. This requires you to rebuild the Docker image locally with a build arg/environment override like:

```
services:
    telemac-mascaret:
        ...
        args:
            USETELCFG=openmpidbg
        env:
            USETELCFG=openmpidbg
```

The `docker` subfolder of the Github repository contains the source `Dockerfile`, necessary auxiliary files, and a different Docker compose file prepared
for local building and running of an image.

# Development

This image is designed for ease of simulation use. As it is desired with encapsulated Docker images, all TELEMAC-MASCARET distribution data is ephermal and
lost during container restarts.

To use this image for TELEMAC-MASCARET development you should map your own distribution sources into the image like follows. This will persist the sources and build
data during restarts to avoid loosing your modifications.

```
# docker run --rm -it -v ./telemac-src:/opt/telemac-mascaret/custom -e TELEMAC_MASCARET_VER=custom flussplan/telemac:v8-latest
```

Just make sure to also modify the rest of the environment accordingly (see `/opt/telemac-mascaret/setenv.sh`).

# Support

Please get in touch with the TELEMAC-MASCARET [community forum](http://www.opentelemac.org/index.php/kunena) for assistance with the solver
suite. Feel free to report image issues directly in the [Github issue tracker](https://github.com/flussplan/docker-telemac/issues) if you are
certain they are related to Docker packaging specifically.

# License and disclaimer

This packaging is provided "as is" and without warranty of any kind by [flussplan e.U.](http://www.flussplan.at) under the GNU GPL Version 3 license.

See the `LICENSE.txt` in the repository for details.

Disclaimer: this is not an official project by TELEMAC-MASCARET, which is managed separately by a consortium of core organisations: Artelia (formerly
Sogreah, France), Bundesanstalt für Wasserbau (BAW, Germany), Centre d’Etudes et d'Expertise sur les Risques, l'Environnement, la Mobilité et l'Aménagement
(CEREMA, France), Daresbury Laboratory (United Kingdom), Electricité de France R&D (EDF, France), and HR Wallingford (United Kingdom). See their
[website](http://www.opentelemac.org/) for more information about TELEMAC-MASCARET.

Includes additional download/build instructions for:

* [METIS](http://glaros.dtc.umn.edu/gkhome/metis/metis/overview) (Apache License, Version 2.0)
* [HDF5](https://support.hdfgroup.org/HDF5/) (Copyright (c) 2006-2018, The HDF Group, All rights reserved. See included `LICENSE.hdf5`)
* [MED](https://www.salome-platform.org/user-section/about/med) (GNU GPL Version 3)