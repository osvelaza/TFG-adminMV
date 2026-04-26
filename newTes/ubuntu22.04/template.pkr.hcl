variable "ubuntu_iso_url" {
  type    = string
  default = "https://releases.ubuntu.com/22.04/ubuntu-22.04.5-live-server-amd64.iso"
}

variable "ubuntu_iso_checksum" {
  type    = string
  default = "sha256:9bc6028870aef3f74f4e16b900008179e78b130e6b0b9a140635434a46aa98b0"
}

source "qemu" "ubuntu" {
  iso_url          = var.ubuntu_iso_url
  iso_checksum     = var.ubuntu_iso_checksum
  output_directory = "output/ubuntu.qcow2"
  disk_size        = "20G"
  format           = "qcow2"
  accelerator      = "kvm"
  vm_name          = "ubuntu-24.04"
  cores            = 15
  memory           = 4096
  ssh_username     = "usuario"
  ssh_password     = "contrasenaacambiar"
  ssh_timeout      = "60m"
  ssh_handshake_attempts = 1000
  shutdown_command = "echo 'contrasenaacambiar' | sudo -S shutdown -P now"
  boot_wait        = "1s"
  boot_command = [
    "e<wait><down><down><down><end> autoinstall 'ds=nocloud;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/'<F10>"
  ]

  http_directory = "http"
}

build {
  sources = ["source.qemu.ubuntu"]
}
