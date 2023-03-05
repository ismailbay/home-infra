terraform {
  cloud {
    organization = "ismailbay"

    workspaces {
      name = "home-infra"
    }
  }
} 