# Short name: Short name, following [a-zA-Z_], used all over the place.
# Some uses for short name:
# - Docker image name
# - Kubernetes service, rc, pod, secret, volume names
SHORT_NAME := redis
DEIS_REGISTY ?= ${DEV_REGISTRY}/
IMAGE_PREFIX ?= deis

include versioning.mk

SHELL_SCRIPTS = $(wildcard _scripts/*.sh) rootfs/bin/boot

# The following variables describe the containerized development environment
# and other build options
DEV_ENV_IMAGE := quay.io/deis/go-dev:0.11.0
DEV_ENV_WORK_DIR := /go/src/${REPO_PATH}
DEV_ENV_CMD := docker run --rm -v ${CURDIR}:${DEV_ENV_WORK_DIR} -w ${DEV_ENV_WORK_DIR} ${DEV_ENV_IMAGE}
DEV_ENV_CMD_INT := docker run -it --rm -v ${CURDIR}:${DEV_ENV_WORK_DIR} -w ${DEV_ENV_WORK_DIR} ${DEV_ENV_IMAGE}

all: docker-build docker-push

dev:
	${DEV_ENV_CMD_INT} bash

# For cases where we're building from local
# We also alter the RC file to set the image name.
docker-build:
	docker build --no-cache --rm -t ${IMAGE} rootfs
	docker tag ${IMAGE} ${MUTABLE_IMAGE}

test: test-style test-unit test-functional

test-style:
	${DEV_ENV_CMD} shellcheck $(SHELL_SCRIPTS)
