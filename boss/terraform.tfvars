## Subscription Variables ##
billing_account_name = "xxxxxxxxxxxxxxxxxxxxxxxx3-2c9d4083cb05_2019-05-31"  # boss add yours from ur azure
billing_profile_name = "xxxxxxxxxxxx" # boss add yours from ur azure
invoice_section_name = "xxxxxxxxxxxxxxxxx"  # boss add yours from ur azure

# Keycloak integration
keycloak_base_url  = "https://keycloak.pixiescloud.com"
keycloak_realm     = "pixies"   # was argocd
keycloak_idp_alias = "oidc"     # was azuread


# Users to provision (examples)
ad_users = [
  {
    user_principal_name = "alice.admin@NETORGFT18138813.onmicrosoft.com"
    display_name        = "Alice Admin"
    initial_password    = "TempP@ssw0rd123!"
    force_password_change_on_next_sign_in = true
  },
  {
    user_principal_name = "bob.user@NETORGFT18138813.onmicrosoft.com"
    display_name        = "Bob User"
    initial_password    = "TempP@ssw0rd123!"
  }
]

# Optional: override default group name
ad_group_name = "keycloak-users"
