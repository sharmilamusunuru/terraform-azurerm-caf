
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus"
  }
}

resource_groups = {
  kv_region1 = {
    name   = "keyvault-rg1"
    region = "region1"
  }
}
