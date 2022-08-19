variable "auth0_domain" {}
variable "auth0_client_id" {}
variable "auth0_client_secret" {}

terraform {
  required_providers {
    auth0 = {
      source  = "auth0/auth0"
      version = "~> 0.34"
    }
  }
}

provider "auth0" {
  domain        = var.auth0_domain
  client_id     = var.auth0_client_id
  client_secret = var.auth0_client_secret
}


resource "auth0_client" "spa_terraform" {
  name            = "WebAppSPA1"
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

# Output the client id of the created spa app
output "application_clientid" {
  value = auth0_client.spa_terraform.client_id
}