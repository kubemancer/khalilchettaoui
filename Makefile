# Variables
IMAGE_NAME = khalil-site
CONTAINER_NAME = khalil-site-container
PORT = 8080

# Detect container runtime (podman or docker)
CONTAINER_RUNTIME := $(shell command -v podman 2> /dev/null || command -v docker 2> /dev/null)

# Default target
.PHONY: help
help:
	@echo "Available commands:"
	@echo "  build     - Build the container image (using $(CONTAINER_RUNTIME))"
	@echo "  run       - Run the container"
	@echo "  stop      - Stop the container"
	@echo "  clean     - Remove container and image"
	@echo "  dev       - Run Hugo development server"
	@echo "  logs      - Show container logs"
	@echo "  shell     - Open shell in running container"
	@echo "  rebuild   - Clean, build and run"
	@echo "  runtime   - Show detected container runtime"

# Show detected runtime
.PHONY: runtime
runtime:
	@echo "Using container runtime: $(CONTAINER_RUNTIME)"

# Build the container image
.PHONY: build
build:
	$(CONTAINER_RUNTIME) build -t $(IMAGE_NAME) .

# Run the container
.PHONY: run
run:
	$(CONTAINER_RUNTIME) run -d --name $(CONTAINER_NAME) -p $(PORT):80 $(IMAGE_NAME)
	@echo "Site running at http://localhost:$(PORT)"

# Stop the container
.PHONY: stop
stop:
	$(CONTAINER_RUNTIME) stop $(CONTAINER_NAME) || true
	$(CONTAINER_RUNTIME) rm $(CONTAINER_NAME) || true

# Clean up container and image
.PHONY: clean
clean: stop
	$(CONTAINER_RUNTIME) rmi $(IMAGE_NAME) || true

# Run Hugo development server locally
.PHONY: dev
dev:
	hugo server -D --bind 0.0.0.0

# Show container logs
.PHONY: logs
logs:
	$(CONTAINER_RUNTIME) logs $(CONTAINER_NAME)

# Open shell in running container
.PHONY: shell
shell:
	$(CONTAINER_RUNTIME) exec -it $(CONTAINER_NAME) /bin/sh

# Rebuild everything
.PHONY: rebuild
rebuild: clean build run