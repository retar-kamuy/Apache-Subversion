DOCKER	 = docker

CONTAINER	 = r8-systemd-httpd

BUILD_IMAGE	 = $(CONTAINER):build

BUILD_FLAGS	 = --rm
BUILD_FLAGS	+= --tag $(BUILD_IMAGE)
BUILD_FLAGS	+= -f ./.docker/Dockerfile

RUN_FLAGS	 = -it
RUN_FLAGS	+= --detach
RUN_FLAGS	+= --name $(CONTAINER)
# RUN_FLAGS	+= --volume /sys/fs/cgroup:/sys/fs/cgroup:ro
RUN_FLAGS	+= --publish 80:80

all: build run

build:
	$(DOCKER) build $(BUILD_FLAGS) .

run:
	$(DOCKER) run $(RUN_FLAGS) $(BUILD_IMAGE)
