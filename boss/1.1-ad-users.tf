#############################
# Entra ID (Azure AD) Users #
#############################

resource "azuread_user" "ad_users" {
  for_each            = { for u in var.ad_users : lower(u.user_principal_name) => u }

  user_principal_name = each.value.user_principal_name
  display_name        = each.value.display_name
  mail_nickname       = replace(split("@", each.value.user_principal_name)[0], ".", "-")
  account_enabled     = true

  # Initial password (rotate via policy/SSPR if you need forced change next sign-in)
  password = each.value.initial_password
}

##################
# AD Group (opt) #
##################

resource "azuread_group" "keycloak_users" {
  display_name     = var.ad_group_name
  security_enabled = true
  description      = "Users who can authenticate into Keycloak"
}

resource "azuread_group_member" "keycloak_users_members" {
  for_each         = azuread_user.ad_users
  group_object_id  = azuread_group.keycloak_users.object_id   # <- was .id
  member_object_id = each.value.object_id                     # <- was each.value.id
}
