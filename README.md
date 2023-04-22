# expressjs-app-example

This is an example project to get you quickly bootstrap an ExpressJS app in Docker.

Docker:  `docker run -p 8080:8080 -it  jecklgamis/expressjs-app-example:main`

What's In The Box?

* [ExpressJS](https://expressjs.com/) app initially generated
  from [Express application generator](https://expressjs.com/en/starter/generator.html)
* Alpine [Docker](https://docker.io) Image
* HTTP and HTTPS listeners (uses self-signed certs)
* Example integration tests using [Mocha](https://mochajs.org/) and friends
* /build-info endpoint (returns Git branch, version, and build time info)
* /probe/ready, /probe/live endpoints for Kubernetes deployment
* Statsd metrics (response time, 2xx/3xx/4xx/5xx metrics)
* [Kubernetes](https://kubernetes.io/) Helm chart 

Have fun and hope you find this useful!

## Requirements

* [NodeJs](https://nodejs.org/en/download/package-manager/)
* [Docker](https://docs.docker.com/get-docker/)
* GNU Make

Most build and run commands are wrapped inside Makefile. Explore this one to see what the existing targets you can
invoke of if you like to add one.

## Building
```
make install-deps
make all
```

## Running
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


All the endpoints are instrumented with timing and status code counters using Statsd.

* <endpoint.name>.duration - timer
* <endpoint.name>.hits - counter
* <endpoint.name>.2xx - counter
* <endpoint.name>.3xx - counter
* <endpoint.name>.4xx - counter
* <endpoint.name>.5xx - counter

## Contributing
Please send an issue or pull request. Thanks.


