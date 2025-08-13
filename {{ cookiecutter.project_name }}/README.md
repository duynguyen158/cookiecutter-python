# {{ cookiecutter.project_name }}

[![Python version](https://img.shields.io/badge/python_version-{{ cookiecutter.python_version|truncate(4,True,'', 0) }}-blue)](https://github.com/psf/black)

{{ cookiecutter.project_description }}

## Usage
**TODO: Describe how to use your project! Is it a library? A CLI? A web app?**

## Development
This project uses [uv](https://docs.astral.sh/uv/) to manage Python dependencies.

Frequently used commands or groups of commands are defined as `Makefile` recipes. Run `make help` to see a list of available recipes.

### Setting up system dependencies
{%- if cookiecutter.use_nix_direnv %}
Run `direnv allow` to enable direnv for this project, if you haven't already.

Edit the list of system dependencies in `shell.nix`. When you're ready, `cd` again into the project directory. All system dependencies will be installed in a sealed environment specific to your project. This environment will unload if you `cd` out of the project directory, and reload if you `cd` back in. Any changes you make to `shell.nix`, including adding or removing dependencies from the declared `packages` list automatically sync to your environment every time you hit Enter on the command line.

The [Nix package repository](https://search.nixos.org/packages) is a good place to search for packages you can install (use the `unstable` channel). If a package isn't available, you can try building it from scratch directly within `shell.nix`. Here's an example of how to install Vespa
```nix
let
    nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-unstable";
    pkgs = import nixpkgs { 
        config = {
            allowUnfree = true;
        }; 
        overlays = []; 
    };
    
    # Install vespa-cli from source since it isn't available on nixpkgs
    # Then you can reference vespa-cli below
    vespa-cli = pkgs.stdenv.mkDerivation {
        name = "vespa-cli";
        version = "8.489.59";
        src = pkgs.fetchurl {
            url = "https://github.com/vespa-engine/vespa/releases/download/v8.489.59/vespa-cli_8.489.59_darwin_arm64.tar.gz";
            sha256 = "sha256-lyRR50CTi4eBYz5zhfFfp/lhFHonb2ruVUOsnJaKaHo=";
        };
        unpackPhase = "tar -xzf $src";
        installPhase = ''
            mkdir -p $out/bin
            cp vespa-cli_8.489.59_darwin_arm64/bin/vespa $out/bin/vespa
        '';
        buildPhase = " : "; # No build needed, it's precompiled
    };
in
pkgs.mkShellNoCC {
    packages = with pkgs; [
        vespa-cli # References the vespa-cli derivation created above
    ];
}
```
{%- else %}
Feel free to install system dependencies like `uv` however you like. See the commands inside `Makefile` recipes for the system packages you'll need to install.
{%- endif %}

### Setting up project dependencies
It's literally as easy as
```zsh
make setup
```

### Running tests
Run
```zsh
make test
```
to run all unit and (if available) integration tests.

### Code formatting
Applies to Python and (if applicable) Terraform code.
```zsh
make format
```

We use [Ruff](https://docs.astral.sh/ruff/) as the formatter for Python. Rules are specified in `pyproject.toml`.

### Code linting
Here, "linting" refers to the process of static-type checking in Python and (if applicable) validation of Terraform configurations.
```zsh
make lint
```

We use [Pyright](https://github.com/microsoft/pyright) as the Python static type checker. Rules are also specified in `pyproject.toml`.

## Deployment
{%- if cookiecutter.use_infrastructure %}
### Deploy infrastructure
We use Terraform to manage our infrastructure. Configuration is defined inside the `infrastructure` directory.

First, run
```zsh
make plan-infra
```
to see the infrastructure changes that will be applied.

Then, when you're ready to apply the changes, run
```zsh
make apply-infra
```
{%- else %}
**TODO: Describe how your project is deployed.**
{%- endif %}

_This project was created using [Duy Nguyen's cookiecutter template](https://github.com/duynguyen158/cookiecutter-python)._