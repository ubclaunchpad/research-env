research-env
===================

A training environment for machine learning.

## :running: Getting Started

You will need [Docker](https://www.docker.com/docker-mac).

```
make build-env
make run
```

## :package: Adding Dependencies

Add `conda` packages to `environment.yml`, use `pip` command if required.

```
make rebuild-env
```

## :shipit: Deployment

```
make push-env
```
