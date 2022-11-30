terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm",
      version = "~> 2.0"
    }

    auth0 = {
      source  = "auth0/auth0"
      version = "~> 0.34"
    }
  }

  backend "azurerm" {
    resource_group_name  = "LearningDeployment"
    storage_account_name = "tfdevopsstorage"
    container_name       = "tfstatedevops"
    key                  = "auth0.tfstate"
  }
}

provider "auth0" {
  domain        = var.auth0_domain
  client_id     = var.auth0_client_id
  client_secret = var.auth0_client_secret
}

provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you're using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}
}

# An Auth0 Client loaded using its ID.
data "auth0_client" "some-client-by-id" {
  client_id = "0kOS3T3gjqY7k9A3hbc30Eh1GFA1HotU"
}

resource "auth0_client" "spa_terraform" {
  name            = "WebAppSPA - ${var.environment}"
  description     = "My Web App Created Through Terraform SPA1"
  app_type        = "spa"
  callbacks       = ["http://localhost:3000/callback"]
  allowed_origins = ["http://localhost:3000"]
  allowed_logout_urls  = ["http://localhost:3000"]
  web_origins    = ["http://localhost:3000"]
  oidc_conformant = true
  grant_types = ["authorization_code", "refresh_token"]

  jwt_configuration {
    alg                 = "RS256"
  }

  refresh_token {
    leeway          = 0
    token_lifetime  = 1557500
    rotation_type   = "rotating"
    expiration_type = "expiring"
    infinite_token_lifetime = false
    infinite_idle_token_lifetime = false
  }
}

resource "auth0_connection" "github" {
  name = "github-connection"
  strategy = "github"
  options {
    client_id = "0kOS3T3gjqY7k9A3hbc30Eh1GFA1HotU"
    client_secret = "b4f9BD9-V4bjFwiiKoDpG_4rlvO5I0GbCmBgFM9Ft_iq92cf6mh4APwhHcTOBqX7"
    scopes = [ "email", "profile", "public_repo", "repo" ]
  }
  enabled_clients = [auth0_client.spa_terraform.client_id]
}

# Output the client id of the created spa app
output "application_clientid" {
  value = auth0_client.spa_terraform.client_id
}