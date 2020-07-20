{ pkgs ? import ./nix {} }:

pkgs.mkShell {
  name = "terraform-dev-shell";
  buildInputs = with pkgs; [
    go
    terraform
  ];
}
