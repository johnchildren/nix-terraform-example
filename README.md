# Terraform Nix Example

Demonstration Repo of how I've been managing Terraform versions with Nix

## Relevant files:

- [shell.nix](./shell.nix) - defines the development environment
- [plan.yml](./.github/workflows/plan.yml) - defines how plans are run for PRs
- [apply.yml](./.github/workflows/apply.yml) - defines how the config is applied
- [sources.json](./nix/sources.json) - defines the locked version of nixpkgs (and therefore Terraform)

## Requirements

Unfortunately this project requires a few tools to be installed, though their versions should not matter as much as Terraform's does. The minimum requirement is just [`nix`](https://nixos.org/), but in order to improve QoL [`niv`](https://github.com/nmattia/niv) is used to manage the nixpkgs pinning and [`direnv`](https://github.com/direnv/) is used to automatically load the development environment when a user enters the directory.

If you are not using `direnv` it should be possible to run `nix-shell` from the root directory to get a reproducible environment that you can then use to perform Terraform tasks.

Importantly this will be the same version of Terraform used by the runner in CI so you shouldn't need to worry about getting versions out of sync. The exception to this would be if `terraform apply` is run with an updated version by someone, in which case the state version will break in a normal way.

## TODOs

- This repo should really have some remote tfstate otherwise the example is not compelling.
