output "subnet_id" {
  value = module.vnet.subnet_id
}

output "aad_admin_group_object_id" {
  value = module.aad.admin_group_object_id
}

output "aks_cluster_name" {
  value = module.aks.cluster_name
}
