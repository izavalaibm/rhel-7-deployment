
/*data "vsphere_virtual_machine" "temp_vm" {
  name          = var.vm_name
  datacenter_id = data.vsphere_datastore.vsphere_datastore.id
  default       = null
}*/

resource "vsphere_virtual_machine" "vm" {


  name             = var.vm_name
  folder           = var.vm_folder
  num_cpus         = var.vm_cpu
  memory           = tostring(tonumber(var.vm_memory) * 1024)
  resource_pool_id = data.vsphere_resource_pool.vsphere_resource_pool.id
  datastore_id     = data.vsphere_datastore.vsphere_datastore.id
  guest_id         = data.vsphere_virtual_machine.vm_template.guest_id
  scsi_type        = data.vsphere_virtual_machine.vm_template.scsi_type

  clone {
    template_uuid = data.vsphere_virtual_machine.vm_template.id
    timeout       = var.vm_clone_timeout
    customize {
      linux_options {
        domain = var.vm_domain
        host_name = var.vm_name
      }
        network_interface {

          ipv4_netmask = 24
        }

      ipv4_gateway    = var.vm_ipv4_gateway
      dns_suffix_list = var.vm_dns_suffixes
      dns_server_list = var.vm_dns_servers
    }
  }


  network_interface {
    network_id   = data.vsphere_network.vm_private_network.id
    adapter_type = var.vm_private_adapter_type

  }

  disk {
    label          = "${var.vm_name}.vmdk"
    size           = var.vm_storage
    keep_on_remove = "false"
    datastore_id   = data.vsphere_datastore.vsphere_datastore.id
  }

}


resource "null_resource" "vm-create_done" {
  depends_on = [
    vsphere_virtual_machine.vm,
  ]

  provisioner "local-exec" {
    command = "echo 'VM creation done for ${var.vm_name}.'"
  }
}

