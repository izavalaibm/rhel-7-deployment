provider "vsphere" {
  version = "< 1.16.0"
  allow_unverified_ssl = "true"
}

resource "random_string" "cluster_id" {
  length  = 10
  special = false
  upper   = false
}

data "external" "get_vcenter_details" {
  program = ["/bin/bash", "./scripts/get_vcenter_details.sh"]
}

locals {
  vcenter         = data.external.get_vcenter_details.result["vcenter"]
  vcenteruser     = data.external.get_vcenter_details.result["vcenteruser"]
  vcenterpassword = data.external.get_vcenter_details.result["vcenterpassword"]
}

module "deployVM" {
  source = "./vm_deployment"

  #######
  vsphere_datacenter                 = var.vsphere_datacenter
  vsphere_resource_pool              = var.vsphere_resource_pool
  vm_name                            = var.vm_hostname
  vm_template                        = var.vm_template
  vm_domain                          = var.vm_domain_name
  vm_folder                          = var.vm_folder
  vm_ipv4_gateway                    = var.vm_ipv4_gateway
  vm_private_adapter_type            = var.vm_network_adapter_type
  vm_private_network_interface_label = var.vsphere_network
  vm_dns_servers                     = var.vm_dns_servers
  vm_dns_suffixes                    = var.vm_dns_suffixes
  vm_clone_timeout                   = var.vm_clone_timeout
  vm_datastore                       = var.vsphere_datastore
  vm_cpu                             = var.vm_cpu
  vm_memory                          = var.vm_memory
  vm_storage                         = var.vm_storage
}
