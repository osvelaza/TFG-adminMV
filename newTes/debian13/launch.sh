#!/bin/bash
cd $1
rm -rf output/
#PACKER_LOG=1
packer build template.pkr.hcl
if [[ $2 == "True" ]]
then
    ./virsh.sh $(pwd)/output/debian.qcow2/debian13 Debian13
fi
exit
