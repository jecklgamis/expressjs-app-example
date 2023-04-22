# expressjs-app-example

This is an ExpressJS app template to get you quickly bootstrap an ExpressJS app in Docker.

Run Docker image:  `docker run jecklgamis/expressjs-app-example:latest`

What's In The Box?

* [ExpressJS](https://expressjs.com/) app initially generated
  from [Express application generator](https://expressjs.com/en/starter/generator.html)
* Alpine [Docker](https://docker.io) Image
* HTTP and HTTPS listeners (uses self-signed certs)
* Example integration tests using [Mocha](https://mochajs.org/) and friends
* /build-info endpoint (returns Git branch, version, and build time info)
* /probe/ready, /probe/live endpoints for Kubernetes deployment
* Statsd metrics (response time, 2xx/3xx/4xx/5xx metrics)
* Example [Kubernetes](https://kubernetes.io/) deployment file

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

Run unit tests (all tests under `test/unit`):

```
make tests
```

Run integration tests (all tests under `test/integration`):

```
make int-tests
```

## Deploying

### Kubernetes

This assumes:

* You have access to a Kubernetes cluster (i.e. a valid $HOME/.kube/config)
* You have access to Docker Hub

```
make deploy-to-k8s
```

This command

* Pushes Docker image to Docker Hub
* Creates `deployment-<version>.yml` in `deployment/k8s`
* Runs `kubectl apply -f deployment/k8s/deployment-<version>.yml`

## Metrics

All the endpoints are instrumented with timing and status code counters using Statsd.

* <endpoint.name>.duration - timer
* <endpoint.name>.hits - counter
* <endpoint.name>.2xx - counter
* <endpoint.name>.3xx - counter
* <endpoint.name>.4xx - counter
* <endpoint.name>.5xx - counter

## Contributing

Found an issue or something needing improvement? Please raise it in Github. Thanks!

