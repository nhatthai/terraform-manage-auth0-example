terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm",
      version = "2.98"
    }

    auth0 = {
      source  = "auth0/auth0"
      version = "0.34"
    }
  }

  backend "azurerm" {
    resource_group_name  = "LearningDeployment"
    key                  = "auth0.tfstate"
  }
}

provider "auth0" {
  domain        = var.auth0_domain
  client_id     = var.auth0_client_id
  client_secret = var.auth0_client_secret
}

provider "azurerm" {
  version = "2.98"
  features {}
}

resource "auth0_client" "spa_terraform" {
  name            = "WebAppSPA - ${var.environment}"
  description     = "My Web App Created Through Terraform SPA1"
  app_type        = "spa"
  callbacks       = ["http://localhost:3000/callback", "http://localhost:4000/callback"]
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

# Output the client id of the created spa app
output "application_client_id" {
  value = auth0_client.spa_terraform.client_id
}

output "application_client_secret" {
  value = auth0_client.spa_terraform.client_secret
  sensitive = true
}
