#!/bin/sh

{% if cookiecutter.use_infrastructure %}
# Infrastructure-as-code
mkdir -p infrastructure/environments/prod/main.tf
mkdir -p infrastructure/modules/example/main.tf

{% endif %}