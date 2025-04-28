let
    nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-unstable";
    pkgs = import nixpkgs { 
        config = {
            allowUnfree = true;
        }; 
        overlays = []; 
    };
in
pkgs.mkShellNoCC {
    packages = with pkgs; [
        # Define system dependencies here. They'll be installed in a hermetically sealed environment.
        # If you don't use nix-direnv, just install the packages listed below however you prefer.
{%- if cookiecutter.use_gcloud %}
        google-cloud-sdk
{%- endif %}
{%- if cookiecutter.use_infrastructure %}
        terraform
{%- endif %}
        uv
    ];
}