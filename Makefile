###############################################################################
# User settings
###############################################################################
DOCKER		 = podman
CONTAINER	 = r8-systemd-httpd

#######################################
# Build settings
#######################################
BUILD_IMAGE	 = $(CONTAINER):latest

BUILD_FLAGS	 = --rm
BUILD_FLAGS	+= --tag $(BUILD_IMAGE)

#######################################
# Run settings
#######################################
RUN_FLAGS	 = -it
RUN_FLAGS	+= --detach
RUN_FLAGS	+= --name $(CONTAINER)
RUN_FLAGS	+= --volume /sys/fs/cgroup:/sys/fs/cgroup:ro
RUN_FLAGS	+= --publish 8080:80

###############################################################################
# Rules
###############################################################################
all: build run

build:
	$(DOCKER) build $(BUILD_FLAGS) .

run:
	$(DOCKER) run $(RUN_FLAGS) $(BUILD_IMAGE)

clean:
	$(DOCKER) rm -f $(CONTAINER)
	$(DOCKER) image prune --all --force
