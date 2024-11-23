# {{ cookiecutter.project_name }}

[![Python version](https://img.shields.io/badge/python_version-{{ cookiecutter.python_version|truncate(4,True,'', 0) }}-blue)](https://github.com/psf/black)

{{ cookiecutter.project_description }}

## Usage
**TODO: Describe how to use your project! Is it a library? A CLI? A web app?**

## Development
This project uses [uv](https://docs.astral.sh/uv/) to manage Python dependencies.

System dependencies (such as the `uv` CLI itself and `gcloud` or `terraform`) are specified in the `compose.yaml` file, meaning you don't need to have them already installed on your machine. **The only system dependency you need to get started is Docker.**

Frequently used commands or groups of commands are defined as `Makefile` recipes. Run `make help` to see a list of available recipes.

### Setup
It's literally as easy as
```zsh
make setup
```

Optionally, you can create an alias for `docker compose run --rm` to save quite a few keystrokes as you use the `compose.yaml`-specified system dependencies:
```zsh
echo '# Docker Compose Run alias\nalias dcr="docker compose run --rm"' >> ~/.zshrc
source ~/.zshrc
```

Now, for example, you can run `dcr uv --help` to see the `uv` CLI help message, which includes how to add a new Python dependency or run a Python script. 

Makefile recipes uses `docker compose run` under the hood. To rebuild the containers behind the services specified in `compose.yaml` before running a recipe, run `make BUILD=1 <recipe>`.

### Code formatting
Applies to Python and (if applicable) Terraform code.
```zsh
make format
```

### Code linting
Here, "linting" refers to the process of static-type checking in Python and (if applicable) validation of Terraform configurations.
```zsh
make lint
```

## Deployment
**TODO: Describe how your project is deployed.**

_This project was created using [Duy Nguyen's cookiecutter template](https://github.com/duynguyen158/cookiecutter-python)._