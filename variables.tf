variable "az_resource_group_name" {
  description = "Azure Group Name"
  type        = string
}

variable "az_storage_account_name" {
  description = "Azure Store Account Name"
  type        = string
}

variable "az_container_name" {
    description="Azure Container Name"
    type = string
}

variable "arm_access_key" {
    description="Azure Access Key"
    type = string
}
variable "auth0_client_id" {
    description = "Client Id of Auth0(M2M)"
    type        = string
}

variable "auth0_client_secret" {
    description = "Client Secret of Auth0(M2M)"
    type        = string
}

variable "auth0_domain" {
    description = "Auth0 Domain"
    type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}