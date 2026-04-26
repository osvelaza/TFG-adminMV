variable "ubuntu_iso_url" {
  type    = string
  default = "/home/oscar/Descargas/ubuntu-24.04.3-live-server-amd64.iso"
}

variable "ubuntu_iso_checksum" {
  type    = string
  default = "sha256:c3514bf0056180d09376462a7a1b4f213c1d6e8ea67fae5c25099c6fd3d8274b"
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

  provisioner "shell" {
    execute_command = "echo 'contrasenaacambiar' | sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
    inline = [
      "sudo apt update",
      "sudo apt install ca-certificates curl -y",
      "curl -fsSL https://get.docker.com -o get-docker.sh",
      "echo 'contrasenaacambiar' | sudo sh get-docker.sh"
    ]
  }
}
