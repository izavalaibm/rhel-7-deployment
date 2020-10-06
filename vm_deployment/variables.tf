##############################################################
# Vsphere data for provider
##############################################################
data "vsphere_datacenter" "vsphere_datacenter" {
  name = var.vsphere_datacenter
}

data "vsphere_datastore" "vsphere_datastore" {
  name          = var.vm_datastore
  datacenter_id = data.vsphere_datacenter.vsphere_datacenter.id
}

data "vsphere_resource_pool" "vsphere_resource_pool" {
  name          = var.vsphere_resource_pool
  datacenter_id = data.vsphere_datacenter.vsphere_datacenter.id
}

data "vsphere_network" "vm_private_network" {
  name          = var.vm_private_network_interface_label
  datacenter_id = data.vsphere_datacenter.vsphere_datacenter.id
}

data "vsphere_virtual_machine" "vm_template" {
  name          = var.vm_template
  datacenter_id = data.vsphere_datacenter.vsphere_datacenter.id
}

#########################################################
##### Resource : vm_
#########################################################

variable "vm_name" {
  type = string
}

variable "vm_folder" {
  description = "Target vSphere folder for virtual machine"
}

variable "vm_template" {
  description = "Target vSphere folder for virtual machine"
}

variable "vsphere_datacenter" {
  description = "Target vSphere datacenter for virtual machine creation"
}

variable "vsphere_resource_pool" {
  description = "Target vSphere Resource Pool to host the virtual machine"
}

variable "vm_dns_servers" {
  type        = list(string)
  description = "DNS servers for the virtual network adapter"
}

variable "vm_dns_suffixes" {
  type        = list(string)
  description = "Name resolution suffixes for the virtual network adapter"
}

variable "vm_ipv4_gateway" {
  description = "IPv4 gateway for vNIC configuration"
}

variable "vm_ipv4_address" {
  description = "IPv4 address for vNIC configuration"
  type        = string
}

variable "vm_ipv4_prefix_length" {
  description = "IPv4 prefix length for vNIC configuration. The value must be a number between 8 and 32"
}


variable "vm_clone_timeout" {
  description = "The timeout, in minutes, to wait for the virtual machine clone to complete."
  default     = "30"
}


variable "vm_domain" {
  description = "Domain Name of virtual machine"
}

variable "vm_private_network_interface_label" {
  description = "vSphere port group or network label for virtual machine's private vNIC"
}

variable "vm_private_adapter_type"{
  type = string 
}

variable "vm_datastore"{
  type = string
}

