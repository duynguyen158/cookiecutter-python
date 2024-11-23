FROM python:{{ cookiecutter.python_version }}-slim-bookworm
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv

# Install ruff tool for formatting
RUN uv tool install ruff
RUN uv tool run ruff --version

# Install pyright tool for linting (i.e., static type checking)
RUN uv tool install pyright
RUN uv tool run pyright --version # Besides showing version, this installs Node so that subsequent runs don't have to