

# ========= RESOURCES =========
# App registration
resource "azuread_application" "sp_app" {
  display_name = var.sp_display_name
}

# Service principal (enterprise app)
resource "azuread_service_principal" "sp" {
  # v3.x uses client_id (NOT application_id)
  client_id = azuread_application.sp_app.client_id
}

# Client secret
# Service principal password (client secret)
resource "azuread_service_principal_password" "sp_secret" {
  # Use the full resource ID, not the GUID
  service_principal_id = azuread_service_principal.sp.id

  # # ~1 year from now
  # end_date = timeadd(timestamp(), "8760h")
}


# Role assignment at subscription scope
resource "azurerm_role_assignment" "sub_scope" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = var.role_definition_name
  principal_id         = azuread_service_principal.sp.object_id
}
