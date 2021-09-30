IMAGE_NAME:=jecklgamis/expressjs-app-template
IMAGE_TAG:=$(shell git rev-parse HEAD)

default:
	@echo make all - build Docker image
	@echo make run - run Docker image
	@echo make run-app-dev-mode - run app directly in development mode
dist:
	./generate-ssl-certs.sh
	./generate-build-info.sh
image:
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) -t $(IMAGE_NAME):latest .
run:
	docker run -p 8080:8080 -p 8443:8443 $(IMAGE_NAME):$(IMAGE_TAG)
run-bash:
	docker run -i -t $(IMAGE_NAME):$(IMAGE_TAG) /bin/bash
login:
	docker exec -it `docker ps | grep $(IMAGE_NAME) | awk '{print $$1}'` /bin/bash
all: dist image
up: all run
install-deps:
	npm install
	npm install --save-dev --global nodemon
	npm install --save-dev --global jest
tests:
	@echo "Running unit tests"
	@jest
clean:
	@rm -f server.crt server.key build_info.js
run-app-dev-mode:
	@./run-app-dev-mode.sh
