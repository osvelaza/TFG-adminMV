terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
      version = ">= 0.9.1"
    }
  }
}

provider "libvirt" {
}

resource "libvirt_volume" "ubuntu-qcow2" {
  name = "ubuntu.qcow2"
  pool = "default"
  create = {
    content = {
      url = "file:///home/oscar/DAM/TFG/newTes/output/ubuntu/ubuntu-22.04.qcow2"
    }
  }
}

resource "libvirt_domain" "ubuntu" {
  name = "ubuntu20.04"
  type = "kvm"
  memory = "4096"
  vcpu = 5

  network_interface {
    network_name = "default"
  }

  disk {
    volume_id = "${ubuntu_volume.ubuntu-qcow2.id}"
  }

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type = "vnc"
    listen_type = "address"
    listen_address = "0.0.0.0"
    autoport = true
  }
}
