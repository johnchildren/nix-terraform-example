{ sources ? import ./sources.nix
, overrideTerraformPlugin ? import ./override-plugin.nix }:
with {
  overlay = _: pkgs: {
    niv = import sources.niv { };
    terraform-providers = pkgs.terraform-providers // {
      docker = overrideTerraformPlugin pkgs.terraform-providers.docker
        sources.terraform-provider-docker;
    };
  };
};
import sources.nixpkgs {
  overlays = [ overlay ];
  config = { };
}
