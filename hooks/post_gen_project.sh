#!/bin/sh

{% if cookiecutter.use_infrastructure %}
# Infrastructure-as-code
mkdir -p infrastructure/environments/prod/main.tf
mkdir -p infrastructure/modules/example/main.tf

{% endif %}
echo "🎉🎉🎉 Project created! 🎉🎉🎉"
echo "You can add the following alias to your .zshrc or .bashrc to run commands installed in compose.yaml (such as uv) more easily:"
echo ""
echo "# Docker Compose Run alias"
echo 'alias dcr="docker compose run --rm"'