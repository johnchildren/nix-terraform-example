terraform {
  required_version = "0.12.8"
}

provider "docker" {
  version = "~> 2.7"
  host = "tcp://127.0.0.1:2376/"
}

module foo {
  source = "./modules/foo"
}

module bar {
  source = "./modules/bar"
}
