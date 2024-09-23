# Load environment variables from .env file
include .env

# Docker Compose files for stage and production
STAGE_COMPOSE_FILE = docker-compose.stage.yml
PROD_COMPOSE_FILE = docker-compose.prod.yml

# Commands
.PHONY: stage-deploy production-deploy stage-start production-start \
        stage-stop production-stop stage-clean production-clean

# Check if IMAGE_TAG is set
define check-image-tag
	@if [ -z "$(IMAGE_TAG)" ]; then \
		echo "Error: IMAGE_TAG is not set. Please provide an image tag."; \
		exit 1; \
	fi
endef

# Export IMAGE_TAG for use in docker-compose files
define export-image-tag
	@export IMAGE_TAG=$(IMAGE_TAG)
endef

# --------- Stage Commands ----------

# Stage deployment
stage-deploy:
	$(call check-image-tag)
	$(call export-image-tag)
	@echo "Deploying stage app with image: $(DOCKER_IMAGE):$(IMAGE_TAG)..."
# @docker compose -f $(STAGE_COMPOSE_FILE) pull
	@docker compose -f $(STAGE_COMPOSE_FILE) up -d
	@echo "Stage app deployed."

# Start the stage app
stage-start:
	@echo "Starting stage app..."
	@docker compose -f $(STAGE_COMPOSE_FILE) start
	@echo "Stage app started."

# Stop the stage app
stage-stop:
	@echo "Stopping stage app..."
	@docker compose -f $(STAGE_COMPOSE_FILE) stop
	@echo "Stage app stopped."

# Clean up stage app (stops and removes)
stage-clean:
	@echo "Cleaning up stage app..."
	@docker compose -f $(STAGE_COMPOSE_FILE) down
	@echo "Stage app cleaned."

# --------- Production Commands ----------

# Production deployment
production-deploy:
	$(call check-image-tag)
	$(call export-image-tag)
	@echo "Deploying production app with image: $(DOCKER_IMAGE):$(IMAGE_TAG)..."
# @docker compose -f $(PROD_COMPOSE_FILE) pull
	@docker compose -f $(PROD_COMPOSE_FILE) up -d
	@echo "Production app deployed."

# Start the production app
production-start:
	@echo "Starting production app..."
	@docker compose -f $(PROD_COMPOSE_FILE) start
	@echo "Production app started."

# Stop the production app
production-stop:
	@echo "Stopping production app..."
	@docker compose -f $(PROD_COMPOSE_FILE) stop
	@echo "Production app stopped."

# Clean up production app (stops and removes)
production-clean:
	@echo "Cleaning up production app..."
	@docker compose -f $(PROD_COMPOSE_FILE) down
	@echo "Production app cleaned."
