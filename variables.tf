
variable "vsphere_network" {
  type = string
}

variable "vsphere_datacenter" {
  type = string
}

variable "vsphere_resource_pool" {
  type = string
}

variable "vm_hostname" {
  type = string
}

variable "vm_cpu" {
  type = string
}

variable "vm_memory" {
  type = string
}

variable "vm_storage" {
  type = string
}

variable "vm_template" {
  type = string
}

variable "vm_domain_name" {
  type = string
}

variable "vm_ipv4_gateway" {
  type = string
}

variable "vm_network_adapter_type" {
  type = string
}

variable "vm_dns_servers" {
  type = list(string)
}

variable "vm_dns_suffixes" {
  type = list(string)
}
variable "vm_clone_timeout" {
  type = string
}
variable "vm_folder" {
  type = string
}
variable "vsphere_datastore" {
  type = string
}

variable "size" {
  type = string
  default = "none"
}