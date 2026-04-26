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

  provisioner "shell" {
    execute_command = "echo 'ubuntu1234-' | sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
    inline = [
      "sudo apt update",
      "sudo apt install ca-certificates curl -y",
      "sudo install -m 0755 -d /etc/apt/keyrings",
      "sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc",
      "sudo chmod a+r /etc/apt/keyrings/docker.asc",
      <<EOT
      sudo tee /etc/apt/sources.list.d/docker.sources <<'EOF'
      Types: deb
      URIs: https://download.docker.com/linux/ubuntu
      Suites: $(. /etc/os-release && echo "$${UBUNTU_CODENAME:-$VERSION_CODENAME}")
      Components: stable
      Signed-By: /etc/apt/keyrings/docker.asc
      EOF
      EOT
    ,
      "sudo apt update",
      "sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y",
      "sudo systemctl enable docker",
      "sudo systemctl start docker"
    ]
  }
}
