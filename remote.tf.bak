terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "jacobm3"

    workspaces {
      name = "az-vault"
    }
  }
}
