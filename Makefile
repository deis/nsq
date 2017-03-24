SHELL = /bin/bash
include includes.mk

DOCKER_HOST = $(shell echo $$DOCKER_HOST)
BUILD_TAG ?= git-$(shell git rev-parse --short HEAD)
SHORT_NAME ?= nsq
DEIS_REGISTRY ?= ${DEV_REGISTRY}
IMAGE_PREFIX ?= deis

TEST_ENV_PREFIX := docker run --rm -v ${CURDIR}:/bash -w /bash quay.io/deis/shell-dev
SHELL_SCRIPTS = $(wildcard rootfs/opt/nsq/bin/*)

include versioning.mk

build: docker-build
push: docker-push
install: kube-install
uninstall: kube-delete
upgrade: kube-update

docker-build:
	docker build ${DOCKER_BUILD_FLAGS} -t ${IMAGE} rootfs
	docker tag ${IMAGE} ${MUTABLE_IMAGE}

clean: check-docker
	docker rmi $(IMAGE)

test: test-style

test-style: check-docker
	${TEST_ENV_PREFIX} shellcheck $(SHELL_SCRIPTS)

update-manifests:
	sed 's#\(image:\) .*#\1 $(IMAGE)#' manifests/deis-nsqd-rc.yaml > manifests/deis-nsqd-rc.tmp.yaml

kube-install: update-manifests
	kubectl create -f manifests/deis-nsqd-svc.yaml
	kubectl create -f manifests/deis-nsqd-rc.yaml

kube-delete:
	kubectl delete -f manifests/deis-nsqd-svc.yaml
	kubectl delete -f manifests/deis-nsqd-rc.yaml

kube-update: update-manifests
	kubectl delete -f manifests/deis-nsqd-rc.tmp.yaml
	kubectl create -f manifests/deis-nsqd-rc.tmp.yaml

.PHONY: build push install uninstall upgrade docker-build clean test test-style \
	update-manifests kube-install kube-delete kube-update
