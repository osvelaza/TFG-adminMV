variable "debian_iso_url" {
  type    = string
  default = "/home/oscar/Descargas/debian-12.13.0-amd64-netinst.iso"
}

variable "debian_iso_checksum" {
  type    = string
  default = "sha256:2b880ffabe36dbe04a662a3125e5ecae4db69d0acce257dd74615bbf165ad76e"
}

source "qemu" "debian" {
  iso_url          = var.debian_iso_url
  iso_checksum     = var.debian_iso_checksum
  output_directory = "output/debian.qcow2"
  disk_size        = "20G"
  format           = "qcow2"
  accelerator      = "kvm"
  vm_name          = "debian12"
  cores            = 15
  memory           = 4096
  ssh_username     = "usuario"
  ssh_password     = "contrasenaacambiar"
  ssh_timeout      = "60m"
  ssh_handshake_attempts = 1000
  shutdown_command = "echo 'contrasenaacambiar' | su - -c 'systemctl poweroff'"
  boot_wait        = "1s"
  boot_command = [
    "<esc><wait>",
    "auto install ",
    "url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg <wait>",
    "<enter>"
  ]

  http_directory = "http"
}

build {
  sources = ["source.qemu.debian"]
}
