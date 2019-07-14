PROJECT_NAME?=hello_flux_test
REPOSITORY?=registry.sensetime.com/infraservice/${PROJECT_NAME}
BRANCH?=$(shell git branch | grep \* | cut -d ' ' -f2)
COMMIT?=$(shell git rev-parse --short HEAD)
IMAGE?=${REPOSITORY}:${BRANCH}-${COMMIT}
PORT?=8080

REGISTRY_USERNAME?=sys-infraservice

test:
	go test .

image-build:
	docker build -t ${IMAGE} -f Dockerfile .

image-run:
	docker run -p ${PORT}:${PORT} --rm ${IMAGE}

login:
	docker login registry.sensetime.com -u ${REGISTRY_USERNAME} --password-stdin < ./data.txt

push: login
	docker push ${IMAGE}
