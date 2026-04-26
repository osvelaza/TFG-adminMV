#!/bin/bash
cd /home/oscar/Dam2/TFG/newTes/ubuntu24.04/
rm -rf output/
PACKER_LOG=1 packer build template.pkr.hcl
exit
