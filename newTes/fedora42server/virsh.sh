#!/bin/bash
pkexec virt-install   --name fedora-server43   --memory 4096   --vcpus 2   --disk path=/home/oscar/Dam2/TFG/newTes/fedora42server/output/fedora/fedora-server43.qcow2   --import   --os-variant generic   --network network=default,model=virtio   --graphics vnc,listen=0.0.0.0   --console pty,target_type=serial --wait 0
pkexec virt-viewer fedora-server43
exit
