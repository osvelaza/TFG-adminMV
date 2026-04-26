#!/bin/bash
pkexec virt-install   --name $2   --memory 4096   --vcpus 2   --disk path=$1   --import   --os-variant generic   --network network=default,model=virtio   --graphics vnc,listen=0.0.0.0   --console pty,target_type=serial --wait 0
#pkexec virt-viewer ubuntu24.04
exit
