# GENERAL
.PHONY: all help

# VARIABLES
# Whether to rebuild the Docker images before running the command
ENVIRONMENT?=prod
{%- if cookiecutter.use_gcloud %}
GCP_PROJECT_ID={{ cookiecutter.gcp_project_id }}
GCP_PROJECT_NUMBER={{ cookiecutter.gcp_project_number }}
{%- endif %}
{%- if cookiecutter.use_infrastructure %}
PATH_TERRAFORM_ENVIRONMENT=$(PWD)/infrastructure/environments/$(ENVIRONMENT)
{%- endif %}

all: help
	@echo "Please specify a target."

help: # Show help for each of the Makefile recipes
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

# SETTING UP
.PHONY: login login-% install install-% setup

login-gcloud: # Login to GCP
{%- if cookiecutter.use_gcloud %}
	-gcloud auth application-default login
	gcloud config set project newsroom-genai-dev
{%- else %}
	@echo "GCP is not enabled in this project."
{%- endif %}

login: login-gcloud # Login to all services

install-terraform: # Initialize Terraform
{%- if cookiecutter.use_infrastructure %}
	terraform -chdir=$(PATH_TERRAFORM_ENVIRONMENT) init
{%- else %}
	@echo "Terraform infrastructure-as-code is not enabled in this project."
{%- endif %}

install-python: # Install Python packages
	uv sync --all-groups
	uv tool install ruff --upgrade
	uvx ruff --version
	uv tool install pyright --upgrade
	uvx pyright --version

install: install-terraform install-python # Install all dependencies

setup: login install # Setup the project

# DEVELOPMENT
.PHONY: format format-% lint lint-% test test-%

format-terraform: # Format Terraform code
{%- if cookiecutter.use_infrastructure %}
	terraform -chdir=infrastructure fmt -recursive
{%- else %}
	@echo "Terraform infrastructure-as-code is not enabled in this project."
{%- endif %}

format-python: # Format Python code
	-uv tool run ruff format
	uv tool run ruff check --fix

format: format-terraform format-python # Format all code

lint-terraform: # Validate Terraform code
{%- if cookiecutter.use_infrastructure %}
	terraform -chdir=$(PATH_TERRAFORM_ENVIRONMENT) validate
{%- else %}
	@echo "Terraform infrastructure-as-code is not enabled in this project."
{%- endif %}

lint-python: # Check for Python type errors
	uv tool run pyright

lint: lint-terraform lint-python # Lint (validate) all code

test-python: # Run Python tests
	uv run pytest

test: test-python # Run all tests

# DEPLOYMENT
{%- if cookiecutter.use_infrastructure %}
plan-infra: # Plan Terraform infrastructure
	terraform -chdir=$(PATH_TERRAFORM_ENVIRONMENT) plan

apply-infra: # Apply Terraform infrastructure
	terraform -chdir=$(PATH_TERRAFORM_ENVIRONMENT) apply

destroy-infra: # Destroy Terraform infrastructure
	terraform -chdir=$(PATH_TERRAFORM_ENVIRONMENT) destroy

{%- endif %}
