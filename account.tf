terraform {
  cloud {
    organization = "NhatThaiQuang"

    workspaces {
      name = "example-workspace"
    }
  }
}