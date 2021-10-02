# expressjs-app-template

This is an ExpressJS app template to get you quickly bootstrap an ExpressJS app in Docker.

Run Docker image:  `docker run jecklgamis/expressjs-app-template:latest`

What's In The Box?

* [ExpressJ](https://expressjs.com/) initially generated
  from [Express application generator](https://expressjs.com/en/starter/generator.html)
* Alpine [Docker](https://docker.io) Image
* HTTP and HTTPS listeners (uses self-signed certs)
* Example test using [Jest](https://jestjs.io/)
* Exposes /buildInfo and /api endpoints
* Statsd metrics
* [Kubernetes](https://kubernetes.io/) deployment file

This is a **Github Template** repo. You can create a copy of this from a clean slate. Simply click <kbd>Use this
template</kbd> button.

Have fun and hope you find this useful!

## Requirements

* [NodeJs](https://nodejs.org/en/download/package-manager/)
* [Docker](https://docs.docker.com/get-docker/)
* GNU Make

Most build and run commands are wrapped inside Makefile. Explore this one to see what the existing targets you can
invoke of if you like to add one.

## Building

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

Run app in development mode. This uses `nodemon` to auto reload modified files and enables verbose logging.

```
make run-app-dev-mode
```

## Testing

This template uses Jest test framework.

Run the non-Dockerized app in debug mode.

```
make run-app-dev-mode
```

## Deploying To Kubernetes

Assumptions:

* You have access to a Kubernetes cluster (i.e. a valid $HOME/.kube/config)
* You have access to Docker Hub

```
make deploy-to-k8s
```
This target 
* Creates `deployment-<version>.yml` in `deployment/k8s`
* Runs `kubectl apply -f deployment/k8s/deployment-<version>.yml`

## Contributing

Found an issue or something needing improvement? Please raise it in Github. Thanks!

