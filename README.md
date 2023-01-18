# docker-nexus

This project aims to provide Docker images for the Sonatype Nexus repository manager.
The following plugins are added:

+ APK repository
+ Composer repository
+ Cargo repository

## Quickstart

```bash
$ docker run --name nexus -e waterscape/nexus:latest
```

## Building

```bash
$ ./build.sh latest
```
