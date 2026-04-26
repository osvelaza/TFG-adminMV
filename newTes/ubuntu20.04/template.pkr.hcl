variable "ubuntu_iso_url" {
  type    = string
  default = "/home/oscar/Descargas/ubuntu-20.04.6-live-server-amd64.iso"
}

variable "ubuntu_iso_checksum" {
  type    = string
  default = "sha256:b8f31413336b9393ad5d8ef0282717b2ab19f007df2e9ed5196c13d8f9153c8b"
}

source "qemu" "ubuntu" {
  iso_url          = var.ubuntu_iso_url
  iso_checksum     = var.ubuntu_iso_checksum
  output_directory = "output/ubuntu"
  disk_size        = "15G"
  format           = "qcow2"
  accelerator      = "kvm"
  vm_name          = "ubuntu-20.04.qcow2"
  cores            = 7
  memory           = 4096
  ssh_username     = "oscar"
  ssh_password     = "1234"
  ssh_timeout      = "60m"
  ssh_handshake_attempts = 1000
  shutdown_command = "echo '1234' | sudo -S shutdown -P now"
  boot_wait        = "1s"
  boot_command = [
    "<esc><esc><esc><esc><wait>",
    "<f6><wait><esc><wait>",
    "<bs><bs><bs><bs><bs>",
    "autoinstall ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ",
    "--- <enter>"
  ]

  http_directory = "http"
}

build {
  sources = ["source.qemu.ubuntu"]
}
