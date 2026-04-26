variable "ubuntu_iso_url" {
  type    = string
  default = "/home/oscar/Descargas/ubuntu-24.04.3-desktop-amd64.iso"
}

variable "ubuntu_iso_checksum" {
  type    = string
  default = "sha256:cc2799ca1f3296cb50bba26509a66a335f972bb7d3eb023778ee97de2682b390"
}

source "qemu" "ubuntu" {
  iso_url          = var.ubuntu_iso_url
  iso_checksum     = var.ubuntu_iso_checksum
  output_directory = "output/ubuntu"
  disk_size        = "20G"
  format           = "qcow2"
  accelerator      = "kvm"
  vm_name          = "ubuntu-24.04.qcow2"
  cores            = 15
  memory           = 4096
  ssh_username     = "paco"
  ssh_password     = "ubuntu1234-"
  ssh_timeout      = "60m"
  ssh_handshake_attempts = 1000
  shutdown_command = "echo 'ubuntu1234-' | sudo -S shutdown -P now"
  boot_wait        = "1s"
  boot_command = [
    "e<wait><down><down><down><end> autoinstall 'ds=nocloud;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/'<F10>"
  ]

  http_directory = "http"
}

build {
  sources = ["source.qemu.ubuntu"]
}
