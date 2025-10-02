## Subscription Variables ##
variable  "billing_account_name" {}
variable  "billing_profile_name" {}
variable  "invoice_section_name" {}

## Entra ID (Azure AD) users to create
variable "ad_users" {
  description = "List of users to create in Entra ID (Azure AD)"
  type = list(object({
    user_principal_name = string
    display_name        = string
    initial_password    = string
  }))
}

variable "keycloak_base_url" {
  type        = string
  description = "Base URL to your Keycloak (e.g., https://keycloak.example.com)"
}

variable "keycloak_realm" {
  type        = string
  description = "Keycloak realm that will use Azure AD as identity provider"
}

variable "keycloak_idp_alias" {
  type        = string
  description = "Identity Provider alias in Keycloak (e.g., 'azuread')"
  default     = "azuread"
}

# Optional group name
variable "ad_group_name" {
  type        = string
  default     = "keycloak-users"
  description = "AD group name for Keycloak users"
}

# ========= CONFIG =========
variable "sp_display_name" {
  type    = string
  default = "tf-agent-sp"
}

variable "role_definition_name" {
  type    = string
  default = "Contributor"
}

variable "sp_secret_end_date_relative" {
  type    = string
  default = "8760h" # 1 year
}
