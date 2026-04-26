variable "ubuntu_iso_url" {
  type    = string
  default = "/home/oscar/Descargas/Fedora-Server-netinst-x86_64-43-1.6.iso"
}
#https://mirror.in2p3.fr/pub/fedora/linux/releases/43/Server/x86_64/iso/Fedora-Server-netinst-x86_64-43-1.6.iso

variable "ubuntu_iso_checksum" {
  type    = string
  default = "sha256:16fd70ddae2c7de13e485637c3da1fb385dd8220389f988279ea3b3d561243cc"
}

source "qemu" "ubuntu" {
  iso_url          = var.ubuntu_iso_url
  iso_checksum     = var.ubuntu_iso_checksum
  output_directory = "output/fedora"
  disk_size        = "20G"
  format           = "qcow2"
  accelerator      = "kvm"
  vm_name          = "fedora-server43.qcow2"
  cores            = 15
  memory           = 4096
  ssh_username     = "usuario"
  ssh_password     = "contrasenaacambiar"
  ssh_timeout      = "60m"
  ssh_handshake_attempts = 1000
  shutdown_command = "echo 'contrasenaacambiar' | sudo -S shutdown -P now"
  boot_wait        = "5s"
  boot_command = [
    "<esc><wait>e<wait>",
    "<down><down><end>",
    " inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/fedora.ks",
    "<F10>"
  ]

  http_directory = "http"
}

build {
  sources = ["source.qemu.ubuntu"]
}
