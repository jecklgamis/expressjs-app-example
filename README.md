# expressjs-app-template

This is an ExpressJS app template

What's In The Box?

* [ExpressJ](https://expressjs.com/) app
* Alpine [Docker](https://docker.io) Image
* Example [Kubernetes](https://kubernetes.io/) deployment file
* Spins up HTTP and HTTPS listeners (uses self-signed certs)
* Example unit test and integrations tests using [Jest](https://jestjs.io/)
* Build info endpoint ( /build-info)
* Observability: Statsd and Prometheus metrics

Run Docker image:  `docker run jecklgamis/expressjs-app-template:latest`

This is a **Github Template** repo. You can create a copy of this repo from a clean slate. Simply click
<kbd>Use this template</kbd> button.

Have fun and hope you find this useful!

## Building

* Ensure you have [NodeJs installed](https://nodejs.org/en/download/package-manager/)
* GNU Make

Install dependencies:

```
make install-deps
```

Build Docker image:

```
make all
```

## Running

Run Docker image:

```

make up

```

Run app in development mode

```
make run-app-dev-mode
```

## Deploying To Kubernetes

Assumptions:

* You have access to a Kubernetes cluster
* You have access to Docker Hub

```
make deploy-to-k8s
```

## Contributing

Found an issue or something needing improvement? Please raise it in Github. Thanks!

