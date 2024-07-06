###############################################################################
# User settings
###############################################################################
CONTAINER	 = r8-systemd-httpd

#######################################
# Common settings
#######################################
DOCKER	 	 = docker

#######################################
# Build settings
#######################################
BUILD_IMAGE	 = $(CONTAINER):build

BUILD_FLAGS	 = --rm
BUILD_FLAGS	+= --tag $(BUILD_IMAGE)
BUILD_FLAGS	+= -f ./.docker/Dockerfile

#######################################
# Run settings
#######################################
RUN_FLAGS	 = -it
RUN_FLAGS	+= --detach
RUN_FLAGS	+= --name $(CONTAINER)
RUN_FLAGS	+= --volume /sys/fs/cgroup:/sys/fs/cgroup:ro
RUN_FLAGS	+= --publish 8080:80

#######################################
# Exec settings
#######################################
EXEC_FLAGS		 = -it

EXEC_COMMAND	 = /bin/bash

###############################################################################
# Rules
###############################################################################
all: build run exec

build:
	$(DOCKER) build $(BUILD_FLAGS) .

run:
	$(DOCKER) run $(RUN_FLAGS) $(BUILD_IMAGE)

exec:
	$(DOCKER) exec $(EXEC_FLAGS) $(CONTAINER) $(EXEC_COMMAND)

clean:
	$(DOCKER) rm -f $(CONTAINER)

distclean: clean
	$(DOCKER) image rm $(BUILD_IMAGE)
