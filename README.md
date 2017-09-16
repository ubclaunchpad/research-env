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

Add packages to `requirements.txt`.

```
make rebuild-env
```

## :construction_worker: Development

```
make run   # Start the container.
make dev   # Enter the container.
```

## :shipit: Deployment

```
make push-env
```
