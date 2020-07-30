{ pkgs ? import ./nix { } }:

let
  customTerraform =
    pkgs.terraform.withPlugins (p: [ p.docker ]);
in pkgs.mkShell {
  name = "terraform-dev-shell";
  buildInputs = [ customTerraform ];
}
