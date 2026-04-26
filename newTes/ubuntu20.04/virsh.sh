#!/bin/bash
pkexec virt-install   --name ubuntu20.04   --memory 4096   --vcpus 2   --disk path=/home/oscar/Dam2/TFG/newTes/ubuntu20.04/output/ubuntu/ubuntu-20.04.qcow2   --import   --os-variant generic   --network network=default,model=virtio   --graphics vnc,listen=0.0.0.0   --console pty,target_type=serial --wait 0
pkexec virt-viewer ubuntu20.04
exit
