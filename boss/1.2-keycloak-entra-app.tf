##########################################
# App Registration for Keycloak (OIDC)   #
##########################################



locals {
  keycloak_redirect_uri = "${trim(var.keycloak_base_url, "/")}/realms/${var.keycloak_realm}/broker/${var.keycloak_idp_alias}/endpoint"
}

resource "azuread_application" "keycloak_broker" {
  display_name     = "Keycloak Broker (${var.keycloak_realm})"
  sign_in_audience = "AzureADMyOrg"

  web {
    redirect_uris = [local.keycloak_redirect_uri]
    implicit_grant {
      access_token_issuance_enabled = false
      id_token_issuance_enabled     = false
    }
  }
}


resource "azuread_application_password" "keycloak_broker_secret" {
  # FIX: use application_id (object id). In v2/v3, .id is the object ID.
  application_id     = azuread_application.keycloak_broker.id
  display_name       = "keycloak-broker-secret"
  # end_date_relative  = "8760h" # 1 year
}

resource "azuread_service_principal" "keycloak_broker_sp" {
  client_id = azuread_application.keycloak_broker.client_id
}
