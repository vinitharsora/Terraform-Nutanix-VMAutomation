terraform {
  required_providers {
    nutanix = {
      source  = "nutanix/nutanix"
      version = "1.2.0"
    }
  }
}

data "nutanix_cluster" "cluster" {
  name = var.nutanix_cluster_name
}

data "nutanix_subnet" "subnet" {
  subnet_name = var.nutanix_subnet_name
}

provider "nutanix" {
  username     = var.nutanix_username
  password     = var.nutanix_password
  endpoint     = var.nutanix_endpoint
  insecure     = true
  wait_timeout = 60
}

resource "nutanix_virtual_machine" "vm" {
  name                 = "terraform-test"
  description          = "terraform virtual machine test"
  cluster_uuid         = data.nutanix_cluster.cluster.id
  num_vcpus_per_socket = 2
  num_sockets          = 2
  memory_size_mib      = 4096

  # This parent_reference is what actually tells the provider to clone the specified VM
  parent_reference = {
    kind = "vm"
    name = "template-ubuntu-bionic"
    uuid = var.uuid
  }

  disk_list {

    data_source_reference = {
      kind = "vm"
      name = "template-ubuntu-bionic"
      uuid = var.uuid
    }

    # Do not touch this, cloning randomly adds a CDROM device and will break if you don't define it here
    device_properties {
      device_type = "CDROM"
      disk_address = {
        device_index = 3
        adapter_type = "IDE"
      }
    }

  }

  serial_port_list {
    index = 0
    is_connected = "true"
  }
  
  nic_list {
    subnet_uuid = data.nutanix_subnet.subnet.id
  }
}
