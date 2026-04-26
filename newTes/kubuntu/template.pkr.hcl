variable "kubuntu_iso_url" {
  type    = string
  default = "/home/oscar/Descargas/kubuntu-25.10-desktop-amd64.iso"
}

variable "kubuntu_iso_checksum" {
  type    = string
  default = "sha256:77cade4b5b6c85f0d7f163c7113b9207d58aec82e8247b7bfab7c37eafcf5963"
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
    "e<wait><down><down><down><end>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "autoinstall 'ds=nocloud;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/'<F10>"
  ]

  http_directory = "http"
}

build {
  sources = ["source.qemu.kubuntu"]
}
