# Terraform Nix Example

Demonstration Repo of how I've been managing Terraform versions with Nix

## Relevant files

- [shell.nix](./shell.nix) - defines the development environment
- [plan.yml](./.github/workflows/plan.yml) - defines how plans are run for PRs
- [apply.yml](./.github/workflows/apply.yml) - defines how the config is applied
- [sources.json](./nix/sources.json) - defines the locked version of nixpkgs (and therefore Terraform)

## Requirements

Unfortunately this project requires a few tools to be installed, though their versions should not matter as much as Terraform's does. The minimum requirement is just [`nix`](https://nixos.org/), but in order to improve QoL [`niv`](https://github.com/nmattia/niv) is used to manage the nixpkgs pinning and [`direnv`](https://github.com/direnv/) is used to automatically load the development environment when a user enters the directory.

If you are not using `direnv` it should be possible to run `nix-shell` from the root directory to get a reproducible environment that you can then use to perform Terraform tasks.

Importantly this will be the same version of Terraform used by the runner in CI so you shouldn't need to worry about getting versions out of sync. The exception to this would be if `terraform apply` is run with an updated version by someone, in which case the state version will break in a normal way.

## Plugins

In addition to managing terraform versions this repo also now demonstrates how you can control and override Terraform providers with `niv`. Adding a specific version of a provider's source can be as straightforward as running `niv add -v 1.0 repo/provider-name`, but you will need to provide the override to `nix`. For this I have added a demonstration function in [`nix/override-plugin.nix`](./nix/override-plugin.nix) which can be used to override providers in a way that keeps them discoverable by terraform. This way you can install versions of plugins not available in nixpkgs or manage plugin versions yourself.

For Go plugins this is perhaps not as obviously useful, but for plugins with C runtime dependencies (e.g. libvirt) this seems like an invaluable addition.

To override a plugin, after adding the source with `niv`, you need to add the override to `nix/default.nix` in a way illustrated by this example:

```nix

    terraform-providers = pkgs.terraform-providers // {
      docker = overrideTerraformPlugin pkgs.terraform-providers.docker
        sources.terraform-provider-docker;
    };
```

The `//` operator combines the two sets of providers so you should put your override inside the set on the righthand side as shown with the `docker` provider.

## TODOs

- This repo should really have some remote tfstate otherwise the example is not compelling.
