IMAGE_NAME:=jecklgamis/expressjs-app-example
IMAGE_TAG:=$(shell git rev-parse HEAD)

default:
	@echo "Makefile targets:"
	@echo "make install-deps - install app dependencies"
	@echo "make up - build and run Docker image"
	@echo "make all - build Docker image"
	@echo "make run-app-dev-mode - run app directly in debug mode mode (auto reloads)"
	@echo "make deploy-to-k8s - create Kubernetes deployment"
	@echo "make delete-from-k8s - delete Kubernetes deployment"
	@echo "See Makefile for other useful targets"

all: tests int-tests dist image
up: all run
dist:
	@./generate-ssl-certs.sh
	@./generate-build-info.sh
image:
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) -t $(IMAGE_NAME):latest .
run:
	docker run -p 8080:8080 -p 8443:8443 -e "NODE_ENV=production" $(IMAGE_NAME):$(IMAGE_TAG)
run-app-dev-mode:
	./run-app-dev-mode.sh
run-bash:
	docker run -i -t $(IMAGE_NAME):$(IMAGE_TAG) /bin/bash
login:
	docker exec -it `docker ps | grep $(IMAGE_NAME) | awk '{print $$1}'` /bin/bash
tests:
	mocha --exit test/unit
int-tests: dist
	mocha --exit test/integration
clean:
	@rm -f server.crt server.key build_info.js
install-deps:
	npm install
	npm install -g nodemon mocha
chart:
	cd deployment/k8s/helm && make package

