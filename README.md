# What is TELEMAC-MASCARET

The [TELEMAC-MASCARET solver suite](http://www.opentelemac.org) is a high-performance Fortran based application for a range
of free-surface flow problems.

This software is a very powerful toolkit for numeric simulation that can be slightly cumbersome to install depending on the
host operating system. The runtime might also need some tweaks to the configuration provided in the upstream repository to
reflect Fortran compiler version and library locations.

This image provides a Debian-based precompiled packaging of the latest TELEMAC-MASCARET suite for immediate usage. This
alleviates the burden to setup TELEMAC-MASCARET and only requires a [Docker installation](https://docs.docker.com/get-docker/)
on the workstation/server and an Intel VT-x or AMD-V enabled CPU to run simulations practically at bare metal performance.

It is built with Open MPI support for immediate multi-CPU/multi-core parallelization. Therefor it is also well prepared for
HPC cluster operations with some additional tweaking and an orchestration software like Kubernetes to spread the container over
a group of nodes.

The image is hosted as public [Dockerhub Repository](https://hub.docker.com/repository/docker/flussplan/telemac) and Docker
build sources can be found on the [flussplan Github](https://github.com/flussplan/docker-telemac).

# How to use this image

The image is designed for interactive usage in the shell:

```
# docker run --rm -it -v ./workdir:/opt/telemac-mascaret/latest/workdir flussplan/telemac
```

As you can see the TELEMAC-MASCARET suite is installed in the folder `/opt/telemac-mascaret/<version>` with a symbolic link being
provided via `/opt/telemac-mascaret/latest` for easy access from the host system.

In the example above a local folder named `workdir` is mapped into the `${HOMETEL}` root installation folder. This is where you
can put your simulation files and data for execution and fetch/visualize the results on the host machine if required.

The root installation folder is also where the image shell will drop you after startup.

You can run TELEMAC or MASCARET solvers from there like:

```
# cd examples/telemac2d/gouttedo
# telemac2d.py t2d_gouttedo.cas --ncsize=4
```

Just copy your simulation files into the `workdir` folder on the host machine and run your it inside the Docker container, e.g.
in a subfolder named `my-simulation` like:

```
# cd workdir/my-simulation
# telemac2d.py my-simulation.cas --ncsize=4
```

On the host machine you can browse the local folder `workdir/my-simulation` after the simulation has finished to check the results.  

# Docker compose file

In the github repository provided above you will find a Docker compose file for easy startup of the image. Just check out the
repository to start using it immediately as shown here:

```
# docker-compose run --rm --service-ports telemac-mascaret
```

This compose file is prepared with an automated mapping of the subfolder `workdir` (as in the `docker run` example above).
The compose file also makes sure to map all available CPUs into the docker image for parallelization, please adapt your `--ncsize` parameter
accordingly.

The compose file also includes an optional port mapping for a built-in web-based file browser running at [http://localhost:8090](http://localhost:8090)
providing easy access to the examples and docs in the current distribution.  You can enable the Apache serving the file browser by passing the environment
variable `ENABLE_WEB_BROWSER=1` to `docker` or `docker-compose`. The file browser imposes a slight security risk because the TELEMAC-MASCARET
installation files are accessible in read/write manner the mapped port `8090` should generally not be accessible on the public interface of the
host machine if you enable this feature. 

# Image tags

While the tag `latest` will provide access to the most current building SVN trunk TELEMAC-MASCARET, you can also access stable release versions directly
with the corresponsing TELEMAC-MASCARET Subversion repository tag.

Major releases can be tracked with `vX-latest`, eg. `v8-latest` to automatically get the latest `v8` patch/revision updates.

# Testing and support

Please get in touch with the TELEMAC-MASCARET community in the [forum](http://www.opentelemac.org/index.php/kunena) for assistance with the solver
suite. Feel free to report image issues directly in the [Github issue tracker](https://github.com/flussplan/docker-telemac/issues) if you are
certain they are related to Docker packaging specifically.

Note that the automated pipelines run the `examples/telemac2d/gouttedo` example to verify the build. If upstream TELEMAC-MASCARET versions do
not properly execute this basic example the image will not be pushed into the repository. This might delay the daily automated SVN trunk build.

# License

This software is provided by [flussplan e.U.](http://www.flussplan.at) under the GNU GPL Version 3 license, similar to TELEMAC-MASCARET itself.

See the `LICENSE.txt` in the repository for details.