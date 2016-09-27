SHELL = /bin/bash

DOCKER_HOST = $(shell echo $$DOCKER_HOST)
BUILD_TAG ?= git-$(shell git rev-parse --short HEAD)
SHORT_NAME ?= nsq
DEIS_REGISTRY ?= ${DEV_REGISTRY}
IMAGE_PREFIX ?= deis

include versioning.mk

build: docker-build
push: docker-push
install: kube-install
uninstall: kube-delete
upgrade: kube-update

docker-build:
	docker build -t ${IMAGE} rootfs
	docker tag ${IMAGE} ${MUTABLE_IMAGE}

clean: check-docker
	docker rmi $(IMAGE)

update-manifests:
	sed 's#\(image:\) .*#\1 $(IMAGE)#' manifests/deis-nsqd-rc.yaml > manifests/deis-nsqd-rc.tmp.yaml

kube-install: update-manifests
	kubectl create -f manifests/deis-nsqd-svc.yaml
	kubectl create -f manifests/deis-nsqd-rc.yaml
	kubectl create -f manifests/deis-nsqlookupd-svc.yaml
	kubectl create -f manifests/deis-nsqlookupd-rc.yaml

kube-delete:
	kubectl delete -f manifests/deis-nsqd-svc.yaml
	kubectl delete -f manifests/deis-nsqd-rc.yaml
	kubectl delete -f manifests/deis-nsqlookupd-svc.yaml
	kubectl delete -f manifests/deis-nsqlookupd-rc.yaml

kube-update: update-manifests
	kubectl delete -f manifests/deis-nsqd-rc.tmp.yaml
	kubectl create -f manifests/deis-nsqd-rc.tmp.yaml
