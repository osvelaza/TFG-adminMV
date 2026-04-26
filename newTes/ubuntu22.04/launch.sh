#!/bin/bash
cd $1
rm -rf output/
packer build template.pkr.hcl
estado=$?
[ $estado -eq 0 ] && echo "Ejecución correcta" || echo "Error"
if [[ $2 == "True" ]]
then
    ./virsh.sh $(pwd)/output/ubuntu/ubuntu-24.04
fi
exit
