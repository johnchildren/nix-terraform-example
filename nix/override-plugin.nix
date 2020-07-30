# Override a Terraform provider in a way that will let terraform discover it.
plugin: source:

plugin.overrideAttrs (old: {
  name = "${source.repo}-${source.version}";
  version = source.version;
  src = source;

  # Terraform allow checking the provider versions, but this breaks
  # if the versions are not provided via file paths.
  postBuild = "mv go/bin/${source.repo}{,_v${source.version}}";
})
