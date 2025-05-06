#!/bin/sh

{% if cookiecutter.use_infrastructure %}
# Infrastructure-as-code
mkdir -p infrastructure/environments/prod && touch infrastructure/environments/prod/main.tf
mkdir -p infrastructure/modules/example && touch infrastructure/modules/example/main.tf
{% endif %}

{% if cookiecutter.open_source_license == "Not open source" %}
rm LICENSE
{% endif %}

# Development environment setup
{% if cookiecutter.use_nix_direnv %}
cp .env.example .env && echo ".env file created."
cp .envrc.example .envrc && echo ".envrc file created."
{% else %}
rm shell.nix
{% endif %}
rm .env.example
rm .envrc.example

echo "🎉🎉🎉 Project created! 🎉🎉🎉"
echo "Go to the project directory with 'cd {{ cookiecutter.project_name }}' and start developing!"
{% if cookiecutter.use_nix_direnv %}
echo "Run 'direnv allow' to activate the dev environment."
{% endif %}
