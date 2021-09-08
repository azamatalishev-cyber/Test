terraform {
  backend "remote" {
    organization = "stash"

    workspaces {
      name = "akeyless-shared-services-dev"
    }
  }
}
