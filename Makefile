# Based on https://github.com/LINKIT-Group/dockerbuild/blob/master/Makefile
# Used under the MIT license

# Make variables
PROJECT_NAME := vscode-server
PROJECT_TAG := $(shell git log -1 --pretty=%h)
TAGGED_IMAGE := $(PROJECT_NAME):$(PROJECT_TAG)
LATEST_IMAGE := $(PROJECT_NAME):latest
BUILD_IT := docker build -t $(TAGGED_IMAGE) --build-arg ROOTPASS=${VSCODESERVER_ROOTPASS}
TAG_LATEST := docker tag $(TAGGED_IMAGE) $(LATEST_IMAGE)
RUN_ARGS := -p ${VSCODESERVER_PORT}:22 --name $(PROJECT_NAME) -v ${VSCODESERVER_MNTPATH}:/home/${VSCODESERVER_USERNAME}/code --restart unless-stopped $(LATEST_IMAGE)

# No files to check for these targets
.PHONY: run help build rebuild

run:
	docker run -d $(RUN_ARGS)

help:
	@echo ''
	@echo 'Usage: make [OPTION]'
	@echo ''
	@echo 'OPTIONS:'
	@echo '  build    build docker image and tag as latest'
	@echo '  rebuild  force (--no-cache) build docker image and tag as latest'
	@echo '  run      run latest docker image'
	@echo ''

run_shell:
	docker run -it $(RUN_ARGS) bash

build:
	$(BUILD_IT) .
	$(TAG_LATEST)

rebuild:
	$(BUILD_IT) --no-cache .
	$(TAG_LATEST)
