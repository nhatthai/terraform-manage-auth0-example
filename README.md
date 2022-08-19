# Auth0 Management with Terraform
+ Manage Auth0 Configuration with Terraform

### Requirements
+ Create an account & Install Terraform
+ Create an account Auth0

### Usage
+ Create a Machine to Machine application in Auth0
+ You'll need to authorize your new app to call the Auth0 Management API.
+ Select it in the dropdown and then authorize all scopes
+ Open the Settings tab and copy the Domain, Client ID, and Client Secret values - you'll need them in the next step for configuring the Auth0 Provider.
+ terraform login
+ terraform init
+ terraform apply

### Reference
+ [Manage Your Auth0 Configuration](https://auth0.com/blog/use-terraform-to-manage-your-auth0-configuration/)
+ [Setting up Auth0 with Terraform](https://hceris.com/setting-up-auth0-with-terraform/)