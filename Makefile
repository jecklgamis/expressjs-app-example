IMAGE_NAME:=jecklgamis/expressjs-app-template
IMAGE_TAG:=$(shell git rev-parse HEAD)

default:
	@echo "Makefile targets:"
	@echo "make install-deps - install NPM dependencies"
	@echo "make up - build and run Docker image"
	@echo "make all - build Docker image"
	@echo "make run - run Docker image"
	@echo "make run-app-dev-mode - run app directly in debug mode mode (auto reloads)"
	@echo "make deploy-to-k8s - deploys to a Kubernetes cluster"
	@echo "See Makefile for other useful targets"

all: clean tests dist image
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
	jest
clean:
	@rm -f server.crt server.key build_info.js
install-deps:
	npm install
update-deps:
	npm install -g npm-check-updates
	npm update --save
push:
	 docker push $(IMAGE_NAME):$(IMAGE_TAG)
	 docker push $(IMAGE_NAME):latest
tag:
	 git tag -m "expressjs-app-template-v$(IMAGE_TAG)" -a "v$(IMAGE_TAG)"
	 git push --tags
deploy-to-k8s: dist image push
	cd deployment/k8s && ./create-k8s-files.py --version $(IMAGE_TAG)
	kubectl apply -f deployment/k8s/deployment-$(IMAGE_TAG).yml
delete-from-k8s:
	kubectl delete -f deployment/k8s/deployment-$(IMAGE_TAG).yml

