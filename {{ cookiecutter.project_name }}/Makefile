# GENERAL
.PHONY: all help

# VARIABLES
# Whether to rebuild the Docker images before running the command
BUILD?=0
ENVIRONMENT?=prod
{%- if cookiecutter.use_gcloud %}
GCP_PROJECT_ID={{ cookiecutter.gcp_project_id }}
GCP_PROJECT_NUMBER={{ cookiecutter.gcp_project_number }}
{%- endif %}

all: help
	@echo "Please specify a target."

help: # Show help for each of the Makefile recipes
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

# SETTING UP
.PHONY: login login-% install install-% setup
	
login-gcloud: # Login to GCP
{%- if cookiecutter.use_gcloud %}
	-docker compose run$(if $(filter 1,$(BUILD)), --build) --rm gcloud auth application-default login 2>/dev/null
	docker compose run$(if $(filter 1,$(BUILD)), --build) --rm gcloud config set project newsroom-genai-dev 2>/dev/null
{%- else %}
	@echo "GCP is not enabled in this project."
{%- endif %}
	
login: login-gcloud # Login to all services
	
install-terraform: # Initialize Terraform
{%- if cookiecutter.use_infrastructure %}
	ENVIRONMENT=$(ENVIRONMENT) docker compose run$(if $(filter 1,$(BUILD)), --build) --rm terraform init 2>/dev/null
{%- else %}
	@echo "Terraform infrastructure-as-code is not enabled in this project."
{%- endif %}
	
install-python: # Install Python packages
	docker compose run$(if $(filter 1,$(BUILD)), --build) --rm uv sync 2>/dev/null

install: install-terraform install-python # Install all dependencies
	
setup: login install # Setup the project

# DEVELOPMENT
.PHONY: format format-% lint lint-% test test-%

format-terraform: # Format Terraform code
{%- if cookiecutter.use_infrastructure %}
	docker compose run$(if $(filter 1,$(BUILD)), --build) --rm terraform -chdir=../.. fmt -recursive 2>/dev/null
{%- else %}
	@echo "Terraform infrastructure-as-code is not enabled in this project."
{%- endif %}

format-python: # Format Python code
	-docker compose run$(if $(filter 1,$(BUILD)), --build) --rm uv tool run ruff format 2>/dev/null
	docker compose run$(if $(filter 1,$(BUILD)), --build) --rm uv tool run ruff check --fix 2>/dev/null

format: format-terraform format-python # Format all code

lint-terraform: # Validate Terraform code
{%- if cookiecutter.use_infrastructure %}
	ENVIRONMENT=$(ENVIRONMENT) docker compose run$(if $(filter 1,$(BUILD)), --build) --rm terraform validate 2>/dev/null
{%- else %}
	@echo "Terraform infrastructure-as-code is not enabled in this project."
{%- endif %}

lint-python: # Check for Python type errors
	docker compose run$(if $(filter 1,$(BUILD)), --build) --rm uv tool run pyright 2>/dev/null

lint: lint-terraform lint-python # Lint (validate) all code

test-python: # Run Python tests
	docker compose run$(if $(filter 1,$(BUILD)), --build) --rm uv run pytest 2>/dev/null

test: test-python # Run all tests