variable "kubuntu_iso_url" {
  type    = string
  default = "/home/oscar/Descargas/ubuntu-24.04.3-desktop-amd64.iso"
}

variable "kubuntu_iso_checksum" {
  type    = string
  default = "sha256:cc2799ca1f3296cb50bba26509a66a335f972bb7d3eb023778ee97de2682b390"
}

source "qemu" "kubuntu" {
  iso_url          = var.kubuntu_iso_url
  iso_checksum     = var.kubuntu_iso_checksum
  output_directory = "output/kubuntu"
  disk_size        = "20G"
  format           = "qcow2"
  accelerator      = "kvm"
  vm_name          = "kubuntu"
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
  sources = ["source.qemu.kubuntu"]
}
