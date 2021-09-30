# expressjs-app-template

This is an ExpressJS app template.

What's In The Box?

* [ExpressJ](https://expressjs.com/) app
* Alpine [Docker](https://docker.io) Image
* Example [Kubernetes](https://kubernetes.io/) deployment file
* Spins up HTTP and HTTPS listeners (uses self-signed certs)
* Example unit test and integrations tests using [Jest](https://jestjs.io/)
* Build info endpoint ( /build-info)
* Observability: Statsd and Prometheus metrics

Clone repo: `git clone git@github.com:jecklgamis/expressjs-app-template.git`
Run Docker image:  `docker run jecklgamis/expressjs-app-template`

This is a **Github Template** repo. You can create a copy of this project from a clean slate. Simply click
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

## Running Locally

Run Docker image:

```

make up

```

Run app directly with auto-reloading

```

./run-app-dev-mode.sh

```

## Contributing

Found an issue or something needing improvement, please raise it in Github. Thanks!

