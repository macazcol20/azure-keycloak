
# ========= OUTPUTS =========
output "subscription_id" {
  value = data.azurerm_subscription.current.subscription_id
}

output "tenant_id" {
  value = data.azurerm_subscription.current.tenant_id
}

output "arm_client_id" {
  description = "Use as ARM_CLIENT_ID"
  value       = azuread_application.sp_app.client_id
}

output "arm_client_secret" {
  description = "Use as ARM_CLIENT_SECRET"
  value       = azuread_service_principal_password.sp_secret.value
  sensitive   = true
}

output "arm_tenant_id" {
  description = "Use as ARM_TENANT_ID"
  value       = data.azurerm_subscription.current.tenant_id
}

output "arm_subscription_id" {
  description = "Use as ARM_SUBSCRIPTION_ID"
  value       = data.azurerm_subscription.current.subscription_id
}

output "keycloak_broker_client_id" {
  description = "Azure App Registration Client ID for Keycloak OIDC broker"
  value       = azuread_application.keycloak_broker.client_id
}

output "keycloak_broker_client_secret" {
  description = "Azure App Registration Client Secret for Keycloak OIDC broker"
  value       = azuread_application_password.keycloak_broker_secret.value
  sensitive   = true
}

# If you already output tenant ID elsewhere, you can remove this.
output "azuread_tenant_id" {
  description = "Tenant ID to use as OIDC issuer in Keycloak"
  value       = data.azurerm_subscription.current.tenant_id
}

output "keycloak_redirect_uri" {
  value       = local.keycloak_redirect_uri
  description = "Register this exact Redirect URI in the Azure App."
}
