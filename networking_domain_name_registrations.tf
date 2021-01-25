module domain_name_registrations {
  source   = "./modules/networking/domain_name_registrations"
  for_each = try(local.networking.domain_name_registrations, {})

  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  dns_zone_id         = try(each.value.dns_zone.lz_key, null) == null ? local.combined_object_dns_zones[local.client_config.landingzone_key][each.value.dns_zone.key].id : local.combined_object_dns_zones[each.value.dns_zone.lz_key][each.value.dns_zone.key].id
  global_settings     = local.global_settings
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  name                = try(each.value.name, "") == "" ? try(local.combined_object_dns_zones[local.client_config.landingzone_key][each.value.dns_zone.key].name, local.combined_object_dns_zones[each.value.dns_zone.lz_key][each.value.dns_zone.key].name) : ""
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  settings            = each.value
}

output domain_name_registrations {
  value = module.domain_name_registrations
}

