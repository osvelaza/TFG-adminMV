#!/bin/bash
pkexec virt-install   --name ubuntu24.04   --memory 4096   --vcpus 2   --disk path=/home/oscar/Dam2/TFG/newTes/ubuntu24.04-docker/output/ubuntu/ubuntu-24.04.qcow2   --import   --os-variant generic   --network network=default,model=virtio   --graphics vnc,listen=0.0.0.0   --console pty,target_type=serial --wait 0
pkexec virt-viewer ubuntu24.04
exit
